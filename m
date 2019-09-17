Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C64B4A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfIQJGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 05:06:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfIQJGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=twoRXxt7dNIPASh5zYTUvqumsB7Y4/vYcfmEMBY5b/Y=; b=EFw2mcqCBpl+FNFW2rFXoDtRa
        A7E04nrSFQ0FkXaEQ2I4mpW25wvT519zJGp3WUMz+z/hfW0mwHU5QW+dtb6OXbd3HSzR2ldi1Jvc4
        v4tgZd8CnrjK4uNWYOzhsuZ6ng+YzpNvv7LikCQwL7JD82RcVFMJjRNAk6tZr1OpC4XlA5QUqysxP
        ta9yDstNwFNxIxv2KRISRp0qz371IwzALzqbVm84a1wJqkwxCOrsQPsvozdsKYAqO44WPxtsTUpJU
        vU8z1PO8j8ZoGuX5p5cj4zx2CUFGnwVU8rdTSR/5gfRUu+REskuWxXtd2I+qxPWH707sJOhIS37wK
        HjpLTFZNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA9R7-0002Uq-SG; Tue, 17 Sep 2019 09:06:14 +0000
Date:   Tue, 17 Sep 2019 02:06:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190917090613.GC29487@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916223741.GA5936@bobrowski>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:37:41AM +1000, Matthew Bobrowski wrote:
> > Independent of the error return issue you probably want to split
> > modifying ext4_write_checks into a separate preparation patch.
> 
> Providing that there's no objections to introducing a possible performance
> change with this separate preparation patch (overhead of calling
> file_remove_privs/file_update_time twice), then I have no issues in doing so.

Well, we should avoid calling it twice.  But what caught my eye is that
the buffered I/O path also called this function, so we are changing it as
well here.  If that actually is safe (I didn't review these bits carefully
and don't know ext4 that well) the overall refactoring of the write
flow might belong into a separate prep patch (that is not relying
on ->direct_IO, the checks changes, etc).

> > > +	if (!inode_trylock(inode)) {
> > > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > > +			return -EAGAIN;
> > > +		inode_lock(inode);
> > > +	}
> > > +
> > > +	if (!ext4_dio_checks(inode)) {
> > > +		inode_unlock(inode);
> > > +		/*
> > > +		 * Fallback to buffered IO if the operation on the
> > > +		 * inode is not supported by direct IO.
> > > +		 */
> > > +		return ext4_buffered_write_iter(iocb, from);
> > 
> > I think you want to lift the locking into the caller of this function
> > so that you don't have to unlock and relock for the buffered write
> > fallback.
> 
> I don't exactly know what you really mean by "lift the locking into the caller
> of this function". I'm interpreting that as moving the inode_unlock()
> operation into ext4_buffered_write_iter(), but I can't see how that would be
> any different from doing it directly here? Wouldn't this also run the risk of
> the locks becoming unbalanced as we'd need to add checks around whether the
> resource is being contended? Maybe I'm misunderstanding something here...

With that I mean to acquire the inode lock in ext4_file_write_iter
instead of the low-level buffered I/O or direct I/O routines.
