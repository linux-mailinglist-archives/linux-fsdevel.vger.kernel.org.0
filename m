Return-Path: <linux-fsdevel+bounces-18124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29B8B5F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909F0282A07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DEE8626C;
	Mon, 29 Apr 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBydDiH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610F83CBA;
	Mon, 29 Apr 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410300; cv=none; b=HehtC/EPuX5qIUxdCl7atJ4irhLDpsOJByXNSGwpas5sErGWW2TRB5zx+LOmcIOMkGEXuaTIJbzqPtzZcllDJZMmLKKnemy99KAi+9F9jTZY05+WZRXb8a3cCI3H+gNMiePh6KZxF1moVSzFtGAu4ATnReKuj5h9fQ4mUwUppW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410300; c=relaxed/simple;
	bh=rgBnb8kNelGFoEuF+9gSifpAE2erEJQ3IXeaCnjnJIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7ADVe84Sed5OJUgHi9wvzafWSbMscWUNeSh4r11/DsPe8lYChiBi8T20UVQjWrYEkqBcvH/6gcQXY/h4PRaDWhhCc3t07nzLPWv7b7yFzDdcDhwDSNMfrMBy+CrLyp8FjU1Vo6q2mYQID1A+4dWyWrML9ieWRc7mpigIZZxFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBydDiH+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6eb86b69e65so2877268a34.3;
        Mon, 29 Apr 2024 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410298; x=1715015098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbJ8300Bg7dObjiydXebhYyYyzlw5PN8FKXGfdtJkHo=;
        b=ZBydDiH+fA/1bP3GZ/RcllDl6TKKA/IqcI/ldfXDPMtB66NjqqDETmCs4rxRnbo0J/
         1MAsuWkB5wVn7NI8VFJRS3nWu4xn4MQO1PiqAswRkzDVInHOoQ6sr3maGMWu0Kt12Fwo
         Apc7h2D9GfH6p4EPy2CgeaEBfUO8u2tyFHXVyBhR66RslDDPxZz4KC9LN7H0K4ig/zec
         NQcu9VnGM6qYDbzKn1IgzneOrNKBEdgzQhyr3cqb+JzODummA3NU+jxIYpwXRdOZCS8O
         SCHyaPDYEbWwcbnSmc6bMqcBlt4CfXdNTAM5Xs0MWWjpcGsNKqEFiEMdTSiZA61f2S9f
         qnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410298; x=1715015098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbJ8300Bg7dObjiydXebhYyYyzlw5PN8FKXGfdtJkHo=;
        b=Z9/frp7Q/PgckP5Apm5lqhjp6y64X7C/rXqyFucW5RLmmzCoLHz9JTVrFh/aqZ0MZS
         umO5l8vKR9qoRycF3gVN/ke3+XtwffRJ6zJFGKphmKe3NNW+dL6Od+cNZ/mSWcyfSK1G
         g4S80GLw/rK6aR3FAYc76kwn8OTiXAYOPMSMc71sS1cQEKHHtSp+v0fY/0g+T3ts4uDR
         TRIYsdlqInFTO/uIPwBiPfYnqa93b5ABMJ54AWdP/ffJ3Hn9JFg65iAi2C743AqrW2MR
         Nzfmaz7Q2yYzK+lXPLajxw7N7u2YXGUiWf+wP6HU4JmR7eBwyZ/Wvn5ebY0MqwwVLv/V
         dvrw==
X-Forwarded-Encrypted: i=1; AJvYcCUE0npJG1qODwyF8l+5wIC3zPdZXCerE/PMjgNBR1e7N94beEBpmNGHbES/uIHcQPAiTDiLqyy7g14PjcRPALrdplzms5Dqc732pOGsTefIj/XXr5CXn3ptDMNzHq5HzbfZfn6nCyahcg==
X-Gm-Message-State: AOJu0YyPabATQIVRJW35GIySFLR1Rqf4SfoO1fwzk3J5oq1vyiDB/FAz
	estuxQPFM6jFtVH3wgv5lyzRu4daaLlCbmWwzdYr6A9T+TWrtRqY
X-Google-Smtp-Source: AGHT+IGTSUZCw51+UtLT9AMWjJRVxBGYIxlCGo0X8H6A2GGnenuf0ViFidr/sXJeRaXyY8aUr+2TQw==
X-Received: by 2002:a9d:7981:0:b0:6ee:2d1e:10f9 with SMTP id h1-20020a9d7981000000b006ee2d1e10f9mr4520928otm.15.1714410297664;
        Mon, 29 Apr 2024 10:04:57 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.04.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:04:57 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 03/12] dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
Date: Mon, 29 Apr 2024 12:04:19 -0500
Message-Id: <dc4fa451639a619c1228cbc2cade8dce3bd954f0.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function should be called by fs-dax file systems after opening the
devdax device. This adds holder_operations, which effects exclusivity
between callers of fs_dax_get().

This function serves the same role as fs_dax_get_by_bdev(), which dax
file systems call after opening the pmem block device.

This also adds the CONFIG_DEV_DAX_IOMAP Kconfig parameter

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/Kconfig |  6 ++++++
 drivers/dax/super.c | 30 ++++++++++++++++++++++++++++++
 include/linux/dax.h |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a88744244149..b1ebcc77120b 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,10 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_IOMAP
+       depends on DEV_DAX && DAX
+       def_bool y
+       help
+         Support iomap mapping of devdax devices (for FS-DAX file
+         systems that reside on character /dev/dax devices)
 endif
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index aca71d7fccc1..4b55f79849b0 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -122,6 +122,36 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
 EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+/**
+ * fs_dax_get()
+ *
+ * fs-dax file systems call this function to prepare to use a devdax device for
+ * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
+ * dev_dax (and there  * is no bdev). The holder makes this exclusive.
+ *
+ * @dax_dev: dev to be prepared for fs-dax usage
+ * @holder: filesystem or mapped device inside the dax_device
+ * @hops: operations for the inner holder
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int fs_dax_get(struct dax_device *dax_dev, void *holder,
+	const struct dax_holder_operations *hops)
+{
+	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
+		return -ENODEV;
+
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder))
+		return -EBUSY;
+
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
index 9d3e3327af4c..4a86716f932a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -57,6 +57,11 @@ struct dax_holder_operations {
 
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
+
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
+struct dax_device *inode_dax(struct inode *inode);
+#endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-- 
2.43.0


