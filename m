Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474D32E6536
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 16:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393330AbgL1P6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393323AbgL1P6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:58:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DCC06179B;
        Mon, 28 Dec 2020 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FGpC//fOURR6xbsUxytCh0bux+vv2dcWmfFgyJiqKQ8=; b=QL7PQTdZ3w2Zu/c+bVynnSoH+C
        9k8q+5hWkvSV2XCDBDEb3+dM7z4qTbL+xORHbkS8ej+Yg8tG7uZoC/DCyA9C+L6FASNWkbeRdbbFQ
        YFGYgZ2z6H+46KVo9UfsINGlMF7Y3YpJh5Q8t8zYoa90EWKbtDoertRpKqTB57EqPurQUlyx6h7iA
        hqqpvYVI4JFBcpvKyah3mC2VVrzwIqwLVknTtLdf7ikp/lbsoo/b9L4gBCdR5S+bneE4iENY3FeTz
        xH7GTvcYHXLL+d+jKEx09XV1KsQdy1ZV0/GFHA5jnmDmiOsv4TT3B3hhWSIrZoL11ghOhRaSou5A6
        OgXTq9DQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktusc-0001eS-6o; Mon, 28 Dec 2020 15:56:36 +0000
Date:   Mon, 28 Dec 2020 15:56:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201228155618.GA6211@casper.infradead.org>
References: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org>
 <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 08:25:50AM -0500, Jeff Layton wrote:
> To be clear, the main thing you'll lose with the method above is the
> ability to see an unseen error on a newly opened fd, if there was an
> overlayfs mount using the same upper sb before your open occurred.
> 
> IOW, consider two overlayfs mounts using the same upper layer sb:
> 
> ovlfs1				ovlfs2
> ----------------------------------------------------------------------
> mount
> open fd1
> write to fd1
> <writeback fails>
> 				mount (upper errseq_t SEEN flag marked)
> open fd2
> syncfs(fd2)
> syncfs(fd1)
> 
> 
> On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
> calls. The first one has a sample from before the error occurred, and
> the second one has a sample of 0, due to the fact that the error was
> unseen at open time.
> 
> On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
> return an error and syncfs(fd2) will not. If we split the SEEN flag into
> two, then we can ensure that they both still get an error in this
> situation.

But do we need to?  If the inode has been evicted we also lose the errno.
The guarantee we provide is that a fd that was open before the error
occurred will see the error.  An fd that's opened after the error occurred
may or may not see the error.

