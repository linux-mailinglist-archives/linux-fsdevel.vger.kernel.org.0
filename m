Return-Path: <linux-fsdevel+bounces-59727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431EB3D4D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE29E3BD02A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BABC2765D4;
	Sun, 31 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="APh4JKrA";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ci3YaaZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4271F5413
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667890; cv=none; b=n5NtXFSa84ZI82dSOgy4tzdyGZx27VKr4Q4VTPl+TvzWjpZV5n7RCWs0J8fhY7wzs4anJRHEg2ty/sh2mkxcGFHnDOpNOlZJGTDo5M/wdoi+WBAKIjMwYJm3iohFgRfARCph4HIIWoHainX9bkrJqjdMfokLZ8H9ypsByiJEH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667890; c=relaxed/simple;
	bh=ABm7sCuXnVGTUvJ3oYj/x/myV+euHTB1ShT8xKihbqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8HqRmRTNKKt99tXNmRdsX5sf+dB+U0NBBEd91AMHNULTBePiYVyP3Jc1929xHbobFSzqNWlK+8Xa56FLVrvy7XoqbgBIHmq6SD2RN/kkxRAG7IFYLaO2Q9S7aw79jkeWZAA1JUmPNwD6E3dSNtqMqYbMkEboCqP3AM+FqxAq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=APh4JKrA reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ci3YaaZ+; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668789; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=; b=APh4JKrA2ira0myI78uw61CUma
	sx7DgvTBxXOgPhXArI4I3HsnHJW++Yw8iIfWoIMS1otOVyAgcYYOEokfH2Wq73RP3LQhaSgIo5Kyp
	SYOhK4bvVaHie66F4o+9F1wxaxgXmp2PDLpn6GGlqbPaB+jORPk8AOY47Z2lz1r3rfQSzHLQliSeh
	wYNrs7ejbiCGe0ILUop/+ybNLgiBZHNGFMrcRoA6mGGgPV2c4bGgn8pvDTwxmIg3Es5Rsg83KLXSN
	5R3iVukt5Z/DG1JB0LAlxDnoWiXti/HPSkvKJvsjlSvHmvlGVu9axWQfnTeFgt7H3iqOSj2GB+VWT
	qV9f41dQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667889; h=from : subject
 : to : message-id : date;
 bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=;
 b=ci3YaaZ+M2rDwm5r4tgocHNs984/tMi6kkK3ajCZYWZansra8ZkWMAUII8gQv/zv18GvY
 Wfra1OyyUETORlv5Cy30GlZB9KQuXrLp8fN84h3KhEYLDX0aMRxjY+rxnPR50dW9r+YJSTs
 jF5gIhTHekVyZ6ZUIhJM5JUNSTMMCHXjQhsy/sfaw55rzcQEA/3OHRZLgHYN9qmRX8R2pW6
 k6EBhPKZ4IGIRFkh5QRIypC9UyWTTagvyY8fsG8Or0Q12qjaW9eIbckhjYJNVM69a32KHrd
 HRRUuTlGu0PEoQCTESS8MBOZkWueoU5UjHHp1X/MNlRYWBCyq0u4lDDAaZTg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4VS-H5; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrprk4-pPNu; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 4/5] wait: Introduce io_wait_event_killable()
Date: Sun, 31 Aug 2025 21:03:42 +0200
Message-ID: <370180ef235d9e183c93bfb9677e8a35e4ca27f2.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: jIWWlMxb-Kap._nl_8X1Av5NQ.8plFsQpU0Mf
Feedback-ID: 510616m:510616apGKSTK:510616s1xwnvTvE6
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..cfeb1adee973 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -937,6 +937,21 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __io_wait_event_killable(wq, condition)					\
+	___wait_event(wq, condition, TASK_KILLABLE, 0, 0, io_schedule())
+
+/*
+ * wait_event_killable() - link wait_event_killable but with io_schedule()
+ */
+#define io_wait_event_killable(wq_head, condition)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __io_wait_event_killable(wq_head, condition);		\
+	__ret;									\
+})
+
 #define __wait_event_state(wq, condition, state)				\
 	___wait_event(wq, condition, state, 0, 0, schedule())
 
-- 
2.50.1


