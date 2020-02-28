Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B091740A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1T74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 14:59:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1T74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xY8PKVfaI12cjGthFIErDX+1jB0/adgnMfS1LHlHQYY=; b=fKw+M+IHRBrPRjZvU4H43ipERs
        60IJF3gBEXe9m6cyMBAB6C72c271LTysvqXbfPeDE/sEmchtoAHyNWEdfKHqJsONNLn+xeej9II3u
        Ss9iE+sSJ3o5F0HYaJ6szarp7/WIUA8gkNN4VIFb31rC/PY2c2Y0Rp0kdslZRPnWLJUZAOkES8rU9
        uN2z2jVfq22ledVbmZ+2cc9TgHvRgMIFEfs9mmUGg+CH7vamZqNtTnP9FJftzPbiBqIkn5c4c72yv
        7JLZGc2d/5Gig0E40gsbzIDbukM837OPc3Lle+xozLSboNAO+I4mZMAqQ5giKbSHCwTv48kGxZ9aZ
        2PPE9TXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7lne-0004W7-NN; Fri, 28 Feb 2020 19:59:54 +0000
Date:   Fri, 28 Feb 2020 11:59:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200228195954.GJ29971@bombadil.infradead.org>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
 <20200228194401.o736qvvr4zpklyiz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228194401.o736qvvr4zpklyiz@fiona>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:44:01PM -0600, Goldwyn Rodrigues wrote:
> +++ b/fs/iomap/direct-io.c
> @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		size_t n;
>  		if (dio->error) {
>  			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +			ret = 0;
>  			goto out;

There's another change here ... look at the out label

out:
        /* Undo iter limitation to current extent */
        iov_iter_reexpand(dio->submit.iter, orig_count - copied);
        if (copied)
                return copied;
        return ret;

so you're also changing by how much the iter is reexpanded.  I
don't know if it's the appropriate amount; I still don't quite get the
iov_iter complexities.

