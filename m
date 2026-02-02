Return-Path: <linux-fsdevel+bounces-76093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s0iXC24YgWmnEAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:34:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAFD1ACD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B623A3016EC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2122EC0A6;
	Mon,  2 Feb 2026 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1homIfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F68B652;
	Mon,  2 Feb 2026 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068071; cv=none; b=SUwfudMSD3XxM5cwpHXQOofhtqsFeYKVe/aN1ARQmLUHBdOJyDNTJ7O8tgfTUuTu37lZJ3yPe83RjOUHnvREsnk+FrSyS0LujnCRCXWXSJvzxF2UdrFVqaMHZFVuO1Qu7vxRypfWfDEyMqC+MjdgDKI6wv0ygT7M2qOfO164+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068071; c=relaxed/simple;
	bh=DC7EiSLggQqA6wyyZE4iUjU1VOfB5KhO0zARRFtO0Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJJGhe60dYpDPomnZTcaao+Czf3C3L/Jahr8ko/zM+WW0EX9AYbMvtReirVdPLiZZDaxVnXBe+80UnOZ5JAdV0Ge3k6D3lIezqXQ0apUa3c5SAugn48cuW1Mw5lnU3wydV1ow1qNryc77uHpn/9uecPuU6+HpvqT+1WBCv/neqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1homIfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC0C116C6;
	Mon,  2 Feb 2026 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068071;
	bh=DC7EiSLggQqA6wyyZE4iUjU1VOfB5KhO0zARRFtO0Vw=;
	h=From:To:Cc:Subject:Date:From;
	b=s1homIfOIZywWqxP021ZFafaVVT3cN5TzwzadD0dPXq9/kivJ1exjy0iXDwB6qO7A
	 iswOpO/SORtPYu6mu8ZmClqeqgdv2KU7m7av98P8W5XesQicLBym/GZo8MasxHF2zA
	 JKKIHOOplJPdrGQLwtnnHIF85JfrrEXyiC6ne0iYj75AEtsxvn7noVGLkY6psjZWQ3
	 uN3oauGqbeMNMOkwSJWzU7wsUvNPFWfvU5mLGcT6ht9KYVA9Dpw83f8dqJaK0FQIY7
	 DC6jXs8PsH6ZBbfoM6LmzW7QFdP9oFr7/kj0kGYHP33XhH65w4WlBOfIF7Tk5q1PdQ
	 hZCkfC+Hw1Hzw==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fsverity: remove inode from fsverity_verification_ctx
Date: Mon,  2 Feb 2026 13:33:39 -0800
Message-ID: <20260202213339.143683-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76093-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76DAFD1ACD
X-Rspamd-Action: no action

This field is no longer used, so remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/verify.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 37e000f01c180..31797f9b24d0f 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -17,11 +17,10 @@ struct fsverity_pending_block {
 	u64 pos;
 	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
 };
 
 struct fsverity_verification_context {
-	struct inode *inode;
 	struct fsverity_info *vi;
 
 	/*
 	 * This is the queue of data blocks that are pending verification.  When
 	 * the crypto layer supports interleaved hashing, we allow multiple
@@ -314,11 +313,10 @@ static bool verify_data_block(struct fsverity_info *vi,
 
 static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
 				   struct fsverity_info *vi)
 {
-	ctx->inode = vi->inode;
 	ctx->vi = vi;
 	ctx->num_pending = 0;
 	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
 	    sha256_finup_2x_is_optimized())
 		ctx->max_pending = 2;

base-commit: ada3a1a48d5a21a78c1460c8853502d13062ffc9
-- 
2.52.0


