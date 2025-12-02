Return-Path: <linux-fsdevel+bounces-70469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A4C9C476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD20F34977F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D32853F8;
	Tue,  2 Dec 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="U6hPtoXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB0281369
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694007; cv=none; b=C33qm9lY7A4MRjan4REzBJYvcsv2RSyogQvI9Snzaf1waO5PKp/EOwBZKjep3pcD94buyNGMLywQjd9JPGLEia2j37zx4VZM8ZhFjBg3bsygCqO4ZfRf0T605WCtF1h1nN1bmIFUurvrVrzMKmx1J3DKrlg6hCh8PFzvMiOwrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694007; c=relaxed/simple;
	bh=Hu+qkOp0h5DiY90U0VVh9vIgGY881e7+OCMBXsFEBOg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aYplgM9mtXFHphwbcfb7BYqgiJ+UbzajOWOBOuVKrn/qry65nLA4DYzx6t2NjsADmIY02I+GHDrViK3LL0vQsUUBChs2x1u0l/5P7RbGuIM3OU1f7+R2T7ib8MDzz6ez1M8s/GizxLo2TKu7DAupNBI5w9FDLv0ZQCpJRtyHnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=U6hPtoXX; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 7473a04b-cf9e-11f0-809d-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7473a04b-cf9e-11f0-809d-005056992ed3;
	Tue, 02 Dec 2025 17:46:31 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 525245d8-cf9e-11f0-80d9-00505699693e;
	Tue, 02 Dec 2025 17:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tOYqdj1+qjapT4odQA7Iq/XRpczVepfMygTBTItYuRQ=;
	b=U6hPtoXXDuB/9MQza+aEpU5+m3szan1Rw5lrufdTw/UNmknRLkDLIDNEXFgs/jVdtZP6Kqi4av5+d
	 MwWl+x7NjRNiedwuLd1aXMe45iX1Jpm/FzcSI67j63viNynTdhtk4LQarGMheXgOIT6hXClqVcKkTM
	 oYCuI0JElWbgpYiqEQ8fTLvFrbDaymo1Gc89b5BHJSETNOMvSBQAPbRrkC6OrMZkcCAMlEX8qD+4pl
	 i8jwPrk1/Ug2jtntqsadqmsHpBe/28tmUn0EI6Bu4KgZQCAX0Gn9MEGIkJ+e9SsWRyEbkeuFNxxuIw
	 ktTWzcLZZviMt5fpbYYXKi12G6DF2TA==
X-KPN-MID: 33|zjs2GyhTIG2M/6hsb4TCfON8MLBEKQ8DCFFrO9NMfD8i+cOq94wSRapfzH325vt
 m5MRepJswaPcdbAFdKyXplFer8p5uh5Q/+g7OPHYn33g=
X-CMASSUN: 33|YS09MIrPSIMyF6QhJfvfSveGPCieqdlt47Rc1e8My/uOU4hXs57zOMQvNVevI3j
 Ci20pvegKt+tDH9/qGgzxbw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5245ebac-cf9e-11f0-94b1-00505699eff2;
	Tue, 02 Dec 2025 17:45:34 +0100 (CET)
Date: Tue, 2 Dec 2025 17:45:34 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
 <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Message-ID: <604178298.203251.1764693934054@kpc.webmail.kpnmail.nl>
In-Reply-To: <01e9ce7fb96e555f0ab07f27890b0ed3406a92ae.camel@ibm.com>
References: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
 <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
 <299926848.3375545.1764534866882@kpc.webmail.kpnmail.nl>
 <01e9ce7fb96e555f0ab07f27890b0ed3406a92ae.camel@ibm.com>
Subject: RE: [PATCH v2] hfs: replace BUG_ONs with error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal

Hi Viacheslav,

I am not completely sure if I understood all your suggestions, so let me re=
ply
with code instead (before I submit a v3).

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..9835427b728e 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct i=
node *dir,
 =09int res;
=20
 =09inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
-=09if (!inode)
-=09=09return -ENOMEM;
+=09if (IS_ERR(inode))
+=09=09return PTR_ERR(inode);
=20
 =09res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 =09if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
 =09int res;
=20
 =09inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-=09if (!inode)
-=09=09return ERR_PTR(-ENOMEM);
+=09if (IS_ERR(inode))
+=09=09return ERR_CAST(inode);
=20
 =09res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 =09if (res) {
@@ -254,11 +254,24 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idm=
ap, struct inode *dir,
  */
 static int hfs_remove(struct inode *dir, struct dentry *dentry)
 {
+=09struct hfs_sb_info *sbi =3D HFS_SB(dir->i_sb);
 =09struct inode *inode =3D d_inode(dentry);
 =09int res;
=20
 =09if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
 =09=09return -ENOTEMPTY;
+
+=09if (unlikely(S_ISDIR(inode->i_mode)
+=09      && atomic64_read(&sbi->folder_count) > U32_MAX)) {
+=09    pr_err("cannot remove directory: folder count exceeds limit\n");
+=09    return -EINVAL;
+=09}
+=09if (unlikely(!S_ISDIR(inode->i_mode)
+=09=09&& atomic64_read(&sbi->file_count) > U32_MAX)) {
+=09    pr_err("cannot remove file: file count exceeds limit\n");
+=09    return -EINVAL;
+=09}
+
 =09res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 =09if (res)
 =09=09return res;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 81ad93e6312f..0fec6fd1cde7 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,23 @@ struct inode *hfs_new_inode(struct inode *dir, const =
struct qstr *name, umode_t
 =09s64 next_id;
 =09s64 file_count;
 =09s64 folder_count;
+=09int err =3D -ENOMEM;
=20
 =09if (!inode)
-=09=09return NULL;
+=09=09goto out_err;
+
+=09err =3D -EINVAL;
=20
 =09mutex_init(&HFS_I(inode)->extents_lock);
 =09INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 =09spin_lock_init(&HFS_I(inode)->open_dir_lock);
 =09hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, =
name);
 =09next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
-=09BUG_ON(next_id > U32_MAX);
+=09if (next_id > U32_MAX) {
+=09=09atomic64_dec(&HFS_SB(sb)->next_id);
+=09=09pr_err("cannot create new inode: next CNID exceeds limit\n");
+=09=09goto out_discard;
+=09}
 =09inode->i_ino =3D (u32)next_id;
 =09inode->i_mode =3D mode;
 =09inode->i_uid =3D current_fsuid();
@@ -209,7 +216,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 =09if (S_ISDIR(mode)) {
 =09=09inode->i_size =3D 2;
 =09=09folder_count =3D atomic64_inc_return(&HFS_SB(sb)->folder_count);
-=09=09BUG_ON(folder_count > U32_MAX);
+=09=09if (folder_count > U32_MAX) {
+=09=09=09atomic64_dec(&HFS_SB(sb)->folder_count);
+=09=09=09pr_err("cannot create new inode: folder count exceeds limit\n");
+=09=09=09goto out_discard;
+=09=09}
 =09=09if (dir->i_ino =3D=3D HFS_ROOT_CNID)
 =09=09=09HFS_SB(sb)->root_dirs++;
 =09=09inode->i_op =3D &hfs_dir_inode_operations;
@@ -219,7 +230,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 =09} else if (S_ISREG(mode)) {
 =09=09HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
 =09=09file_count =3D atomic64_inc_return(&HFS_SB(sb)->file_count);
-=09=09BUG_ON(file_count > U32_MAX);
+=09=09if (file_count > U32_MAX) {
+=09=09=09atomic64_dec(&HFS_SB(sb)->file_count);
+=09=09=09pr_err("cannot create new inode: file count exceeds limit\n");
+=09=09=09goto out_discard;
+=09=09}
 =09=09if (dir->i_ino =3D=3D HFS_ROOT_CNID)
 =09=09=09HFS_SB(sb)->root_files++;
 =09=09inode->i_op =3D &hfs_file_inode_operations;
@@ -243,6 +258,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 =09hfs_mark_mdb_dirty(sb);
=20
 =09return inode;
+
+=09out_discard:
+=09=09iput(inode);
+=09out_err:
+=09=09return ERR_PTR(err);
 }
=20
 void hfs_delete_inode(struct inode *inode)
@@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
=20
 =09hfs_dbg("ino %lu\n", inode->i_ino);
 =09if (S_ISDIR(inode->i_mode)) {
-=09=09BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 =09=09atomic64_dec(&HFS_SB(sb)->folder_count);
 =09=09if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
 =09=09=09HFS_SB(sb)->root_dirs--;
@@ -260,7 +279,6 @@ void hfs_delete_inode(struct inode *inode)
 =09=09return;
 =09}
=20
-=09BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 =09atomic64_dec(&HFS_SB(sb)->file_count);
 =09if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
 =09=09HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..907776773e25 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -150,11 +150,27 @@ int hfs_mdb_get(struct super_block *sb)
=20
 =09/* These parameters are read from and written to the MDB */
 =09HFS_SB(sb)->free_ablocks =3D be16_to_cpu(mdb->drFreeBks);
+
 =09atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
+=09if (atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX) {
+=09=09pr_err("next CNID exceeds limit =E2=80=94 filesystem possibly corrup=
ted. It is recommended to run fsck\n");
+=09=09goto out_bh;
+=09}
+
 =09HFS_SB(sb)->root_files =3D be16_to_cpu(mdb->drNmFls);
 =09HFS_SB(sb)->root_dirs =3D be16_to_cpu(mdb->drNmRtDirs);
+
 =09atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
+=09if (atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX) {
+=09=09pr_err("file count exceeds limit =E2=80=94 filesystem possibly corru=
pted. It is recommended to run fsck\n");
+=09=09goto out_bh;
+=09}
+
 =09atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
+=09if (atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX) {
+=09=09pr_err("folder count exceeds limit =E2=80=94 filesystem possibly cor=
rupted. It is recommended to run fsck\n");
+=09=09goto out_bh;
+=09}
=20
 =09/* TRY to get the alternate (backup) MDB. */
 =09sect =3D part_start + part_size - 2;
@@ -273,15 +289,12 @@ void hfs_mdb_commit(struct super_block *sb)
 =09=09/* These parameters may have been modified, so write them back */
 =09=09mdb->drLsMod =3D hfs_mtime();
 =09=09mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
-=09=09BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 =09=09mdb->drNxtCNID =3D
 =09=09=09cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 =09=09mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
 =09=09mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
-=09=09BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 =09=09mdb->drFilCnt =3D
 =09=09=09cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-=09=09BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 =09=09mdb->drDirCnt =3D
 =09=09=09cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
=20
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..23c583ffe575 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -32,8 +32,29 @@ static struct kmem_cache *hfs_inode_cachep;
 MODULE_DESCRIPTION("Apple Macintosh file system support");
 MODULE_LICENSE("GPL");
=20
+static bool hfs_mdb_verify(struct super_block *sb) {
+=09struct hfs_sb_info *sbi =3D HFS_SB(sb);
+
+=09/* failure of one of the following checks indicates programmer error */
+=09if (atomic64_read(&sbi->next_id) > U32_MAX)
+=09=09pr_err("mdb invalid: next CNID exceeds limit\n");
+=09else if (atomic64_read(&sbi->file_count) > U32_MAX)
+=09=09pr_err("mdb invalid: file count exceeds limit\n");
+=09else if (atomic64_read(&sbi->folder_count) > U32_MAX)
+=09=09pr_err("mdb invalid: folder count exceeds limit\n");
+=09else
+=09=09return true;
+
+=09return false;
+}
+
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+=09if (!hfs_mdb_verify(sb)) {
+=09=09pr_err("cannot sync fs because hfs_mdb_verify() failed\n");
+=09=09return -EINVAL;
+=09}
+
 =09hfs_mdb_commit(sb);
 =09return 0;
 }
@@ -65,6 +86,11 @@ static void flush_mdb(struct work_struct *work)
 =09sbi->work_queued =3D 0;
 =09spin_unlock(&sbi->work_lock);
=20
+=09if (!hfs_mdb_verify(sb)) {
+=09=09pr_err("flushing mdb failed because hfs_mdb_verify() failed\n");
+=09=09return;
+=09}
+
 =09hfs_mdb_commit(sb);
 }

There is a choice to be made with the delayed work that flushes the mdb whe=
n
it is marked dirty, because of course if the counts or CNID exceeds limit
it is unlikely to change later on. So, flush_mdb will just keep failing. I
don't see any other solution then marking it RO if this happens. Curious
what you think.

>=20
> I had impression that HFS already has it. But even if it is not so, then =
it
> sounds like another task. Let's don't mix the different problems into one
> solution. Otherwise, we will have a huge patch.
>=20

Agreed. Also, I just checked and hfs does not have this behavior (yet).

Thanks,
Jori.

