Return-Path: <linux-fsdevel+bounces-11816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E285758B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E942869E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E34175BD;
	Fri, 16 Feb 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6/WkIuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B31401F;
	Fri, 16 Feb 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060622; cv=none; b=csvl1Ve5uR2dg6XGsX38xlw//99IXPmX+VVEUEfHXp5D7STZHICufzg6kzARK1ejHSCWucZ7uNXlBE2+spUOW98UszUzIE0zg02TQfAVx8tIUnqMjTYtsvLiYPK16Ewt0b/it4DcFxoeWJxU7zc6cAaiY07SvR6qMldidlgYCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060622; c=relaxed/simple;
	bh=WuYpU7Tl3Hur5yBPxFGUFGTbvu6gUXpdmpQ3/MOYgP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbOq+tEqGmdG3c/i2yqT0Zojwf8RQNWDzHeYybMROxiqyw5s7I4nm0BC8YEmHZH7naIW88BhsJUSZN1qMEq1kMwxCoUe+8zRX73M74qkhLNlFHySCPs686ghGg1qGOiJUwArYkVAWTjAJeO7O5OlsiPXwj8CW2cgquFf7ls+nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6/WkIuk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708060620; x=1739596620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WuYpU7Tl3Hur5yBPxFGUFGTbvu6gUXpdmpQ3/MOYgP8=;
  b=P6/WkIukM1WMIcrK5jB/PJtlx3+pm40IBnHV1UZIrCuWbqfQpwuSAZeo
   ZI1bhFLCqHeHgJiDRd5fjcAEv9egOJgYkGU7U/mRI3y5SA39b7Ylf18fL
   1/IMlaON17vpu6azAqozSp9CgAML7JX2Gn+/b4LfCGPe+iVfkoIDk8pnk
   bojIgfceUdMy4WkS+BL7/HtWOXLxkEv6/OhNZPxaoR8t14ZE7upc+LPu1
   bW+NAlbjpAnidW52/HD4Xi8otYAkyb+xoeXtHTLhAMcnhIpRihKrKEuDA
   Eepu5TLZh3Mo9v+lPmbBsVB4UcOtdqhBp7Wwn8JISETI2c/JPmZ7LlF0S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5149345"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5149345"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4063888"
Received: from lvngo-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.17.186])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
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
Subject: [RFC v3 2/5] cleanup: Fix discarded const warning when defining guard
Date: Thu, 15 Feb 2024 21:16:37 -0800
Message-ID: <20240216051640.197378-3-vinicius.gomes@intel.com>
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

When defining guards for const types the void* return implicitly
discards the const modifier. Be explicit about it.

Compiler warning (gcc 13.2.1):

./include/linux/cleanup.h:154:18: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  154 |         { return *_T; }
      |                  ^~~
./include/linux/cred.h:193:1: note: in expansion of macro ‘DEFINE_GUARD’
  193 | DEFINE_GUARD(cred, const struct cred *, _T = override_creds_light(_T),
      | ^~~~~~~~~~~~

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 085482ef46c8..c0347eb137a5 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -151,7 +151,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return (void *)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
-- 
2.43.1


