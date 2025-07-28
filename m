Return-Path: <linux-fsdevel+bounces-56168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4FB1431B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4237AD9C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E527EC99;
	Mon, 28 Jul 2025 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdPKHAYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163F229B15
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734696; cv=none; b=gBtkkOa5Bw/4cQ2QhL2rXG4RWregY2xpVPiJpcqM799pQUQPxnzjRSaoY0D7+WTasZPBi95hzxY/prJi6zWx8PMj74yx++aTP60OeAC6eL94tSZJPyzaIDjdWB0i3S+5uhW7KK+sFd+03+ssF0oZUxgtgOL7Z+PzskoLOX5OthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734696; c=relaxed/simple;
	bh=V8qNbzjsE4JBu1MhTEPPGAHCYOvhHUKvJ9SI0FfHYX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=i00FLgNNuqxvjiR+zXG47Du4c+i17eyPbdKxzRjILFJg98ysA8Eu1Sk7RMpYHAapihwbIMMtPDSFOp/fidmjwfkru0vsLnapKwKKsLNEvZ30vUkR6ZcwkTdMn4l9ve/d5DJ84gm4QEUW9jMipWfRU7kHCNcVEkJIoqvunEF0r8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdPKHAYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPq7ioMuDIU1givclwrLOed+wUzgBQHM4Krd29hrZGg=;
	b=OdPKHAYPSIWSvTUd/qY5ZhQDrE6r6jgIycdQeMrqMAh64PUjVpBe7Qj8WDkdgnrCdz56+Y
	FeWjOlIr9SlEwq539o3hKesmama/Cm3kisuSlUucilPWSW1/ueFJufPThKNkQzKgcUvaJ+
	feq1QnARJ9rNTuLE5BzINkwSXkGI9oQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-ghDj_2izPh-qw00Kcna58g-1; Mon, 28 Jul 2025 16:31:32 -0400
X-MC-Unique: ghDj_2izPh-qw00Kcna58g-1
X-Mimecast-MFC-AGG-ID: ghDj_2izPh-qw00Kcna58g_1753734692
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-612be84c047so5107787a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734691; x=1754339491;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPq7ioMuDIU1givclwrLOed+wUzgBQHM4Krd29hrZGg=;
        b=xIsPYyPe7Rah2J/4TmkiaMC4qwOHFlJpQrtVWoLv8nkJBUG3akXx+5D/puv8vLe7ud
         8oUdJHh4cuiI3bMyyt8b5xHTUC1LZqhf4krToeez5EyEu2+NEK0/ORJfkkfkZM79Wwlf
         pBbqYwnad0/DSrQBRsWGqT97rbRnLP+0umc43DLJiSmKiZWOFQCXk5QmrMtytPGxAwfJ
         RLh8BFV7KuwRM6uHC3uHulfBFiYT6yPhgfOdh+2NsJeIexh2p9ZU7eXDmcMZfqrrS97z
         z9jVQjOPYDB4TC9HVvNWJ/IQmc86byOMIBpWlYq5LWXhWuuTxwxAxOopGVUhPk9a4Wk4
         +OhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzKL6ba6K/OXsfF26CPaqHr8MuXRiVBwAxMwIUZbB8Mgl2+JW45of9TTpWlGE7snFA8fuc0GLgjQbRZ6aA@vger.kernel.org
X-Gm-Message-State: AOJu0YypeNVz9JMfvIHisoE/TVJy8Iova6d8rpNKDeRClnrubU2nYZCP
	1hgHwH4sW0EHkcJ7IvH2ONUqVEqY8EYHc2MniCN8VVLwY09+hxU4WCX9oYWmraDYv2Y3mqvAObu
	kftlk12p0E3seGYzwLtygtnkBO3jNahGUXoEqZVczOpBewlzayzjcbYvSvNBnkYzERm/BrLYTL5
	hC4iWaWWCoyJG/jFjfD0v9ueN9Oq6Bj1TtPnB+KwX9jTb3s8NUYA==
X-Gm-Gg: ASbGncsC42qNyRHcYn8iAylhZ/essROA7MjWLKpNW1iN/qBXPs/+36csN6YXXYEKv9q
	7hf8ohwV42Y4qthNwVA/bVOm+kE1U0liLmLhC0kdrsqpFeA2c33SyHooORaDyDdfLjHQoXvSD7V
	gVWDxj0hrAsg77cDJkGh0zY7JxsanmjWSF0rqVn0FXoTP0TlRUp99bIdlA+NceVAFT9DJZak4sr
	64GRE8Athu/JwRz0Ty6LUsBGiXFEvwlm2b+jAxAc1SLT2RFSt3qqBZpXAQ56oV3HmBd2MG1ftyY
	z8BJ+JTpAOA8UAlx6NpV9i2pIEC/Y0PDmiptmO6CbJ+1Sg==
X-Received: by 2002:a05:6402:2807:b0:60e:23d:43b1 with SMTP id 4fb4d7f45d1cf-614f1df695bmr12503528a12.16.1753734691271;
        Mon, 28 Jul 2025 13:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJO8IlWhrpYESDaiCimQKB8ZcKiDQlQp927UKgU705UcobB9htySU5iKjsIwV3f3uW8HK5fQ==
X-Received: by 2002:a05:6402:2807:b0:60e:23d:43b1 with SMTP id 4fb4d7f45d1cf-614f1df695bmr12503495a12.16.1753734690764;
        Mon, 28 Jul 2025 13:31:30 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:30 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:14 +0200
Subject: [PATCH RFC 10/29] btrfs: use a per-superblock fsverity workqueue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-10-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=kuOn1nMdlYjue/gx8Se2FoLjVY/GfmNvzXVoSFxJQLY=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviQdOW/4+UExSWf7seuPldh/jPvRu3Mjtucsj6
 39LeJhNYn5HKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAibw6yfBPKy6t/d68ZbPT
 JxV8DZ5d7r6gb7Z+Us6O/f0W04RtCi67MjL07RM9G7V6tuLfTUuTPn9OjZ+/7kvtz7wM7cArTX0
 zDI6zAwBm2EpH
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Switch btrfs to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..cf82c260da9c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,6 +28,7 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -954,6 +955,19 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_export_op = &btrfs_export_ops;
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &btrfs_verityops;
+	/*
+	 * Use a high-priority workqueue to prioritize verification work, which
+	 * blocks reads from completing, over regular application tasks.
+	 *
+	 * For performance reasons, don't use an unbound workqueue.  Using an
+	 * unbound workqueue for crypto operations causes excessive scheduler
+	 * latency on ARM64.
+	 */
+	err = fsverity_init_wq(sb, WQ_HIGHPRI, num_online_cpus());
+	if (err) {
+		btrfs_err(fs_info, "fsverity_init_wq failed");
+		return err;
+	}
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;

-- 
2.50.0


