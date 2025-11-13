Return-Path: <linux-fsdevel+bounces-68131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B63ECC54FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0A9E34AA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BD21B195;
	Thu, 13 Nov 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UuW/VctS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+wh1xts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683131D5CFB;
	Thu, 13 Nov 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994480; cv=none; b=Phcu5X7A1fVEMtwrbw/bmVQ4Fa3KAVFAu3ouYSaju5cMbrxdU7RrhYfOMQSxpVxqaKnSEg9hLsx3lX+Jo5XmAKYzDHx7vTHnET49nkR0iGRZPtYZ8g1vhAod7ndbKUdc+/6/L8aa/QPZF5JAfS0iXUzsUzqZTdCWumNftULJvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994480; c=relaxed/simple;
	bh=8mV+lSr2kkrCKnqfXCF06Iu0l5B6vbTjWAZnPD/FeH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkla2H5/uT2ZFhklhdJ5kS8BtKuXiDY+k7+2Vywb5TC91tSkrQQH0JbvfHLZ8eLMl1M2A3PwxrtgIBUWqs8LoPqL1c5iaG5euan0L2jEL5ixhbf2Oq8U6pSUV9P9cfEIymtTc/lAbRMFozDnicjDzultUrBYvg5rTrTUuqapfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UuW/VctS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+wh1xts; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id DDBE113000C2;
	Wed, 12 Nov 2025 19:41:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 12 Nov 2025 19:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994476;
	 x=1763001676; bh=ifeb9Z6tHI8QQRu8gzLyS7QIKDXGEWCi5GIjD5opmC4=; b=
	UuW/VctSFixUBOftqNYzX2ieN0GL7PY2HfzX67S5flNdW5enoaFjPbDxTifMR71e
	JN7S+733J9Kwx7yhd+CR2xScy+mLMihKCkrEYqbI7QwS21VAytoeF6x09SyWyAjn
	8W6/skup+PnF0Udz0aNG7AlQvKMi21HcTU4ymanZTW9MkgelMQcfuN3TN3a+9jqi
	nhlWR+zJHxZwHvUgkO4q65IF4Ffnr3jK/V5FdXbovzyPbJhMu+fQdT22HLqfHnZz
	muNbSqDQ+uE/TUxNbcKTeEHZzkGd4r0c512sRwcLTsWdPjJoER7SXNO9OPfm6ZaI
	86SdywG1Pz8DK+5pu2mIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994476; x=1763001676; bh=i
	feb9Z6tHI8QQRu8gzLyS7QIKDXGEWCi5GIjD5opmC4=; b=m+wh1xts4oKo/8DMC
	NEclfRI8/kLTDPow/cnJhX4tQuc3jJvPGgugFxmB2BY6Ic7tkPZSnMps0iQwsN4w
	34Djwg49rF7Uw6ezk/d7KRTsPqdqsZb5q3KxFvMO35l3/DlNLoWlf2CbKfIGmNky
	GanpwITvgSZ+SA7UvewsaN3XgFq5wMpr/Km3KtodatOfyyTTiW1ZHSQw3SUgWmnP
	B2r0MRkBnv+YCj1iNfdldlN1uYrrFfazvCZ0MG/wbqEod/HgEnPiPlx79ii13fid
	bg28DgxHijoNbaUHgYDT2NA0yDUGeHvlChqAXP2DEqvWlmRyJZbhkBnj9Mpc0P9y
	5oJ/Q==
X-ME-Sender: <xms:LCkVafJEr48n9Rm-a-LmHagnBcYZhfQjzlPBRyBNQsr_ld32azzWKw>
    <xme:LCkVaYOVq_1_72madEPJ5HAMMfTGOaBGdnMlyFoc1iBFRFdZVoGbWm0vmCJz1M34Q
    8_F1RGKp0cIo4CaIsUXVN-6Y75KMLmTD_1GDV3WkY40xu6oQw>
X-ME-Received: <xmr:LCkVaUugTIRynH9EfxEUxt48bszD89USaJqobfT8vTiAo4NS0fuBVhxoNiWtY64-23W2Twi7abmkmY_qWdldOOBc7CrCmdBO0ivsXWwHgo_N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:LCkVaWFD9nCyJ3IvC0_gkli2Q2ApTn3N3ym-DlxDOvvL9ESk2etF5A>
    <xmx:LCkVaX5tYFC2dqmAEKkLGvfeKSrDIe7hDmO96K-Xd8dk84pQZ2DOZg>
    <xmx:LCkVaRXhcmMsOSwtL4BPVmJKTk4udHvDumHNJjpiDmxAWVh3KtzmDg>
    <xmx:LCkVaZzItx9J0KIx3EUTOD7uZsFyc--gkUt77TKygyDRjDhnCbsiww>
    <xmx:LCkVaSTwcbRYHoj1T3FCcEjdLFv_Mmb6q8GXTrsd5kacnVTaFJPMzjzm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:41:06 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v6 07/15] smb/server: use end_removing_noperm for for target of smb2_create_link()
Date: Thu, 13 Nov 2025 11:18:30 +1100
Message-ID: <20251113002050.676694-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Sometimes smb2_create_link() needs to remove the target before creating
the link.
It uses ksmbd_vfs_kern_locked(), and is the only user of that interface.

To match the new naming, that function is changed to
ksmbd_vfs_kern_start_removing(), and related functions or flags are also
renamed.

The lock actually happens in ksmbd_vfs_path_lookup() and that is changed
to use start_removing_noperm() - permission to perform lookup in the
parent was already checked in vfs_path_parent_lookup().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/server/smb2pdu.c |  6 +++---
 fs/smb/server/vfs.c     | 27 ++++++++++++---------------
 fs/smb/server/vfs.h     |  8 ++++----
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f901ae18e68a..94454e8826b0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6092,8 +6092,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
-	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
-					&path, 0);
+	rc = ksmbd_vfs_kern_path_start_removing(work, link_name, LOOKUP_NO_SYMLINKS,
+						&path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
@@ -6111,7 +6111,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 			ksmbd_debug(SMB, "link already exists\n");
 			goto out;
 		}
-		ksmbd_vfs_kern_path_unlock(&path);
+		ksmbd_vfs_kern_path_end_removing(&path);
 	}
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2b73..ea0a06b0ae44 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -69,7 +69,7 @@ int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 
 static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 				 char *pathname, unsigned int flags,
-				 struct path *path, bool do_lock)
+				 struct path *path, bool for_remove)
 {
 	struct qstr last;
 	struct filename *filename __free(putname) = NULL;
@@ -99,22 +99,20 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 		return -ENOENT;
 	}
 
-	if (do_lock) {
+	if (for_remove) {
 		err = mnt_want_write(path->mnt);
 		if (err) {
 			path_put(path);
 			return -ENOENT;
 		}
 
-		inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-		d = lookup_one_qstr_excl(&last, path->dentry, 0);
+		d = start_removing_noperm(path->dentry, &last);
 
 		if (!IS_ERR(d)) {
 			dput(path->dentry);
 			path->dentry = d;
 			return 0;
 		}
-		inode_unlock(path->dentry->d_inode);
 		mnt_drop_write(path->mnt);
 		path_put(path);
 		return -ENOENT;
@@ -1207,7 +1205,7 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 static
 int __ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
 			  unsigned int flags,
-			  struct path *path, bool caseless, bool do_lock)
+			  struct path *path, bool caseless, bool for_remove)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	struct path parent_path;
@@ -1215,7 +1213,7 @@ int __ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
 	int err;
 
 retry:
-	err = ksmbd_vfs_path_lookup(share_conf, filepath, flags, path, do_lock);
+	err = ksmbd_vfs_path_lookup(share_conf, filepath, flags, path, for_remove);
 	if (!err || !caseless)
 		return err;
 
@@ -1286,7 +1284,7 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
 }
 
 /**
- * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
+ * ksmbd_vfs_kern_path_start_remove() - lookup a file and get path info prior to removal
  * @work:		work
  * @filepath:		file path that is relative to share
  * @flags:		lookup flags
@@ -1298,20 +1296,19 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
  * filesystem will have been gained.
  * Return:	0 on if file was found, otherwise error
  */
-int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
-			       unsigned int flags,
-			       struct path *path, bool caseless)
+int ksmbd_vfs_kern_path_start_removing(struct ksmbd_work *work, char *filepath,
+				       unsigned int flags,
+				       struct path *path, bool caseless)
 {
 	return __ksmbd_vfs_kern_path(work, filepath, flags, path,
 				     caseless, true);
 }
 
-void ksmbd_vfs_kern_path_unlock(const struct path *path)
+void ksmbd_vfs_kern_path_end_removing(const struct path *path)
 {
-	/* While lock is still held, ->d_parent is safe */
-	inode_unlock(d_inode(path->dentry->d_parent));
+	end_removing(path->dentry);
 	mnt_drop_write(path->mnt);
-	path_put(path);
+	mntput(path->mnt);
 }
 
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index df6421b4590b..16ca29ee16e5 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -120,10 +120,10 @@ int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 			unsigned int flags,
 			struct path *path, bool caseless);
-int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags,
-			       struct path *path, bool caseless);
-void ksmbd_vfs_kern_path_unlock(const struct path *path);
+int ksmbd_vfs_kern_path_start_removing(struct ksmbd_work *work, char *name,
+				       unsigned int flags,
+				       struct path *path, bool caseless);
+void ksmbd_vfs_kern_path_end_removing(const struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
-- 
2.50.0.107.gf914562f5916.dirty


