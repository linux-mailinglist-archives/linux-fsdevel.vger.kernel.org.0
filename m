Return-Path: <linux-fsdevel+bounces-69989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CCC8D83A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3B9E4E6751
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D0253F05;
	Thu, 27 Nov 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gid/SW5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99D328B7B;
	Thu, 27 Nov 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235456; cv=none; b=NT/szPygN5wawt7uNStS/4h7aumFnK1R+ddd+XzonenX6A5Nu/D2oI5wmkNXg7NmmR8zhGkzxeZV3JnWqk5tCmZaKdpSB76lwlfXJgSFpPK8EyDZwNxjQG0nqfGcgWwkrxBaSHx77S9+rXErz7P5lxvSbaUjj4J4SjmPkhd/vck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235456; c=relaxed/simple;
	bh=TGD2mBSI2Nm525yY965kECMgewcZU2Vn20LzBqfECL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyx4evoZgOtmZgc2lDNC3JxUMiIzdzHKWv/jjvRCFKocbwkqr4Ky0zT2naXeIYJ4Ch+EpXH6R6qHL4erGxod67DsnYt/Wv+xcf4dD9j/PTehPwrHTRJTS08DL/27P2N81sSHt13Gy7/CdM1P0pTk0nw9ccO8BhijrfHg2pZMzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gid/SW5K; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764235455; x=1795771455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGD2mBSI2Nm525yY965kECMgewcZU2Vn20LzBqfECL8=;
  b=Gid/SW5K4Ahe2t3LppZIur1yOgeZOFT2/VGA1EhOrvUe3KzwZzhJErEX
   WtaTRAbJih7idinGe3ZOMplpSUy02bGjIu85ZXbJB1L7unWveUwXFnKw0
   b3E1uQLn0a+HpSe/NswpugE4kq2SH1RhUPRFFs9l1qWlp6XgycmNsZ/By
   Wv8UaVcJiUfELmAM4qeYhIUMLmIMFF8H4nqsU67ujdxa4u8yavu2HE01+
   xkzKA9PDsoCx+F9uAzr2t9NYApxxIXlY7rbImJN4Sqfvr+TitZ6dN+nVB
   IECWMkWrN2BWjvrykB8GDPWwFIxVkXlsGsqB1V+RIUIaS/UbRoIKjr8go
   g==;
X-CSE-ConnectionGUID: y9ECDumcTRG7U5SLGj/6LQ==
X-CSE-MsgGUID: KGvqSI2oQwuh1U7X2z3PUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66226336"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66226336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:24:13 -0800
X-CSE-ConnectionGUID: FmZim8WuRQWylPHqkM42lg==
X-CSE-MsgGUID: Pfg9esApRR+Pu2HVOvZauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="223888045"
Received: from jsokolow-alderlakeclientplatform.igk.intel.com ([172.28.176.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:24:11 -0800
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/1] IDR fix for potential id mismatch
Date: Thu, 27 Nov 2025 10:27:31 +0100
Message-ID: <20251127092732.684959-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When debugging an issue found in drm subsystem (link to the
discussion in Link tag), a bug was found in idr library
where requesting id in range would return id outside
requested range. Didn't see in documentation that this is how
idr should behave.

This is an RFC as this library is deprecated but still in use by other
subsystems. Is this fix proper?

Link: https://lists.freedesktop.org/archives/dri-devel/2025-November/538294.html
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
Jan Sokolowski (1):
  idr: do not create idr if new id would be outside given range

 lib/idr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.43.0


