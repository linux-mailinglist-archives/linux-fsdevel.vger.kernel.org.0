Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9252E0DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLVRrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 12:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgLVRrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:47:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF20C0613D3;
        Tue, 22 Dec 2020 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IHzuUPUbSW1sV9U94ACf/su1/lnf5rfvzD9sEkmvo6k=; b=Kzrm3AjSIcsfm+HUTeW6ZWBp+H
        yaUq8R061U2X0bv0GJfMuUP0Caqme+utXHF1nEGJG6+G7PowW/UBlaYbMY8sRM2x8XNbBm5CfJyCJ
        Ebq4o+gO4GrykA7KWNWe0KuXaNcDgVqc8nPQ4VkCLTZYAHo2ddpp15mxNXBOE12nRB528DkJbI7hw
        WjWrY074CdM2/s7rAFOo3vdyNeX6C9CkErlpJGr8A7hw2N7DTdHbVgyPXm4LGnNsChAP8G+xRH8yh
        XcrUldBorBcqPF1ZG70QTOmATKRcJ9FIYeSbIIsh2j7pmtMih6QNCV9/pVWodIAFtvL+5HnNok1B/
        v47GyDoA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krlk5-00027N-Je; Tue, 22 Dec 2020 17:46:37 +0000
Date:   Tue, 22 Dec 2020 17:46:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201222174637.GK874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201222162027.GJ874@casper.infradead.org>
 <20201222162925.GC3248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222162925.GC3248@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:29:25AM -0500, Vivek Goyal wrote:
> On Tue, Dec 22, 2020 at 04:20:27PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > > +{
> > > +	struct ovl_fs *ofs = sb->s_fs_info;
> > > +	struct super_block *upper_sb;
> > > +	int ret;
> > > +
> > > +	if (!ovl_upper_mnt(ofs))
> > > +		return 0;
> > > +
> > > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > +
> > > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > > +		return 0;
> > > +
> > > +	/* Something changed, must use slow path */
> > > +	spin_lock(&file->f_lock);
> > > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > > +	spin_unlock(&file->f_lock);
> > 
> > Why are you microoptimising syncfs()?  Are there really applications which
> > call syncfs() in a massively parallel manner on the same file descriptor?
> 
> This is atleast theoritical race. I am not aware which application can
> trigger this race. So to me it makes sense to fix the race.
> 
> Jeff Layton also posted a fix for syncfs().
> 
> https://lore.kernel.org/linux-fsdevel/20201219134804.20034-1-jlayton@kernel.org/
> 
> To me it makes sense to fix the race irrespective of the fact if somebody
> hit it or not. People end up copying code in other parts of kernel and
> and they will atleast copy race free code.

Let me try again.  "Why are you trying to avoid taking the spinlock?"
