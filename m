Return-Path: <linux-fsdevel+bounces-12597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57786861A27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773791C255B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F912D763;
	Fri, 23 Feb 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX7cIouw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A302133995;
	Fri, 23 Feb 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710146; cv=none; b=MRS8Tce995o0XDIrrD16FXTqFbEjo7BOkzRZ5XC2jZ/qBQ1mfTbfPFLGQrkYkPYb+QI2Sn2AIvtK9gHgNe4Avil73ZuvGA991Cv1BNk/UyxEOk92i6k9JM0nF4AW+R9QG9eGvhZwesA3ugiVx0s+8ukIy1KDg8LuSGE1iCq4jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710146; c=relaxed/simple;
	bh=CkgahHLrXAzsDc1GyliBXNYmxljQ1YjaPW98OF38fIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBYzj/NpSEssK5hD8C9Fu3ZcyWBILtc1cJQsOp2S5qXtNN3pIo00srv6k0OnqTLJUOdWye0kpPFtx7b90b9B9LvTQIwEy9BGzOhPf9WsLZRe5J48cZFmYbyurUxb9vbH0xGstEaS3apckQSVWknQ5SzIKYuvSGScMpSTYDgqwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX7cIouw; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c18190000aso895616b6e.0;
        Fri, 23 Feb 2024 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710144; x=1709314944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGMjiwg1uZ6Jr5mNemJ2ScloiGdJ6cdnQKQjOvidMjQ=;
        b=nX7cIouwONAXINeRyPtbbK/k6MwCuGp+ndudCxQ/CejLMO16YXbv0j2Kry6T06U1VO
         K6Rn7qbiWOGsYFoMWAct3xtYPBViDZaIkkpmJekD7wye2lcE5JxR691OXQBiUavIgS4B
         jlcEpYqTU1HdUYH0uUY+dXLbZG28Ik1qT6hRgUyMWO8/ASTOYH/HCQbnkS3+BL33WrcC
         FS8jVKJnVgQfG3iPtxRZl6C8YJ89F+nVIBZMPZzhMXzAsNlfnb7QvX/8FCNvdL7Ew0sF
         kAX5I5bLxO4rrc8yTLg2eOaGsDuNBLiTyGk8kIpbU7dQl8pMZZ2qT+dZ9wk1E5xQIRLW
         KB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710144; x=1709314944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGMjiwg1uZ6Jr5mNemJ2ScloiGdJ6cdnQKQjOvidMjQ=;
        b=gcgjWKH4CBEX6PQtpKufiQs1ORgAePdJmpXbvw1AstCOHbi+/unkOEsFYVYPyHwzzs
         67ElrzK3ZWJMGUj0qVtc7WHJ87VwHgOqV3twpfP4a61jOhDMWvTNGblXAvXyD9HiyjHr
         aDjMDpFEPOYjRTmqhD7WL+TrhOEkVZGuGxi3fUjPjH6XLUgPeusshKzIcUrShlmeQqLD
         /woOpVxTjcnx5V4aBy1oTvIwOHjWmY1YG/85oDDwtV2VjpiSLy0dRCz0a0RoQUxjgJPM
         1GHuD9Tci8jjx0kX/9MRtj8nd1TktsHofHGLYuAt7Kq0IIRdwLwHQXrYtwu4j3s1UgUM
         iceQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkSqwmcvO28rZtyh9z6nmgTmUs4ERcDL2vuS5SAHpHGvM3rZvdV19poIG0PR2uux15FAziUPm/r92tXMygd+rvrNwvkzqpitIil4HevYdA92urDXvrjf/tE1wWQvs1ndBuCU2SKMLsspAZVmfZ8bDbB/H6t5F4MwvwpbInhNJN/1OKWNjcCv3zdsAzxD8YqUaljPePZ7mtQ2qE9Ms/RugvGA==
X-Gm-Message-State: AOJu0YwxP5hbCPZSbkT0y30hs/hUBG09YZDclisKgS+fX8awAXoSUo9w
	Qe68c730eFZnnUGjIsgITliQYsjH/NbGO6QMDEt/oWj6aCtXS/YN
X-Google-Smtp-Source: AGHT+IGTh/vsL/iyfr1+O5xIszFoRGO1T0cqNt3QFKtOmtVkFPM3Pqvq3kpeRl0uX4riIRv1bk+bvQ==
X-Received: by 2002:a05:6871:489:b0:21f:662:e01 with SMTP id f9-20020a056871048900b0021f06620e01mr481442oaj.56.1708710143576;
        Fri, 23 Feb 2024 09:42:23 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:23 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 02/20] dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
Date: Fri, 23 Feb 2024 11:41:46 -0600
Message-Id: <69ed4a3064bd9b48fd0593941038dd111fcfb8f3.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function should be called by fs-dax file systems after opening the
devdax device. This adds holder_operations.

This function serves the same role as fs_dax_get_by_bdev(), which dax
file systems call after opening the pmem block device.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index f4b635526345..fc96362de237 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -121,6 +121,44 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
 EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+
+/**
+ * fs_dax_get()
+ *
+ * fs-dax file systems call this function to prepare to use a devdax device for fsdax.
+ * This is like fs_dax_get_by_bdev(), but the caller already has struct dev_dax (and there
+ * is no bdev). The holder makes this exclusive.
+ *
+ * @dax_dev: dev to be prepared for fs-dax usage
+ * @holder: filesystem or mapped device inside the dax_device
+ * @hops: operations for the inner holder
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int fs_dax_get(
+	struct dax_device *dax_dev,
+	void *holder,
+	const struct dax_holder_operations *hops)
+{
+	/* dax_dev->ops should have been populated by devm_create_dev_dax() */
+	if (WARN_ON(!dax_dev->ops))
+		return -1;
+
+	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
+		return -1;
+
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder)) {
+		pr_warn("%s: holder_data already set\n", __func__);
+		return -1;
+	}
+	dax_dev->holder_ops = hops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fs_dax_get);
+#endif /* DEV_DAX_IOMAP */
+
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
 	DAXDEV_ALIVE,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..e973289bfde3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -57,7 +57,12 @@ struct dax_holder_operations {
 
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
+
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
+#endif
 void *dax_holder(struct dax_device *dax_dev);
+struct dax_device *inode_dax(struct inode *inode);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
-- 
2.43.0


