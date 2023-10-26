Return-Path: <linux-fsdevel+bounces-1260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215E7D86E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E790B21077
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234712B69;
	Thu, 26 Oct 2023 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y35dPWwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014C440B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 16:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921A0C433C8;
	Thu, 26 Oct 2023 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698338690;
	bh=VkmD28XmKapcsmkLaNHg30vEdJW4Z2Gx2cq73Aex2YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y35dPWwUPLw+ExW99iaMXX/vYLtPHLPJnv2fEAO15fceuuI0FGyHEbdtgFMELLuhD
	 l7Hj3Sy65wEyGS9JIhIgfqzKQw1ZUtWqBdULoDLrvRgKE4/Zrshcad6xatPlbQj/Q5
	 on145ggPLMZzsDfEDyn/WpNdOefr5uMcY2aj62i7hbsXXf4SgYrSbOtREHx3fBzU78
	 8N82x/gvxVPC9jVyFfwOT+Iji+05/84++zaAH2Xj1B5g/rkw8DyjgMKq9ntAZR/eZT
	 PvHvKZOIon9Sl6kdCTtQohChP1j+wUG707WezLfeJFShpfFjaN0MEEUZ1HghXqOTEi
	 TwMYTUFE/90Zg==
Date: Thu, 26 Oct 2023 09:44:49 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [RFC] weirdness in f2fs_rename() with RENAME_WHITEOUT
Message-ID: <ZTqXgdiK7DAyz_IB@google.com>
References: <CAHk-=wjSbompMCgMwR2-MB59QDB+OZ7Ohp878QoDc9o7z4pbNg@mail.gmail.com>
 <20231011215138.GX800259@ZenIV>
 <20231011230105.GA92231@ZenIV>
 <CAHfrynNbfPtAjY4Y7N0cyWyH35dyF_BcpfR58ASCCC7=-TfSFw@mail.gmail.com>
 <20231012050209.GY800259@ZenIV>
 <20231012103157.mmn6sv4e6hfrqkai@quack3>
 <20231012145758.yopnkhijksae5akp@quack3>
 <20231012191551.GZ800259@ZenIV>
 <20231017055040.GN800259@ZenIV>
 <20231026161653.cunh4ojohq6mw2ye@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026161653.cunh4ojohq6mw2ye@quack3>

On 10/26, Jan Kara wrote:
> Jaegeuk, Chao, any comment on this? It really looks like a filesystem
> corruption issue in f2fs when whiteouts are used...

Thanks Al and Jan for headsup.
Let us take a look as soon as possible.

> 
> 								Honza
> 
> On Tue 17-10-23 06:50:40, Al Viro wrote:
> > [f2fs folks Cc'd]
> > 
> > 	There's something very odd in f2fs_rename();
> > this:
> >         f2fs_down_write(&F2FS_I(old_inode)->i_sem);
> >         if (!old_dir_entry || whiteout)
> >                 file_lost_pino(old_inode);
> >         else   
> >                 /* adjust dir's i_pino to pass fsck check */
> >                 f2fs_i_pino_write(old_inode, new_dir->i_ino);
> >         f2fs_up_write(&F2FS_I(old_inode)->i_sem);
> > and this:
> >                 if (old_dir != new_dir && !whiteout)
> >                         f2fs_set_link(old_inode, old_dir_entry,
> >                                                 old_dir_page, new_dir);
> >                 else
> >                         f2fs_put_page(old_dir_page, 0);
> > The latter really stinks, especially considering
> > struct dentry *f2fs_get_parent(struct dentry *child)
> > {
> >         struct page *page;
> >         unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &page);
> > 
> >         if (!ino) {
> >                 if (IS_ERR(page))
> >                         return ERR_CAST(page);
> >                 return ERR_PTR(-ENOENT);
> >         }
> >         return d_obtain_alias(f2fs_iget(child->d_sb, ino));
> > }
> > 
> > You want correct inumber in the ".." link.  And cross-directory
> > rename does move the source to new parent, even if you'd been asked
> > to leave a whiteout in the old place.
> > 
> > Why is that stuff conditional on whiteout?  AFAICS, that went into the
> > tree in the same commit that added RENAME_WHITEOUT support on f2fs,
> > mentioning "For now, we just try to follow the way that xfs/ext4 use"
> > in commit message.  But ext4 does *NOT* do anything of that sort -
> > at the time of that commit the relevant piece had been
> >         if (old.dir_bh) {
> > 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
> > and old.dir_bh is set by
> >                 retval = ext4_rename_dir_prepare(handle, &old);
> > a few lines prior, which is not conditional upon the whiteout.
> > 
> > What am I missing there?
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

