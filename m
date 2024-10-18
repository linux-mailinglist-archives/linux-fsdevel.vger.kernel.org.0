Return-Path: <linux-fsdevel+bounces-32314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205239A35C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C01C219D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A718E742;
	Fri, 18 Oct 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG8HIowt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC518858C;
	Fri, 18 Oct 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233668; cv=none; b=PxUBMMWFVZ93s6IpSTgiTyGshEcdah9xMuDwa/w966Vb8WzIeKnqYHXAkffmbm50hZXAxpJ3YHBXWWizwVYuOolYzwOvHlHHUUBfHsbUBDC8LRL8pUgnASqmiZotwXctHhmljzf0xSabAR262xyDsXHCiPFCk3PMHZc+0gwk8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233668; c=relaxed/simple;
	bh=Z1uLVHFrCxBVRppWSz2uPPFIJpDocNdlo79Vr4aRt6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D56mnSvgbL5P8piY8KRfXeWgkNE6dZNaxhC+ub06daRm9gpYrXEs67cev3wUNNCGMODeXyPhZl0XNfyQCgEVS46N2I8BxhIL3pMno60+q/RHy7fkyPeYLQcYp0GVmySkgr/dSwjF36Y5SnC1cSNwOrgb+MhnubD19zAwi7OtYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG8HIowt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233667; x=1760769667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z1uLVHFrCxBVRppWSz2uPPFIJpDocNdlo79Vr4aRt6E=;
  b=TG8HIowtisZKcDx9fylSVbxdwPk1IBk30b+kUbv92cGfT6evCtMwBEji
   +Ye6d+OJiP8cjPxAOQ9eUGp43egyYrLDAUkPkrEEDWGDKB1red0ew84i8
   9iEUxsAPxJmlWMqbwISbPCS82Omvul+iAITHdHSVuhkLVWuYL4NjpkEho
   FgR+3hqDuWTpyOwuRSzlB2Ep98Y2agRsYsv8aG46gtsYK+uve0Dw+eTRF
   arcbx2Oquun3VtoHLH4nHq4mr57FPWLHC4Iq4VGsrE908Ze/InSv+8skl
   cHw4XG0blix0bMmZVchZdq4JewlE09GL0zFCo0UWRnNgG/JaUJLl8/xt5
   Q==;
X-CSE-ConnectionGUID: nqPY467TSxyDfVNSteo+nA==
X-CSE-MsgGUID: iBYUGjgjQ0uPwiJqU/z7EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884837"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:02 -0700
X-CSE-ConnectionGUID: BcOBrWNBQuGJzmoGtHi9jQ==
X-CSE-MsgGUID: tf9TGtY1SRSPfpX2G7ugmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607504"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:02 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 05/13] crypto: iaa - Make async mode the default.
Date: Thu, 17 Oct 2024 23:40:53 -0700
Message-Id: <20241018064101.336232-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes it easier for IAA hardware acceleration in the iaa_crypto
driver to be loaded by default in the most efficient/recommended "async"
mode, namely, asynchronous submission of descriptors, followed by polling
for job completions. Earlier, the "sync" mode used to be the default.

This way, anyone that wants to use IAA can do so after building the kernel,
and *without* having to go through these steps to use async poll:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo async > /sys/bus/dsa/drivers/crypto/sync_mode
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 6a8577ac1330..6c262b1eb09d 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -153,7 +153,7 @@ static DRIVER_ATTR_RW(verify_compress);
  */
 
 /* Use async mode */
-static bool async_mode;
+static bool async_mode = true;
 /* Use interrupts */
 static bool use_irq;
 
-- 
2.27.0


