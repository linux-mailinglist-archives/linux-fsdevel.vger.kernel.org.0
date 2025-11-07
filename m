Return-Path: <linux-fsdevel+bounces-67512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F6C41E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B012188CBF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3F33A00C;
	Fri,  7 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u8Hfy9yp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AB331A6E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555828; cv=none; b=BPvpmEbBv8z7kSPImgL66k6NfpeujsZk36EV3f0XI5I0/eEsZH8/tXw9ZRw05D4zeTJ0QyWhTcur/02dA3/VH/TS69jh4wgG8a7PQNmRxlFsOoeDpYF0EW7gL91Rf8Go9ok9En8JN/uJedIBPsrfLEZz7M5g3co/5wtDX2qfgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555828; c=relaxed/simple;
	bh=tSh2k/90dL3dI0zpcxARGhUF4rlq7O4vW4BNP7CcNwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3KtObxZbnKg2vVfCTNXBafjXeLIXx6bE3ELT+r2y/FxC5tAb+lhe41o+UrHvA1RAm5Syzfd+HpXWM71oPlLZSaK7g6MXxNipOh9HjlS7K/68hFMWyem9RZJtpWvBbuPUX9syXxVtIrAOarFMIRN1Td2Rh2d1Mfg7rHOQ7BUfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u8Hfy9yp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda6a8cc12so453411cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555824; x=1763160624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=u8Hfy9yppE7hJYWdvGXwqu4UUeJ4c8M72GvB8nzB0sKhjGANzGmY42LWYH+0FGd3EV
         SavDmpdq8ifuPbqHLTScAUSKvQ95XkQfTliSlYf46abW/LzfVBb6QPJ/ORSOZhf4NFV3
         EWRGsXr+V1my0qR84FgK7VLRr8iC0d8jMSPsexMJBu8GOb/yIH1XNkVsEEbTFk+ZQyBA
         DfRyJWxMV1o+V1RRUB7VYS4eze804l4gq9LKAEcF0RLyjQcnaaoHBaWMUbPQUGbFs8mC
         XunbN6E9jJKfqhQ+71Q0Z4g4WrmJdnXgPdy38U4pAkrivI43xewrYqL48JWs6CJaTQhd
         r5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555825; x=1763160625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=Tbu0ABJYo4UJYZh45rFXgJu5iNck/Pt29zju5KPB6nTJ3jg/8tk7kEcYFfTOgbAGFg
         r3GLuRPMTMgISyaNVoT07pbOucqSIjaMfhE7iOBFR2hkawtqwj0yMVQW3zvoPKxBZxLm
         h08O4KlKdoKGasmKfyB3xS8AL0SdK4RsihwQ6BpuZtEeXaKXvuuTduRWLbaOGzz/y/cU
         6sE1VXUv0cm2ElPfP2VVXHopZheCMEw1CNAUZvEqJro6n6x3fO0Ss+r8LB1qzzQdlGnP
         /ZnoXnVi/6E8fLZIeG6X5u1nklCyEnebogjYEM4musJmghJNKzjpQ+D6tS2OHH09er5D
         YvBA==
X-Forwarded-Encrypted: i=1; AJvYcCXyWp8Yxpag/II2fJ44mK4mZeh+1+aVPukKYwZ/1FcxwrADAeFnxGvr93zrgDIEwDt7OoXD0SOjVx+0BMIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUzOXOfK587b58efA3ij67zmezeRFTbmfpmoo0eVbAwJxxCW/
	Ozimmgv8U/XMJ9pjgJa3Lehqgob9DRyEl6crPvPPFWa3eM8bd3leLgw4vz9saQg69L0=
X-Gm-Gg: ASbGncv/X69+bJGy9iS95sQYK4Tcm/2TI+ApgMATuLc5aSxdxFkpSGgAXpr081dJ0tq
	UXX6ni00Ank46EcTZIoU9+lHlvVk4kW1kX1HXBGtJ/3wF6hCv63Ze5hD/OHq7yDvkKlGVrG6O/1
	D43P+YJvOXa+SrN2bUKBYhJDKO0vyro96LbnOtZuNOqO+ALATwtV1byFfRvFI8JQH7wXq4JI3fz
	oUt1P+psW1DHQcLahP6xmgdC5WIQ4jO3VjVEVrG7QmFaUYFJzKHEq3Lxg144eQ8nnfnhPLKnMR7
	llenZ+37rpCaSDTG3fSurQMtmVFCb+/B6fDwUJ2HDBJ9LLv6w9cJYCGdmY4cDqWv67rwxpLqB9R
	uWV/XCvqE1VuHTc2q9VstVGN1VVOJQacJ7Itls/1ivEGnXJ642pZoc/GQpC4zK0FzdoCsjmrjOS
	tkGN0vgr1KmvZrSRGjKzotaczGcrtyqPoTVsZLybsG8vFm2VS7GDtD5uKkL4AWIzNB2BmFI9xz8
	l4=
X-Google-Smtp-Source: AGHT+IGGUkY/hMvQZUDcDXSyhiDaml+qPtZeSmCY7fYoXMiela3sPEpJdPQ5lN6VWEde9PlUke632Q==
X-Received: by 2002:a05:622a:1ba9:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4eda4f8ffb3mr10117651cf.39.1762555824542;
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
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
Subject: [RFC PATCH 7/9] drivers/dax: add protected memory bit to dev_dax
Date: Fri,  7 Nov 2025 17:49:52 -0500
Message-ID: <20251107224956.477056-8-gourry@gourry.net>
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

This bit is used by dax/kmem to determine whether to set the
MHP_PROTECTED_MEMORY flags, which will make whether hotplug memory
should be restricted to a protected memory NUMA node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..4321e80276f0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1361,6 +1361,43 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	if (dev_dax->protected_memory != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->protected_memory = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1388,6 +1425,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
@@ -1494,6 +1532,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->protected_memory = data->protected_memory;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..0a885bf9839f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	bool protected_memory;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..605b7ed87ffe 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -89,6 +89,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	bool protected_memory;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..140c6cb0ac88 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -169,6 +169,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		mhp_flags = MHP_NID_IS_MGID;
 		if (dev_dax->memmap_on_memory)
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		if (dev_dax->protected_memory)
+			mhp_flags |= MHP_PROTECTED_MEMORY;
 
 		/*
 		 * Ensure that future kexec'd kernels will not treat
-- 
2.51.1


