Return-Path: <linux-fsdevel+bounces-27724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7F963764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712611C2247E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7B82D94;
	Thu, 29 Aug 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVa+BEir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6D73452;
	Thu, 29 Aug 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893481; cv=none; b=nVHnMzpaxKZqvBwhWSf8qakJamifoPjX9QgQVDMb/pM+qUEQGCJWtYnSqe8rqQUSt/p5mSzfCE81Xhk0ikl984T2G/HPuDQ6jjc+MM6Eg8+B9xUgwpcAWbiJ+W3SpVvOudZ+mlo3LaGskolyICqs2uDl8/9cr6wzbyDHmAVC4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893481; c=relaxed/simple;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5uPZx+SblgL5Ziwf8Kv56jUj/M9gBnrbmHEGVhI4oP6G1KWFCNc9oTQLshjiN0kHmGhK0gp/3rt69xzvYWFIuZk5CkroNPyFhndYfefmmkWSR5l+TFTZ6JW7MRAwLQ2l/tpXKylx03/QJW5rd081S054HB8i4IMvOBb5nioh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVa+BEir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390DCC4CEC0;
	Thu, 29 Aug 2024 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893480;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVa+BEirRlC2189Pm61Z6Wk25VrV5KlLb1RWDhZqT4QL0MPDjd7q3qslREUdYHqU1
	 /UdygFvodAbn9PjkVsKD9uojTj0GMAopwhgebC0b5fox3g7cY5pqUzKh6N9hdELiaa
	 ckZ2Uk8o+5+/GemJyUzAUZl2dEO73+eTAnUpHH7fJC9mOVsaA/wE5fobOsIB3ISUf/
	 0cHydWBVPBgUJ9uACKo/2aDiMWhHcKJTvGhMnC7/AaTxrRgkgegeW51mGk5sKe6LiI
	 cWbmmzHyDio19ZMNQwbarS3oT6dTs/GdUer+O0gMrKMCb4nKyA6AGY3UW0EKavvhcq
	 eu/0AoBAexG7A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 11/25] SUNRPC: remove call_allocate() BUG_ONs
Date: Wed, 28 Aug 2024 21:04:06 -0400
Message-ID: <20240829010424.83693-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
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

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
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


