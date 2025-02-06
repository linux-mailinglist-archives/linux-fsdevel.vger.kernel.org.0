Return-Path: <linux-fsdevel+bounces-41069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668EA2A8D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4C316112B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037622DFB3;
	Thu,  6 Feb 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNSuhn0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61413D897;
	Thu,  6 Feb 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846317; cv=none; b=SrI5DTdmbkaSH18Z+ESzNo3fTBzyftPWvS09s83mgBWCUhiQHBlvW9gepmAc9iy9a+AyMVRF/BPNmnLmFO5wVIQJlaweXBn/wX7BYKHeZ3bUUyoLZmyS/ucPBtVQtPk+ZP3y/EoGx58C/V99MKQIGNWMODrUqAx/MXkPcFqOAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846317; c=relaxed/simple;
	bh=3JHrsLCwAfTYwRHPzjFJncpCKarZ4/lXd+HSjcYXhEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vCjTqahXWHsepzWoD7B6QcpDH+MxpIA1udm0QxKuwmqIYgFhHje9eIJqIbr+qUUafNF5kf9Jlu3Rtdl33WOt8zXr92CowHluMF7cHcVh1bavaQ1yrrxByH6uN+VnFsvW0IrODA5vNcb8pFllfABZ2IR69uLIb68bYBg/iPny7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNSuhn0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650DAC4CEDD;
	Thu,  6 Feb 2025 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738846317;
	bh=3JHrsLCwAfTYwRHPzjFJncpCKarZ4/lXd+HSjcYXhEw=;
	h=From:Date:Subject:To:Cc:From;
	b=UNSuhn0zuvgFMuD/FsG623LR/7O+uuehcpKHEgLUrcX8n3TMVrw6ktb4FeyjNEbhE
	 TTl08OMWeRyBe9HuplVot8HHp7uO29WQGhNdDLjJ8G4EM4gGRNIDIyzlsbn+SCP7Sv
	 q5LFGhIjbQXOwdUG0DzQwRl2e1IJm11DXRehQRdci377eBsgSQ7W2j1kaIUu7DKX8f
	 RcycvMlqEcr48+eXNhYKHWhxMqvJHCq3hoZsflDZD8mDm35aiZZaDmFPr02jccxSTY
	 HBO5e4/rqx6FFRFM2jE9Eqlk8CxmiRcdR9SOloLgkH3lKmYLA93grgV5x+PezZThXl
	 nD8HKaPAiV0uQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Feb 2025 07:51:52 -0500
Subject: [PATCH v2] statmount: add a new supported_mask field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-statmount-v2-1-6ae70a21c2ab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGewpGcC/23MQQ7CIBCF4as0sxYDNBbrynuYLrAd2okKZkCia
 bi72LXL/+XlWyEiE0Y4NSswZooUfA29a2BcrJ9R0FQbtNQHqWUrYrLpEV4+CWcm219xlE63UP9
 PRkfvzboMtReKKfBno7P6rf+UrIQSR6OcNdgp1/XnG7LH+z7wDEMp5Qut9ohAowAAAA==
X-Change-ID: 20250203-statmount-f7da9bec0f23
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4144; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3JHrsLCwAfTYwRHPzjFJncpCKarZ4/lXd+HSjcYXhEw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpLBsDZ9kaZemK6gCnbin3FV2JwUHCM+yQzMtw
 ixNV/jgaOGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6SwbAAKCRAADmhBGVaC
 FWNvEACTq3MetU4jjdmwt4miJ+y0T/gBtJZw3vAsImOmgX1mAp1eiFCm1eN+KIUEmjT7Qfg+jPx
 erp7Zm+l+ECwUuQXxt7XvN5hoHr8kiMDDlXu2jobf52pxEYl9MjB0mhqX6JMgwReeWR6NOvlZWo
 0rXCmcZdGnCD6heGBz6Id/DVt8v4kYrQSo85QE7zyNvdhHe1380GoPOEUVHBl1jb366Io3RqJ8Z
 NmrKaZ4PFgRqzJf8hbA2euE4hpNM+5LTjDGjjpBSAlvBfMD1vopzKAjXEhUw6alkNoNWQw4CUiN
 9W4V/W/MrJUGthRg+tunmFzBn4Y7uA4xJJ7DvMavHT62HqDnBv9KiFHl2HxK007FmdwzB+DR/mh
 wkLy0DzCo1v6Fj2TdZ1wN/MCSpFuhZ5B7Dyi5RnjVSaWin6ZWRAS/kCVFgHaB6ronthYnMBuBxD
 HrymPox22E1SBU4izH5dCHD1zjt7sttt3C+1XIzFPwXZ3A+89C4TJz0yCPF0aPzkZ57eVo9logg
 I3gIVHguKCe48mWfPB8F7ldk+KaC9WEYiDQhzh5BCkTdn3vsNuWrZB1T3OuQLl3H82zLSCFNAgq
 siBtg1wXhueqExPswwOubHI0V5xLkDjn5OnCOjncOO1e5Rt5MEeVA4WH6MV9YAQySxK9OtxGElO
 MbEPfEz+etyUXgw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some of the fields in the statmount() reply can be optional. If the
kernel has nothing to emit in that field, then it doesn't set the flag
in the reply. This presents a problem: There is currently no way to
know what mask flags the kernel supports since you can't always count on
them being in the reply.

Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kernel can
set in the reply. Userland can use this to determine if the fields it
requires from the kernel are supported. This also gives us a way to
deprecate fields in the future, if that should become necessary.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I ran into this problem recently. We have a variety of kernels running
that have varying levels of support of statmount(), and I need to be
able to fall back to /proc scraping if support for everything isn't
present. This is difficult currently since statmount() doesn't set the
flag in the return mask if the field is empty.
---
Changes in v2:
- Fix the assignment of the mask and setting of new bit in return mask
- Add WARN_ON_ONCE() when there are bits present in return mask that are
  not present in STATMOUNT_SUPPORTED
- Link to v1: https://lore.kernel.org/r/20250203-statmount-v1-1-871fa7e61f69@kernel.org
---
 fs/namespace.c             | 23 +++++++++++++++++++++++
 include/uapi/linux/mount.h |  4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cbae6238cda09874e2dac146080eb6..d13c50e7202248fd6213d46d3675263beeea46aa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5317,6 +5317,21 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 	return 0;
 }
 
+/* This must be updated whenever a new flag is added */
+#define STATMOUNT_SUPPORTED (STATMOUNT_SB_BASIC | \
+			     STATMOUNT_MNT_BASIC | \
+			     STATMOUNT_PROPAGATE_FROM | \
+			     STATMOUNT_MNT_ROOT | \
+			     STATMOUNT_MNT_POINT | \
+			     STATMOUNT_FS_TYPE | \
+			     STATMOUNT_MNT_NS_ID | \
+			     STATMOUNT_MNT_OPTS | \
+			     STATMOUNT_FS_SUBTYPE | \
+			     STATMOUNT_SB_SOURCE | \
+			     STATMOUNT_OPT_ARRAY | \
+			     STATMOUNT_OPT_SEC_ARRAY | \
+			     STATMOUNT_SUPPORTED_MASK)
+
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
@@ -5386,9 +5401,17 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
+	if (!err && s->mask & STATMOUNT_SUPPORTED_MASK) {
+		s->sm.mask |= STATMOUNT_SUPPORTED_MASK;
+		s->sm.supported_mask = STATMOUNT_SUPPORTED;
+	}
+
 	if (err)
 		return err;
 
+	/* Are there bits in the return mask not present in STATMOUNT_SUPPORTED? */
+	WARN_ON_ONCE(~STATMOUNT_SUPPORTED & s->sm.mask);
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index c07008816acae89cbea3087caf50d537d4e78298..c553dc4ba68407ee38c27238e9bdec2ebf5e2457 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -179,7 +179,8 @@ struct statmount {
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
 	__u32 opt_sec_num;	/* Number of security options */
 	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
-	__u64 __spare2[46];
+	__u64 supported_mask;	/* Mask flags that this kernel supports */
+	__u64 __spare2[45];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -217,6 +218,7 @@ struct mnt_id_req {
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
+#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
 
 /*
  * Special @mnt_id values that can be passed to listmount

---
base-commit: 57c64cb6ddfb6c79a6c3fc2e434303c40f700964
change-id: 20250203-statmount-f7da9bec0f23

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


