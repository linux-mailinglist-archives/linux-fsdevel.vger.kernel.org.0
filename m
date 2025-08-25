Return-Path: <linux-fsdevel+bounces-59089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21983B345C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8CB488427
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FE2FD1C5;
	Mon, 25 Aug 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MmUXfq8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0E2FCBE9;
	Mon, 25 Aug 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135662; cv=none; b=bDk/4M3BD8xQdxvoQFAM3EaahcYyMBcVQS6wbCoorYF9/51wKxs/Eb7Tw68BdZCvYdbXjfwyfYfa9OmoBVQsC6qpnY0Sl7Zxj6kGIRL69Tm24eFHe5pJRL7DzpTZAAjouE9+c6SgwAa/UjjgdVtbIVGvTO/96sge+2zibvR6S9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135662; c=relaxed/simple;
	bh=9teZsTlxaiCMeOlbM7YIEPYnNGo5OqA0QqKK4+oc4Ns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUpOL9m+FxYKE3KosiQNV6I/xP6MaXk1qgWaYtnR7+8OjJfDBy1ejH8DlwENULHyqiU7B8BBwED+rJZb+JDkrQu0z48ApFoBGt5DVVCyV7Zz4LMDg+TTuSrclXC90QX+rlZV5Y20Rw2qugDFKWTsvdFYevzESNwqz46PYLCJ0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MmUXfq8D; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756135660; x=1787671660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjR3IxmlegVTQ8y8i+n1XtxsAeGOstInWSOCpUqe+tk=;
  b=MmUXfq8Dq6g8cjhuRgL9Fti7x/nIDO90WPT6MvX5gMNWBUE9pExtjljC
   zHhG0mqY6wUEmNQaPORh0at5PForiH3q4Vb8ev0eZURs16LMyFoYFauma
   FRgpJNY2nw/99Xo0sqLiih9VvhILCdt42ovroSCn/MLOylLFRnHIyoeRM
   hkQVhxEgYj8DC2sScLSLRQgjC6U2jt8ogAoxbCtlHc9Ed06a7tvyyuW+B
   DbYK+OGAnn4htRNYN92odRP+Gowfqc36TqbTWcs0oSG1Nt0ayQqe2ua+F
   IkBObDqN3DpYSlq7lg+CCbYL1UaXj8sFeafdldUvvOJ+x12bOCQsjbQPe
   g==;
X-CSE-ConnectionGUID: ga3VzlrpSj+HL4YyCc3hVg==
X-CSE-MsgGUID: aGHBHyP+SVyVvc1gK/EdTA==
X-IronPort-AV: E=Sophos;i="6.18,213,1751241600"; 
   d="scan'208";a="1635991"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 15:27:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:23105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.91:2525] with esmtp (Farcaster)
 id 1152cbe8-a41b-4717-b99d-7936b4c67de5; Mon, 25 Aug 2025 15:27:39 +0000 (UTC)
X-Farcaster-Flow-ID: 1152cbe8-a41b-4717-b99d-7936b4c67de5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 25 Aug 2025 15:27:39 +0000
Received: from 6c7e67c92ceb.amazon.com (10.106.100.51) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 25 Aug 2025 15:27:39 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <stable@vger.kernel.org>
CC: <regressions@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>, Nathan Gao
	<zcgao@amazon.com>
Subject: [REGRESSION] fs: ERR_PTR dereference in expand_files() on v6.12.43
Date: Mon, 25 Aug 2025 08:27:25 -0700
Message-ID: <20250825152725.43133-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

I noticed an ERR_PTR dereference issue in expand_files() on kernel 6.12.43
when allocating large file descriptor tables. The issue occurs when
alloc_fdtable() returns ERR_PTR(-EMFILE) for large nr input, but
expand_fdtable() is not properly checking these error returns. dup_fd()
seems also have the issue, missing proper ERR_PTR handling.

The ERR_PTR return was introduced by d4f9351243c1 ("fs: Prevent file
descriptor table allocations exceeding INT_MAX") which adds INT_MAX limit
check in alloc_fdtable().

I was able to trigger this with the unshare_test selftest:

[   40.283906] BUG: unable to handle page fault for address: ffffffffffffffe8
...
[   40.287436] RIP: 0010:expand_files+0x7e/0x1c0
...
[   40.366211] Kernel panic - not syncing: Fatal exception

Looking at the upstream kernel, this can be addressed by Al Viro's
fdtable series [1], which added the ERR_PTR handling in this code path.
Perhaps backporting this series, especially 1d3b4be ("alloc_fdtable():
change calling conventions.") would help resolve the issue.

Thanks for all the work on stable tree.

Best,
Nathan Gao

[1] https://lore.kernel.org/all/20241007173912.GR4017910@ZenIV/

Signed-off-by: Nathan Gao <zcgao@amazon.com>
-- 
2.47.3


