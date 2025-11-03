Return-Path: <linux-fsdevel+bounces-66816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F12C2CC51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A88424CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCB337109;
	Mon,  3 Nov 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZuEia7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43763334698;
	Mon,  3 Nov 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181907; cv=none; b=N8wyWqMA+24VX1Oqiea6yGKUjSmWqUg6z0LyjMEkEgUzPcAXd8PIIA4aloiPKG6ZRKln8NFGeWxpmpXnlrEg4M1eS5kNO7HSHwWkmza4TOvKZkTXdr6bHU9rn+t1KjJhjWWojWbd9h4WO07nJRGmUWQv9d4H8l2cmAdHY5S2ZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181907; c=relaxed/simple;
	bh=bY8HkFfKRTUKYlL9vmR8hZHpb2HcHBiGKuybPYfCqeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V10jaHBRw5s5tzMwdKmkHqj9EMT7ippRJ4CPqvHYQHYqx3OvBkDvwyYTSvlP8tviSUjfbee4BEPlxqtSPW4mvHiWeszv2gkKCM2NDctVVkluv0Q1xCMeZcb/IEH2sI1mEL5XtKDAsJNjHpDvwUYtnaWhCwr/xbpPegHop4XsfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZuEia7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B547C4CEE7;
	Mon,  3 Nov 2025 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181906;
	bh=bY8HkFfKRTUKYlL9vmR8hZHpb2HcHBiGKuybPYfCqeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kZuEia7iRAL2Bjn5nZLeUNYnK9vLIQ0tpub7eCFDFep21XV+b602XA/WZiuC1WTNH
	 jNV6GcU+Xy2gjGxgdZn/sViEQr2VjI5o/280FLspkYT2NJpPz4j9DAYKxSxfnrkOEk
	 kzQYCQg+drGBoAcWtQaZJ4xS109LWXgYTFngrR1O8dZ2DMftX4eGvta2sNcjfweor9
	 u6SXJaSC3Q7DXfHfCLKQ1QQzzuW0YPYZ19ecGVUUKkICfIWv8vO7w1tNU51OkO2d03
	 DUOXN+nKdZuhU8SOYw6qugDtmV35XWT0Vu/9q2T7mx/6Avcr4uAB2fmku4lmzXNGVE
	 jXft2fPTrYyjA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:37 +0100
Subject: [PATCH 11/12] trace: use prepare credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bY8HkFfKRTUKYlL9vmR8hZHpb2HcHBiGKuybPYfCqeY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpcNDaq2a+zY//ocYTf/xYLLX2nMNk8ZLGM18CH
 +6Wd5r0qqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi14UZ/ikFNje8yOwNi1i/
 /6DXbsUJs+ZtCVQS5Dc/P+Pt1olrLJ8zMlx4EcRg3LH5bP7d2JBzWf9e3RU4HtVuqP1zQVIjv+i
 tGHYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the prepare credential guard for allocating a new set of
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_events_user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c428dafe7496..3461b1d29276 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1453,8 +1453,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	const struct cred *old_cred;
 	struct cred *cred;
 
-	cred = prepare_creds();
-
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return -ENOMEM;
 
@@ -1477,7 +1476,6 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 		ret = trace_remove_event_call(&user->call);
 
 	revert_creds(old_cred);
-	put_cred(cred);
 
 	return ret;
 }

-- 
2.47.3


