Return-Path: <linux-fsdevel+bounces-11815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C7857586
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3271C2242C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831F14A8B;
	Fri, 16 Feb 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKzwnVlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CE13AEE;
	Fri, 16 Feb 2024 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060620; cv=none; b=cdUFrVABPCj7/6Y8EgKGs80BPAP1vnYDHZ9kJ7OTdpXkwGFQgZsUdOA6yCnuI1RYtu2Nof+s3AfqTYkYB1qXkU2G5e+YThtH0bxd/wCbKifAHe8ECjjfaIEcWdr69HSdwVbfzgUsWyDbdHcBCGdg/wMIad2+Db998jeiazPABYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060620; c=relaxed/simple;
	bh=12AqPGeOC8NWhAo998Q7/iqcQ/iILovqoqyU9sHyqR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7mXofW13G7Vz/zcgTyyI3JR6bGjnEqWBGDIQj2ahvk0xH3EDA240neBMAqOYD4Px0oKXpltYihkOHrFkq2yk85hq7MbQXmt4q0lU8PT8mvxPkML4vUaDLoAZhZBipk3c4ZHC3ff01XOsVMCJEXF/uOsKineOE4i+W6m/TcWMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKzwnVlZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708060619; x=1739596619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12AqPGeOC8NWhAo998Q7/iqcQ/iILovqoqyU9sHyqR8=;
  b=kKzwnVlZLD2eR+VjcIRIth3PSfNsmszRnR4kYv0YDciagzy0jc6MFj2b
   D0RMWpR9xeMoZW9+apfXPD9reK1W25Q1R9joNPKtJGByX3gyNTXlH6KTo
   F9KZlxsC8XJX+C3uOEOkZXVsWk8aM/RcHsFg2BBPqSAzV0wJSF1ggbI2b
   ggBmiMfD4cW1WV8jBnfMXEgwvAHg3CjKS7DQVhR6s7pZXRcWeWl93pZru
   gaSA9CmCoHYYpt+FwVpeEQUxiylrfshKNaDl/+2/AYIqoUfwObdFEu1F7
   iM0VsdNm0DprGTLvIhU8VJPuV1JO7So4FHCFLGw2R3dywhLBkF8j4ROHD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5149342"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5149342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4063885"
Received: from lvngo-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.17.186])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:56 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v3 1/5] cleanup: Fix discarded const warning when defining lock guard
Date: Thu, 15 Feb 2024 21:16:36 -0800
Message-ID: <20240216051640.197378-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216051640.197378-1-vinicius.gomes@intel.com>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following warning when defining a cleanup guard for a "const"
pointer type:

./include/linux/cleanup.h:211:18: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  211 |         return _T->lock;                                                \
      |                ~~^~~~~~
./include/linux/cleanup.h:233:1: note: in expansion of macro ‘__DEFINE_UNLOCK_GUARD’
  233 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
      | ^~~~~~~~~~~~~~~~~~~~~
./include/linux/cred.h:193:1: note: in expansion of macro ‘DEFINE_LOCK_GUARD_1’
  193 | DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
      | ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..085482ef46c8 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -208,7 +208,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 									\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
-	return _T->lock;						\
+	return (void *)_T->lock;					\
 }
 
 
-- 
2.43.1


