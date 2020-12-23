Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5772E1C65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgLWMy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 07:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgLWMy1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:54:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAC8E22475;
        Wed, 23 Dec 2020 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608728026;
        bh=uPZNDtdrztbbNslQqwSCsY2Q8OQGkhzZMUMvfOws8Cs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FfrwdVZGXUJhycIVF3YTAMMF64sSuwIGy27yC70XQjMPnS6P6ODX4KsNOmhTfBZms
         cdWzsjLOfRpsIa/K3kKAY4H5bZkZniP+3+1w6cWBUtIL2jJsHQRl3FXkI8E5AP52lk
         02S3o9WA5C/d6GTnWlLAi2/QHhoI3mLpf3Dmi+MJNarqM5pCWzuqvIcmGhEPE/85py
         W4pKRJegVTvZUa9GEdUZnPwVwNWvs/RPLCc+vjNR3k7zoN5LNJq408+FcOS4qyT8vs
         +rIcMZpvnc+X4O/hUffSPfjkvTQQG+a80zq6A7zTiR3JH9NnhNi/QAcfYdmv3Mhpq6
         GEs7+Q0DmZEdQ==
Message-ID: <dbc580cf9346aca06a3383533a09a794ca68917c.camel@kernel.org>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
From:   Jeff Layton <jlayton@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk, hch@lst.de
Date:   Wed, 23 Dec 2020 07:53:43 -0500
In-Reply-To: <20201222175518.GD3248@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
         <20201221195055.35295-4-vgoyal@redhat.com>
         <20201222162027.GJ874@casper.infradead.org>
         <20201222162925.GC3248@redhat.com>
         <20201222174637.GK874@casper.infradead.org>
         <20201222175518.GD3248@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-12-22 at 12:55 -0500, Vivek Goyal wrote:
> On Tue, Dec 22, 2020 at 05:46:37PM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 22, 2020 at 11:29:25AM -0500, Vivek Goyal wrote:
> > > On Tue, Dec 22, 2020 at 04:20:27PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > > > > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > > > > +{
> > > > > +	struct ovl_fs *ofs = sb->s_fs_info;
> > > > > +	struct super_block *upper_sb;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!ovl_upper_mnt(ofs))
> > > > > +		return 0;
> > > > > +
> > > > > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > > +
> > > > > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > > > > +		return 0;
> > > > > +
> > > > > +	/* Something changed, must use slow path */
> > > > > +	spin_lock(&file->f_lock);
> > > > > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > > > > +	spin_unlock(&file->f_lock);
> > > > 
> > > > Why are you microoptimising syncfs()?  Are there really applications which
> > > > call syncfs() in a massively parallel manner on the same file descriptor?
> > > 
> > > This is atleast theoritical race. I am not aware which application can
> > > trigger this race. So to me it makes sense to fix the race.
> > > 
> > > Jeff Layton also posted a fix for syncfs().
> > > 
> > > https://lore.kernel.org/linux-fsdevel/20201219134804.20034-1-jlayton@kernel.org/
> > > 
> > > To me it makes sense to fix the race irrespective of the fact if somebody
> > > hit it or not. People end up copying code in other parts of kernel and
> > > and they will atleast copy race free code.
> > 
> > Let me try again.  "Why are you trying to avoid taking the spinlock?"
> 
> Aha.., sorry, I misunderstood your question. I don't have a good answer.
> I just copied the code from Jeff Layton's patch.
> 
> Agreed that cost of taking spin lock will not be significant until
> syncfs() is called at high frequency. Having said that, most of the
> time taking spin lock will not be needed, so avoiding it with
> a simple call to errseq_check() sounds reasonable too.
> 
> I don't have any strong opinions here. I am fine with any of the
> implementation people like.
> 

It is a micro-optimization, but we'll almost always be able to avoid
taking the lock altogether. Errors here should be very, very infrequent.

That said I don't have strong feelings on this either.
-- 
Jeff Layton <jlayton@kernel.org>

