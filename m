Return-Path: <linux-fsdevel+bounces-66806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9CC2CA49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025F14640D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BCF328B51;
	Mon,  3 Nov 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLjXuUoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDC322C77;
	Mon,  3 Nov 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181872; cv=none; b=DlLSqL+n5Sk4XbCTN0xChj5MMZoxWVj4D+C29cfWojiaOJunZOEW2G1RuqGVx0H9P1X+0GLjHeIy7/XHOA10aQzzA9tVoSJDWhebThQUR+u5aMuplRXR5YTdJQhul3inAHmzzE31c7qfj72G3J6k+4EjNh62ekJjo8x6YgZi32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181872; c=relaxed/simple;
	bh=4FIQe3VxffPxgRCmmS6I3GrfGBF+QoGj3ILC80hQv90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WT9DbF9vgtbss3D5maueNCC6L4sAIcn8Vqse39l5VKDrz2ltLtS7tCy+PaSVaQ8iQc+w+cqtH6r0o7TPgu3Bf+ZikY9OP/uxtklS9jxhbQ0t2YQw7zzopiymcyKjH85YhxP+pkfKopVzxspQQKO/Nf9Y+bb7XMVYfIggQjDL41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLjXuUoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA7C113D0;
	Mon,  3 Nov 2025 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181871;
	bh=4FIQe3VxffPxgRCmmS6I3GrfGBF+QoGj3ILC80hQv90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vLjXuUoFUJElIwFBAcCMlGSjdBOYo8gViAn1eihUG7yDV+RMuzPOA3H2d6sdWQVT0
	 iFCAm27lSJk35WgvtHROw9cceYwMa2ddvBviZRxwdG39lnt/3NBah/yI4tmRKIh9G8
	 xK4XU5iXq/PS+5lKtTsBYwdmNDPMAaauXKYm4J1BWqdU+kXHabP36pWK19zCvwdbS0
	 AxVVaD0g1CbYB38i4TSTjywMuKTIwRURV8jCuKbC4+I67e/LmA5asrlrRlZJO4wKxB
	 N6Btegr3aD6lhJsAi0L5m7psVMgrdxWm11EdNanu1fQMv7m1Ko+Rt253CMCHFHsqvx
	 woawv5v9qdMoA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:27 +0100
Subject: [PATCH 01/12] cred: add prepare credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-1-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4FIQe3VxffPxgRCmmS6I3GrfGBF+QoGj3ILC80hQv90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrhqf+l6336T+fDHRf3Tc271VSQHnqCe7JxX4K54
 fYSljWqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpPMTwz3J+wMbc/ScOHZih
 deWlNceNtc4zVJX3r9fltz/OpxEj4MHwV7LbYvuDVeLHeSfnrls3T/7vHqvOT4q+e7JsVbh/b+P
 O4QYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A lot of code uses the following pattern:

* prepare new credentials
* modify them for their use-case
* drop them

Support that easier with the new guard infrastructure.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 1778c0535b90..a1e33227e0c2 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -285,6 +285,11 @@ static inline void put_cred(const struct cred *cred)
 	put_cred_many(cred, 1);
 }
 
+DEFINE_CLASS(prepare_creds,
+	      struct cred *,
+	      if (_T) put_cred(_T),
+	      prepare_creds(), void)
+
 DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 
 /**

-- 
2.47.3


