Return-Path: <linux-fsdevel+bounces-41115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C81A2B203
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E08318897E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE11A2547;
	Thu,  6 Feb 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="N21evy+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A723959B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869097; cv=none; b=q9sM/lCXZRbeomhrW1QfrU7Au8LGPWd45C+sbFmwtls5lSM0AZqquvMW/kNk9I41IVjWdaduC7hoNBHwF2MMAx1juORIb9PMvjIh5x95uviKH2kpSU4bGl3kC/L+mb3Tcto7evo9YJTokqms5yQdFykEDHIp1sFkm3E5TExjN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869097; c=relaxed/simple;
	bh=9I0quCuK3ocB6TnLZEvD4/SWmOHMQKlhuRxWXICl38A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErYY6YclBNYKriPjF4AG7n9v/dZ1R6SNK4N7J5eieYFAoBcULde/z9vXvdDWPuy7riVN5F3IU9duaQXMBBHlJ7cRc6ekYDRwJCe2Xryb4grIttMQr65dCn0D7tQ774eADAyiRyNfyCjRJTTFVZezX4/ERj49rh/dILOPw3YGoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=N21evy+s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21661be2c2dso25352525ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738869095; x=1739473895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJbpg75fLLo+n0ed/sL2cOGuJyTnrmNtjTMREUR+jy0=;
        b=N21evy+savpUHrYFOo0CdnxB1C60mmja6DGgymjePyNtHUczzUlHnL2UQiTCseEVA5
         hGzQ1WiSPmFAEw28EGhdVpx3mU/if1SZ6cIMaGNHzVFgPNPsWJK8/7ltyTIUQaQuOGlF
         wsU7mkyE17GpNS+crKGf51O9cEu+VSnkKbxKBuSfe/rFsYVABr/yq4taMxm5V1IRA0NE
         ds2xwEmw36b0zZgQu7WmwCtwJKinh+S2DlPNN+ytJUC/bTkiqVj5FpYLaeW9UmGpVweG
         13eeQOfGk2qQtBC/EprDPEydVsgNQ/RzFGKAmHxKMUSKeIqGQ3JO7jclcdKBgY4gUyT6
         t9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738869095; x=1739473895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJbpg75fLLo+n0ed/sL2cOGuJyTnrmNtjTMREUR+jy0=;
        b=ZUoN1/Sh59ZEF8McYMb/AXmwalj6I71oDKphVWiI91nWtj5Btbh0JBrSdXc4Xww/lQ
         T6IrI8m/HWnBlKHeZcsaWSxJxbhLsbAIJR/b0OJdA2QIN0jKTP3LKX4CgD1ZhL+wmTfy
         HRhwwdCjAYlDuBDhrLsR2ZtUUoVpcCT6xQsBO0Km3+wHF172P/o93HnH79ldyj0vBFD5
         YPzg6CcE9sScwo/HLjrdREsHpYWpN9J0oPIv3whXAWNvfUKHa6xaVCWkoMdK5Zg41U0D
         q+HBBYSziAIc4Hhoh7Aa3UfXr5zqR+tSXZPOtYPgYm0zeIJwIcYxmAII0AHOMQ+SWldH
         hY0w==
X-Forwarded-Encrypted: i=1; AJvYcCXoWLX5YzJX+s7duXHajfl6EiVbiC/3vOdYm+bKHVVNbyN0kGmrimdzN3CeCiYvavC42JPnds3YLtPPEgOI@vger.kernel.org
X-Gm-Message-State: AOJu0YwHtcp86P+ySBhuIz639z/9KhIpIwCChY1jfurwQhmpbuIdZ0MT
	iGlbsft/nNni856IqMXAAx19aDmmiWYTOzHfXY8rwH/Bc0ssIz4Fhe63pN4y6S0=
X-Gm-Gg: ASbGnctgk2X2CP+UEjASFS1z0A0cJaXkyjJDxaYCtWW/KBhnKIojDWASrE3MbjGO7/T
	zggPmk0gdMEOZVOfQUBDeLGZ8Ryqruj2DJXzq3K1ba5ytWGPkKBDULepQ8dbhR4HvuYHoX83Dhq
	0NR73rFkrDgg1qgKplSBfa1H+CiVoYEbG0yttZUBn+gvNplYJlibyLeIMvJf6+T/RTi/QAJd0NC
	7LiS/MVh1SAFLI0gGVA0uB2WABUYfWK8DfpdD5Ix9wie8FvVbHf5XnnKc566za2JW37s7t1d45p
	nBJCVx3S1/OVpuZmC58U76txbh4SuAG8qw==
X-Google-Smtp-Source: AGHT+IHpR9Cnm7qEforH5SUfctVVPWqK7U1sHf/lRtPer8qEaC/amdfvhSui6GQLza8k3+7U2f6oxA==
X-Received: by 2002:a05:6a00:1f1a:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-7305d4135demr740958b3a.3.1738869094843;
        Thu, 06 Feb 2025 11:11:34 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:9444:201b:e311:73ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af649d2sm1674301a12.56.2025.02.06.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:11:34 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: add process/thread ID into debug output
Date: Thu,  6 Feb 2025 11:11:26 -0800
Message-ID: <20250206191126.137262-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Process/Thread ID (pid) is crucial and essential info
during the debug and bug fix. It is really hard
to analyze the debug output without these details.
This patch addes PID info into the debug output.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 include/linux/ceph/ceph_debug.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 5f904591fa5f..6292db198f61 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -16,13 +16,15 @@
 
 # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 #  define dout(fmt, ...)						\
-	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
+	pr_debug("pid %d %.*s %12.12s:%-4d : " fmt,			\
+		 current->pid,						\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
 #  define doutc(client, fmt, ...)					\
-	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+	pr_debug("pid %d %.*s %12.12s:%-4d %s() : [%pU %llu] " fmt,	\
+		 current->pid,						\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
-		 kbasename(__FILE__), __LINE__,				\
+		 kbasename(__FILE__), __LINE__, __func__,		\
 		 &client->fsid, client->monc.auth->global_id,		\
 		 ##__VA_ARGS__)
 # else
-- 
2.48.0


