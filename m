Return-Path: <linux-fsdevel+bounces-72918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E89D05263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCE64301A3A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AC2F12CE;
	Thu,  8 Jan 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6o0xZII";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQxzzizV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6o0xZII";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQxzzizV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C652E8E16
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894012; cv=none; b=sMQes37o+VRlYXd+KPKxVyKPHmfQ/VErYTm37C1Un3chJmaCCppW6mVRH1Gpc0IKWGL479hSqWi7PThTztT/3v89HhFpkPwJvT/joFzurnIkDQNMOS5B6Rtak4WNPmTr0lfU105IPHMlcQeGRIQHaTxkJPUd6EihkQFVQWoyV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894012; c=relaxed/simple;
	bh=9ISoZ8/AESNCpXRzK2y7Gh8rToQ7FulDj9jwvBYDW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfvOyeOSCGQTdetndySIQ44/+1WOkdlNX7hmtqhlbjm+VH8AsFiaXPwYLqW/L3i8pmZyLV/kzIf3Ss23WPXaVFeW7PV0dZs8sowlEs7Ozv/Fa5Z6+jaTL1pDzzHXJUlsjoz6m1WhIAlCyNBd9eThvRdkZJ+hRn0LVR4rgxwf5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6o0xZII; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQxzzizV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6o0xZII; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQxzzizV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 722E55CBEB;
	Thu,  8 Jan 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767894008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbYulziCehk0+dq0CXHXUlJblsepps/x0pBz736+F88=;
	b=v6o0xZIIolBq3Kc+VF6+9Ya5E6t2G34FsAJ4qlruIPlrp3yRFZ1mosmLKssOtf8GopFPv6
	pdM5KNdg6uqkpzJC2OCiQs93p2MdVtM1C1AsH2TngC8tV9OjZ7anbkGl2iE3fhCSU9mvhX
	K1VxnfPudBQRQJ1Q1ovU0oM49Yj5Rmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767894008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbYulziCehk0+dq0CXHXUlJblsepps/x0pBz736+F88=;
	b=iQxzzizVuPHl0WVwxtpKrivs8r+dbY1HBg67emHdQ+8PTu3CciNeemY/i1L/NaN8QOR0LX
	w4waIzEE2aIOLGCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767894008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbYulziCehk0+dq0CXHXUlJblsepps/x0pBz736+F88=;
	b=v6o0xZIIolBq3Kc+VF6+9Ya5E6t2G34FsAJ4qlruIPlrp3yRFZ1mosmLKssOtf8GopFPv6
	pdM5KNdg6uqkpzJC2OCiQs93p2MdVtM1C1AsH2TngC8tV9OjZ7anbkGl2iE3fhCSU9mvhX
	K1VxnfPudBQRQJ1Q1ovU0oM49Yj5Rmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767894008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbYulziCehk0+dq0CXHXUlJblsepps/x0pBz736+F88=;
	b=iQxzzizVuPHl0WVwxtpKrivs8r+dbY1HBg67emHdQ+8PTu3CciNeemY/i1L/NaN8QOR0LX
	w4waIzEE2aIOLGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF653EA65;
	Thu,  8 Jan 2026 17:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TDitFvjrX2kXBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:40:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0782CA0B23; Thu,  8 Jan 2026 18:40:08 +0100 (CET)
Date: Thu, 8 Jan 2026 18:40:07 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLwapsqjcu3srfensh8n36bg4p)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> Yesterday, I sent patches to fix how directory delegation support is
> handled on filesystems where the should be disabled [1]. That set is
> appropriate for v6.19. For v7.0, I want to make lease support be more
> opt-in, rather than opt-out:
> 
> For historical reasons, when ->setlease() file_operation is set to NULL,
> the default is to use the kernel-internal lease implementation. This
> means that if you want to disable them, you need to explicitly set the
> ->setlease() file_operation to simple_nosetlease() or the equivalent.
> 
> This has caused a number of problems over the years as some filesystems
> have inadvertantly allowed leases to be acquired simply by having left
> it set to NULL. It would be better if filesystems had to opt-in to lease
> support, particularly with the advent of directory delegations.
> 
> This series has sets the ->setlease() operation in a pile of existing
> local filesystems to generic_setlease() and then changes
> kernel_setlease() to return -EINVAL when the setlease() operation is not
> set.
> 
> With this change, new filesystems will need to explicitly set the
> ->setlease() operations in order to provide lease and delegation
> support.
> 
> I mainly focused on filesystems that are NFS exportable, since NFS and
> SMB are the main users of file leases, and they tend to end up exporting
> the same filesystem types. Let me know if I've missed any.

So, what about kernfs and fuse? They seem to be exportable and don't have
.setlease set...

								Honza

> 
> [1]: https://lore.kernel.org/linux-fsdevel/20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (24):
>       fs: add setlease to generic_ro_fops and read-only filesystem directory operations
>       affs: add setlease file operation
>       btrfs: add setlease file operation
>       erofs: add setlease file operation
>       ext2: add setlease file operation
>       ext4: add setlease file operation
>       exfat: add setlease file operation
>       f2fs: add setlease file operation
>       fat: add setlease file operation
>       gfs2: add a setlease file operation
>       jffs2: add setlease file operation
>       jfs: add setlease file operation
>       nilfs2: add setlease file operation
>       ntfs3: add setlease file operation
>       ocfs2: add setlease file operation
>       orangefs: add setlease file operation
>       overlayfs: add setlease file operation
>       squashfs: add setlease file operation
>       tmpfs: add setlease file operation
>       udf: add setlease file operation
>       ufs: add setlease file operation
>       xfs: add setlease file operation
>       filelock: default to returning -EINVAL when ->setlease operation is NULL
>       fs: remove simple_nosetlease()
> 
>  Documentation/filesystems/porting.rst |  9 +++++++++
>  Documentation/filesystems/vfs.rst     |  9 ++++++---
>  fs/9p/vfs_dir.c                       |  2 --
>  fs/9p/vfs_file.c                      |  2 --
>  fs/affs/dir.c                         |  2 ++
>  fs/affs/file.c                        |  2 ++
>  fs/befs/linuxvfs.c                    |  2 ++
>  fs/btrfs/file.c                       |  2 ++
>  fs/btrfs/inode.c                      |  2 ++
>  fs/ceph/dir.c                         |  2 --
>  fs/ceph/file.c                        |  1 -
>  fs/cramfs/inode.c                     |  2 ++
>  fs/efs/dir.c                          |  2 ++
>  fs/erofs/data.c                       |  2 ++
>  fs/erofs/dir.c                        |  2 ++
>  fs/exfat/dir.c                        |  2 ++
>  fs/exfat/file.c                       |  2 ++
>  fs/ext2/dir.c                         |  2 ++
>  fs/ext2/file.c                        |  2 ++
>  fs/ext4/dir.c                         |  2 ++
>  fs/ext4/file.c                        |  2 ++
>  fs/f2fs/dir.c                         |  2 ++
>  fs/f2fs/file.c                        |  2 ++
>  fs/fat/dir.c                          |  2 ++
>  fs/fat/file.c                         |  2 ++
>  fs/freevxfs/vxfs_lookup.c             |  2 ++
>  fs/fuse/dir.c                         |  1 -
>  fs/gfs2/file.c                        |  3 +--
>  fs/isofs/dir.c                        |  2 ++
>  fs/jffs2/dir.c                        |  2 ++
>  fs/jffs2/file.c                       |  2 ++
>  fs/jfs/file.c                         |  2 ++
>  fs/jfs/namei.c                        |  2 ++
>  fs/libfs.c                            | 20 ++------------------
>  fs/locks.c                            |  3 +--
>  fs/nfs/dir.c                          |  1 -
>  fs/nfs/file.c                         |  1 -
>  fs/nilfs2/dir.c                       |  3 ++-
>  fs/nilfs2/file.c                      |  2 ++
>  fs/ntfs3/dir.c                        |  3 +++
>  fs/ntfs3/file.c                       |  3 +++
>  fs/ocfs2/file.c                       |  5 +++++
>  fs/orangefs/dir.c                     |  4 +++-
>  fs/orangefs/file.c                    |  1 +
>  fs/overlayfs/file.c                   |  2 ++
>  fs/overlayfs/readdir.c                |  2 ++
>  fs/qnx4/dir.c                         |  2 ++
>  fs/qnx6/dir.c                         |  2 ++
>  fs/read_write.c                       |  2 ++
>  fs/smb/client/cifsfs.c                |  1 -
>  fs/squashfs/dir.c                     |  2 ++
>  fs/squashfs/file.c                    |  4 +++-
>  fs/udf/dir.c                          |  2 ++
>  fs/udf/file.c                         |  2 ++
>  fs/ufs/dir.c                          |  2 ++
>  fs/ufs/file.c                         |  2 ++
>  fs/vboxsf/dir.c                       |  1 -
>  fs/vboxsf/file.c                      |  1 -
>  fs/xfs/xfs_file.c                     |  3 +++
>  include/linux/fs.h                    |  1 -
>  mm/shmem.c                            |  2 ++
>  61 files changed, 116 insertions(+), 42 deletions(-)
> ---
> base-commit: 731ce71a6c8adb8b8f873643beacaeedc1564500
> change-id: 20260107-setlease-6-20-299eb5695c5a
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

