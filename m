Return-Path: <linux-fsdevel+bounces-67506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95736C41E09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AC352210
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5F314A90;
	Fri,  7 Nov 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tKXxgKOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D701314A9D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555808; cv=none; b=PhBuM8aAD1d+sgHUfoXAGLVfpEjrIy1f9p8XvOnW6i4aK85iwYo+p4v46muzKTRuaogigBHEc6NAF8W6v1hcNoUmddsCUE/67WCdJ8K0PP6h0wWzPBV3sdpwVhlBYHM2jIBcbbPZSWJ4xT8ZiaZCv05OqJbXJAuS1+EKgeCm6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555808; c=relaxed/simple;
	bh=UCpXheq+ISF5ooL3BArG9j5Ni7nrQ94FnST2TGVI9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSHHjeENdhu1Y+iRwr16xbkAVPGAfxOWN1CuOC/WJ4BM2WiyP57p+vQgnZ080/DV+2ey/vXNohc0xrJH3kuMf0dT6251SIZGzwYR6EoGaANX6vju70Hyfdi02yXJon7biVPzRG6SA4eFNGmLhoVFYz1fNbxV2tnKi057ODeROBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tKXxgKOL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b1f2fbaed7so118509285a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555806; x=1763160606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=tKXxgKOLQJx65x89wlHUjXEms19V2h4+fJag0WnIJD5oEG/ILVml5bMn3kzA7LHKDD
         LoQdZb79TEU0fFHEdNl4l22hrCtI6XV8X/jowNCQvk0BBSWLp7FemAeYB11k0uAvNb7V
         lgfICkxQx5DM7N94uYFET8BHEPw5QZfJIzV8alY5IYe45jTno/a5NixiBZ1VsLouSE6z
         k6i4CxCDOAQIkmBhb/f18FuKH9Iu6OVyW7xn5oYvaATF3mWOYCaHW+Ytm/K5ENzoTYZ7
         3wiIgHSuVrFFM5Gic9V9B2gxUDC60XHGkWXocxp36ukAuwShuqz/V3LH8hgfXHKzLCF8
         d5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555806; x=1763160606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=jy9qQ7a+L7Odfbqoq2XOvIXOnJCDY00xoVNT6MQIp9j8mLql/y3GBfk4hge6yGOAJe
         ihmQ9PD6exNE+l3DmGLhKqVql9R1IpGHur8+lzIGA4t8AfzBye4mH94EBOK8i2QBRGkh
         9WAUm8ufZc2QvkUFIIhdiqkyUk8wIT1aWxmpdltBuDcYvU/3nQ0P1f/JWUdipFAADVZX
         5J1asC4ock6/Pjc6f+NdThHRLZdk5Jl96kBqcpHVGi+6tEyfSUplAJZSjUfWbLkN+sNd
         Hn5iCQaXaYO5GvQfBUby4Tx7N6HTJDbeE7Q8FfFb3zAG5gDPUNolpBwB8tu5J2ZMSFAN
         ZRCw==
X-Forwarded-Encrypted: i=1; AJvYcCXroRIhpv0kr33nMGUpE+qIwBIWCznJxtJsJy+gOwXWL9BlXPrGTfLh3kGyBBsQfeTv9Gov6Hsfs4WKB323@vger.kernel.org
X-Gm-Message-State: AOJu0Ywukj6avDlKcL9EYmMKEuiQLHLWYurb1p8tw2LYNIlNHdpb9Axq
	ZSZhxvDHwX3yJgtqSAQD81bzticrrUgVEcAd5YM8qFsyBQh0zx/lnMBmHwQ9skD9QUc=
X-Gm-Gg: ASbGnctPM84Burpd48Qw169rAuVoNYn7UQ/sxguXSAvMP7qDSSheSMuM5DG3nHuFrDB
	c3rus62q3quygTYeb3AOdQqpBuF1Rb5BV0kuOKLQrCRgc2wPOlVKQGoFGQC1nVy+y8cCz8VWmoS
	rP2KYtbeS2jplqMHnouglK/i07ZiM3gvu+ZaaQgbQeW13lRIk1vZNDXgMj+5aeSFhY5e7o8oSIb
	gTEk/U+ngu2ftEouz3lKEuoGk1hgwcN4AqPrieVwrwwf1270fj3llNYdqGai8rHv7ygOg6GknOx
	SlmSp1DG4XlvmUUzWGO/4ow9uv9YstKImdgzq3FhqPxuUl+Dm3bWlMzB4FD/T9cUDTTe2lALgAF
	V/DJKYwazMdvLoRRfofgl6CbIF82mOek9Wr8MTIMJtMpXknkvo4AxccWCOANn6lZKR2N/dFGbjO
	lWufgUCl8afQhBQgYPrxE8o8jwGhPQzyWtounBmYkFabcMWsWPZ2mTP/2+7vMVCPWV+pNJ/HTO5
	Mr7DdIXGlctIw==
X-Google-Smtp-Source: AGHT+IFFPECdAOsGcbR+MEazzzIO7MJP4xCB0/B2/FxsL9mdOEjwM8IeKSGUWcVdouQFvc3wSAz+tg==
X-Received: by 2002:a05:622a:120f:b0:4ed:6e79:acf7 with SMTP id d75a77b69052e-4eda4fa468emr10231361cf.41.1762555806006;
        Fri, 07 Nov 2025 14:50:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:05 -0800 (PST)
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
Subject: [RFC PATCH 1/9] gfp: Add GFP_PROTECTED for protected-node allocations
Date: Fri,  7 Nov 2025 17:49:46 -0500
Message-ID: <20251107224956.477056-2-gourry@gourry.net>
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

GFP_PROTECTED changes the nodemask checks when ALLOC_CPUSET
is set in the page allocator to check the full set of nodes
in cpuset->mems_allowed rather than just sysram nodes in
task->mems_default.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..2c0c250ade3a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_PROTECTED_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,7 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#define ___GFP_PROTECTED	BIT(___GFP_PROTECTED_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -115,6 +117,7 @@ enum {
 #define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
 #define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
 #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define __GFP_PROTECTED	((__force gfp_t)___GFP_PROTECTED) /* Protected nodes allowed */
 #define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
 
 /**
-- 
2.51.1


