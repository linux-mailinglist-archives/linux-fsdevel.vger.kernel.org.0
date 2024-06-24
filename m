Return-Path: <linux-fsdevel+bounces-22250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B89152E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F9B250A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17219D8AA;
	Mon, 24 Jun 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WKfL22pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22119D899
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244246; cv=none; b=oL+YrXuPm/P1htFoK5whDCxzFGukliS5nBZz9+f9GPP0vs/QvaDEeEMh8an+WcdWvU0fIG2+uHnipBRtJpQ2EMakX6VuuK9P7ahyjMfMdzd4g+TmIrUu85wM96jaKuRjcWXoip2OnKQHhaowPABp8baKtOXOPkFFIadwgMQr5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244246; c=relaxed/simple;
	bh=cDqLNf/uHwQJgBA4MP4M3lkhBs6hll14MGN6bLjx9EU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUTSAGhk3QT9jY0shHMEN0aDmPLhXF/a9Bf9napJ+snCAW9ExL4B8hI1SXwQ26Gqg6vwC2e7tnYPKEjJe8fGx6OlhpC9lGNF0B+/XNkINtzB/z488vjC+S1zBAYmrfszDo4+84R7ipAugieQ5iIf1GSzpBo3nGDiph5um6wplxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WKfL22pB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfb05bcc50dso3898758276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244244; x=1719849044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uonl2vdPq4IuhaBPRJ328Klo99SK+IsfHoHDMlx1/Ho=;
        b=WKfL22pBSs8xbQDSNthirpZlTrjWNToTYrmVXBnc38Zcq3/kSsp2/pGKSe6b2T7TvT
         b9+YE0JXnNykH91pzkhi904r114efcZE3yxxZGnjDv1n2XVXULGRncbC5rcWEkL/RDnA
         nlDaZw1bLoCJgsngu2i8gPHgNYtnXBTC8tqj5Z3abvlkSVnASdbfZg8ScMDSyhVcyu8G
         cU2SFhnvL8343/9rIIiS+dScDzypMNfj8cSMK228HgF8563GJvm3zjKanVyfl6O7PZAj
         nBKRRhf8KYiHPPgqXRxXH2dJh/2zGoOKrez2OJs48TVMtXhVBmDhu20gvJTU9QYVDYKP
         X4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244244; x=1719849044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uonl2vdPq4IuhaBPRJ328Klo99SK+IsfHoHDMlx1/Ho=;
        b=JhZXOy0hBsuKlYDecbYMUN23QZ1zs4vio+QCORZH/N9BaXbJmUPJBGaMe5Eyzh/pRo
         BsW5eKbeWPnw9MW5YcavOSwVEUlDHcAdXS8FT6BY4UluFYRIKinekX+R59F5bDamAJyR
         8eEGIyP/tAxor+f0+RkTVwtcWilRiIIPr0LNe2bIMxWacJuynZpbXF2JE3ttDSXi6lYr
         EdUFjlinOf29Gxb3CM3QtFUbYa1FdHL4uXrlisVIpDrlptCN+BSk1vGTpqxgxyGXib8v
         r5q35D2TylotUojCpUsNZh00/EylVDExBrTzsI5mLlLCPlSUFPU2enY+J5xpyU0c+hzr
         snHA==
X-Gm-Message-State: AOJu0YyIGBui5DD+vrtlKBs/wfjmQFkQsIT6TlrkThSlhBCtVzYEuz/V
	SOCGADQyxaArJoy9nblDS9k6V81l453cRXXc9V+RBuAyqCqm1ycMl0W7fMMvUHaELEnhQTvEftz
	E
X-Google-Smtp-Source: AGHT+IGJliiVscHdOz5cUJ+TuarqpY8oEcuNMKbogxpMbrY4+abQd3RFGImTeUQypg2UvTYm8/NxwA==
X-Received: by 2002:a25:dc84:0:b0:dfb:bf0:59db with SMTP id 3f1490d57ef6-e0303fc13acmr4825303276.41.1719244243635;
        Mon, 24 Jun 2024 08:50:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e623f0f2sm3394395276.25.2024.06.24.08.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/8] fs: export the mount ns id via statmount
Date: Mon, 24 Jun 2024 11:49:47 -0400
Message-ID: <6dabf437331fb7415d886f7c64b21cb2a50b1c66.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to allow users to iterate through children mount namespaces via
listmount we need a way for them to know what the ns id for the mount.
Add a new field to statmount called mnt_ns_id which will carry the ns id
for the given mount entry.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c             | 11 +++++++++++
 include/uapi/linux/mount.h |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index babdebdb0a9c..3c6711fec3cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4977,6 +4977,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static void statmount_mnt_ns_id(struct kstatmount *s)
+{
+	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
+
+	s->sm.mask |= STATMOUNT_MNT_NS_ID;
+	s->sm.mnt_ns_id = ns->seq;
+}
+
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
 	int ret;
@@ -5073,6 +5081,9 @@ static int do_statmount(struct kstatmount *s)
 	if (!err && s->mask & STATMOUNT_MNT_POINT)
 		err = statmount_string(s, STATMOUNT_MNT_POINT);
 
+	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
+		statmount_mnt_ns_id(s);
+
 	if (err)
 		return err;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 88d78de1519f..a07508aee518 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -172,7 +172,8 @@ struct statmount {
 	__u64 propagate_from;	/* Propagation from in current namespace */
 	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
-	__u64 __spare2[50];
+	__u64 mnt_ns_id;	/* ID of the mount namespace */
+	__u64 __spare2[49];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -202,6 +203,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+#define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.43.0


