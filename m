Return-Path: <linux-fsdevel+bounces-13716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0828731DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B2628227D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880365BBB;
	Wed,  6 Mar 2024 08:55:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF16629ED;
	Wed,  6 Mar 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715347; cv=none; b=degqj1WglTv7yJGU6asISEY9GgW9ftgAFRuIeKYfTCb1TFCCt5eex5wYg8m2tnaLIFOoeFXBSEW2WdAhXxu8EGbHSleCLKfBXSMWWZomz2P0rF228790BIEZMVIB6lnHHf++9nIshVyolrOnbHDa7E32ohKnCu3Bqoqv/Pse2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715347; c=relaxed/simple;
	bh=RHlJ2GxVpEp+l17KtAmYPgKdeN+t8Sb6ly9lphI8Ui8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pMbhhEuO9878QIUvmk2KjJQKyAdhwI54ujVEC179APKfOwv0YGsEXXTAjNDlXU/xt9L8QhssXQW9WEatbYnYFAhaIfpUsPzkm1thDPZjTkjVvxqJmbAKEsvXEmKnCqRc2Ax+dtKG7kMhZzjrxFtE+/limGFJ2tEkiNYRiuydj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-58-65e82f7e1343
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 19/27] dept: Apply timeout consideration to waitqueue wait
Date: Wed,  6 Mar 2024 17:55:05 +0900
Message-Id: <20240306085513.41482-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+35/j3ccP1fmpxi7aSzTg3n42Kwxk69NxvzHLEc/Oq7YnSIy
	pQuVHkQX1bhLO7fK04VJDzu1npj0NJKKWh6aq4hr6hruMv989tr78/m8Pv98eEr5iPHlNTHH
	JV2MWqti5bR8eKZ5xdmgL1JwkmsGXL4UDM6fF2kovFfGQuvdUgRlD5MwDNVvgTfjDgSul68o
	yMttRWDu76XgYUMfgmrrORY6BmdBp3OUhebcdBaSb91joe3rFIYeYw6GUls4vMguwmCf+ExD
	3hALBXnJ2F2+YJiwlHBgSfSHAWs+B1P9IdDc95qB6u7lcP1GDwtV1c00NDwZwNDxtJCFvrI/
	DLxoaKKh9XIGA3dGilj4Om6hwOIc5aDdbsJw3+AWnf/xm4HGDDuG88UPMHS+rURQc/EDBlvZ
	axbqnA4M5bZcCiZv1yMYyBzmIOXSBAcFSZkI0lOMNBh6VoPrVyG7YR2pc4xSxFB+glSPm2jy
	vEgkFfm9HDHUdHPEZIsl5dYAcqtqCBPzmJMhtpJUltjGcjiSNtyJyUhLC0earrloMtiZh3f4
	7pavj5S0mjhJFxS6Tx5lrmmijj3iThZf6EaJyMCmIRkvCqvEqql06j/fHX2HPcwKS8Wuronp
	3EdYLJZnfGI8TAkOuVjcEuZhb2G7+Ph9FudhWvAXh/uKkIcVwhrR+s3K/HMuEkvv26c9Mnee
	NZI1fVcprBZfJpvdLHfP/OHF1Mrv3L+F+eIzaxedjRQm5FWClJqYuGi1RrsqMCo+RnMy8MDR
	aBtyP5PlzNSeJ2isdVctEnikmqnYIPssKRl1nD4+uhaJPKXyUSRMDkpKRaQ6/pSkOxqhi9VK
	+lrkx9OqeYqV4ycilcIh9XHpiCQdk3T/u5iX+SaihVfEx7JmubnOD9rb+jXeCRVeSZP1Qlf+
	jNP81br6OdduZif8fO/tXN7YA15n5hqllgUubRi3ZtsSx7bwwxvXLvsU4LV/X2r4fH1b5sC5
	ZcaakI8jvWMmlZ7fG0bijFs3+6bE5kfsPIjTFmeHbra3364Qr6f4BRhyrJsKGmeH5qpofZQ6
	JIDS6dV/AdVQUNRIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0hTcRQH8H6/e+/vztHitoQuShSjiLQnaB0sKgLz0osiIymobnXLlS82
	M40yy/U0X4UtU8sXc7n12ix6OBuaNpPUUixfq8Qy8bEoJ5lSbUX/HD6cA99z/jgySqln/GTq
	mHhJEyNGqYiclm9anrogedEXaXHexyWQfWkxuEfO05B/10yg+Y4JgbniFIb+2jB4OzqIYPxV
	EwX6nGYERR+7KaiocyKwGU8TaOmdAq1uF4H6nDQCqSV3CbwemMDQdfUyBpNlIzRkFWOwj/XR
	oO8nkKdPxZ7yBcOYoZwFQ8oc6DFeZ2HCc0S9s42BmoJ6BmwdgZB7o4tApa2ehrpHPRhanuQT
	cJp/M9BQ56ChOTudgdvDxQQGRg0UGNwuFt7YCzHc03nSzn7/xcCLdDuGs6X3MbS2P0VQdf4D
	Bou5jUCNexCD1ZJDwc+yWgQ9GUMsnLk0xkLeqQwEaWeu0qDrCobxH/lkdYhQM+iiBJ31qGAb
	LaSFl8W88Ph6NyvoqjpYodByRLAaA4SSyn4sFH1zM4Kl/AIRLN8us8LFoVYsDDc2soLj2jgt
	9Lbq8Wb/HfIV+6UodYKkWbRyjzyyqMpBxT1gE0vPdaAUpCMXkY+M54L4O65O7DXh5vLv3o1R
	Xvtys3hr+mfGa4oblPOljWu9nsZt4h++z2S9prk5/JCzGHmt4Jbyxq9G5l/mTN50z/43x8fT
	zxzO/LtLyQXzr1KLSBaSF6JJ5chXHZMQLaqjghdqD0cmxagTF+6LjbYgz7sYTkxkP0IjLWHV
	iJMh1WTFap8+ScmICdqk6GrEyyiVr+L4z15JqdgvJh2TNLG7NUeiJG018pfRqumKddulPUru
	oBgvHZakOEnzf4plPn4p6KQYXRDWvqZvin5SeIBj/tOyypDIJkeftHPDLecVe4Ttc9Wy9U/2
	ZuwyW+PKbmZdc22/3bCODX0eSrY2Bj1LCxenblmzoeDDs87jESMVvf6rZuQ2X1hvemlXJX4q
	C42PHZg9zxRU4Aw8EPijsyG52/mpZEa7NthyqDY3YptzegROXquitZHikgBKoxX/AKRsMwwq
	AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ebeb4678859f..e5e3fb2981f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -304,7 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1


