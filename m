Return-Path: <linux-fsdevel+bounces-1841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D761B7DF68C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8352DB21272
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6971CF86;
	Thu,  2 Nov 2023 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGiOLDfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8B6ABD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:35:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A1138
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939323; x=1730475323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7TnWc5cu1rXOOadSPTnE1cG3GqE2CTV6A8R/grTOLa0=;
  b=BGiOLDfwqcw706EkjyEgUotBbAiM40mDPpmK/Sy6oe5U7Nx8GLwCapdh
   aZPX2BqHRFO3Mut6JWy7wHWvEuiwRJk4YbKf5HQQf/V0sUefRzJTcnfuz
   AwZ4EKBKBXoI4HP9AaKnMDQCX4e2PPgiQof8Nq269pGQWQF61Y4rxSmHa
   08aPMj2XM9m63hsx9ghe7HweKOUP00nTODutF92xWGG5NNEMQYsF7Z+zs
   0DtIgy5HqxjXkD+XEH6XTa3xL7xGmYwGNBhMmPPJOJ6IyPcky46KGdtTg
   rOrakfMDaiFiEWkZKPGKlYDPTo8myYlWhGKqUpSb6ojMKu227diYr965i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419848015"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419848015"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="9042463"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:22 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/3] ida: Allow allocations of contiguous IDs
Date: Thu,  2 Nov 2023 16:34:52 +0100
Message-Id: <20231102153455.1252-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers (like i915) may require allocations of contiguous ranges
of IDs, while current IDA supports only single ID allocation and does
not guarantee that next returned ID will be next to the previous one.

Extend implementation of IDA to allow allocation of arbitrary number
of contiguous IDs and add some basic KUnit test coverage.

Cc: Matthew Wilcox <willy@infradead.org>

Michal Wajdeczko (3):
  ida: Introduce ida_weight()
  ida: Introduce ida_alloc_group_range()
  ida: Add kunit based tests for new IDA functions

 include/linux/idr.h |   4 +
 lib/Kconfig.debug   |  12 +++
 lib/Makefile        |   1 +
 lib/ida_kunit.c     | 140 ++++++++++++++++++++++++++
 lib/idr.c           | 240 +++++++++++++++++++++++++++++++++++---------
 5 files changed, 351 insertions(+), 46 deletions(-)
 create mode 100644 lib/ida_kunit.c

-- 
2.25.1


