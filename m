Return-Path: <linux-fsdevel+bounces-12236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915585D49A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8811F21361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A54CDE7;
	Wed, 21 Feb 2024 09:50:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11242ABD;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509003; cv=none; b=lhNk79KVc+mlLvWJRCbKKws96xwFDOv/wzt0PhUVVexv+FDWnt8JucvvI/01DBAttPjz2snxzjkIL7ItAcQKwukhzrUg9ndLSg8mvpdVu0/gkF2p9ZR+gnhwPIEbBA5hiZKiTlHWF/XJjs/10YD0dqhiFU0Rt3/qBH2nAU/1G6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509003; c=relaxed/simple;
	bh=32dhqEgXIybDFaJN1JuIlSUqelCcRZP5tULcFTO0inM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gS3Av+tAytRiAVptky+gG0zHZziMajXog1pf5U+Uon4cjcwZCItswsI7WVOK55xLjdswf7HBbZI8iG6pqHxIbuV5bMXr/BZ7Ad1h0QD01gdQHGpIvlnurXSiB/LFMAxR9wy0Z8OhIVWPXnvfjOoz48D/YqD8l0Kc+I2lqsPxVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-68-65d5c73a67e7
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
	viro@zeniv.linux.org.uk,
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
Subject: [PATCH v12 14/27] cpu/hotplug: Use a weaker annotation in AP thread
Date: Wed, 21 Feb 2024 18:49:20 +0900
Message-Id: <20240221094933.36348-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2yLexjH/X7vtbXypiZ7Rw4nTRZM3IeHCP7ZOa9jE3GJGEHpG2usG93s
	IhGzSzmziZKt2DLdSHVbsXUuY7rUsAsZHS0lM9PIOWadyaal21xa4p8nn3y/+X7+elhCfpOa
	xKqT00RtsjJJQUtJaX9YxaylrS5xbk+5HPSFc8H36SgJZVcsNDgu1yCwXD2Moff+3/Dc70Uw
	0vGYAEOxA0HFm1cEXG3pRmAz59Dw9O04cPoGaGgvPkZD7vkrNHT2jWLoKjmJocYaDw9PVGKw
	B/4nwdBLQ6khFwfPOwwBUzUDpuwo8JjPMjD6Zh60dz+jwPZyJpwp76Lhtq2dhJYGD4ant8po
	6LZ8p+BhSxsJDn0RBZc+VNLQ5zcRYPINMPDEbsRQmxcU6Ya+UdBaZMegu1CHwfmiEUHT0R4M
	VsszGu76vBjqrcUEDF+8j8BzvJ+B/MIAA6WHjyM4ll9CwuOvrRTkdS2EkS9l9Mqlwl3vACHk
	1WcINr+RFB5U8sLNs68YIa/pJSMYrfuFenO0cP52LxYqBn2UYK3+lxasgycZoaDfiYUPjx4x
	QtvpEVJ46zTgtZMTpMtUYpI6XdTOWb5DmlhZ6CD3vpZkekt2ZqPvTAGSsDwXw+eU55K/+aLr
	Mw4xzU3j3e4AEeJw7k++vug/qgBJWYI7MpY3f+ygQ8UELo7XWTw/RSQXxV96fy84YFkZt4i/
	3rTjl3MqX1Nr/+mRBOOqUi8VYjm3kHd1XiNCTp47IuEdbcPUr0Ekf8fsJk8gmRGNqUZydXK6
	RqlOipmdmJWszpy9K0VjRcGHMh0c3dKABh3rmxHHIkWYLPGGU5RTyvTULE0z4llCES4jM4KR
	TKXMOiBqU7Zr9yeJqc1oMksqImTz/RkqObdbmSbuEcW9ovZ3i1nJpGwUualoRV/sai6gogpX
	7VPOL27Vc1ULnLLxfVFxU+zbN9O2huGICP1fqshz7pySOs03z/RTpzYuTvlYu26CfHpCP3mv
	I3Yovk7nNN5wNMZO3DDjH1eMzdDWs2WnLDrNFR5WNUUTt6083L1mY2PCUGaOes1W/R/++LhO
	nWIJdShhfb6CTE1UzosmtKnKH7XfM6lMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa1BMYRjHve855z2nZc2ZrRlnYlwWYyZKjMzDGsMwHAajL8z4oqVDS8Xs
	KmVcooRUKrZiq6lltlVL7EoubbNTdHGNNpIUMUjLkjZWuWyML8/85v+f/+/Tw1EKAxPIaWJ3
	SdpYdbSSyGjZGlVy8LyGVil08NR8yE4PBU//URoKKiwEmi+WI7BcOYih5/ZyeDrgQjB4/yEF
	efpmBCWvXlBwpb4Tgd18iEDLm9Hg9LgJNOmPE0g+W0HgUe8Qho7cHAzl1tVwN8uIweF9R0Ne
	DwFDXjL2nfcYvKYyFkxJU6HbfIaFoVezoKnzCQN1hU0M2Nunw+miDgLV9iYa6q91Y2i5UUCg
	0/Kbgbv1jTQ0Z2cwcOGTkUDvgIkCk8fNwmNHMYZLKT5b6tdfDDRkODCknruMwfnsJoKaoy8x
	WC1PCNR5XBhsVj0FP0pvI+jO/MjC4XQvC4aDmQiOH86l4eHPBgZSOsJg8HsBWaQS61xuSkyx
	7RbtA8W0eMcoiNfPvGDFlJp2Viy2xok2c5B4troHiyV9Hka0lh0jorUvhxXTPjqx+OnBA1Zs
	zB+kxTfOPLx23AbZgkgpWhMvaWcujJBFGdOb6Z1dfgmu3E1J6Debhvw4gZ8jlLZ+w8NM+GlC
	W5uXGuYAfqJgy3jLpCEZR/FHRgrmz/fJcOHPrxJSLd1/xzQ/Vbjw4ZZvwHFyfq5wtSbin3OC
	UH7J8dfj54vPG1zMMCv4MKH1USWVhWTFaEQZCtDExseoNdFhIbrtUYmxmoSQzTtirMj3MqZ9
	Q9nXUH/L8lrEc0g5Sh5V5ZQUjDpelxhTiwSOUgbI6d2+SB6pTtwjaXds1MZFS7paNJajlWPk
	K9dLEQp+q3qXtF2Sdkra/y3m/AKT0Ia6rOCE1+P3e2wk+FmoaiSZ4F5SFD5psvFmkN0649ji
	SjZdv3hvSeXS6hCqqrKvq29bxA2N4Uv+fHArisjzQ11blu3P7z99vXPvgXXO8GT9Hv+VVSe8
	J9m34wP5SarCzNdz7h1po5bOXuFfEOPfWPojLrwo0hGa45ky2ay6PNSuUtK6KPWsIEqrU/8B
	w+OkGS4DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1. So trylock version of annotation
is sufficient for that purpose. Now that dept partially relies on
lockdep annotaions, dept interpets rwsem_acquire() as a potential wait
and might report a deadlock by the wait. So replaced it with trylock
version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a86972a91991..b708989f789f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -535,7 +535,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1


