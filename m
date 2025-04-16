Return-Path: <linux-fsdevel+bounces-46599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3CA90E84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B9844508D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019F233705;
	Wed, 16 Apr 2025 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1ASBuan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72791C5D72;
	Wed, 16 Apr 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841819; cv=none; b=iAuh5KCuvj9jsS+D7KwsUf4T0DQqkN23PoboYde3RTbAVcOZr6843WTId7YAmRzr50+H+ofoQP0Yotnk9gJul2LxdC+oOIjeiy98awGbDwDhqVqkEGLtTHCvP6BHiZTtyOAPwXGXYRf0IdElvMvPE43L8gaVhcg9mTzXGyLK/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841819; c=relaxed/simple;
	bh=97bRWU25PgosLRHpJQ6h3zrlFJwdICKzb3byRPrU8mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ru23lif6CRwVsat1luBhB4NZh/vJNzKcIXlEv2KIgCRQe9Y3Z8yTvOlSgq13rrc2wNfOI1nTB/K0PlystQOu1hh5EPQV3vFVFGiHQdN8PiWU/ySDow5qZrFPIknteaihbTFCU6WxZ/XzMS758FhSLvmxai/rs/djpvWz8ryNPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1ASBuan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA76C4CEE2;
	Wed, 16 Apr 2025 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744841819;
	bh=97bRWU25PgosLRHpJQ6h3zrlFJwdICKzb3byRPrU8mE=;
	h=From:To:Cc:Subject:Date:From;
	b=i1ASBuanlv2WTlRNG19Vpk1JVfFJqxb7MN6czXwNZMTo3g8BA11pln/dH7njEEb1W
	 YHd2sTme/2hHYndVgPPONRFTCw+zUN7PkvMN8aIeU13EWsEohEERtrJAKsbUM8IMeN
	 aAqASj77aSrNyGLedLa3LLAcPE0TO4ZdmpyBx++6UFdyxSqKO7sZGoE2VIKIPDJgcO
	 ReoFfNoaRfgHI3XEr/TGqiJLY4sLpMQkqdZkMHW+AzMZIMpkJvp5wfCM9VnZ10N34a
	 k3SCrF2fRlwW3ehvEMMJMA5nWkotcfNAr6WPr2LR+0JwDRXcgFVeKLkmeUZoGDr3wU
	 jgF4j6hZf12qA==
From: Kees Cook <kees@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] netfs: Mark __nonstring lookup tables
Date: Wed, 16 Apr 2025 15:16:55 -0700
Message-Id: <20250416221654.work.028-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=kees@kernel.org; h=from:subject:message-id; bh=97bRWU25PgosLRHpJQ6h3zrlFJwdICKzb3byRPrU8mE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkMOuGbOa9fEP7j8tf6ZevfUy/0bvjwtv4pDp7KfzCxK unVgyWNHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJZWRkOBtgyft8k1ZQ1r29 RwwMOQUOLGqVjf9fPXt/2HZxpuAdHQz/DJmzTet+v5v1qJ6/59efv+8L2ypf/57gzLeNIea4Xu4 KRgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's new -Wunterminated-string-initialization notices that the
character lookup tables "fscache_cache_states" and "fscache_cookie_states"
(which are not used as a C-String) need to be marked as "nonstring":

fs/netfs/fscache_cache.c:375:67: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (6 chars into 5 available) [-Wunterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
fs/netfs/fscache_cookie.c:32:69: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (11 chars into 10 available) [-Wunterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~

Annotate the arrays.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: netfs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/fscache_cache.c  | 2 +-
 fs/netfs/fscache_cookie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..8f70f8da064b 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] __nonstring = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..3d56fc73435f 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,7 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] __nonstring = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.34.1


