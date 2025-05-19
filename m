Return-Path: <linux-fsdevel+bounces-49370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68914ABB95D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2F7A0594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF0284665;
	Mon, 19 May 2025 09:19:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60B26D4D4;
	Mon, 19 May 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646344; cv=none; b=cLGiDsr1U5QDhPatgDKiAAjDh5OGAJRwuRFDuAYN4IneQukEROF8Syl82gq4/TWJGkWCmypuxD++dvTYFHnJ4/ZGlmbjGNnVLbTZj7ORl8bixHcR+J6DRVXzOogTWRFqF6fha08OpwScA15FhwearMBLxBDLam8wcVP8kXSFPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646344; c=relaxed/simple;
	bh=WLFy2XrzC3m864Tg26cLbN8q8gwXnUddJfJFmRKv6UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b4SXLmtA3OZuPuyRv2d0DiMyMDORBEaViTe/np+pNMT8hkWFp+MArL6X8kG2JIN/iRNE6oae5hW8Ysvxt0k2sfeUa+STrk6+vQBqSlbK3pQj9SKy8DXem4o6h2vo8HJkVj+bJVcVvGqtUj8LWKGO4yD1EDZeInadwHBYpsARn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-aa-682af7708138
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
Subject: [PATCH v16 30/42] fs/jbd2: use a weaker annotation in journal handling
Date: Mon, 19 May 2025 18:18:14 +0900
Message-Id: <20250519091826.19752-31-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfVDLcRzHfX+P2zR+Nw/9xOFGh5yHkPtwiCN+/zhP/8Vhpx/bqeyWUpy7
	poRWCT1cD5tVTLcW2dzJw5J2pkSGWQ8q6Tqnq+kubT2ssHL++dz7Pu97vT7/fAS4pJ4MEihi
	z/KqWFm0lBIRIndAySrlcIh8rbl6DniGrhJQ/MBEgeN+BQLTIzUGva/2QLO3H4Hv3Xsc8nMd
	CEq+deDwyN6JwFp+iYJPPTPA6RmgoCFXQ0FK2QMKPvSNY9CedxODCvNe+Gr4TkBjdikG+b0U
	FOWnYP7xA4NRg5EGQ3IwdJcX0jD+LRQaOl0kWNtWQoGunYLn1gYC7NXdGHx6WkxBp+kPCY32
	egK8WfPBcSOThMqfpRT0eQ04GDwDNHys1WNg18+FqlS/MO3XbxJeZ9ZikHbnIQbO1mcIaq52
	YWA2uSiwefoxsJhzcRi79wpBd5abhssZozQUqbMQaC7nEZDaHga+Ef9l7VAoqG9XEVA54ULb
	t3ImnQlxtv4BnEu1nOPGPJ8pzurVE9ybUpZ7UthBc6k1bTSnN8dzlvIQrux5L8aVDHpIzmy8
	RnHmwZs0l+52YtzPpiZ6/4JI0ZYoPlqRwKvWbDsukmucBZhyZHqi9noTSkbDwnQkFLDMBnbE
	VUD9zwa9mp7MFLOMbWkZxSfzbGYxa8n8TqYjkQBnXNPZZm0rmixmMftY291bUzDBBLOfy1Km
	YDGzkbV9sZP/pIvYiqraKZHQv2/T2KZYCRPGOit0xKSUZfKFbFGRG/0D5rEvy1uIbCTWo2lG
	JFHEJsTIFNEbVsuTYhWJq0+ciTEj/38ZLo4frkaDjkN1iBEgaYC4yrpCLiFlCXFJMXWIFeDS
	2WKjZblcIo6SJZ3nVWeOqeKj+bg6NF9ASAPF67znoiTMKdlZ/jTPK3nV/xYTCIOSUfHBx2+Q
	8q16FNdf2aRxBy2pFy1JrF0HkqGeI1927f7wokt7Mrsy3NjlXtU3FqG55NuREam1f81b1PM7
	40ikL1gXYc8IW3hvYdmBzTkBD5tTjnb7wpUdhojSxm0XdK0TNbNOXPDFzwx0z5h4u5Nfej8t
	J3D9MJOnd4Rv5hdHaXN4KREnl4WG4Ko42V+wLt0OWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2yLcRTG/d9rWzpvauGNu8bCtrjUjMPELcHfbUgkEiI09kYbuzQts0mw
	6SysNkam1Dq1UtN1Nq3FXCrLmpW5zFgVM6MLYrFZsM42c+kmvpz8cp48v/PliEiZnR4tUifv
	FrTJykQ5I6Ek8XH6aZofUaqZRhOCYNcRCgrLHQw0XC1F4LieSUBb7Qp40d2O4OfjJyQYCxoQ
	XAi8IeG6twWBu+QQA43vw8AX7GSgrsDAgN5azsDTz/0ENJ8+SUCpcy28tX2k4OGJYgKMbQyc
	M+qJ0PhEQK/NzoItIwJaS0ws9AcUUNfip8FjrqPB3RQNZ4uaGbjjrqPAW9VKQOOtQgZaHH9o
	eOi9T0F33hhoyM+loexLMQOfu20k2IKdLDyrthDgtYyEiqyQNfv7bxru5VYTkH3xGgG+V7cR
	3D3yjgCnw8+AJ9hOgMtZQELf5VoErXkdLBw+1svCucw8BIbDpynIao6Fnz2hy+YuBWSer6Cg
	7JcfLV6IHUUOhD3tnSTOcu3FfcHnDHZ3Wyj8oJjHN01vWJx1t4nFFuce7CqJwtY7bQS+8C1I
	Y6f9KIOd306yOKfDR+Av9fXs+nGbJQsShER1qqCdsXC7RGXwnSU0PUPTzMfrUQb6Ic5BYhHP
	zeZtlkx2gBluCv/yZS85wOHcRN6V+5HOQRIRyfmH8i/Mr9BAMIJbx3sunWIGmOIi+OdW/WBZ
	ys3hPa+99D/pBL60onpQJA7tmwyewa6Mi+V9pUXUCSSxoCF2FK5OTk1SqhNjp+t2qdKT1WnT
	d6QkOVHog2z7+/OrUFfjihrEiZB8mLTCHamS0cpUXXpSDeJFpDxcandNVcmkCcr0fYI2ZZt2
	T6Kgq0FjRJR8lHTVJmG7jNup3C3sEgSNoP2fEiLx6Aykiig0tj26X2u6MT8gObY8Hy/23ypc
	NLY1Ol9cvnLucSYu+rHEHplS1qxWfM0eFh/TEzN364E18yrDzqSNOxS25coG6+39ZYaYSZM0
	Vcv+jC+eVcmFjVyScLFjtiF2Y8H3QKDpw2qr5qDeMGSReZZx3gTT5IRRBxUPhnsqy+P6Kocv
	WSqndCqlIorU6pR/AZU0VWc9AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
to be placed between start_this_handle() and stop_this_handle().  So it
marks the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire_read() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cbc4785462f5..7de227a2a6f8 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
-- 
2.17.1


