Return-Path: <linux-fsdevel+bounces-60580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F3B49872
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3841BC5A7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6631AF18;
	Mon,  8 Sep 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="DhdMIUn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE328469C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356666; cv=none; b=onvUJkifbpF9OAzCWJSwS17Co5cDDxM64wtR8+qCVzZDF68R73g9wmQ1Juts6DzbBBq3SdKl1ireBE57jODsRXgE7gC3JmgIXOqrhgBvKb1qnOSoA3SWDQntND51pAraf6lHxtewckzI/zPIboOoAaKdzd79CsHavHjOj0C+6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356666; c=relaxed/simple;
	bh=naqO89vSOyeXTBBgns+p5M5J7Oz56gjzzJXfxlrHQ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ux1VEanrH1nZyPS4xGYqq9+QE/QWgGKTP0K6xg07qY5mdEyLbsptmEEisdLVHmSBPbP7nYW3DgiJrnGL1YXnA2DiaXq4K5o+Q/L2Mum1hX3/wNek3HbEVm8RIbaCA9/ow/sTkOoEjOwn95f3qkTAIW/4FoSJ5GqiawT+Vw4pgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=DhdMIUn6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603a9cfaso40448687b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757356663; x=1757961463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YgGQycmClIa+ShcSNbH+2BUvPBs54QxzARtkevxCKcA=;
        b=DhdMIUn67ckVRX/8i1WXVq4zmxf6wJpqkVRHHdyexMVuTjMpsjPLi2cDqdZ4TddQ75
         iIJfa0tAUoahsC74EXBEmvJ4VwebpuqtIpWkf+UjF25btSZpGsA4U0tVdGyr/keXnifo
         AjMYRFOsYSVWHUsxvE8oCXJqVPLoHpHivnTW6KPt9shbShaqchiSiLuy7S8bcLibFAnh
         EgaM3XrLni2SpspcnJBgR4+8i+a7XSR06b6rdYUnhVZZtH3EsVYwfKGR1Yoa2Fe3s9Q7
         RboVrzyv0J4B2q7AxJRsu+BR6bTdLlE7MwX0NZ+OrvUL9rAkcPcNcWmo7PR29ufvEkE0
         jpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757356663; x=1757961463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgGQycmClIa+ShcSNbH+2BUvPBs54QxzARtkevxCKcA=;
        b=N7FCKXOg4ad/+gJ3988rGmezpuyVWeo7515/SmCFXjbQj7nZmOdCjAvlxPXh9BgTFU
         x+wJ+YAaMq2Ly20zFvZf664Y2dteEOpQ/VrnLBkwTKDZK+vXg8LdvX1+ALKAGQPPKTQ0
         EXg/u32rDBGMp5yY5yBcBPcavWuLe4s33uI/sma4xDGJTJf688e7yobdNxaPhP6mui7k
         5bm6CafGTPRMM03RtSVhEb8Q0y/SY0+6C7erPIzDQmIK/52HvJVi3iR9ABITjD8Nb8cY
         HjM069NVGmj658/wu5szqsbh1HgqKKm/6s4y2/KIBkMWNj+3ggkqlwV4RO3ctXm6Dn1b
         XK9Q==
X-Gm-Message-State: AOJu0Yx1QXMdBPP9ZKcvG0tUB8oLbVA8TNkwEL/vpxpGSmqSCqeSOhXa
	wokkEVJJs9pv3kgbolmHxk7h2Uu8LIk1d/5Vm1gumwrknT4oAMTkRRJ/Ok5DnBrAIjA=
X-Gm-Gg: ASbGnctcr8G4H+1yvauXdJZwxuyPJiODcK6a5IOpSLKi0tC1dredAkdbziIL5axGL0e
	TWxHEUdo3Kuw2YRv+BeTMF2BJBVC9xptHZ8dRU8hMu4sXP7XXBJ3y9Bh2xDVh8rvVgVypPjBDGr
	PD/FCKHQdUgaaILCXB0WHbyyEd/wLuMuWOOLAk8Z3jc/d/GmRnwksDzX2eLKU/fScCTTYhQWZOA
	Ga4rwWOFwxmuY73cn2tyXTpZGijx0SoJmZZzvedoLhaJEdSWl+dX/AzE3QPcKLKuoBWKtr6+qrk
	nx9YCl3Z9pQeepvju2hLoH8FKI/ENs3Rn5aFpY9P6IBzDjuGpDhI5KLWsZjgeefnlRJahyt4D2b
	SoE4MufPr+U+Edo+eElvuSeaS6kWxKtdCBu9xGUK5
X-Google-Smtp-Source: AGHT+IHJwOEaYNEwhDFYKpOG5zDF1keBM7TigRfJxMnjrTs21qRd/6AmYj8DmXH8zmiqUMQlztaQdw==
X-Received: by 2002:a05:690c:4b0b:b0:722:6ab7:f652 with SMTP id 00721157ae682-727f5a344aemr72652107b3.51.1757356663183;
        Mon, 08 Sep 2025 11:37:43 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:5d01:275f:7660:c6ef])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a859ff2fsm55140397b3.65.2025.09.08.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:37:42 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	idryomov@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH v2] ceph: add in MAINTAINERS bug tracking system info
Date: Mon,  8 Sep 2025 11:37:18 -0700
Message-ID: <20250908183717.218437-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

CephFS kernel client depends on declaractions in
include/linux/ceph/. So, this folder with Ceph
declarations should be mentioned for CephFS kernel
client. Also, this patch adds information about
Ceph bug tracking system.

v2
Ilya Dryomov suggested to add bug tracking system info
for RADOS BLOCK DEVICE (RBD) entry and to correct
CephFS and libceph maintainers info.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..787365f2ef26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5622,23 +5622,28 @@ F:	drivers/power/supply/cw2015_battery.c
 
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
-M:	Xiubo Li <xiubli@redhat.com>
+M:	Alex Markuze <amarkuze@redhat.com>
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
+B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	include/linux/ceph/
 F:	include/linux/crush/
 F:	net/ceph/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
-M:	Xiubo Li <xiubli@redhat.com>
 M:	Ilya Dryomov <idryomov@gmail.com>
+M:	Alex Markuze <amarkuze@redhat.com>
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
+B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
+F:	include/linux/ceph/
 F:	fs/ceph/
 
 CERTIFICATE HANDLING
@@ -20980,6 +20985,7 @@ R:	Dongsheng Yang <dongsheng.yang@easystack.cn>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
+B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/ABI/testing/sysfs-bus-rbd
 F:	drivers/block/rbd.c
-- 
2.51.0


