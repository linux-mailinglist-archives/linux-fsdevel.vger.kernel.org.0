Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F610344CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhCVRK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCVRJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:09:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1EC061574;
        Mon, 22 Mar 2021 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9pBxK++rOdIu6auvAS1zs5EH7ywKGgPoUb614cFfN9k=; b=UGGKqhE8DJjuTFnUKQ819Uvw93
        PsTWheAhjkG4Y5U/aZG5axtvQy+yECK+MSX+pezy8ureB6M/MHg6gfOPiTe9jE8P6ONMmMMkA2wFW
        BA5v0VARijyBMGPeDi47CJJp/i1KwQQxMUjYCaZnmFLivfFBIcFBMN4HJ6KC57jSVou+MiqXgmgdJ
        Nm87DABBZa8jjW5hciJ4Ym5oIEvLeoBrVZJiV3JPsQIzjxoSrn7EKHH58P7DA6mRNMPGs1SGgb9Nh
        lLdX08/ntYSZcDPPixRgJ+vht8AtDMA4fp9slUvXkUFGLzgChry7uo5gKbSAFJX93yixiPi7oMQR/
        wmxT7M7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOO3I-008p9Z-TN; Mon, 22 Mar 2021 17:09:23 +0000
Date:   Mon, 22 Mar 2021 17:09:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        hyc.lee@gmail.com, viro@zeniv.linux.org.uk, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322170916.GS1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322081512.GI1719932@casper.infradead.org>
 <YFhdWeedjQQgJdbi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhdWeedjQQgJdbi@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:03:21PM +0900, Sergey Senozhatsky wrote:
> On (21/03/22 08:15), Matthew Wilcox wrote:
> > 
> > What's the scenario for which your allocator performs better than slub
> > 
> 
> IIRC request and reply buffers can be up to 4M in size. So this stuff
> just allocates a number of fat buffers and keeps them around so that
> it doesn't have to vmalloc(4M) for every request and every response.

Hang on a minute, this speaks to a deeper design problem.  If we're doing
a 'request' or 'reply' that is that large, the I/O should be coming from
or going to the page cache.  If it goes via a 4MB virtually contiguous
buffer first, that's a memcpy that could/should be avoided.

But now i'm looking for how ksmbd_find_buffer() is used, and it isn't.
So it looks like someone came to the same conclusion I did, but forgot
to delete the wm code.

That said, there are plenty of opportunities to optimise the vmalloc code,
and that's worth pursuing.  And here's the receive path which contains
the memcpy that should be avoided (ok, it's actually the call to ->read;
we shouldn't be reading in the entire 4MB but rather the header):

+		conn->request_buf = ksmbd_alloc_request(size);
+		if (!conn->request_buf)
+			continue;
+
+		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
+		if (!ksmbd_smb_request(conn))
+			break;
+
+		/*
+		 * We already read 4 bytes to find out PDU size, now
+		 * read in PDU
+		 */
+		size = t->ops->read(t, conn->request_buf + 4, pdu_size);

