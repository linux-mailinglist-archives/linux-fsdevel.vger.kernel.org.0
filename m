Return-Path: <linux-fsdevel+bounces-26293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC99572D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DE01C23779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3B189B9E;
	Mon, 19 Aug 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKCGzhlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19796189B80;
	Mon, 19 Aug 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091482; cv=none; b=WXOg7g68I00BzmS1wTJi5YKJzdWDBAdeLu4G5shPRW9GEbrBXxy1jmoM9i2vORALTMMjjtgWVXwqePOQwLRVvohYclFBUkI8H9/khaOWvZ4+4Qd6hH0qEGXsB+Hi1mUZ9XZ4N6T8TvhRp9c6p0PsN8jb3VrRxFmCxWWqz93ox24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091482; c=relaxed/simple;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgwwUL9/vh45GqZ1BK0+bqgshiLQDuJEinw5L1bOv8PanuidF0CG/yJqoSpWHJHl2E7qS5V+4zUIhRna8axfwPQF0ARGmYN/xvGM14OR3jWVKQez6+YGtkvRV26f9/8zndXYtyJBCZq/Dc4oQBVld2lxgYz2BAliUnay0Lj/AVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKCGzhlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBBEC4AF0F;
	Mon, 19 Aug 2024 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091481;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKCGzhlCmYElPMoWh+YgAQfHS+vouq/5gc6ZhUy6rDkMw3zrkuoaRnOGQDYnoP6Qw
	 GJ/BBzmtsYZqSVwysqWvlHxR535uPEjfvR3C9eDBX0CucaCvBHltyJ00ZBgCoBL6dc
	 lt9rKS2qP5OvlozmuXL7tt9sKm9vy7j4HKFoIGGa8J0CUQ0A/FMB3BJ4095wi47f9L
	 RMlBIZ7JCqp6NXZ3dqxOTmIbQt0DLTWgSrnMUvHhgWnTKMgOCSCBrN4jivGthckHIX
	 YlqG9SIuwuP3gD2Jh8Sa0Iapl367UChJJbRxqxWjxWA7xq/mtpUe/9bK/QeKaEpeNa
	 xlcqERxvCpX+A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 07/24] SUNRPC: remove call_allocate() BUG_ONs
Date: Mon, 19 Aug 2024 14:17:12 -0400
Message-ID: <20240819181750.70570-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
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


