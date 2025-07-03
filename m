Return-Path: <linux-fsdevel+bounces-53828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E19AF809C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35944E39F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5E2F49F0;
	Thu,  3 Jul 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpXvOiW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BD2F4327;
	Thu,  3 Jul 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568656; cv=none; b=KmYMSL10K4JIzgLjmdUKpu2iDXeAatpunwUoEY6OHRG3YBdMAY6owwVPTAy0gGWn7RMVAF5+uRGegsmNLryrXN+SJNjpjtMaBTATBZeRBoCYO702XkH/jpFz1+RZnkwmHSuHdD4SNbUAduUgmRjUmyBKlK+ZxBeA1VRX7Ep3LrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568656; c=relaxed/simple;
	bh=3KazfK/QQTaTKMCPWi0YxDdEC7X6OVxJtOIOm2yyTcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmGX0u94mV4QPwkWnbJAKBdiR+7pgC4RZuVoJvnSPxvP7ohxnorWsXmQw8JXKSnRugIgSuZnO7lplwMK5eWwfDmhjve2qEwNlOhKvDOujVlKIYQivo6iwlc01FvbE5av0mobRQuuPOTqZCkz1xRqAzpSWdg4E26YBHbIzFKtCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpXvOiW2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7382ffcb373so158586a34.0;
        Thu, 03 Jul 2025 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568654; x=1752173454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaZvyCikUvPqtnjUjM92+A61XpmMjGb4Ba8q0a5FCxQ=;
        b=BpXvOiW2YfI5BrKVWmJ4j3ntBBMS0BBWEomgtyOZrTi3uRmqCtkz4Pt2AEIDWzQbc1
         hhOS5RgCKHIprUxXQDAgEpKasHfEUV0e74NUQdjcC2iP2pIjVb5IXEO1nB9Zyk/mdZBj
         UFYOmZM4bOy6jUc+595OL2qLts1cSqu6qSc4gmNgCW3rTbBjCdkQxovLOzf8mh6Xgk2c
         xmkctnLBNcV1grRv1EdUabA8p9tP9nHYT0AyVecvSirdusnML6EqYGLEjgDBP4HCbsfm
         BZdwB3zge7l+Tsihi5E6LtrfCZGdbI2532D8LnzHFGlk0swmNigz6wzYmyEzY5qJeesj
         49hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568654; x=1752173454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaZvyCikUvPqtnjUjM92+A61XpmMjGb4Ba8q0a5FCxQ=;
        b=cXdFvRti6Qs2ZLpKfOoibSDXfZmsghQPU6Nb+ajoRwARoH4emr4brWSPl5IaGonKCj
         Se28m7N/lC0fOhH0zvAY5qd3BcZYlVh9+mgUhezkFNGBbR+s6XPMi1vvfSWUebCDKG3J
         tXp5FC45k5734XMJpuDO7bTzxXWMKIBM6ZaYbQtc/RG8bBcHsqEpsD5t2XHiy4Wd8d82
         TOa5y30MFBaHypWUQfTo3XXS/xtkgUu38F/CVa/Md6zuR/AeczDhhW/Ewgvzhw2Irdl6
         BkCcpi3IM6WRZU83N3dUbR8HDmS67k1T9ad3CJYRs32j1RvBRTTbpm+uWrC1S78hcWAt
         ekrA==
X-Forwarded-Encrypted: i=1; AJvYcCWtg5RwpES+I5DcnrfIzfJ0D8nRZUAcf3LCZzIGn+8RZ0OA0QdalNSMsySvstyffY2r4H0Kn9ZOYD0=@vger.kernel.org, AJvYcCWw+bK1I/5CrDkIiXu8FGwN44rjhj0Iv/hAh+IYES4NmU5Ke2Hf+K0wzPSKPENmC4wq2no0PG4xlOSqQn8L9Q==@vger.kernel.org, AJvYcCX4jB+cCMAfBck18dzLIxLZPweCHyZgXrQ6X/GESVKqxcJreSh9ebE79PZDRsgWkmwy3Dfb8Q0mcSpk@vger.kernel.org, AJvYcCXbcv0LRHtWyYpXKaiaTHprjjyC+Xcdqrm/CSMZQ4Rag3NDGJ+LtZSL5zx9132ec7XLZ4gvapkv6W004O/2@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg4sZ3MkC4EZBvT5WFWZNDCCKvrfBleoHsjlfIr+48tU5S21o
	1LoAiZntpVtZ9RG6tCBujLlVk4RHKqni4lxLGVHNVZ65P+1p8md9U70D
X-Gm-Gg: ASbGncvHoGfKAEqTmS/zIfywi3fdZYDcwlqsrSNbsown8OyQBcVHY5VpkBuARXt+I0O
	ixA/TKSwA86I8C/Zk7qcMDT4tGuFlC6apyCTI8mRChGC+oNtm7eE+MiPR3F8zmylBFDd2lv0d+O
	BseBYTtCKUadO9XR/NwAr3vaAAFHkybevW0Fduwm8AA2TrUbZ7HJ5JAv0GFJ2jftY89cQBNM1C6
	hEmegrMdXCvhnxMZjXTF8Ye474WIGLcaTKjuMKW9P3d6joMA0UEBmLaJfqQGX6rMeqcJtkqG5Q9
	K1kwmglXYQaAtL/WsK2yMUtfH84h5w/A1ppDd7KP7S7zhzpd2rQ/8xO/Xl3cL5joZQmslmIzcBL
	cZWbdQPubHcFV1A==
X-Google-Smtp-Source: AGHT+IG1W2DMSfl06LORBDysLa+UgwkOnJVfP99hi5suwjrNBfuyFXSpDfxUXAAn0IKIrMiIDsFKRg==
X-Received: by 2002:a05:6830:f8b:b0:73b:2c88:8ec3 with SMTP id 46e09a7af769-73c8c5d0bccmr3217610a34.27.1751568654018;
        Thu, 03 Jul 2025 11:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:53 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 05/18] dev_dax_iomap: export dax_dev_get()
Date: Thu,  3 Jul 2025 13:50:19 -0500
Message-Id: <20250703185032.46568-6-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
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
index 48bab9b5f341..033fd841c2bb 100644
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
index 86bf5922f1b0..c7bf03535b52 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 #if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
 int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
+struct dax_device *dax_dev_get(dev_t devt);
 #endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
-- 
2.49.0


