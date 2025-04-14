Return-Path: <linux-fsdevel+bounces-46388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13298A885A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C335E1902DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77887291153;
	Mon, 14 Apr 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsJjg6G+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62428F513;
	Mon, 14 Apr 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640402; cv=none; b=Gf/BXdDmXpnmO3KjhFGOY550DPlokQAOTeRWG71bwEECvsByo+p+wK8QsX2Wz8z+2EvLebNx3v8ge3hDO8miDwT30nc22dHXAD5NlJyo5Ix+v8sRcTVJK3cPX8R7pnn2Qjf2kCSbi0mxUu9huTgz+oQFSD2DgGZ36rVlVeil7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640402; c=relaxed/simple;
	bh=4HluSwNWTBR8eHRrEF+w8ybc5StWcpkyjDrH6+uQSwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AjW5UBWMCFG8zOiOqwGNkC2UsnX2LWDiDsd+hCoaLWWSIvuwyPGokXULA/+0q3hve50r1wo5vhTzMzHoS/X7eNmSh10cHWv5UG/eqPGup3SkDNjBMDD9FH57epJkhGnNocrlMrudMS4ZV1+whl4zn63v/Sgu3ZcxPzgezlpraII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsJjg6G+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so23550035e9.2;
        Mon, 14 Apr 2025 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640399; x=1745245199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glJjEQgGBLhG4Ninmzh++t+Xe4BZvesnJ6GFYu9vl6g=;
        b=QsJjg6G+ts6tzHYe99KhHvsHJQiqyrQRpmzilJrDFdZrkYDDElJwtFfq2Qj4nbFEN5
         sfRuBN/6peI7efVl1Hbq8OiKft6f7Kzgy+xHm1ejeWznZwCp9BzuHKHiAb8i8qy6TDob
         7k34ulfixJxNN8zXDa2AuTOcPkbNCLSAdIeyhFYY3eTo0KfOIGvhG7bsuRX4kUPRGoXw
         f0a1MqF/3STmPolu2nEXnCXktElFxDv3VX2rXH9VuolEQoDb7ug2MmDi7boOjQKdjoz+
         hGH6abpTK2sA3HC/HE7Tf9rH5Ywl6UwMkjPc3wuJC2nxAe6SznvjLwv5W7R5bsxRPAgE
         BCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640399; x=1745245199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glJjEQgGBLhG4Ninmzh++t+Xe4BZvesnJ6GFYu9vl6g=;
        b=RPHJaA3OKu+E7aiz015hOF4nbs3k3LhG4gg9xzu75mbJHCHz7nv174zaJetW2nuz3w
         M/fEm426PsM0UoH/lH12BiNwwU+BwwiIQ7GL7vlP9UXzO79CUkVZ/MMQYkPJLoTnzNnm
         WbbCA1Asvn4gxaYz6n+fFLs4Dn2b9cNEJLsO98pv2WnpvbXMCdMoQxrlho54brmBqqXa
         Tkdioa5+RvG4n7o9mJcXxHiUalIXS3VkxhNVOVHkCA6XNolyQv9XfSAuvuHwsRCdFlXi
         jec+XOnb+TKPjqGaYKr+ATw21tdBV89iIOwaLUmr8Brbe2voDICV2EIhO3PTDSWgk65R
         noLA==
X-Forwarded-Encrypted: i=1; AJvYcCWaufDo5trk6E1ZZ1z9BE3un8pOguHJwJVym8a9fwvfGB/1bj9v46ygncjfuX807ceqgyicytLzExYLaO+I@vger.kernel.org, AJvYcCWrX36nx12zteO0MdgNgkDJsh07uzKsFwbjKHmoD4QtOT9vUCdR/TvF/Uvdz4gmNsn09zVuUOYLoXhJgdI/@vger.kernel.org
X-Gm-Message-State: AOJu0YwUm4fRZpv40m35CLz5342AyPKr/6Jdv0IDbAlIeESDWCWlgonv
	1qPQchQhUTotSgDICLetDisSyAjusP8+29qKQs2cQ+8RmlzfQxYXsyIK0bxKCFo=
X-Gm-Gg: ASbGncvFooZlN4thqZCdLxCcQVEBDlLnqKOnp9cLR09GBwMuYqLDXUtFamcY2LhkRMp
	B8dV92N8rBjNrj6OtW4V8yEF/uGvsP4Tt+lvaJ4wpU8pQVPDTRabWWtyhQ+AWaPrTY2yj4E5aOf
	IP4UgeT1scbKBsgh2yaKdCKf9MUvgZ5XMWDJAhh8CcUCnLV2aXG1bvYNBltrwbHz3JztIl2SS0U
	hiKO99yBArPWQvcXJabu/n+o4tXrj7lCdcgJapijsOjF43ikrpg+3bm9u8aCe8wAUdzRZx3TYpV
	KkvdimH2dukaJ8MWBe7xG6AgDe97OggjN/GCJXwO0UCWFH8=
X-Google-Smtp-Source: AGHT+IEzS7RuQM+JXTxQhuUASOr5aQ5FuO0AY24LlH9uKFE9DugCkzr8JbnEOiJvoEsrDVG0ljh0UA==
X-Received: by 2002:a05:600c:6a16:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43f415d29a7mr72789265e9.14.1744640398599;
        Mon, 14 Apr 2025 07:19:58 -0700 (PDT)
Received: from noctura.suse.cz ([103.210.134.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f23572bb2sm178143515e9.29.2025.04.14.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:19:58 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
X-Google-Original-From: Brahmajit Das <listout@listout.xyz>
To: 
Cc: jlayton@kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfs: fix building with GCC 15
Date: Mon, 14 Apr 2025 19:49:43 +0530
Message-ID: <20250414141945.11044-1-listout@listout.xyz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the Linux kernel initializes many non-C-string char arrays with
literals. While it would be possible to convert initializers from:
   { "BOOP", ... }
to:
   { { 'B', 'O', 'O', 'P' }, ... }
that is annoying.
Making -Wunterminated-string-initialization stay silent about char
arrays marked with nonstring would be much better.

Without the __attribute__((nonstring)) we would get the following build
error:
fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
...
fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Upstream GCC has added this commit
622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
about truncating NUL char when initializing nonstring arrays.

[0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
[1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455

Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/netfs/fscache_cache.c  | 3 ++-
 fs/netfs/fscache_cookie.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..ccfe52056ed3 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,8 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE]
+	__attribute__((nonstring)) = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..c455d1b0f440 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,8 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR]
+	__attribute__((nonstring)) = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.49.0


