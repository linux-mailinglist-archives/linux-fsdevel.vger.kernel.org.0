Return-Path: <linux-fsdevel+bounces-1259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BD7D8693
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A78A2820AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E8381BA;
	Thu, 26 Oct 2023 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjGpmaPE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNlmgScq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1051241FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 16:16:56 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5317093
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 09:16:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 078BB1FE7C;
	Thu, 26 Oct 2023 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698337014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYTH4yMZVdBwlSKfLNE9uAE6AYye0KxaGq9YcrI3ijE=;
	b=mjGpmaPE8Pne25tpBgqvZoZhai8dsOtiaqr7gXU06UGu0EPDj/FWu9LWFitzK/GLTSgRev
	akjvvKa7DvMSFvEQip+ojV+Agb55QgP5ZGGKcbKSS8TX7sq5yGEckYpWQjlvlu1sCu5s/W
	cFpUC36GkjikNzBIQR8mjU1ZP5Vc9k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698337014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYTH4yMZVdBwlSKfLNE9uAE6AYye0KxaGq9YcrI3ijE=;
	b=HNlmgScqjnr3H3SAqT3Kwed6C7Nci43fz24iL7EimY0nvJMIaQrLvDZj+UJabfbcYmoyyd
	/cZiu4CIBXAiXzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECC28133F5;
	Thu, 26 Oct 2023 16:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mgy5OfWQOmWcEwAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 16:16:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59630A05BC; Thu, 26 Oct 2023 18:16:53 +0200 (CEST)
Date: Thu, 26 Oct 2023 18:16:53 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Subject: Re: [RFC] weirdness in f2fs_rename() with RENAME_WHITEOUT
Message-ID: <20231026161653.cunh4ojohq6mw2ye@quack3>
References: <20231011203412.GA85476@ZenIV>
 <CAHk-=wjSbompMCgMwR2-MB59QDB+OZ7Ohp878QoDc9o7z4pbNg@mail.gmail.com>
 <20231011215138.GX800259@ZenIV>
 <20231011230105.GA92231@ZenIV>
 <CAHfrynNbfPtAjY4Y7N0cyWyH35dyF_BcpfR58ASCCC7=-TfSFw@mail.gmail.com>
 <20231012050209.GY800259@ZenIV>
 <20231012103157.mmn6sv4e6hfrqkai@quack3>
 <20231012145758.yopnkhijksae5akp@quack3>
 <20231012191551.GZ800259@ZenIV>
 <20231017055040.GN800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017055040.GN800259@ZenIV>

Jaegeuk, Chao, any comment on this? It really looks like a filesystem
corruption issue in f2fs when whiteouts are used...

								Honza

On Tue 17-10-23 06:50:40, Al Viro wrote:
> [f2fs folks Cc'd]
> 
> 	There's something very odd in f2fs_rename();
> this:
>         f2fs_down_write(&F2FS_I(old_inode)->i_sem);
>         if (!old_dir_entry || whiteout)
>                 file_lost_pino(old_inode);
>         else   
>                 /* adjust dir's i_pino to pass fsck check */
>                 f2fs_i_pino_write(old_inode, new_dir->i_ino);
>         f2fs_up_write(&F2FS_I(old_inode)->i_sem);
> and this:
>                 if (old_dir != new_dir && !whiteout)
>                         f2fs_set_link(old_inode, old_dir_entry,
>                                                 old_dir_page, new_dir);
>                 else
>                         f2fs_put_page(old_dir_page, 0);
> The latter really stinks, especially considering
> struct dentry *f2fs_get_parent(struct dentry *child)
> {
>         struct page *page;
>         unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &page);
> 
>         if (!ino) {
>                 if (IS_ERR(page))
>                         return ERR_CAST(page);
>                 return ERR_PTR(-ENOENT);
>         }
>         return d_obtain_alias(f2fs_iget(child->d_sb, ino));
> }
> 
> You want correct inumber in the ".." link.  And cross-directory
> rename does move the source to new parent, even if you'd been asked
> to leave a whiteout in the old place.
> 
> Why is that stuff conditional on whiteout?  AFAICS, that went into the
> tree in the same commit that added RENAME_WHITEOUT support on f2fs,
> mentioning "For now, we just try to follow the way that xfs/ext4 use"
> in commit message.  But ext4 does *NOT* do anything of that sort -
> at the time of that commit the relevant piece had been
>         if (old.dir_bh) {
> 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
> and old.dir_bh is set by
>                 retval = ext4_rename_dir_prepare(handle, &old);
> a few lines prior, which is not conditional upon the whiteout.
> 
> What am I missing there?
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

