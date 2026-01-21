Return-Path: <linux-fsdevel+bounces-74906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEN3IEo0cWlQfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:17:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120B55CFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0AEACE4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D00366DB4;
	Wed, 21 Jan 2026 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="K85somvW";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ZQMH4rQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163839E6E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024451; cv=none; b=o/WhyC4pMbIu4I0yBGscwwXF5UoKY4eCpxbC+Y78SPBqseVqXBtkn8saQT1u4c4wcof064tFSsrtCFloCK0Dxtin0ydzxWdevh/TIgITvSO2OuMBVMS5Xlw8OzsVF2eOogZ/96dt8fuOJux9MrxCuVonk6u5pv+CHBVbOD59zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024451; c=relaxed/simple;
	bh=xWR8+2wGjm3ruZk2p6dj6phIUu2lpRDLViyNPoYkxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdLKzQj6ya7O/Ax+eHu0SLjsQ665ZkN+f0Ngi6LM7ZLb2/SvWsJUNkra8/DRg6EQTFrrx11cH7MrIKW37rceoae4WGJ7lNZkjjrUHixBI+apE61id48X1wfQ48bOOaToX/z3XSPZLwro9+q0xrhlrHpNAuOhwWvT7ch+JT8GqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=K85somvW reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ZQMH4rQl; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769025349; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=4cFXi5ffTlofjVqYriSS7S+dg6PFnmAY2IZAHb9HavE=; b=K85somvW7KM4wJEo2VIVOkG9db
	sPUkPv7CS64MYECRvSJBY/e4ps4wzvklW7KR5zajkWi0xsVy+a3J/vw1fQ667X2Z1Ik/6CTIUVv9r
	6slIMMGwBeOc9XKCrWTemyVCRtOcMDRTlX6b0B5wpKZhqXK/jEb02QqSZMsW0MB9IHCNTuWFjv2RC
	UOsaZ+PweLbCOV0ZMrZgYgPW6pJqbf+oGjnRRC6HXNuaDIv1qxDD9I9gut3EwlI19P/3lmCzKiUcs
	6doDAxYf3UX7p38QDgzjJOAAcNb4PmnYtEbPGltk4ifkx/tnjrPNB/UdOz4qFsJTIFlBpN7GtcVp0
	jTzwI2rQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769024449; h=from : subject
 : to : message-id : date;
 bh=4cFXi5ffTlofjVqYriSS7S+dg6PFnmAY2IZAHb9HavE=;
 b=ZQMH4rQl6Lay67iBCUdvlWUpf7HorGXwA9lDgZZPujh/VX6L860/JPWPrfO9Ac53mpzvK
 8vh9JrSMEJ+yr3Vk5i3/TuYjRxm86ZY5+a/w/UnUgcGILCunYxma/FP3UgpG6bi1Ga9qwT4
 qnW66ORi95BC+ciW9oqIUKFzVqIImbmYawIE6uAQqyf9if+7zx9Tvb/9Ww/jfSgASoa30Hg
 mGSaqyYJBNx19133Td8E/cWDF5V4KhUyGJQ+o0U19kqNr6YGK6s6oSdxY7wd7A/gTy3lWo7
 +nZ+hTiEsNpNHEelMI2/XYSNzieWMrxsPkoStZQC/hxnswYQyI+Nrpa49HWg==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3f-TRk7G4-Ax; Wed, 21 Jan 2026 19:40:03 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3e-FnQW0hPpU1x-o72R; Wed, 21 Jan 2026 19:40:03 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/2] wait: Introduce io_wait_event_killable()
Date: Wed, 21 Jan 2026 20:21:58 +0100
Message-ID: <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769009696.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769009696.git.repk@triplefau.lt>
References: <cover.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: ydgmxhPuTl9z.aJg7Xc6iPEhx.clsw7wI12Ja
Feedback-ID: 510616m:510616apGKSTK:510616s8cjAlH8hC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74906-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,triplefau.lt:email,triplefau.lt:dkim,triplefau.lt:mid]
X-Rspamd-Queue-Id: 120B55CFD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5..dce055e6add3 100644
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


