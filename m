Return-Path: <linux-fsdevel+bounces-72708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F29D00CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 04:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4769A3025A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 03:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF811288C27;
	Thu,  8 Jan 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FqRQ2G9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62D276038;
	Thu,  8 Jan 2026 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841647; cv=none; b=DiBM92WX2Krwd4vzIjSEGyxRZmvd71ZfUW2cSo+LdifJ1BD/zpYDM/ICH/X25zzz2eNFubQIqim3DTiIzqjy68ghXjz5Z5MLJ0XcXDgS70hI8ovzXJX20IRbr7ye/xvCrLf7Wo2iB8L3P4fm/pwSua37db239nr/E7uKNzMNrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841647; c=relaxed/simple;
	bh=HfFu8rI60AdSIcWyq9vAh1O2Lw40nJXqSfKYFovigJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1XsgQc/CzPpW4wsONi388g3U0uoNfMqHsLF5Dqcz8sbrm+zDqfI4mGWUBGGscbRcUtLXg9659dsJ1iFEV6oZuJQL0QbeZ26IioXItJKZyMkv28xD9nHPSL3R9Uo5Wz77LL1XlfgBOwv1nu5fcxY8g9SnQjXquaxSpDwuyh+MkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FqRQ2G9K; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767841636; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=oQheF5fgsLWjFmn4sCy3TBSdl1g+pvd4CN8mZqdibpE=;
	b=FqRQ2G9KiFq2NdlLkNi9b9ICT3123Qco246P/Fs4cI3cPv/H4PROv8WghoqAb9t/m5kmOp89/1kh/CR1iZBSm5/EEwzO4Fl30MrHg1QgJM0elcd+XgQYirEeZGeGv2Lrg2dlt18SiVm/pctMQFa99n+i6+3NUKEU9BDWPgV5Z0g=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwb0Z-x_1767841631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 11:07:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dusty Mabe <dusty@dustymabe.com>,
	=?UTF-8?q?Timoth=C3=A9e=20Ravier?= <tim@siosm.fr>,
	=?UTF-8?q?Aleks=C3=A9i=20Naid=C3=A9nov?= <an@digitaltide.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth increasing for now
Date: Thu,  8 Jan 2026 11:07:09 +0800
Message-ID: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
stack overflow when stacking an unlimited number of EROFS on top of
each other.

This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
(and such setups are already used in production for quite a long time).

One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
from 2 to 3, but proving that this is safe in general is a high bar.

After a long discussion on GitHub issues [1] about possible solutions,
one conclusion is that there is no need to support nesting file-backed
EROFS mounts on stacked filesystems, because there is always the option
to use loopback devices as a fallback.

As a quick fix for the composefs regression for this cycle, instead of
bumping `s_stack_depth` for file backed EROFS mounts, we disallow
nesting file-backed EROFS over EROFS and over filesystems with
`s_stack_depth` > 0.

This works for all known file-backed mount use cases (composefs,
containerd, and Android APEX for some Android vendors), and the fix is
self-contained.

Essentially, we are allowing one extra unaccounted fs stacking level of
EROFS below stacking filesystems, but EROFS can only be used in the read
path (i.e. overlayfs lower layers), which typically has much lower stack
usage than the write path.

We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
stack usage analysis or using alternative approaches, such as splitting
the `s_stack_depth` limitation according to different combinations of
stacking.

Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
Reported-by: Timothée Ravier <tim@siosm.fr>
Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
Acked-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Alexander Larsson <alexl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Sheng Yong <shengyong1@xiaomi.com>
Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2->v3 RESEND:
 - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
   as pointed out by Sheng Yong (APEX will rely on this);

 - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.

 fs/erofs/super.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..5136cda5972a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		 * fs contexts (including its own) due to self-controlled RO
 		 * accesses/contexts and no side-effect changes that need to
 		 * context save & restore so it can reuse the current thread
-		 * context.  However, it still needs to bump `s_stack_depth` to
-		 * avoid kernel stack overflow from nested filesystems.
+		 * context.
+		 * However, we still need to prevent kernel stack overflow due
+		 * to filesystem nesting: just ensure that s_stack_depth is 0
+		 * to disallow mounting EROFS on stacked filesystems.
+		 * Note: s_stack_depth is not incremented here for now, since
+		 * EROFS is the only fs supporting file-backed mounts for now.
+		 * It MUST change if another fs plans to support them, which
+		 * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
 		 */
 		if (erofs_is_fileio_mode(sbi)) {
-			sb->s_stack_depth =
-				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
-			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-				erofs_err(sb, "maximum fs stacking depth exceeded");
+			inode = file_inode(sbi->dif0.file);
+			if ((inode->i_sb->s_op == &erofs_sops &&
+			     !inode->i_sb->s_bdev) ||
+			    inode->i_sb->s_stack_depth) {
+				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
 				return -ENOTBLK;
 			}
 		}
-- 
2.43.5


