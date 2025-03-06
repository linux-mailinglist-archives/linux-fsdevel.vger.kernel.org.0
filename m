Return-Path: <linux-fsdevel+bounces-43333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B4A548D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E591F7A6BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3982204F7A;
	Thu,  6 Mar 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BluvcIg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD321946A2;
	Thu,  6 Mar 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259555; cv=none; b=jqhJb1rOX5t1ps4wZTprUJRqdyStCN+aDNbB2NlhQ14szuoMj2/Jc0UOa6c47vEa1Vdpkq4uDW7SFyOfnE9b/Ub2fqHXSeqgE4Y3eF5xTNmLesfr2odZZxVOKCI4VuLHbuT0dx7qORiWJetGTNfNuBTd/Nobtv5REukT4jHWmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259555; c=relaxed/simple;
	bh=llx+qzXZXIbgvEbZc6XpBiGoD8V5i+4dnvn08Y7XHDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8YWn5Od5hVy5RcShif8CafvAud022xTfOgKL1qnF4ZqVwHPUfFCT3hYIbEm+wnLSpEpAwEjuHJpxiKK9HvPNdRsZSop06NvSLqM98hPwY3gW98GFmA1jmzyWDfTn/8DZ96sxFfVEjR/FkxuXrWtJ7KIbuU1S0YjTgWiYnz1BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BluvcIg/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5nPBCqkr0XAmWw9QrM4XamZwYpikIpvAzafOHS2cuu0=; b=BluvcIg/kDwEAXqW0J6fa+rg6Q
	Hksvc5mxcXbXQPm0kNa1P9I/uGNpjQNGquDstSOhtEmxcHFbwztw5AjgvL9kkKT4P2NWwY8qQ5O7J
	OLcQlXQ9KAiQ8fHVmveEVnOjh4M76GSI0832mgbNHMfNXuyNBuSIHp5mavORDQqaaXAYHNzRN8k6N
	IQDFAM58JQEpWUwxFzYP9lxYaxVquF1NIP8I+U8DtbWaiZ+Ub5XHv+0xTb/nLfbl6nN8Mu59HbtXV
	sdWGyTFcqG9kqRySWCtuRyRvLoAzthUooOpM2UrTF0ovmyKXfuaAaG/oF1RYnytcTj6R8Gb6fXfnO
	tQcgE5/g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tq99I-004ht7-Ga; Thu, 06 Mar 2025 12:12:26 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fuse: fix possible deadlock if rings are never initialized
Date: Thu,  6 Mar 2025 11:12:18 +0000
Message-ID: <20250306111218.13734-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting a user-space filesystem using io_uring, the initialization
of the rings is done separately in the server side.  If for some reason
(e.g. a server bug) this step is not performed it will be impossible to
unmount the filesystem if there are already requests waiting.

This issue is easily reproduced with the libfuse passthrough_ll example,
if the queue depth is set to '0' and a request is queued before trying to
unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
will try to wake up all tasks waiting in fc->blocked_waitq, but because the
rings were never initialized, fuse_uring_ready() will never return 'true'.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7edceecedfa5..2fe565e9b403 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 {
 	return !fc->initialized || (for_background && fc->blocked) ||
-	       (fc->io_uring && !fuse_uring_ready(fc));
+	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
 }
 
 static void fuse_drop_waiting(struct fuse_conn *fc)

