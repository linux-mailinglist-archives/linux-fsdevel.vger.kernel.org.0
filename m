Return-Path: <linux-fsdevel+bounces-1013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7819D7D4E72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005DB2819AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7226283;
	Tue, 24 Oct 2023 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YjdOxtqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mrEUG6pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24D7498
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 10:58:54 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD3109;
	Tue, 24 Oct 2023 03:58:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0CDD1FD8B;
	Tue, 24 Oct 2023 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698145130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfWiK2J4LcfYCXN2E5eTL3h5Rd/X+mU2pyacm/S+Zos=;
	b=YjdOxtqPnBFysJ8z7JAP2eEOLt4p8Cxh6XZiL9/ttc8+T55yo8TbBH5+8U5x0Aw3LklLNR
	c3vDpBPnQsNcTsRvHnxlmaUZE0pAz7kNqw1ZMJdhDjIzSxuqclXsQwqLC2+nfxmy2TP4lN
	MsYJPMtkaaWxqw9eWblCQFBwOrrY7XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698145130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfWiK2J4LcfYCXN2E5eTL3h5Rd/X+mU2pyacm/S+Zos=;
	b=mrEUG6pBFa9mXije4YNR5yf+yCbaFljOXklerk8FLZa+/j+7dHBJF4dpeHr5ZfOx2PAkSI
	dYKKQ70R0dTxYEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF7591391C;
	Tue, 24 Oct 2023 10:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VNKwLmqjN2WQNgAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 10:58:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B680A05BC; Tue, 24 Oct 2023 12:58:50 +0200 (CEST)
Date: Tue, 24 Oct 2023 12:58:50 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] fs: report f_fsid from s_dev for "simple" filesystems
Message-ID: <20231024105850.uooxnz5b7wtmrpbs@quack3>
References: <20231023143049.2944970-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023143049.2944970-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Mon 23-10-23 17:30:49, Amir Goldstein wrote:
> There are many "simple" filesystems (*) that report null f_fsid in
> statfs(2).  Those "simple" filesystems report sb->s_dev as the st_dev
> field of the stat syscalls for all inodes of the filesystem (**).
> 
> In order to enable fanotify reporting of events with fsid on those
> "simple" filesystems, report the sb->s_dev number in f_fsid field of
> statfs(2).
> 
> (*) For most of the "simple" filesystem refered to in this commit, the
> ->statfs() operation is simple_statfs(). Some of those fs assign the
> simple_statfs() method directly in their ->s_op struct and some assign it
> indirectly via a call to simple_fill_super() or to pseudo_fs_fill_super()
> with either custom or "simple" s_op.
> We also make the same change to efivarfs and hugetlbfs, although they do
> not use simple_statfs(), because they use the simple_* inode opreations
> (e.g. simple_lookup()).
> 
> (**) For most of the "simple" filesystems, the ->getattr() method is not
> assigned, so stat() is implemented by generic_fillattr().  A few "simple"
> filesystem use the simple_getattr() method which also calls
> generic_fillattr() to fill most of the stat struct.
> 
> The two exceptions are procfs and 9p. procfs implements several different
> ->getattr() methods, but they all end up calling generic_fillattr() to
> fill the st_dev field from sb->s_dev.
> 
> 9p has more complicated ->getattr() methods, but they too, end up calling
> generic_fillattr() to fill the st_dev field from sb->s_dev.
> 
> Note that 9p and kernfs also call simple_statfs() from custom ->statfs()
> methods which already fill the f_fsid field, but v9fs_statfs() calls
> simple_statfs() only in case f_fsid was not filled and kenrfs_statfs()
> overwrites f_fsid after calling simple_statfs().
> 
> Link: https://lore.kernel.org/r/20230919094820.g5bwharbmy2dq46w@quack3/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. I agree with your choice of sb->s_dev for fsid. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Jan,
> 
> This is a variant of the approach that you suggested in the Link above.
> The two variations from your suggestion are:
> 
> 1. I chose to use s_dev instead of s_uuid - I see no point in generating
>    s_uuid for those simple filesystems. IMO, for the simple filesystems
>    without open_by_handle_at() support, fanotify fid doesn't need to be
>    more unique than {st_dev,st_ino}, because the inode mark pins the
>    inode and prevent st_dev,st_ino collisions.
> 
> 2. f_fsid is not filled by vfs according to fstype flag, but by
>    ->statfs() implementations (simple_statfs() for the majority).
> 
> When applied together with the generic AT_HANDLE_FID support patches [1],
> all of those simple filesystems can be watches with FAN_ERPORT_FID.
> 
> According to your audit of filesystems in the Link above, this leaves:
> "afs, coda, nfs - networking filesystems where inotify and fanotify have
>                   dubious value anyway.
> 
>  freevxfs - the only real filesystem without f_fsid. Trivial to handle one
>             way or the other.
> "
> 
> There are two other filesystems that I found in my audit which also don't
> fill f_fsid: fuse and gfs2.
> 
> fuse is also a sort of a networking filesystems. Also, fuse supports NFS
> export (as does nfs in some configurations) and I would like to stick to
> the rule that filesystems the support decodable file handles, use an fsid
> that is more unique than s_dev.
> 
> gfs2 already has s_uuid, so we know what f_fsid should be.
> BTW, afs also has a server uuid, it just doesn't set s_uuid.
> 
> For btrfs, which fills a non-null, but non-uniform fsid, I already have
> patches for inode_get_fsid [2] per your suggestion.
> 
> IMO, we can defer dealing with all those remaining cases for later and
> solve the "simple" cases first.
> 
> Do you agree?
> 
> So far, there were no objections to the generic AT_HANDLE_FID support
> patches [1], although I am still waiting on an ACK from you on the last
> patch. If this fsid patch is also aaceptable, do you think they could
> be candidated for upcoming 6.7?
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/r/20231018100000.2453965-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/inode_fsid
> 
>  fs/efivarfs/super.c  | 2 ++
>  fs/hugetlbfs/inode.c | 2 ++
>  fs/libfs.c           | 3 +++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 996271473609..2933090ad11f 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -30,6 +30,7 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
>  			 EFI_VARIABLE_RUNTIME_ACCESS;
>  	u64 storage_space, remaining_space, max_variable_size;
> +	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
>  	efi_status_t status;
>  
>  	/* Some UEFI firmware does not implement QueryVariableInfo() */
> @@ -53,6 +54,7 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_blocks	= storage_space;
>  	buf->f_bfree	= remaining_space;
>  	buf->f_type	= dentry->d_sb->s_magic;
> +	buf->f_fsid	= u64_to_fsid(id);
>  
>  	/*
>  	 * In f_bavail we declare the free space that the kernel will allow writing
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 316c4cebd3f3..c003a27be6fe 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1204,7 +1204,9 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
>  	struct hstate *h = hstate_inode(d_inode(dentry));
> +	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
>  
> +	buf->f_fsid = u64_to_fsid(id);
>  	buf->f_type = HUGETLBFS_MAGIC;
>  	buf->f_bsize = huge_page_size(h);
>  	if (sbinfo) {
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 37f2d34ee090..8117b24b929d 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -41,6 +41,9 @@ EXPORT_SYMBOL(simple_getattr);
>  
>  int simple_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
> +	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
> +
> +	buf->f_fsid = u64_to_fsid(id);
>  	buf->f_type = dentry->d_sb->s_magic;
>  	buf->f_bsize = PAGE_SIZE;
>  	buf->f_namelen = NAME_MAX;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

