Return-Path: <linux-fsdevel+bounces-32315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3D9A35C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288661C23714
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021F18EFF9;
	Fri, 18 Oct 2024 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8SHsib9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF018DF73;
	Fri, 18 Oct 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233669; cv=none; b=kZ22l/6E2zroOZ+/V7ERn5AfZiR7rzSJDQt9ncBLWIzKQjV+3AY2tmOeZ/VYld3q9M6NgIXOPrC55W3oc4DLd1kAffncPamVLI2FOfHGY85nEKo1QE3qV+fSeJxuGtdG1Vf1hjgNiZ8Malp9G6kGNe/mY8gGphyb6Lzk3LT9etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233669; c=relaxed/simple;
	bh=EYVB88p4llixVMUciVyNq2hbHLQAzfv8NwXmpPaNhRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDVTRtuS5pPEFMBefDkxtWhFN1jMT+qPBaiadBofVybAEh8BtFbExa+FLI3CotalfpObG3Dc48Gd8EaR2um+4NtFFxuduvYG8KEAttJYGuOup2CRl6fFRoahBMM9pcGg8iLElQGjuHO49K6xAYvPvZwrfq7TEC9EniMlwY/yKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8SHsib9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233668; x=1760769668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYVB88p4llixVMUciVyNq2hbHLQAzfv8NwXmpPaNhRE=;
  b=l8SHsib9QltXFAR8wOWd0fJsFcSaSH6XWcb50Yt2KSEkh4haU1Chgkyn
   BDSO/wE3xc/IAQdCarULydR8qZaK8d+gdwmo9HP+TlGHvIM16jW6cG2dI
   kVpFK/eo0gpGiETbM72Yllmf4gzC0VQ8cX0tW3MMvipqbUAZ2xVu+HRk1
   U8EAaum01MvtQOZcCHKto/nml9WzmGKgPHs3DPXOe/QjRHxVfT36aWaZx
   LoXYBuuLf5QzSYcd2D9w5up5DPOSRPCwq9oUXZogiCSWVFOCBle6g5+VC
   QqbabAeQkB2WOgT4Hf0tgNZH890AZTa2mkEe5bk+H89+ljzYjvpRWQZE0
   g==;
X-CSE-ConnectionGUID: 2/rQjdimRsm6LZvtU0sAlA==
X-CSE-MsgGUID: aOhFlWsHTXqeFpEbosDNFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884856"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:03 -0700
X-CSE-ConnectionGUID: lhuPBnn6Sp2tniOZwmYnLg==
X-CSE-MsgGUID: RubBN4GeQEObYR11REdZpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607509"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:03 -0700
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
Subject: [RFC PATCH v1 06/13] crypto: iaa - Disable iaa_verify_compress by default.
Date: Thu, 17 Oct 2024 23:40:54 -0700
Message-Id: <20241018064101.336232-7-kanchana.p.sridhar@intel.com>
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
driver to be loaded by default with "iaa_verify_compress" disabled, to
facilitate performance comparisons with software compressors (which also
do not run compress verification by default). Earlier, iaa_crypto compress
verification used to be enabled by default.

With this patch, if users want to enable compress verification, they can do
so with these steps:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo 1 > /sys/bus/dsa/drivers/crypto/verify_compress
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 6c262b1eb09d..8e6859c97970 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -94,7 +94,7 @@ static bool iaa_crypto_enabled;
 static bool iaa_crypto_registered;
 
 /* Verify results of IAA compress or not */
-static bool iaa_verify_compress = true;
+static bool iaa_verify_compress = false;
 
 static ssize_t verify_compress_show(struct device_driver *driver, char *buf)
 {
-- 
2.27.0


