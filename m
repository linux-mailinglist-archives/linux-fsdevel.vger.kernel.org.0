Return-Path: <linux-fsdevel+bounces-48861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0BEAB51E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED081B6216C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90F28314E;
	Tue, 13 May 2025 10:08:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995AD27603A;
	Tue, 13 May 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130888; cv=none; b=fjGl9UFs6kxkCP+KpsazbIgVO1xLNAzfJr2TXA+1YxAFeJ5JJivk2264Z9tL176DF5QE7Mkrw6B6jKhreAjxhBSdxvWT8ZVBGmwgGzp350NsemQu20PMJECKx0/z6zZUVySH2ZKatbKT6fMTTC6KBnQvKQTKmmtPslmjuIYcvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130888; c=relaxed/simple;
	bh=V9G75luuvDdhIj9lO7cbblDKNYFXdg8m9W2gAiy+KKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dPpO21+f1DVWiIBbGVeN09WOELxOcttGiqjOSTXdF6RpAEV9VEl7JOJVGdKnKKpctWs6pIEuE09aGASs1YzIwyfQGZx99S7cf/IsGmW4ZyI1lPwp3PYtWQaIfLpus3dPTyb/4mJlnXlCuliYZRfLJnflg1sJWajAW6wxbtlQIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-7c-682319f13be5
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
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 28/43] dept: suppress reports with classes that have been already reported
Date: Tue, 13 May 2025 19:07:15 +0900
Message-Id: <20250513100730.12664-29-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxSHfd9773tviyXXSvCixI8aYwLRiVFzssxtxkRvDEajy6YumWvk
	Zu0shbR8iIkpVTSC0iCKBAQsZakNrcqK2xyCQwwFNGIVKB8BNokBiiCKtFkVP1qN/5w8+f1y
	nvPP4ShlG7OY0+ozJINerVMROS2fml+95mXcSs26uoo4CMyepqHiuouA95oTgeuGGYO/dTv0
	BicRvHnwkILSEi+C6idDFNzwDCNochwn0PU0GroD0wQ6Ss4QOFFzncCjZ3MYBi8WY3C6d8K/
	9lEa7hfZMJT6CVwqPYHDYxxDyF7Lgj13FYw4ylmYe5IEHcM+BpoGEqGsapBAY1MHDZ6bIxi6
	GioIDLveM3Df005D0LIEvOcKGbj63EbgWdBOgT0wzcLjZisGjzUW6vLCwlOv3jHQVtiM4dRv
	v2Po7r+F4Pbp/zC4XT4CdwOTGOrdJRS8vtKKYMQyxcLJsyEWLpktCM6cvEhD3uBGePN/+HLl
	bBKYL9fRcPWtD327WXRVuZB4d3KaEvPqs8XXgR4iNgWttHjPJoh/lw+xYt7tAVa0ujPFekeC
	WNPox2L1TIAR3bX5RHTPFLNiwVQ3Fp93drK74w/Iv0qRdNosyfDF1z/LNY7KRpQ+pDgyHpxg
	c9G4vADJOIHfIFw2t+PP3FBrIREm/Gqhry9ERTiGXy7UF44yBUjOUbwvSuit7EeRYiH/k9D7
	R094geNofpXQdlwXiRX8JqHhxSvyyblMcNY1f/TIwvnbK510hJX8RqHI6qQjToE/LxNszgvs
	p4U44Y6jjy5CCiuaV4uUWn1Wqlqr27BWk6PXHll7KC3VjcLvZT829+NNNOPd24J4DqnmK9r9
	KzRKRp1lzEltQQJHqWIU5r/CkSJFnXNUMqQdNGTqJGMLWsLRqkWK9cHsFCX/izpDOixJ6ZLh
	c4s52eJc9M0sS0y7lJb1R9NCiVvfl36XLPwjK+5KjveP9rRPRJUNFM8scHLe1l/TW/Ntt/Yh
	46wpetuC7cy6pd+v+TJ7ZZWlbOdYf3JCRo3GFLXFeudpZmLh0MGQSRe7NWuiSj8auzBhDG3m
	zfFxvuhzbDk+9EOM6Vr+MUrl+XPHfvlY2h4VbdSokxIog1H9AaMSespaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ8f3+fpOB6n6aH5da3ZGNUmPhuz/KNnjPGXLYaTZ+64u3Kn
	koVyMUq3MtVcXa6ykzrkCkm1W1FOk1IurJKYleJQd1zy447557PXXu993p9/Piwpu0bPZ1Xa
	I6JOq1DLsYSSbF1rWPFlXpgy0tJMgGfiLAXFN20YOm9UIbDVZhAw8jAWer1jCH48eUpCYX4n
	gtI3/STUtg4gaKw4haH73Uzo8bgxOPOzMRjKb2LoGp0ioK/gAgFV9i3w2vqegvbcMgIKRzAU
	FRoI/xgmwGetZMCaHg5DFSYGpt5EgXPARUOL2UlD46vlcKmkD0NDo5OC1rohArrrizEM2H7T
	0N76iAKvMRQ683JouP6pDMOo10qC1eNm4JnDQkCrZS5UZ/pbz4z/oqEtx0HAmSu3COh5eR9B
	09lBAuw2F4YWzxgBNfZ8EiavPkQwZPzIwOnzPgaKMowIsk8XUJDZFw0/vvsvmyeiIONyNQXX
	f7pQzHrBVmJDQsuYmxQya1KESc9zLDR6LZTwuIwX7pn6GSGz6RUjWOxJQk3FMqG8YYQQSr96
	aMFeeQ4L9q8XGCHrYw8hfOroYLYtiJOs2y+qVcmiLmL9XomywtyAEvulR4e9H5h0NCzJQkEs
	z63i6yuNOMCYW8q/eOEjAxzMLeZrct7TWUjCkpxrOt9rfokCwRxuN997+7l/gWUpLpxvO6UO
	aCm3mq//PI7/dS7iq6odf3uC/P7n1Q4qwDIums+1VFG5SGJB0ypRsEqbrFGo1NEr9YeUqVrV
	0ZXxCRo78j+Q9fhUXh2a6I5tRhyL5DOkj0aWKGW0IlmfqmlGPEvKg6UZd/1Kul+RekzUJezR
	JalFfTMKZSl5iHTTDnGvjDugOCIeEsVEUfc/Jdig+ekIG3wq88aQ0bQTF3cNNqVFFBVsvnTf
	Ne/c4hzNuGyn4+0i08Hd4ZHF2oRrsa4Erm0ge1AbL+8wFTrSSlakGPLWumPcC7u+pW4ONT0Y
	dMSsueKbnf3aueGidvVhe9hYX54WJ207uT1Csy4/co9h1uw6Y1PRnRRl+76wOL1OE7nljldO
	6ZWKqGWkTq/4A1Zc+8g8AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Each different chain implies its own dependency problem, that is worth
being reported.  However, generating similar reports mutiple times
should be suppressed.

To avoid that, suppress reports with classes that have been already
reported.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  6 ++++++
 kernel/dependency/dept.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 551168220954..b1e5a1ec6763 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -107,6 +107,12 @@ struct dept_class {
 			 * not an explicit map
 			 */
 			bool		sched_map;
+
+			/*
+			 * for avoiding this class involved in report
+			 * more than once
+			 */
+			bool		reported;
 		};
 	};
 };
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 278194093108..8bea64bab379 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -501,6 +501,7 @@ static void initialize_class(struct dept_class *c)
 		iw->touched = false;
 	}
 	c->bfs_gen = 0U;
+	c->reported = false;
 
 	INIT_LIST_HEAD(&c->all_node);
 	INIT_LIST_HEAD(&c->dep_head);
@@ -913,6 +914,12 @@ static void print_circle(struct dept_class *c)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	do {
+		tc->reported = true;
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
 }
 
 /*
@@ -1225,6 +1232,9 @@ static enum bfs_ret cb_check_dl(void *node, void *in, void **out)
 	struct dept_class *cur = (struct dept_class *)node;
 	struct dept_dep *new = (struct dept_dep *)in;
 
+	if (cur->reported)
+		return BFS_SKIP;
+
 	if (cur == dep_fc(new)) {
 		print_circle(dep_tc(new));
 		return BFS_DONE;
-- 
2.17.1


