Return-Path: <linux-fsdevel+bounces-66701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8DC299A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A74188E0F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084252566DF;
	Sun,  2 Nov 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETrESr0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0B23D29A;
	Sun,  2 Nov 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125183; cv=none; b=YQtYM3EpO8r+/LGeAbgOBWpjoWqAB41mquzIvGBWiumGw99RayCKDzyqcXehgPf1pjrJINnDQf3CT/4jryUIVURNYMp282bnDe2YUNXTiMgnTyunsjk9hxNUTPgq7AOFiytFjxvwEu493jxZSCxFgKJ/MDvNF5iLVWtoCC6ez7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125183; c=relaxed/simple;
	bh=/ykCltfu/oIw+K1+sHKqrLrQ3fmICIH3UJ4AVi6auJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQjbIjqLi+Hzjwkcslvy8Qe+XIK0VKfxPl+3Fkfc7ISBGV2pWlQxGLMqbPtwCkBoKpmQUoQaRBxF4G9+BWhzSqsmJYi30l8YB5WsYdfYQ5HkN2qaIU9y9GksOTAErZNrZgycsJ3erinfZsfghos/6WA1WIXxWxORe8S6unkBduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETrESr0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347EC4CEFD;
	Sun,  2 Nov 2025 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125182;
	bh=/ykCltfu/oIw+K1+sHKqrLrQ3fmICIH3UJ4AVi6auJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ETrESr0abiIwRahtgcCOPDdqP5GyLvmIQMoauHCbkcFgLE6xmDKNCxTwEPHUGQEy6
	 HO4f+g7G5jSo3YF0UP0RBLer/aril9dOzrYp4dXqX1CopNhavkcUJHJPHTvw7ZZrXv
	 wRWXdFf3zeDgy13wnUZonYKyYswK/Uy51XqvVfBvc6Tmo9AxDdufefPe14hni7qzaG
	 fGpgetnB7BVe5rSGzpqMI3v90+0VCTQXly0BukNlYCbBLtdvdRPqYq5b2JvVgGZBE1
	 tcpvBoewmep9tJUZ7r1BpG6JtIYFUywugwUIsTmRMV2Y1U2OIztplQ8xYSxsRB2La8
	 8oph98UpHg2aw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:43 +0100
Subject: [PATCH 4/8] cred: add {scoped_}with_kernel_creds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-4-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/ykCltfu/oIw+K1+sHKqrLrQ3fmICIH3UJ4AVi6auJw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy1Ne+9rr7iDqWD2zl/288QvrN+SeNf5EINegdVf+
 1PZeWonOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSIMLIcHWvLs8DTon4fxs0
 bi24sUVERu3CgQ9n7bzu3+w/Xf9hzmyG/743LEq/bVopn3zCTrTer8eawTDux0+fVV/mTNZkl98
 3hwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a new cleanup class for override creds. We can make use of this in a
bunch of places going forward.

Based on this add with_kernel_creds() and scoped_with_kernel_creds()
that can be used to temporarily assume kernel credentials for specific
tasks such as firmware loading, or coredump socket connections. At no
point will the caller interact with the kernel credentials directly.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-1-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 8ab3718184ad..c4f7630763f4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -187,6 +187,17 @@ static inline const struct cred *revert_creds(const struct cred *revert_cred)
 	return rcu_replace_pointer(current->cred, revert_cred, 1);
 }
 
+DEFINE_CLASS(override_creds,
+	     const struct cred *,
+	     revert_creds(_T),
+	     override_creds(override_cred), const struct cred *override_cred)
+
+#define with_kernel_creds() \
+	CLASS(override_creds, __UNIQUE_ID(cred))(kernel_cred())
+
+#define scoped_with_kernel_creds() \
+	scoped_class(override_creds, __UNIQUE_ID(cred), kernel_cred())
+
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference

-- 
2.47.3


