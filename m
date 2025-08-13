Return-Path: <linux-fsdevel+bounces-57805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1194B256C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF15C1BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050132FD7B1;
	Wed, 13 Aug 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cia1rIXo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986572FCC0E;
	Wed, 13 Aug 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124657; cv=none; b=hsDr4lfEOZe8CaNGvgeOr0hRNMUOPwIiYA0YAaKFtc0kr+O756q0rSFPwQAXvQH/q3+KTWfbq8G2VjrgHgNcifVRe7mynCfNGqcV4w4L380B+cqNf00bjBtUjyDUc+r/Z0MHwYFoikHTiWkTt4UapMIJCh6+1YT0OF7xLlZYEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124657; c=relaxed/simple;
	bh=lU4ozmqZCBQdJYUwXJnTu1hxk+lpM2q9agqgAerI0GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbUjIq99spb49oP72HueL0c26r2VN4vByQL5rAT82p/jU69RAX4TZYzj2ogA37TgLGTqn5coQlWch9pnpRecVNzqDhM26kYj40tmeudZsBd1vBm9swkWMLUEGy6ss6qWYxwGqDrfvB0og5gNcUJh5nQeXa22+LamtOzW5V7Wrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cia1rIXo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DO0kR1G7ppn9wqdcFt1Qr7BM7eh7Mgnj0enaxiw3nyM=; b=cia1rIXoPdpwIm4kMlMb/tyD57
	HrMld6Q3kkaXq5DeNk3uUzlTtH0ls2/FveGt6+9fzMFJ5Rl3IhzRd6OffmoH+FeBdWOx3FacZp4aK
	zTBOSRJMt4Rlo9J0b2aMsjRU2qHnKsuiLAyrzE64Xpux51tG0FpRJtHTo9P4shK8tfF5e1gL+ze0I
	W//I4/hhfKZdh02FUITMuYiVof0z3vStdhV9BlyNgZ+OQaoin6GEYxqvitnniIl9086yC/cCRTwSm
	T+yLrPZql5IjO2c8sCNoTanyVxPBSxrFjaOTZVkvIDQE0t62yCX9SsKJv++F/WlxpuND0D9bL6w3S
	cNSt0wIg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK66-00Ds0c-8R; Thu, 14 Aug 2025 00:37:30 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:40 -0300
Subject: [PATCH v4 4/9] fs: Create sb_same_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-4-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

For cases where a file lookup can look in different filesystems (like in
overlayfs), both super blocks must have the same encoding and the same
flags. To help with that, create a sb_same_encoding() function.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- Improve wording

Changes from v2:
- Simplify the code. Instead of `if (cond) return true`, just do `return
  cond`;
---
 include/linux/fs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 20102d81e18a59d5daaed06855d1f168979b4fa7..64d24e89bc5593915158b40f0442e6d8ef3d968d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3753,6 +3753,24 @@ static inline bool sb_has_encoding(const struct super_block *sb)
 	return !!sb_encoding(sb);
 }
 
+/*
+ * Compare if two super blocks have the same encoding and flags
+ */
+static inline bool sb_same_encoding(const struct super_block *sb1,
+				    const struct super_block *sb2)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb1->s_encoding == sb2->s_encoding)
+		return true;
+
+	return (sb1->s_encoding && sb2->s_encoding &&
+	       (sb1->s_encoding->version == sb2->s_encoding->version) &&
+	       (sb1->s_encoding_flags == sb2->s_encoding_flags));
+#else
+	return true;
+#endif
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

-- 
2.50.1


