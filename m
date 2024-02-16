Return-Path: <linux-fsdevel+bounces-11887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB7D85864F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F472855FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26415137C29;
	Fri, 16 Feb 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owRcMhkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3743433B0;
	Fri, 16 Feb 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112613; cv=none; b=UXXDvf6vMNx+Yyws5J9213yupQ5XSdfmuJn0FQNycFCzhncDD6O7WsnOHv0Vkx0H+GOuIyH4XklWYsXjbu1ODbumZ/+YwtDN/0S4KG136/dYv8rgO0IynvebOMz0xUKuuJQECB+a331SgT/cXvApPgSye4AKT/dQPh0lzbpdDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112613; c=relaxed/simple;
	bh=yNyHPZtxa5jU0ks+mH7ZDBSKGV9sQTZ/GmsXwVvVMhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xz1khV/kTedG3Ghx+oakOWfpRviNDrrI6OTpjeN7q9gnv3+MtMXbDnqN1qfoQTG38T/eltyGj9VbqExbEakQpEJz8WPbrx+AnHtlC+EMSLeyFnItBBabpXRc0jc+VXCDW88D0elwNivSzhDSG0oSNrmEM6NGnlZoU+wqaIvJPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owRcMhkv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JIBYKrHmraGn0Qv35tDBtlGinkhRJwFyg9FJtFLUQ5w=; b=owRcMhkvsO9GVbii6oW8q+GWe1
	dwoWp3Fgl1UHLXCCxepniozgLA+wTKFO0nEyuy16XKn5SNR5vbimxmlk6GTIn8ow92LNuxTcN6rTm
	ZNto7Uzzu+qKz4kQ5crgnuG8SPOVFSeOnv7bs3eu5l/yObnDR+SAMdGRdAZPZDHkQrQpxLfl0fA8k
	vlaO+FaU3OnZl1XW7Gz+85hrCErHErBoE9w741qyc5H19aaJlJgYQv3rL0TfSe5Eugrx3PnR5ZVuN
	8D0nEvSQ9RnaKuWS74WIjzem8ayqdFwbbGoDtOnI6nQHyHE6jxzP6bWCBKjWfsa4hxv/hvXasCuHp
	4B24ayMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb47O-00000003WfT-2ZJh;
	Fri, 16 Feb 2024 19:43:30 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] test_xarray: fix soft lockup for advanced-api tests
Date: Fri, 16 Feb 2024 11:43:29 -0800
Message-ID: <20240216194329.840555-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The new adanced API tests want to vet the xarray API is doing what it
promises by manually iterating over a set of possible indexes on its
own, and using a query operation which holds the RCU lock and then
releases it. So it is not using the helper loop options which xarray
provides on purpose. Any loop which iterates over 1 million entries
(which is possible with order 20, so emulating say a 4 GiB block size)
to just to rcu lock and unlock will eventually end up triggering a soft
lockup on systems which don't preempt, and have lock provin and RCU
prooving enabled.

xarray users already use XA_CHECK_SCHED for loops which may take a long
time, in our case we don't want to RCU unlock and lock as the caller
does that already, but rather just force a schedule every XA_CHECK_SCHED
iterations since the test is trying to not trust and rather test that
xarray is doing the right thing.

[0] https://lkml.kernel.org/r/202402071613.70f28243-lkp@intel.com

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_xarray.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d4e55b4867dc..ac162025cc59 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -781,6 +781,7 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
 {
 	XA_STATE(xas, xa, index);
 	void *p;
+	static unsigned int i = 0;
 
 	rcu_read_lock();
 repeat:
@@ -790,6 +791,17 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
 		goto repeat;
 	rcu_read_unlock();
 
+	/*
+	 * This is not part of the page cache, this selftest is pretty
+	 * aggressive and does not want to trust the xarray API but rather
+	 * test it, and for order 20 (4 GiB block size) we can loop over
+	 * over a million entries which can cause a soft lockup. Page cache
+	 * APIs won't be stupid, proper page cache APIs loop over the proper
+	 * order so when using a larger order we skip shared entries.
+	 */
+	if (++i % XA_CHECK_SCHED == 0)
+		schedule();
+
 	return p;
 }
 
-- 
2.42.0


