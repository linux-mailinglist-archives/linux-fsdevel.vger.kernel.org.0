Return-Path: <linux-fsdevel+bounces-77998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLjkB8yynGmxJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:04:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5317CB09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888FD30AD8BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01137646E;
	Mon, 23 Feb 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuTgYCgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A46374755
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876786; cv=none; b=Tm2sO/GWP+fEjBpz9NqjcprXK5ElmNt1IqIgpMzhs2HwBBysD7VZBDlHvO/tyrPc9jhj33y9wTV+3tn/g3wU4zAE8pTLEag9lw56HGBoAejMT+2mKqrDH1woD2WZggpo4QrILXLk5bKEHCBV9DUI9BP04aXy0NObnHXZLLJ9Yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876786; c=relaxed/simple;
	bh=vSGezea+kHW8+I4FXMUBtjpPhAkkh38ljsBUp1un6Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y1Vh5BdjOA3BDgb2TpoaCWW5oxeeNAQUU/VTgiwuHKOIXf2hl7MA1axJwJfVPHbw0azCzb/clIxW1P7Qndm0zKYR+ZLbPYJ6HbZKibt4W7nUwwuhc1C65IfzrtNbEL10NjVvnjogys0829VAmyXpgdtKxTdpRdvAFJDXZOiWPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuTgYCgx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371d2f661so10835e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771876783; x=1772481583; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szNx6Q9HpZ/iwXNBTZ4lMVazeKKlYTctcpZDy3jvygs=;
        b=PuTgYCgxqHEeEQaPpdXskpsK/s6pQE+bbQL11TWMGAdhyx5mvimruMIPGPQYuKn/c4
         /4PvFooIdPWbfBvRbFEN344fS+lJZk5OB9H55jzjIJjLXNk+RNBjACQ+a78ab9meS4c7
         FkcH4X9LfcKbP4LUrBkWx7kZdP2H+uRzA18kIwCOuuPRG/vKA6S3FqwgG8KvFbXwEd3R
         o+8BLMvv0f3QlY77awO6OPiWUt7lNCGsH7o5O100LeS1Nw6WbwMQ1dMvf58WoQK6qwae
         VASxq68Qyk62krV+RfmbiFY6zuR0VakymyNeigK0PhgGVLSFw2ghaISekar6OIiavimF
         SL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876783; x=1772481583;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szNx6Q9HpZ/iwXNBTZ4lMVazeKKlYTctcpZDy3jvygs=;
        b=wt/mM8TXzrm3DXTaSB+2A0gMz8Em9q5Ym8v+zqaM7TfdnAWHeyOOUDE6KOR4WY4ChX
         CkE++70ylOp2Xz1H8S6sRPxOagHhet6XW9hrUNEsJXoAjLvOUbzBMx4/bfUo6JGBLU2Z
         3U/0d7rSdLSIv7MmtaJ9EfIJ5Th2fvNTw6KmYnnezeqE5eHZVLdWM2/LCCqZbOCQEPJK
         rv4l4EFvQhCl6epEN0oePSVcg3IIcGMm0ywp0xP3393rVyQS4/7UnJiqcu/kiXXDF95Y
         INTFtMWfodaJf5tGUNk6dorSDnMeihSJMrDoZSa9wu96Gj9nW3F2vPSXPqYxFuSSc3Xt
         unOA==
X-Gm-Message-State: AOJu0YyeOwRopVnY1nTnIaPBLILukXXfXIvzojdlapyeH50cbPILlD1P
	nMwiRz3iF4QUmonljtKhK1HeojWT5egJPwFjbJV4EchRQxXN5M/+XkdLqySq9do+Vg==
X-Gm-Gg: AZuq6aLBRJbaL4vORHBvlZnKoWfl8RptN1T4NR1Z1bYUzHoOQp1QUtn8VBKbn6rfyDw
	sHxoqrn1N5KTwIEMtX6gp+S+MMUZAmM9QFBxJ+hkO4LSzxN6/wuQpl/hPrgG8AShvNHQfxlWDf/
	uF3dnJltbjPkjojxA5qorqlQesDm5bz1uajCr8lqsHOoDBJAv9hoUwh0BfZMvAD4xVFPSM0Sb/U
	qvLAZSytvLRTw2bsKBHMP/FwtzfM6Cj8pGrOP/iBK1SduwhEtERhD32LPRbXypFptyC5NEPJv/d
	B9ez9LJ3Yz+kkh8Kk6jYVgtI1v4aOp6/ZIsnKo5f5akPcTSY99qn0zB+mKRUYrWNswhBpX0VNPr
	0LWdl1Dmc+dVYgiug7o6kIe0zqGw8dqYvh66NtnoX1SzZtwp2qPRqkLB5BmUWsGtgBbRKHkrtUU
	oMEs5eoAJ7NadF+3tBrbpyEj+AUwNdKRFHZAo7gEplfqFAzOGj8mE=
X-Received: by 2002:a05:600c:4454:b0:477:86fd:fb1b with SMTP id 5b1f17b1804b1-483b878837emr116465e9.11.1771876782542;
        Mon, 23 Feb 2026 11:59:42 -0800 (PST)
Received: from localhost ([2a00:79e0:288a:8:e3f8:d6ab:bdc7:bdcf])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483b81f8912sm4486845e9.1.2026.02.23.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:59:42 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Mon, 23 Feb 2026 20:59:33 +0100
Subject: [PATCH] eventpoll: Fix integer overflow in ep_loop_check_proc()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-epoll-int-overflow-v1-1-452f35132224@google.com>
X-B4-Tracking: v=1; b=H4sIAKSxnGkC/x3MQQqAIBBA0avErBswjYKuEi3MxhoQFY0KwrsnL
 d/i/xcyJaYMU/NCooszB1/RtQ2YQ/udkLdqkEIOQkqFFINzyP7EcFGyLtyotOhXOyoyeoAaxkS
 Wn386L6V8a/Zz4GQAAAA=
X-Change-ID: 20260223-epoll-int-overflow-3a04bf73eca6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771876777; l=1946;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=vSGezea+kHW8+I4FXMUBtjpPhAkkh38ljsBUp1un6Fs=;
 b=RdragfDp77ExTy4XNQd7Cde3KK3Eu2MW9GuvLXcoBKzltgC7byd5LbGI5kPdL8Vyo4Wccnt4U
 6Gt2X0RHjm4AJOJHzmkeblC3ZLcrSB3Jwn43TzRKzit2MbcKn7TWTZT
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77998-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AF5317CB09
X-Rspamd-Action: no action

If a recursive call to ep_loop_check_proc() hits the `result = INT_MAX`,
an integer overflow will occur in the calling ep_loop_check_proc() at
`result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1)`,
breaking the recursion depth check.

Fix it by using a different placeholder value that can't lead to an
overflow.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Gah, I introduced such an obvious integer overflow when I touched this
code the last time...

No "Closes:" link because the bug was not reported publicly.
---
 fs/eventpoll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a8c278c50083..5714e900567c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2061,7 +2061,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
+ * Return: depth of the subtree, or a value bigger than EP_MAX_NESTS if we found
+ * a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
@@ -2080,7 +2081,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				result = INT_MAX;
+				result = EP_MAX_NESTS+1;
 			else
 				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
 			if (result > EP_MAX_NESTS)

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-epoll-int-overflow-3a04bf73eca6

--  
Jann Horn <jannh@google.com>


