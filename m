Return-Path: <linux-fsdevel+bounces-26644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46F95AA54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED221C22EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871516A92E;
	Thu, 22 Aug 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAkvwVxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D52261D;
	Thu, 22 Aug 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289939; cv=none; b=DQzIctpV03QeHzQk39WnpxiFzzak9VDb/Ic9DpuzzLekcTETR+1jUaz1kKfcXTiz6LNur9cC/gNYbAzYEtmCN3DgqX4mcbQgdbH8v2RMfm64uWTWcPli2jNZE84VU4jqr3XoV6NKUvWViMFhPVhEJHtV6WzrmUGe1Js9ReUA+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289939; c=relaxed/simple;
	bh=MLzBpkUYJWmUiPCC11ofDmi4f/AtUmhAwsVRazuR2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HznRiUueMJzujUxYbcexgmdB439M26GHdjxhG9eI+4hvsggrZUnxDyl4F1UUfib8O/sl1iWdoTPNdX/LnWTaYNc5a2YOjasy9xDy+ii5kZTdP72F5VMqq6jsQ/yVGowovuKg9f5pCNc00Ey7EmRDFtd6luFkvUszGyaAg7z4nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAkvwVxt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289937; x=1755825937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLzBpkUYJWmUiPCC11ofDmi4f/AtUmhAwsVRazuR2Xk=;
  b=VAkvwVxtmx9gKC/365AcAGRHd7A+QiaRVtuXBCkAyCeoMCbbbkn3GvYE
   71PNwmmPXriKDEtWWq2yuL1AYZAGvMkUIt5S5Wg53ZPpKm9kD1QgGfSwg
   +slvhcqlXfKuALaFmmnOyRPypMseH6CtkIfNSz9Ll3oGMnGFIH0w4gBdx
   oGPCbEYRDcLtaOt9pwWPdUc9F41n7qfC4x2M4Bvkz1qwlijx4N0misHaF
   pAW8ycARbO15xNavk4ClR+0KuzcfJvN9GsFohT5HuoTR1htbKcOKJL4/6
   kOdXBLhsH/klCp/mxGBS89yNC6acvS+cPrZ0tSf6CoKQaqAH2ULmRWJwM
   g==;
X-CSE-ConnectionGUID: EP00pN1lRP+7LDkeyw7LTg==
X-CSE-MsgGUID: 13vNRATuSN2MHJmGbPZkig==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574744"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: 0WpHMbqjT32eHpo0Rj8ozA==
X-CSE-MsgGUID: 27+qDwWQSK+S30ndu1F6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811038"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
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
Subject: [PATCH v2 06/16] cred: Introduce cred_guard() and cred_scoped_guard() helpers
Date: Wed, 21 Aug 2024 18:25:13 -0700
Message-ID: <20240822012523.141846-7-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These helpers will make it less error prone to use
override_creds_light()/revert_creds_light(). They make sure that they
are paired.

As they use the _light() version of the credentials override/revert
operations, they should only be used when there are guarantees that
the lifetime of the credentials in question is not modified during the
critical section.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cred.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index e4a3155fe409..f4f3d55cd6a2 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -190,6 +190,13 @@ static inline void revert_creds_light(const struct cred *revert_cred)
 	rcu_assign_pointer(current->cred, revert_cred);
 }
 
+DEFINE_LOCK_GUARD_1(__cred, struct cred,
+		    _T->lock = (struct cred *)override_creds_light(_T->lock),
+		    revert_creds_light(_T->lock));
+
+#define cred_guard(_cred) guard(__cred)(((struct cred *)_cred))
+#define cred_scoped_guard(_cred) scoped_guard(__cred, ((struct cred *)_cred))
+
 /**
  * get_new_cred_many - Get references on a new set of credentials
  * @cred: The new credentials to reference
-- 
2.46.0


