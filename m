Return-Path: <linux-fsdevel+bounces-28121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEE9673B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E02829C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391615E81;
	Sat, 31 Aug 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="draZYXQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6537183063;
	Sat, 31 Aug 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143891; cv=none; b=ttOXJvR74NrTk0mE9ZolrktaV0zWhM2mjqq3VN/A9+Gg9h1low/7JvVauPwaH4iHHT4zoOEjilYlsovLmmaL9buYYtJgt+N1QCdScXf/yccteQnOIGR5VAexiuHtQfV20/wWhcd9X7jg7divKQbsZlGbMmhhBVULdHYf0ygzrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143891; c=relaxed/simple;
	bh=v6Kr4aZMTqmzIOXKWJ8riLtR4R1j9G1RaF8LPR4sBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oODPSO7NcgDdu9wG91DQwcKcm5Q1Kg131KlK2WncvX2Fn4N2ZmYvqrm6BKs0CfEdPTiyoWBW/txjJXUTjHslqIO5QyHFdxXSiY9hgpUL/yUMSpJFJHtm4Xc0iZnqmiHDapg6YG+PrvI/G+aeqHeMS6ROHgvaSTTWmDJXW26E898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=draZYXQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E60AC4CEC4;
	Sat, 31 Aug 2024 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143891;
	bh=v6Kr4aZMTqmzIOXKWJ8riLtR4R1j9G1RaF8LPR4sBk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=draZYXQsGhUB86kV11FI4jYEchkEuWeH8qUhR5vUXin9rqvquHhmlCy4/vyd4EJu+
	 P767N+NEc6wuLJaIjAYykHn+UQ0DhyGYpWAQ3qG9hTvNeLlAY7//234Et0NBOZJXGo
	 DEQRbPLapH/rwyS61kbqvQyS/PAZJcZ/RMiU9PeSjqiciaoHmM3hpHDu0NqLqim1e9
	 pS5NhSkwqaCSnNnzohm49ZNfiqqp5q00mb9J58cToP45X6hyHPiHxuFiaXT2XHJ6sw
	 cg40o/SR4bp65Nbn8tSmCEYnSZX8kmjoSvw/roaY9D3IvsDGZB89w2nULoAgVH5b7J
	 6XutlrYMDW/tA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 11/26] SUNRPC: remove call_allocate() BUG_ONs
Date: Sat, 31 Aug 2024 18:37:31 -0400
Message-ID: <20240831223755.8569-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove BUG_ON if p_arglen=0 to allow RPC with void arg.
Remove BUG_ON if p_replen=0 to allow RPC with void return.

The former was needed for the first revision of the LOCALIO protocol
which had an RPC that took a void arg:

    /* raw RFC 9562 UUID */
    typedef u8 uuid_t<UUID_SIZE>;

    program NFS_LOCALIO_PROGRAM {
        version LOCALIO_V1 {
            void
                NULL(void) = 0;

            uuid_t
                GETUUID(void) = 1;
        } = 1;
    } = 400122;

The latter is needed for the final revision of the LOCALIO protocol
which has a UUID_IS_LOCAL RPC which returns a void:

    /* raw RFC 9562 UUID */
    typedef u8 uuid_t<UUID_SIZE>;

    program NFS_LOCALIO_PROGRAM {
        version LOCALIO_V1 {
            void
                NULL(void) = 0;

            void
                UUID_IS_LOCAL(uuid_t) = 1;
        } = 1;
    } = 400122;

There is really no value in triggering a BUG_ON in response to either
of these previously unsupported conditions.

NeilBrown would like the entire 'if (proc->p_proc != 0)' branch
removed (not just the one BUG_ON that must be removed for LOCALIO's
immediate needs of returning void).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/clnt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..00fe6df11ab7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1893,12 +1893,6 @@ call_allocate(struct rpc_task *task)
 	if (req->rq_buffer)
 		return;
 
-	if (proc->p_proc != 0) {
-		BUG_ON(proc->p_arglen == 0);
-		if (proc->p_decode != NULL)
-			BUG_ON(proc->p_replen == 0);
-	}
-
 	/*
 	 * Calculate the size (in quads) of the RPC call
 	 * and reply headers, and convert both values
-- 
2.44.0


