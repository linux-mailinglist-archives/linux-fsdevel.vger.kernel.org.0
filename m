Return-Path: <linux-fsdevel+bounces-66817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E4C2CB07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE0D421D11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158183375B9;
	Mon,  3 Nov 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpBZwE5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0233710D;
	Mon,  3 Nov 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181910; cv=none; b=mHcmW+5a8hmzO2t5gvlY9ITKVWnfWe63KpcqdHsoYXe5/O8xmUaQ1J2wfo35V8hd96tCWHvPbi1v8Y3S3qpE18axzsUEzCBCepTv3Xi6O3wZoORU5cODkWVvodqBgAv0gCMSYz1kkFaJov4PcutNvXPdK8SlF4JvsdijTAF0H+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181910; c=relaxed/simple;
	bh=CN70SPaB9uDUTmoTMFQEikVK97VTOop0si2tr6t5dG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3oOW0TSOojHQ6xnOcd71thMH7XdqcIMFebRg4tLOPmpM5vYTN5Q27c9KUDcG4O/kXapuv8rZ1uzNb/njgbqjZyHljXq9uDmXmnaBzYmHSfvWXcQW3vNUvRH377aTt1g/qrXXaGEM1m25zioGR6et149Bzs4olRacNsG9VsGz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpBZwE5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F91C116C6;
	Mon,  3 Nov 2025 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181909;
	bh=CN70SPaB9uDUTmoTMFQEikVK97VTOop0si2tr6t5dG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rpBZwE5Zcf6RBsQu6RQgpC/IOnpRjzOaYYoomnODvXeBO85TArXHgKIPf4o1KLwv+
	 RzbpwGM3RxPzCzAdgmmMBq25UmuptGH+6wBUSwwshEax8fSLZR8yw1RvBLk8qqC/aH
	 KP5SheycNIKw15+ZoULoPxIOaz0zpAswNDYLIql7dCo2kLGz/ij6CMdf+3eWWVapx6
	 RZ1qngT/jX1ctwOiKGTwXqW3OsUQjlbR1YFn6LrpLXVUirPAj1UyARzoJNT8UMd9Tf
	 BurHwguSrbMYI64Yi9BpIUYlkZDPch+DB9a1ZZh9PiZppcpFnDUgTLvy+Qu3Rh8Uop
	 RJxn/Pes4VDBw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:38 +0100
Subject: [PATCH 12/12] trace: use override credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CN70SPaB9uDUTmoTMFQEikVK97VTOop0si2tr6t5dG8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHq5Of6I49wDL3cuF1ZOPtQr8766w3eGAQuLxusP1
 745yP973lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARwQ+MDN8aFc4c2FSw7vom
 C+OaYwbfUtlcVpxTr9tpcMK7rDm9Zg7DX5Gwnl2dczkKWLtTnGf/eyuVkLYqfc3KE1JmTosWnJ+
 jzAoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use override credential guards for scoped credential override with
automatic restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_events_user.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 3461b1d29276..4528c058d7cd 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1449,8 +1449,6 @@ static struct trace_event_functions user_event_funcs = {
 
 static int user_event_set_call_visible(struct user_event *user, bool visible)
 {
-	int ret;
-	const struct cred *old_cred;
 	struct cred *cred;
 
 	CLASS(prepare_creds, cred)();
@@ -1470,14 +1468,11 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 
 	old_cred = override_creds(cred);
 
+	with_creds(cred);
 	if (visible)
-		ret = trace_add_event_call(&user->call);
-	else
-		ret = trace_remove_event_call(&user->call);
+		return trace_add_event_call(&user->call);
 
-	revert_creds(old_cred);
-
-	return ret;
+	return trace_remove_event_call(&user->call);
 }
 
 static int destroy_user_event(struct user_event *user)

-- 
2.47.3


