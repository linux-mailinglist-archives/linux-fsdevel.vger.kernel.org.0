Return-Path: <linux-fsdevel+bounces-8734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3DC83A8F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE3B2832A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D065BC5;
	Wed, 24 Jan 2024 12:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41763410;
	Wed, 24 Jan 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097610; cv=none; b=twyUBzbMAU4KNDiCoKiVXkXlvHHM5+Cht4o2/prwIZAD2Nhj1vpGSlGCCBzvnc7ViXVO1ub9Pr0dKMjRTlNpEDdNCFoMSFzmID4GGazfo0m8Pe8M8lq0gugT/uixw5TDg/dF3a3/okowUPhv2p1AfDljpG/v8pVeRdE8LwIqOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097610; c=relaxed/simple;
	bh=EIC7RWTml3WGFeQFxVb2eS9TiiJPhRDEmqyuGxWQs6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AQF3cKVnEYujo9BD2kLaUsb4p4Fc1GmMNaBZztM4MbjW1jJpnsNbtFr/nxqxrqUnDEUanw3IslczltifqvZHC43Cf0TmXj3aGCuQ9nUK7y5+UsALJiR8wBW61X8Mbz9kpqsT4VqZqoEjF8TNwPoBjDwiE/LKMqIxA/zAgC4QhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-25-65b0fbb64f6a
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
Subject: [PATCH v11 14/26] locking/lockdep, cpu/hotplus: Use a weaker annotation in AP thread
Date: Wed, 24 Jan 2024 20:59:25 +0900
Message-Id: <20240124115938.80132-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0wTaRTH9/tm5puh2s1YTRjkwd1Gs8rGC8SaIxpDfHC/jZo1IfFhtVkn
	dBaq3CyCYjSCVkAu3giwKEFALU0p0i1m44IYqBHBC1asCgSrEKMSiyhatFIvBePLyS/n/P+/
	pyMwmhZurmBM3aWYUuVkLVGxqtGZtYv/m3Qoy8rtS+FE8TLwvytgoarJTsB9oQGB/WIuhpFr
	v8HDCR+Cydt3GKgocyOoHXrEwMVOL4I260EC957+CB7/GIHusiICh842Ebj7MohhsPwkhgbn
	Rrh5vA5De+A5CxUjBE5XHMKh8QJDwGLjwZKzAIatp3gIDkVDt/cBB20Dv0Jl9SCBy23dLHRe
	GsZwr6WKgNf+hYObnV0suE+UcND4qo7AywkLAxb/GA+97TUYHOaQKO/tZw6ul7RjyDv3LwZP
	fyuCKwVPMDjtDwhc9fswNDvLGPhYfw3B8NFRHg4XB3g4nXsUQdHhchbufLrOgXlQB5Mfqkhc
	LL3qG2OouXk3bZuoYemNOon+f+oRT81XBnha48ykzdYoevbyCKa1436OOm1HCHWOn+Rp4agH
	01c9PTzt+meSpU89FXhT5J+q1QYl2ZilmJau2aZK8p65i9Lr+T2luV6Sg0pIIQoTJHG5lFeZ
	w37nx+5cfoqJ+IvU1xdgpniO+JPUXPKMK0QqgRHzZ0jW17dDZUGYLeolc0HCVIYVF0jDwaFp
	j1pcIeW3vue+OedJDY72aU9YaN9YOTCd0Yg66YntGD/llMT8MKnQ189/K0RIHdY+9jhS16Af
	bEhjTM1KkY3Jy5ckZaca9yxJSEtxotBHWfYHt1xC4+54FxIFpJ2pjrM1KRpOzsrITnEhSWC0
	c9R9ERcUjdogZ+9VTGl/mTKTlQwXihRYbbg6ZmK3QSMmyruUHYqSrpi+X7EQNjcH/dzo8R0w
	rPm9eCG7M+FzZmKr60bcjIX6KH94esQfmwNKwaqh2YZ989+Q2Flm3YtofZFjJbeaBiM+zLNy
	G2IeKgm1+7urS7NUqm2RvfdLR/AGWS+v77/Vm3cuVpeSuFbYujjNsaKrp/r89vhF74/F/62a
	pYtuWdexpb4j/K1rkT5Gy2YkydFRjClD/gpVmRPATQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe5736mrxugzfrEgGFRldBLVDRkQFvkRJX7pJocNecrRZbGpa
	BOqm2VJrK52Z5S2WzZU2JewyE03LJLM0NbGVEpnlpdRZOrvMoi+HH+f8z+/TnyVkBZQfq4yN
	EzWxCpWclpCS8FDdmrvuSnG9w7QIjJnrwTWRQUJBhY2GttvlCGzVKRgGG8Oga3IIgfv5CwLM
	OW0IivveElDd5ETgKEulof3DfOhwjdLQnHOOBl1pBQ0vv8xg6M01YSi374KWCyUY6qYGSDAP
	0nDFrMOe8QnDlMXKgCV5OfSX5TMw0xcIzc5OChquNlPg6FkNl6/10vDQ0UxCU00/hvb7BTQ4
	bb8paGl6SkKbMYuCWyMlNHyZtBBgcY0y8KquCEOl3mNLH/9FwZOsOgzp1+9g6HjzAEFtxnsM
	dlsnDQ2uIQxV9hwCpm80IujPHmYgLXOKgSsp2QjOpeWS8OLnEwr0vcHg/lFAbwkVGoZGCUFf
	dUJwTBaRwrMSXriX/5YR9LU9jFBkjxeqygKE0oeDWCgec1GC3XqWFuxjJkYwDHdgYaS1lRGe
	5rlJ4UOHGe9eEiHZdFhUKRNEzbrNUZIYZ+FLdPwGk3gxxUknoyzagLxYngvi37WlMLNMcyv5
	7u4pYpZ9OH++KusjZUASluDOzOXLvj73PLDsAu4Qr8+Ins2Q3HK+f6aPnGUpF8KfefCd+udc
	xpdX1v31eHn2ty73/M3IuGD+vfU8cwFJitAcK/JRxiaoFUpV8Frt0ZikWGXi2uhjajvydMZy
	esZYgybaw+oRxyL5POkWa4UooxQJ2iR1PeJZQu4j7V50W5RJDyuSToqaY5GaeJWorUeLWVLu
	K92xT4yScUcUceJRUTwuav5fMevll4y88/bopGrvrt966/4wVdw48t2wN68ndclih7Eln3m9
	ovsRPwBXmcSBWt/oYrw9U1fYGFl4szRd1xg+bbD/XGhYJY8IVZuWRu48cNB78lKnO+CzLWSg
	OHt6bFfkqv2KmDW5ERv9t1aOk6ao9i7zKeNF79ZvPx4HFcY1BY294wK3yUltjCIwgNBoFX8A
	2+WWAC8DAAA=
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

Furthermore, now that Dept was introduced, false positive alarms was
reported by that. Replaced it with try lock annotation.

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


