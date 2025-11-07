Return-Path: <linux-fsdevel+bounces-67513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4053C41E57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AF53A3BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041D33DEDD;
	Fri,  7 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q08QAoxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA833A018
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555831; cv=none; b=kGystKMOHchKedH/+UnBuScGVsWcJmRinuYJVNmNlTPjQEGL6Kolab1Dc6k3+k17Kcb/0QZtGSCwnFXaRFPDsfbzJrLFXCrQSZB+fdawKoXirzWuMP/WmG+Lkk0y8UM8vL++vESMmFvDPrvyyG6IOeL31nFkbp7G8H303+OQyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555831; c=relaxed/simple;
	bh=CNVKe4UoF4HjKWlrvxf/qnyhxQc08gfgs8nx9Dft3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKWzGP1PssWaug7cOhjDzA3hEnWrV89XGdYDXgjSiG9UNm2k+/d9CckNvsCBaAfHt4D2k7tBvdx7SRmMsc5dQ2wdYkzyxUArHpHuju4MpIBLdKXXjMpW1r6G5Uf/0NbAVERpn0P034mchUA6dcXqgR1DCBPNrEpwdGl5rWinE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q08QAoxW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed82ee9e57so17142261cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555827; x=1763160627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=q08QAoxWVJj69JFbkhxxapbBs4S8dpPKapCmH9sXwTVst1MP8fcWCHDuZgzdljL88L
         H5vIVF/Ov67nCjUb+ldFEdIqq8PXzqV83sB3DKsUKdtmo6ocPd2nVi2cHA9lFp6BT373
         +02gnhC1M6NSAKbGOuh9RcEVEWpyN4nrzaRGvdBl2ZKJwXPONSLHO6wk0fRrBj6ARh0F
         odZqvQAs9wAgYFxUCZYqGhjFCRnLQKeg9k06osxeFnKA9a7GH8BRSdrpVJLK922lC7Ca
         Fj2gO0yCKwQ1tYGZq0b0uH8PPrTQ1AJnch2Vv9ZWRZgItpiXtaSKa/GQk8mlrSNr8gsW
         TJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555827; x=1763160627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=ssPnwN8T3Gj+LxnZx6fy8J2TciGtpaV5l0z+vCLyA5CUjzW8o5bULrjnSbcSi6cY3z
         DP/0PSMhC67za3MoylaCqkLRIWUavkz/ANqDFbkGKCZpiE+GsnLU4ztAOlxY/LU3vVj7
         vRzsosPuD1Kuop8cZL6bCY7d3xcDcNpQ6CbBYektL0sfCCAKGbgdPAAjPlWAErr/5F+Y
         6RhX0lWLZ0CXvA4yDRN0M4kzYJBEPTZkgbKDfECR1dHYIVbez7JbU0lEGY8BXGngmkP5
         0X76hLeLaA/tk4FeAZ40SoGq+EPFB+3WgpnB0StFTeNqmSpejo1GPzyYTbrP+CmoKKYK
         fVTw==
X-Forwarded-Encrypted: i=1; AJvYcCUpJwa3ORySryXZrGw2J86uqfdMrdT7MIRsa8tUBFEGCw7AtzAtOm7BNdfpNNnrpQVxGYh/P03Yrb30YJRx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8b8+/wCEaiek5ExE4xfK8mCjKnCWjt/+a1tIW0oHgjoBcPJE
	BXAR2XmBzj1qVlyBiF6tr6w5EFQDtTAf/Hr2J03tsQKCdWvxOTzGWJb5ZCw3nzv7dQE=
X-Gm-Gg: ASbGnctGA2dPfOZgG6sKWT0LiguPO3MSthoDM+WYqAQDZMIKt/+1dCfcHHrLJ7Is7OT
	1YyRLJ9TVaU0CdQOWYkG6Vd3RGmEHdG57QF7YAZtge8+vmSLhBlovhMAj4mp5W5uLp/peZzdESS
	JW7gWZjMPFxDjUkmNkPFqdc5qKZopdgD3PHC8s7zmqvu3jKT68E/pq4qoZRVLVgAUJQ+lulx29F
	ybs/GqhtzURtg7LkXTPwHc6WMiFHoNjtAd1Rh6NMFO8KiykCVqIVOmOAuPFP9JIFWRMX7fkANGq
	aygvFeM8D6jwDupx1qVE3mBJ12cZ10qD2jbu5Q2SiLT1at3SOxf1rTRW/va7ltfyhbSsGj8zss1
	kt5/eArcTz45/fV19BYrKewVbSlSMEr7SdXBC9saRkewjZXRfDhLuEeJCYRhAI1UVn8zFOH2N47
	IPRWQYjGyE9S3EyxNr9pL6KfUMEEU5cFsph7zp2KLA9MNlgzhRhn2OlLrHa3RsRMlh
X-Google-Smtp-Source: AGHT+IFm7+5mwYzM+NrPR3r2lO2/HN8TDlNByi59dSrMG4CDuhQ9TLgCeHpdJXuwA3iY2H9OGim97w==
X-Received: by 2002:ac8:5751:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4eda4fd4dd3mr9303801cf.73.1762555827556;
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 8/9] drivers/cxl: add protected_memory bit to cxl region
Date: Fri,  7 Nov 2025 17:49:53 -0500
Message-ID: <20251107224956.477056-9-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add protected_memory bit to cxl region.  The setting is subsequently
forwarded to the dax device it creates. This allows the auto-hotplug
process to occur without an intermediate step requiring udev to poke
the DAX device protected memory bit explicitly before onlining.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/dax/cxl.c         |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..a0e28821961c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -754,6 +754,35 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	cxlr->protected_memory = val;
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -762,6 +791,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..0ff4898224ba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @protected_memory: mark region memory as protected from kernel allocation
  */
 struct cxl_region {
 	struct device dev;
@@ -543,6 +544,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	bool protected_memory;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..a4232a5507b5 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.protected_memory = cxlr->protected_memory,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
-- 
2.51.1


