Return-Path: <linux-fsdevel+bounces-26965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCA95D4FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD316284D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098F1925A4;
	Fri, 23 Aug 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxnZsZ83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7EE1925B0;
	Fri, 23 Aug 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436873; cv=none; b=hFweimVQMVpVmLMgNHPVA62yatZYIvvujlVR58n0MCWVHIuqO1wmE0FT1t4HAZyQkc5Al6npukf6fEbVu6Amc0T4f+7IdU2Qsbwvrj4FCQ8QLFSiMLM1ZuE+oC5kj/D/SdEkGfB4Cgh4DsjOITsI13D88hzkWwmxcoCRvO5Gfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436873; c=relaxed/simple;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScYx+QV+A0qt/w32SSsjRmPJ63+2JfvfefaGJETy+haPGYUIAPtjWEVMBKt1cSyKMD4vPynv1PWArAiRZkZMMUb2KJskFMu9VkaWI85l6an6iHGjp+LHvrhKaBA5U6sP2+mIjFeo4NdmvIgIQ6Lk9j7Onjw+5F2L+cIHORMUKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxnZsZ83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C154C4AF10;
	Fri, 23 Aug 2024 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436873;
	bh=sr03EmomsHBukis3MHoLZ8JDIsGx0uE2tUIIuCFaF7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxnZsZ83QGFALnWNNV1/sRKx/gaT1zPdtNz2013NndVBpC/YozO/AQ4mCWJocYE4P
	 52E7cepZwJoQaxnv/k3Z9INniw3wCuD/h1kjOY4KSkLF1Z3jpigqUcvOaHr0tGDVly
	 Ebxm4in7d5LbwXM6ATtc0KXwVT9hUF8iUcwIjo6wOyFF8PS1jfKU9ZYg50M35CBrMf
	 ir7XH5Qim7JpcCmi2UVJI5i121dLz+4nl/phXk2jF09TuFKk/Yp9qi1cbQ9Kz1ghKK
	 rVGras/0B0vtLzmPw0OmxdutfS9cEWAwIfVDE8ZYeD5c8tg0v6KSKUemyEJGBCWLCe
	 FQvHeuxMkJPDg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 06/19] SUNRPC: remove call_allocate() BUG_ONs
Date: Fri, 23 Aug 2024 14:14:04 -0400
Message-ID: <20240823181423.20458-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
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


