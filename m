Return-Path: <linux-fsdevel+bounces-22271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D635915753
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266D6280DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1381A0738;
	Mon, 24 Jun 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DD3mue46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFC1A0720
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258072; cv=none; b=KzOWCEdQPy1oRK5felIRZgKrVMQuHt6UXXZiCDSQJ9GtkEeCe5aejoPZE67l07BsRWp6H8rmI5t4KJr7seO5tVh4RR8ff5uurd3d87ACFHtylI/5iEcBRzKWDiEZO2vKPVMy1mU5FArNDE4MTotKMeI5+F9dmKCPyNYrpGanaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258072; c=relaxed/simple;
	bh=tOjcCnOLWKqoOb8eV5NCcTg0eL6gd30G4h4ZGS4h3bg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piWjcCp02qmn/I3CqyDHkCxavTX5n/e9aPOV32XGoYUP7VCyZAs7utsJM+Abec2fevFFn4R+Em2cCS8Ksg/LV2MU9NEvtpwuUlQ1E05PKtc5fdm+VWbSRkv8WsKfkr9nojcrjp38Eu/DxPnVkznahflWKx9S0JGhbP+EhpjUHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DD3mue46; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b5031d696dso23095636d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719258069; x=1719862869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wa6nsJIfWMaZ6hMNvJrCgTkmvIEPizWz1r158Y5fRPs=;
        b=DD3mue46vBimUWZlQ7ZzGEEfzarYQawEqVsHjbWyW+0JjMThX2lSHk2pcbvFSw9aLZ
         7LmBYPyNOFW8sbO3HxdtMlF1RYfH/1zjK2WtlG1YlG+rNqutgOuYRopRMhyTcA6c8dRX
         d3TXLUzd2lm7ZfHGcpoBIE+bt6q2FoepwLOxsxzVv2I6WGpGGSCimQxmR+DGu/UziZzd
         WPBIZQ8xGhjynykzHXYB/2v7EE8S40U8UetQqVueVPHvQUvgA3dh5ntZbi+JoIAazVS3
         3qcmA2zIvDLB6/F2qoGgIBQqhSOEc4nWvFpdlKd1m0DUpk1UAz6zoMdPYojewEH1/hAh
         3TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258069; x=1719862869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa6nsJIfWMaZ6hMNvJrCgTkmvIEPizWz1r158Y5fRPs=;
        b=bBa/DkDJpufkcM9SSfqANIWxUV/xJWYJ5FMMPXFTBjdL8Qv60IV1k0eKs50ul4Qb5z
         elxRtSeNGr2hMWPDeqKq2q2Lv9mBAUuxjmeNZig/xvlWIwmntLoRN52pEzcdy7HLJHyc
         JM7N7kn5wJ0oqydN6lvGbqI739eY4/kNiQ4gKU2jrZzzvZmSlJJraFRbhuQh63NuTB3Z
         HfGPcMjLKKAcC1BxIhxYYzQkIkLl8YYQvUECYHVGXWLuajBZ0lue4SgISVB92d7+6YfN
         v3+OKZYJ9dyqiWNsrQfQvd20QROymN4dW4wR1Fx/mC3ZbC+MYjgmxqosIsrLLzVoRr5r
         asIg==
X-Gm-Message-State: AOJu0YwhnW0yRB3y9mxzxuyNjuFJ5LGQovtsVioc3OXEChWGh9qfrZn9
	B8feSn+I78couh0p+Sahq2xhdtPfAOWCVJC/MzY58q8KS1UkHFrG/ksx3j3U2O0u/cYhnR5q2W8
	3
X-Google-Smtp-Source: AGHT+IFFRe/FrKxDsDFAb01H5ntOS8Qt9g757y8jrvD+00Diw5Mjwnl7/BB5Twlvxy+YWl2g2qlJmQ==
X-Received: by 2002:a0c:c988:0:b0:6b5:6f9:4846 with SMTP id 6a1803df08f44-6b540bf4a8emr56833896d6.53.1719258069176;
        Mon, 24 Jun 2024 12:41:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef6b12fsm36944046d6.134.2024.06.24.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:41:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/4] fs: export mount options via statmount()
Date: Mon, 24 Jun 2024 15:40:52 -0400
Message-ID: <3aa6bf8bd5d0a21df9ebd63813af8ab532c18276.1719257716.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

statmount() can export arbitrary strings, so utilize the __spare1 slot
for a mnt_opts string pointer, and then support asking for and setting
the mount options during statmount().  This calls into the helper for
showing mount options, which already uses a seq_file, so fits in nicely
with our existing mechanism for exporting strings via statmount().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c             | 7 +++++++
 include/uapi/linux/mount.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6d44537fd78c..2a6a8cbf5d0a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5003,6 +5003,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_point = seq->count;
 		ret = statmount_mnt_point(s, seq);
 		break;
+	case STATMOUNT_MNT_OPTS:
+		sm->mnt_opts = seq->count;
+		ret = show_mount_opts(seq, s->mnt);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5079,6 +5083,9 @@ static int do_statmount(struct kstatmount *s)
 	if (!err && s->mask & STATMOUNT_MNT_POINT)
 		err = statmount_string(s, STATMOUNT_MNT_POINT);
 
+	if (!err && s->mask & STATMOUNT_MNT_OPTS)
+		err = statmount_string(s, STATMOUNT_MNT_OPTS);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index ee1559cd6764..225bc366ffcb 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -154,7 +154,7 @@ struct mount_attr {
  */
 struct statmount {
 	__u32 size;		/* Total size, including strings */
-	__u32 __spare1;
+	__u32 mnt_opts;		/* [str] Mount options of the mount */
 	__u64 mask;		/* What results were written */
 	__u32 sb_dev_major;	/* Device ID */
 	__u32 sb_dev_minor;
@@ -206,6 +206,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
+#define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.43.0


