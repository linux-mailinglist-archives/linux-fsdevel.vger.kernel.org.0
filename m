Return-Path: <linux-fsdevel+bounces-75896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHeuDyXMe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:07:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B03B47FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03863017032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46435C198;
	Thu, 29 Jan 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qC+QQ2Bf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83D35C19F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720696; cv=none; b=CcV9MLBo+JesjpZls6uExor8ovBY9ddkHh+iwlbVFUUlr7VnOREPEfFMA0Fkw2spIjJGyJarltl2N4K+JrZ2E0yvlasWE9czCtX9Wu4QPBRpxm0Ehef3IFw/mRVGKRzOJOvZPcZQEFRs09qZOSJK+hggkqJxTdp440r7AsGkUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720696; c=relaxed/simple;
	bh=V3jcetw4D8mN0UQEcroE5IaVeGXsJTloPdOskFdLl70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkx0mCaPAsvdxbD1/6IvqigpUtu9EOTvNmRVIilLpF66lzkQT/Q1OGSZYTC7wWKIY2cdgnKWwGTU6wsKs4P9xzj2EnjoU6uhnjbgwxVE9cMcSnH31TKMRmj0bdUn9LSbc/nT0ZNuyklwswedkETczjL28ZIq6/MnihcePwrgsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qC+QQ2Bf; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c532d8be8cso144850985a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720691; x=1770325491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFORCx/4rWXlwM5MWzZ4y2ZhtVTmicaaxzmL4W2ym48=;
        b=qC+QQ2BfI5LPjX/qao3rzwQhsN2mA3Hl5tspU/p8ra1TKa08jShwmEd13jhZBGrJLT
         dC9WoER48g/QzZ3u68huExwm8c/iX4Qq/q9AuqFSw0t+22UY+4bKmw/8vYVjL59dU0hq
         sgMPKidtkVAzGkUvSQOMERNFdcHFdtglcIPWxebfBSvbHamvffoUJdJmm0CBarsOPh7u
         VzuZwq5W502DJxVv33LFq2/tGFxwwI2FAe3JRIMwS5D1i9qk1vLoTdTJjOFaAbl1NFEx
         z+a2EBi/qNQ1pO14qLwlKxAL9x+zGT7QEPcCUe3V3NxbVbx2OlchfR695JYBppJUGp0Z
         vMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720691; x=1770325491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFORCx/4rWXlwM5MWzZ4y2ZhtVTmicaaxzmL4W2ym48=;
        b=bvI9Kd4BTSIzBLMO/I8W/hpIcnG5mHYSA8WgV074eNxmiryFJE1c5A3+BSggK6Ro4e
         8bsHprROfSgf98gpEORY84H3vDmUDZlArf71drq9wDAW7XLUs0HQnnnW2SVBSnc+wY64
         Sgg4g2OX8moL0kG8SrhND5eB9v0pOTTxW/JodzoFSA5ZOPogWrERQeZFhbxU8Uys8Kip
         FODJP6PsnnAaVJ3sMocrJF4X3B5ePJFflWPN9fuW4dPhK7ptLalUCwVW/KRf1UD8eKWt
         OKyRylLDBonVkEJOfuMLEIE29LGdoBAxN69Dg7yNtymYW/gptdrInE85IskfZLEnPC7l
         HKWw==
X-Forwarded-Encrypted: i=1; AJvYcCX5hVgQyAxJVEdq4Du/t3oclLtaN4431NgsfnJYRvgh2hc/lulGal2zaiWBCWAyFzKpUx/LoES/V+fJLXfm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BSr/JNYdToyRWPGcejRh3c0QMZJIGe2EMhOqcuAzOrrhmjuQ
	zqi42Tb3cTgzOgtgbCIHwjbjc39D2HhGQQHx5RWVmLK3IJ367/Ua/bELQ6ipzQLOhRY=
X-Gm-Gg: AZuq6aIvUbCeh2C/SYd6WO7o9YPNaAatGMt0sB17A3XbSZwhvKxPEtpOb9VqOlB8foG
	y0x65MQWbR0EuPHSlCcwgNbdWqE0rP9gscPkfp88zbWWW/gQqoS65XJfYwLz9VX1aRUvrNTpa3Z
	6duCHBPCxb+ys0S4WRDl77DbC6DgbtWtEopJfPoiZDf529+fyetitciExYhB2VZeTM0Eb5mWf9V
	0MqPehl+3qMFu5XIa3pMoFb+m0nwfuxadVR7xPAFMrGNDOtLJcolg+q0XIq03jjAz9r9Ptq/oE7
	oQO0MVk9t27hUbgp28c5r7h+MKRKng1WkBzZ2zxLSa6Xl2GlO+s+ESEC3iBDCUbrPOxTPii846Y
	6bwQ5tp7erDfFlgubpMKHk3L3h6mXV6orNF2skB0Ss8Ev7pHP9yKbQ5i/RX/Xkgs8JeVCmEHg4e
	9DewFsVgIDvIfPhqXLcyxA65jBMx2GekzuFKoRLOZpWnXsI5mlUVvUZRCZFxuTiRRz/6InJPTnL
	fU=
X-Received: by 2002:a05:620a:298d:b0:8c5:391f:1db7 with SMTP id af79cd13be357-8c9eb3119c3mr144724885a.64.1769720690713;
        Thu, 29 Jan 2026 13:04:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:50 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH 1/9] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Thu, 29 Jan 2026 16:04:34 -0500
Message-ID: <20260129210442.3951412-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75896-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,suse.de:email,gourry.net:email,gourry.net:dkim,gourry.net:mid]
X-Rspamd-Queue-Id: D1B03B47FC
X-Rspamd-Action: no action

Modify online_memory_block() to accept the online type through its arg
parameter rather than calling mhp_get_default_online_type() internally.
This prepares for allowing callers to specify explicit online types.

Update the caller in add_memory_resource() to pass the default online
type via a local variable.

No functional change.

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bc805029da51..87796b617d9e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	int *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1578,8 +1580,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
+		int online_type = mhp_get_default_online_type();
+
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
+	}
 
 	return ret;
 error:
-- 
2.52.0


