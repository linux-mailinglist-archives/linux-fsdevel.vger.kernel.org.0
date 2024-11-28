Return-Path: <linux-fsdevel+bounces-36086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A89DB7BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D63BB233BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44919F411;
	Thu, 28 Nov 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H15v0y7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766819DF99;
	Thu, 28 Nov 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797241; cv=none; b=WYeC3kxcGdEcR4cf0/OSBdeDjgVjvQKo3jiTtGjaD48NUnzIEyXseON/uM6iojidY1fYfE2YzZo7xYFz44E3ZlEvCVCO2j6tlaB3yTThUpPNH/VWzVvorb2hEWL+aEyOF+vuLtz1TWAoTTo80/TTkmospOfuxChjcW/6GD1/it8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797241; c=relaxed/simple;
	bh=MFoiCellN60PnTExDzerfYG5XksVeX7MxYSpt1qtWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYF9uOC7Z2yt3clpL1+zHymEYDYYdBsXW1YMEI9vN2pqcPRybBhGPJFbj778sHz69Y7hLKypvHvUFy+QgS3ujngG7hg1lYLjzUcjmm+x0vKZUdTa9VQuiMV22m4X4odZbGpDYhEqr4s76eyIWPzmJiHPTZMRg2t7YM+eFTaK9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H15v0y7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0792EC4CED2;
	Thu, 28 Nov 2024 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797240;
	bh=MFoiCellN60PnTExDzerfYG5XksVeX7MxYSpt1qtWT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H15v0y7jw74xDtEnHNikJYEpIKP3Yl2650HieT4Fjaj+530wSNfhgL6kfX8G6veDB
	 Rbrh/GTOOeCYVwj+B2pDHqn4411mU9udMLL3yn5DOSXM0eloJtSuWtgLSPiImROHYZ
	 rdTc9Y3sbRu+irijRCTNkc7Mp1o5lIc/AYJwoTqexupBRJoDfeqU7r6DIgip8THO5o
	 JP/lspSfHzHjn2IuU2nlym/6kIeDr9dGmWtX/FpmOu7mKcCSK2vXajh+JwPpHt2gDw
	 PrkVUAdl8JyCupgdmRLep2V1AT8MaWOy540ysre+AHY3q0GAmywpaa+KRI+v+03aHP
	 gyXdMUa1RVcVQ==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 0/2] pidfs: file handle preliminaries
Date: Thu, 28 Nov 2024 13:33:36 +0100
Message-ID: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114-fragt-rohre-28b21496ecbc@brauner>
References: <20241114-fragt-rohre-28b21496ecbc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241128-work-pidfs-2bd42c7ea772
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075; i=brauner@kernel.org; h=from:subject:message-id; bh=MFoiCellN60PnTExDzerfYG5XksVeX7MxYSpt1qtWT4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7JKtI1s5SC2pW0v3j/FBhSqCzWv9CTR9edfHcs7JeM Y+e10l0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATITZn+E3e+dvLpU2v4jQ7U6F SmfvvNwk5Vm3dElP88JFNgWuPi/9GBnWLS4yf3eR83jDk2/rj7m/UNFjeVnBHMtxseLNpo8Xna9 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

This reworks the inode number allocation for pidfs in order to support
file handles properly.

Recently we received a patchset that aims to enable file handle encoding
and decoding via name_to_handle_at(2) and open_by_handle_at(2).

A crucical step in the patch series is how to go from inode number to
struct pid without leaking information into unprivileged contexts. The
issue is that in order to find a struct pid the pid number in the
initial pid namespace must be encoded into the file handle via
name_to_handle_at(2). This can be used by containers using a separate
pid namespace to learn what the pid number of a given process in the
initial pid namespace is. While this is a weak information leak it could
be used in various exploits and in general is an ugly wart in the
design.

To solve this problem a new way is needed to lookup a struct pid based
on the inode number allocated for that struct pid. The other part is to
remove the custom inode number allocation on 32bit systems that is also
an ugly wart that should go away.

So, a new scheme is used that I was discusssing with Tejun some time
back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
are used for the generation number. This gives a 64 bit inode number
that is unique on both 32 bit and 64 bit. The lower 32 bit number is
recycled slowly and can be used to lookup struct pids.

So after applying the pidfs file handle series at
https://lore.kernel.org/r/20241101135452.19359-1-erin.shepherd@e43.eu on
top of the patches here we should be able to simplify encoding and
decoding to something like:

diff --git a/fs/pidfs.c b/fs/pidfs.c
index e71294d3d607..a38b833a2d38 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -78,7 +78,7 @@ void pidfs_remove_pid(struct pid *pid)
 }
 
 /* Find a struct pid based on the inode number. */
-static __maybe_unused struct pid *pidfs_ino_get_pid(u64 ino)
+static struct pid *pidfs_ino_get_pid(u64 ino)
 {
 	ino_t pid_ino = pidfs_ino(ino);
 	u32 gen = pidfs_gen(ino);
@@ -475,49 +475,37 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
-#define PIDFD_FID_LEN 3
-
-struct pidfd_fid {
-	u64 ino;
-	s32 pid;
-} __packed;
-
-static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
 			   struct inode *parent)
 {
 	struct pid *pid = inode->i_private;
-	struct pidfd_fid *fid = (struct pidfd_fid *)fh;
 
-	if (*max_len < PIDFD_FID_LEN) {
-		*max_len = PIDFD_FID_LEN;
+	if (*max_len < 2) {
+		*max_len = 2;
 		return FILEID_INVALID;
 	}
 
-	fid->ino = pid->ino;
-	fid->pid = pid_nr(pid);
-	*max_len = PIDFD_FID_LEN;
+	*max_len = 2;
+	*(u64 *)fh = pid->ino;
 	return FILEID_INO64_GEN;
 }
 
 static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
-					 struct fid *gen_fid,
+					 struct fid *fid,
 					 int fh_len, int fh_type)
 {
 	int ret;
 	struct path path;
-	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
 	struct pid *pid;
+	u64 pid_ino;
 
-	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
+	if (fh_type != FILEID_INO64_GEN || fh_len < 2)
 		return NULL;
 
-	scoped_guard(rcu) {
-		pid = find_pid_ns(fid->pid, &init_pid_ns);
-		if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0)
-			return NULL;
-
-		pid = get_pid(pid);
-	}
+	pid_ino = *(u64 *)fid;
+	pid = pidfs_ino_get_pid(pid_ino);
+	if (!pid)
+		return NULL;
 
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
 	if (ret < 0)

Thanks!
Christian

---
Christian Brauner (2):
      pidfs: rework inode number allocation
      pidfs: remove 32bit inode number handling

 fs/pidfs.c            | 138 +++++++++++++++++++++++++++++++++++---------------
 include/linux/pidfs.h |   2 +
 kernel/pid.c          |  11 ++--
 3 files changed, 103 insertions(+), 48 deletions(-)
---
base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
change-id: 20241128-work-pidfs-2bd42c7ea772


