Return-Path: <linux-fsdevel+bounces-18127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812308B5F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8CC1F23996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810661272AB;
	Mon, 29 Apr 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXm4fFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDB126F1C;
	Mon, 29 Apr 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410313; cv=none; b=J3WprfBzHm/X/T6XlA4c9k7XBmjVo2oKXWBglvTzV2+IXWwGp5rj+0Ij++Rv3xcshy6Z/Rk5HkZGF2Sr7Ev3yRNfXizeOn792ry1Wm1WxH7tcQHuUbEOGODyT5xQmsO+jUEx3QSvnALmGO3441CLJPOdtRXRxLeY9qWBsd/FVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410313; c=relaxed/simple;
	bh=Dq3IXVMAl3LwKTvbPabCyz/Wl0bJyojQgrN3Tsz/e+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlWXzP3niVa8P0zYC8il+wwg0t9oaBZq4Cn+1RCEfiVVYYIo0pae/P7PnbhOQqEqTeEg/QB4/BQZDoKy1S4CMUIq6Jyo35XIAzX3iodv6vzRYcB3hYY1xCpMkexIKhMMD2n82dJQE7aSaU9gB5vNxclo7pkHlWVXp2tM0UuYXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvXm4fFJ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee5b2de791so62801a34.3;
        Mon, 29 Apr 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410310; x=1715015110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyJucMVndmC161Z9DZrkXcMb4iGiZ+dSnJlqt7NeU2c=;
        b=BvXm4fFJ1g9CvjQrP86azOyWfSPNl6q//i5bb/mL8CSU+UtVsFqZPaFINk6VG6sMsN
         4cOG9W01f/VZOnp6AZTNgmE9tuKcKYi6I0VHpxg5bJyB2Sbh+lZRtO9pj0+rSkE5H4gw
         tiERlStM9LSUwBZN/xP9qCP8h1QIkBnvr4qT50j18LATH5TO1UtK4dqkWRdKku3gK9Vw
         0n2nJkZ00qHsROso20XMbb5KYGNst/0+q4mZniPu2rldyicy4pR3ObxWfRHy5Oy5gSdh
         nKd/HE6pWcNovuYAa0E2HDF5YVve4yUNtIOOuWCryWDYxSVasRSN3bzeAvLKTq8lGbMb
         A0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410310; x=1715015110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyJucMVndmC161Z9DZrkXcMb4iGiZ+dSnJlqt7NeU2c=;
        b=Zxloyw7gXnER6/M9+Y/kpVcWM5PARW2gco/nEjq4kvxght+EHriGXVHBUFNnjYq3b7
         eCLQSejhXGVqfGjbPVB9tmT9nge0v3qZYk8xde+ddMdW8Z7L0og6W5gWqhFT2t86p8On
         9F1bB5VGzekho5myEfgG7H70L8z9la8+g9FmHIwjxcGDf1Z1bemRx/tPcpIP4RyrPGVj
         czdPUZgRkbXGHFHFw0wukrZNa4M2DpXBfbhvsGDzpa0BBHMPMhLMOkRr0fw65S28ygZ4
         2O265i7+8RWarYHRVoVQxPMPD+LUfqvWWzWBg3OySBt4Zr2g5Y2c1rifNoHvwbJrb8kD
         0gHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUooAxKLiEwNNAag1je/gt3IsMSFYsPPnTUKWdgrnay8s/LA16lCxDevOYI1N6Db+Mey/4pKy9jc28nNtEi/Qz4QjbgUqLzHXdxJJqIeSuyFqQy0djJLRn+KLzi8ouH6RorRT/h6KILYQ==
X-Gm-Message-State: AOJu0Yw5nRr/T+Ez5+Ka6PZkm3hVVuDzA4KRt5AMm6Z8JRzVN63d0cnY
	1xKKApidx4ie9zcyvW7K6/jqaLPi73V+dO1F/erqncTAepZjk6Sf
X-Google-Smtp-Source: AGHT+IHCqWTpNSXlvdUZw5ucdR3X7rIc7toNINCsl6MqALgYwnAAdl+NtVvIB095bO1OU6/08opuLg==
X-Received: by 2002:a05:6871:a4ca:b0:229:faa9:3b35 with SMTP id wb10-20020a056871a4ca00b00229faa93b35mr12606534oab.21.1714410310612;
        Mon, 29 Apr 2024 10:05:10 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/12] dev_dax_iomap: export dax_dev_get()
Date: Mon, 29 Apr 2024 12:04:22 -0500
Message-Id: <bcbc4e4a58e763ac31aade005f61b6676518e581.1714409084.git.john@groves.net>
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

famfs needs access to dev_dax_get()

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 4b55f79849b0..8475093ba973 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -452,7 +452,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -475,6 +475,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 4a86716f932a..29d3dd6452c3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -61,6 +61,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 #if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
 int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
+struct dax_device *dax_dev_get(dev_t devt);
 #endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
-- 
2.43.0


