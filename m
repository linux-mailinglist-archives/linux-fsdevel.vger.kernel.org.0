Return-Path: <linux-fsdevel+bounces-932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C37D3955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3794A1C20A41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8291BDE7;
	Mon, 23 Oct 2023 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKQ771sX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E081BDC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 14:30:59 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427BAD7D;
	Mon, 23 Oct 2023 07:30:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32dc918d454so2166257f8f.2;
        Mon, 23 Oct 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071455; x=1698676255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8uwT+INyfSEhUg8urPKaaeAxSI9K09w0usUEfl77gdI=;
        b=nKQ771sX5m7t0+E/QZ69PXcEjyj80kbrIr1abYJ9Mi8Pv/lqqxr6tyhOyw+1lY9vGG
         76rT950UfjfB0VgHF4g3rjMSZ4BPSsQT9nZ5LaJYmSsU95xEnnEsZyWEY7CHBWhtOi9L
         YeecInt9/ferdssdgMx6d+uK21iEzDMxjljWPgv+EAtsYGbWxsJRcaXDHCNv9gFQsifX
         r3TD+DtsupsJMQtGUoZ+s2+QGGwDYOGze0AqakGgH+saXMFg4Y5lPUjy31bGXcy+ZjvS
         4bqz1+LqfMkYlaZqr/nk8V0J3T67q1iZBqDhrawFSO+DQjH+Bfxc8dLQefIKT4WYWixz
         VGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071455; x=1698676255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uwT+INyfSEhUg8urPKaaeAxSI9K09w0usUEfl77gdI=;
        b=TCO5lnUChGleBA+YyESCPONRV32orrKmUYXZvWV68nzw/9KTasBfPIoWtu/6LDV499
         wCmaSLVk85JL24r9BmoLk/Bx7ta/K8VLM273RPJOyJGOw8anDHdStouuq0iXO/u6blP9
         k7t9EUOIelEBtNNRjhTSZ2L3urwBbE8GmKDn0QwarX9AoYJbRVCVhdlDNRDF6ggQvZ4L
         WNogExQTT2tszxUAfLU80D8+pyaD8Mi2/nl0jVXZSO00iDefyV5TS551TFCBgTTNLLCc
         6GzBOZKxyeR7g1xHuFmzSTOySewaSm7QtPikSWJkWUTAocne/hx3T5euZWHmKTtmFbPx
         cbLg==
X-Gm-Message-State: AOJu0Yz+ZGvjwerEKI0RPk6JfmMDRdOOWWa3T+YnlU7mzxrLgVVALe99
	SoiqNRnsPmZtbtcsxQQhCKo=
X-Google-Smtp-Source: AGHT+IEjDkVly3YZ2IksWBbnieMRKmSsB81SGeuDejCUCrtn9Fh79CTXmeBjVuLRRD6ITnP248WjTg==
X-Received: by 2002:adf:ea88:0:b0:32d:8961:d864 with SMTP id s8-20020adfea88000000b0032d8961d864mr6074731wrm.48.1698071455338;
        Mon, 23 Oct 2023 07:30:55 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b0031c6e1ea4c7sm7929892wrr.90.2023.10.23.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:30:54 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] fs: report f_fsid from s_dev for "simple" filesystems
Date: Mon, 23 Oct 2023 17:30:49 +0300
Message-Id: <20231023143049.2944970-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many "simple" filesystems (*) that report null f_fsid in
statfs(2).  Those "simple" filesystems report sb->s_dev as the st_dev
field of the stat syscalls for all inodes of the filesystem (**).

In order to enable fanotify reporting of events with fsid on those
"simple" filesystems, report the sb->s_dev number in f_fsid field of
statfs(2).

(*) For most of the "simple" filesystem refered to in this commit, the
->statfs() operation is simple_statfs(). Some of those fs assign the
simple_statfs() method directly in their ->s_op struct and some assign it
indirectly via a call to simple_fill_super() or to pseudo_fs_fill_super()
with either custom or "simple" s_op.
We also make the same change to efivarfs and hugetlbfs, although they do
not use simple_statfs(), because they use the simple_* inode opreations
(e.g. simple_lookup()).

(**) For most of the "simple" filesystems, the ->getattr() method is not
assigned, so stat() is implemented by generic_fillattr().  A few "simple"
filesystem use the simple_getattr() method which also calls
generic_fillattr() to fill most of the stat struct.

The two exceptions are procfs and 9p. procfs implements several different
->getattr() methods, but they all end up calling generic_fillattr() to
fill the st_dev field from sb->s_dev.

9p has more complicated ->getattr() methods, but they too, end up calling
generic_fillattr() to fill the st_dev field from sb->s_dev.

Note that 9p and kernfs also call simple_statfs() from custom ->statfs()
methods which already fill the f_fsid field, but v9fs_statfs() calls
simple_statfs() only in case f_fsid was not filled and kenrfs_statfs()
overwrites f_fsid after calling simple_statfs().

Link: https://lore.kernel.org/r/20230919094820.g5bwharbmy2dq46w@quack3/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This is a variant of the approach that you suggested in the Link above.
The two variations from your suggestion are:

1. I chose to use s_dev instead of s_uuid - I see no point in generating
   s_uuid for those simple filesystems. IMO, for the simple filesystems
   without open_by_handle_at() support, fanotify fid doesn't need to be
   more unique than {st_dev,st_ino}, because the inode mark pins the
   inode and prevent st_dev,st_ino collisions.

2. f_fsid is not filled by vfs according to fstype flag, but by
   ->statfs() implementations (simple_statfs() for the majority).

When applied together with the generic AT_HANDLE_FID support patches [1],
all of those simple filesystems can be watches with FAN_ERPORT_FID.

According to your audit of filesystems in the Link above, this leaves:
"afs, coda, nfs - networking filesystems where inotify and fanotify have
                  dubious value anyway.

 freevxfs - the only real filesystem without f_fsid. Trivial to handle one
            way or the other.
"

There are two other filesystems that I found in my audit which also don't
fill f_fsid: fuse and gfs2.

fuse is also a sort of a networking filesystems. Also, fuse supports NFS
export (as does nfs in some configurations) and I would like to stick to
the rule that filesystems the support decodable file handles, use an fsid
that is more unique than s_dev.

gfs2 already has s_uuid, so we know what f_fsid should be.
BTW, afs also has a server uuid, it just doesn't set s_uuid.

For btrfs, which fills a non-null, but non-uniform fsid, I already have
patches for inode_get_fsid [2] per your suggestion.

IMO, we can defer dealing with all those remaining cases for later and
solve the "simple" cases first.

Do you agree?

So far, there were no objections to the generic AT_HANDLE_FID support
patches [1], although I am still waiting on an ACK from you on the last
patch. If this fsid patch is also aaceptable, do you think they could
be candidated for upcoming 6.7?

Thanks,
Amir.

[1] https://lore.kernel.org/r/20231018100000.2453965-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/inode_fsid

 fs/efivarfs/super.c  | 2 ++
 fs/hugetlbfs/inode.c | 2 ++
 fs/libfs.c           | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 996271473609..2933090ad11f 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -30,6 +30,7 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
 			 EFI_VARIABLE_RUNTIME_ACCESS;
 	u64 storage_space, remaining_space, max_variable_size;
+	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
 	efi_status_t status;
 
 	/* Some UEFI firmware does not implement QueryVariableInfo() */
@@ -53,6 +54,7 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks	= storage_space;
 	buf->f_bfree	= remaining_space;
 	buf->f_type	= dentry->d_sb->s_magic;
+	buf->f_fsid	= u64_to_fsid(id);
 
 	/*
 	 * In f_bavail we declare the free space that the kernel will allow writing
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..c003a27be6fe 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1204,7 +1204,9 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
 	struct hstate *h = hstate_inode(d_inode(dentry));
+	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
 
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_type = HUGETLBFS_MAGIC;
 	buf->f_bsize = huge_page_size(h);
 	if (sbinfo) {
diff --git a/fs/libfs.c b/fs/libfs.c
index 37f2d34ee090..8117b24b929d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -41,6 +41,9 @@ EXPORT_SYMBOL(simple_getattr);
 
 int simple_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	u64 id = huge_encode_dev(dentry->d_sb->s_dev);
+
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_type = dentry->d_sb->s_magic;
 	buf->f_bsize = PAGE_SIZE;
 	buf->f_namelen = NAME_MAX;
-- 
2.34.1


