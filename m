Return-Path: <linux-fsdevel+bounces-19985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56078CBC75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618101F22511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB680BF5;
	Wed, 22 May 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fxmmeEfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA8003A;
	Wed, 22 May 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364386; cv=none; b=pwspLI3rSE+O+oGoGCxnRyxjdVn1O4P3VULL4lsd+/ColgwnPukdcgQe849KDAFWL8sTbczOKdozRJ1f0WtrT3mYSIc53ZPxlimVJOTCbzqvmLsGzB+1yM/ZfPm645k8JUlFckJTCgco8vfDoBAks2e2unD8+dDsnhyOVIomlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364386; c=relaxed/simple;
	bh=Xj30BspwB2ZJM37mRWm/eSDeD9On/18YKbKVZJZ6Bjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9veCyz2HH1WqS/qQfLYWxnnDnunQ/IqSOQNMn1aVFA2V+V0M8ziHZI71rfybUfzsbzH0q8kxt7Von5tjKfjdxQ0mLZAKFQ935VC41/Tll/Z/pzOTIo+wqipsG3FVACFZurdK4xGLISlejmcSe2ip7NDtkMN85I5KCrj6LZ9SZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fxmmeEfh; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364385; x=1747900385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tcuh+p5nJoghdQBJL3ji43C7DQTD/lzlQqzzKUPARXQ=;
  b=fxmmeEfhvk90lanVuO6bLRo37ZXx+aXkcJ3u1EhxrMmqY0UyV3bHuUx+
   EB7wfFUKMiCsyNSZDzLKQC6xSHvgC3mPaB5+fHA1LGBRb/d/dTS3DfGGA
   XGx6hYaGnnKWBo5aZStug25P7y6qbQIuE/6fgH/K1ugDQC4oVyjMx4L25
   aIYrH0YKDA8KwzCQoq76kNm3wtLY8tCiX+/RXGnpQY7KBDrYBAgTq+FW1
   wIzscznnjaildtJG9b8WxY0IzndUkoFeTIwsHgVXptI5d505bqj01PAF1
   QPCVwLDzCIXxNonmU3g1sviHwyV+7/YJScg77xKB5GyoPf0WDhCEQ3v3u
   w==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:51 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="415026697"
Received: from unknown (HELO OptiPlex-7080..) ([IPv6:2001:cf8:1:5f1:0:dddd:6fe5:f4d0])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2024 16:42:51 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sukrit.Bhatnagar@sony.com
Subject: [PATCH 2/2] mm: swap: print starting physical block offset in swapon
Date: Wed, 22 May 2024 16:46:58 +0900
Message-Id: <20240522074658.2420468-3-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a swapfile is created for hibernation purposes, we always need
the starting physical block offset, which is usually determined using
userspace commands such as filefrag.

It would be good to have that value printed when we do swapon and get
that value directly from dmesg.

Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
---
 mm/swapfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6ca215fb92f..53c9187d5fbe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3264,8 +3264,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
 	enable_swap_info(p, prio, swap_map, cluster_info);
 
-	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
+	pr_info("Adding %uk swap on %s. Priority:%d extents:%d start:%llu across:%lluk %s%s%s%s\n",
 		K(p->pages), name->name, p->prio, nr_extents,
+		(unsigned long long)first_se(p)->start_block,
 		K((unsigned long long)span),
 		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
 		(p->flags & SWP_DISCARDABLE) ? "D" : "",
-- 
2.34.1


