Return-Path: <linux-fsdevel+bounces-49360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B301ABB912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FEE189D3A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7D27A92E;
	Mon, 19 May 2025 09:18:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2EF274FF6;
	Mon, 19 May 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646338; cv=none; b=pOdwFKKdVaCqraWOesCUqbm+F8Yl9GqBmy30JcJmrA9PSu4A8l9FEAZ9Nu7UA9Te2AlFb/4nac5oP3XaEq0MXrJxRo70F8rz51ReFE72B2zGR1/gZessBH7za36A/PWRQyE6m6ttIgzzC4WbxtXgnFWR6Nsh9XjwSMFO/lW9hbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646338; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bp6MlfOh7En8dDbPJMbOGLQKRAjCOpgq8BgDck9TXPUNKrPKoGI1VpF3WRklP2PECvVxjI0PVYnAfkPL9cSvouV66xMCDtann4JfpgoNUMIb4C4S5vS2wzodYbgobT9gwbxqQTam8jHBKq3q/dHuAGaKjbvUWonOiCxmB/ZsAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-13-682af76ee140
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
Subject: [PATCH v16 20/42] dept: apply timeout consideration to swait
Date: Mon, 19 May 2025 18:18:04 +0900
Message-Id: <20250519091826.19752-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe7Lc28rnddi4CpNNE2MivMFg+zMOLNkWbgxITPZh2Uao1Vu
	bGML2ipQExc6kAgMAkZgWmXlJYXRKvXWRHwpQRhFxJeCFZAASkUckUoGtIqiW+u2Lye/nPPP
	75wPhyWVnfQKVpdxTDRmaPRqLKfkwZiaDZlvErWb5/I4CM2dpuBCsxOD77IDgfOqhYDJzlQY
	CE8heH//IQlVFT4ENWMjJFz1jiLwNP6M4dH4Z+APTWPorijGkFfXjKH31QIBw5VnCHBIafDU
	PkFBT1ktAVWTGKxVeUSk/EnAvL2JAXvuagg0nmdgYSwJukf7afAMrYdz1cMYbnm6KfC2BAh4
	dOMChlHn3zT0eO9QEC5NAF95CQ2XXtdieBW2k2APTTPQ12YjwGuLA1d+RFgw+5GGrpI2Agrq
	rxDgf3ITQevpZwRIzn4MHaEpAtxSBQnvGjoRBEqDDJz6ZZ4Bq6UUQfGpSgryh7fC+7eRzRfn
	ksDym4uCSx/60ddfCc5qJxI6pqZJId+dLbwLPcaCJ2yjhLu1vHD9/Agj5LcOMYJNOi64GxOF
	uluThFAzE6IFqakQC9LMGUYoCvoJ4fWDB8wu1W759nRRr8sSjZt27Jdrm8ct6MgszqnqrKdz
	0V26CMlYnkvmC6xBVITYT+x3EdE25tbwg4PzZJSXcat4d8lEJC5nSa5/MT9w8Ukkz7Cx3Lf8
	c1k0QnGr+fo/2qgoK7gU3jVjxf/aV/IOV9snjSzSHyruQFFWclt5v6Oaiip5rkHGnz079985
	y/nbjYNUGVLY0KImpNRlZBk0On3yRq05Q5ez8WCmQUKR57KfXNjTgmZ837cjjkXqGIXLs06r
	pDVZJrOhHfEsqV6maHKv1SoV6RrzCdGYuc94XC+a2lECS6njFVvC2elK7pDmmHhYFI+Ixv+n
	BCtbkYuSc75YyqYYDTv0DXu7DgZ+j3uBzT+WHdriSDzQG6zo3i2V31vOdk1lX/uBX7lq4LuE
	Bf1fi/zpcuXRK4V9utsHdj7UmdKu/5TiU1lnVS2xZSpV/JepbxaXq5eqDalpR8fl2pc3X1ae
	y4uRvjGz7b/O74xptSTtKvR+rEvVxH0e2LZETZm0mqRE0mjS/ANV28cNWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxjF97733vfeVmtuOtxucMalic7hVEiGe5IZoh+mNyQsLlkkkWyz
	GzdrFSq5pSBLTOgAx4ogyICMCit/UkhbRteyjaFlhEpndTqUrgoBNpkjEhASoJUKbmtN9uXJ
	L885OefL4Sh1F5PM6Q2FkmzQ5mmIkla++3bZXsOTFF3qVz8DRFYrabjc6yIw+q0TgavPjGFu
	5Cjciy4gWL/1GwVNDaMI2h5MUdAXmEbg6/6cwNjDLRCKLBEINlQRKOvoJXBnfgPDZOMlDE5P
	Fvxhn6XhZm07hqY5AtamMhw/jzDE7A4W7KU7Yaa7mYWNB2kQnA4z4G8JMuCb2ANft04SuOoL
	0hDon8EwNnCZwLTrXwZuBq7TEK3ZBqN11Qz0LLYTmI/aKbBHlli4O2TDELC9BO7yeOr5lX8Y
	+KV6CMP5zu8whMavIBis/BODxxUm4I8sYPB6Gih42jWCYKbmMQsVF2IsWM01CKoqGmkon0yH
	9bV4c8tqGpi/cdPQ8yyMDmWIrlYXEv0LS5RY7i0Wn0Z+J6IvaqPFG+2C+FPzFCuWD06wos1j
	Er3dKWLH1Tksti1HGNHj+JKInuVLrGh5HMLi4u3b7LHtJ5QHc6U8fZEk7884qdT1PjSjghVy
	tmmkkylFNxgL4jiBf1MIubEFKTjCvybcvx+jEpzEvyp4q2fjFiVH8eFNwr2WcWRBLPci/47w
	lyJhofmdQue1ITrBKv6A4F62kgQL/A7B6R56HqOI/yeq/CjBaj5dCDlb6VqktKEXHChJbyjK
	1+rz0vcZT+tKDPqz+z45k+9B8fnYz23U9aPVsaPDiOeQZrPK7Xtdp2a0RcaS/GEkcJQmSeXw
	7tapVbnaks8k+cxHsilPMg6jbRyteVmVmS2dVPOfagul05JUIMn/q5hTJJci/OGzjqzd9QPH
	1xsPHiner5yJOQPXwuiDt9ambIcs9a+0hbcnn4r1H+aaTVl7qSv6jPeO/ejNVtcfXh3M3azX
	vLF48decXRVb+hRb/cG/swuP1PbsmS8wk8r22YJiayxzWZNzyjq89oVM3fqhNfPj8dTU6TqT
	PPD+iul7R9dgVD6goY06bVoKJRu1/wE2pECfOgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 277ac74f61c3..233acdf55e9b 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1


