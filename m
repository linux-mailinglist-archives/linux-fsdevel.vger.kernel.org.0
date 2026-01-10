Return-Path: <linux-fsdevel+bounces-73115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8505D0CE92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D9F3067658
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D5284693;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D8udur4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3B21CC59;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=utQ4CjZLa1WyNRTjfEY4X4wfrYP7HMEEDdMx64O/4vaTk+f3hUJEFvdgQ15AoeyPtJJthDZi4qRmpZTTleYc1KTCx+3pV1IhybDYInxzAQ9itYW/R5ePy54xKl4XWGpOdfAFQjAEBlq8e6fb83PAuJUE3wRR/VSxc7kCi3d1SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=PHiqAo8sfETc1EUDjMcxffd+xcaTBy5CaEWJ25g7Pv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVpxdjbIjdZgf9ePflxKIOrg0Fouu+fFz0Nc0LCWGN2yZwejIv+o6mDuAjwNhC8f+MKSL8yR8JCyKglF6ZIMZ7CxyGcODItduNvLQrEu/18aYg6SF0Sz+3/hTSC8JlFS5Nau2RJDLS0XUQ3qZvbnsSWkXBKoQCMJ8HRx4Jyr5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D8udur4h; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NYQE0/4xpxjm8d68deKwDm3nKFoSSIOI589+d+MkqSY=; b=D8udur4huObW0MeP2JD6P+gkIU
	SeFREtW5He2AXWOlxBjfeigmkmEF53QTJmJUzNh7IDQh3PHtwQg4A5AXBUUv6GjfnZlBt+WcJkVg8
	YKdX97Mm1CugfdSPg3qM6Wk3l+aoysR1sXWj6d6U3lrFF/vJ3lMvrr+kqxZymEAVmrKEmfk8RRE/g
	co+NMA+99yF9cshfrQlFS6mnZ/zDYCFVyw/FjAvGbuNza6QvjOA36iDXrLf20r7/kANoHmlsYG3nG
	Ag1HnDnZndRzj1D/IMAt4lmQid3tIeOG/9qNnpmZP+h3wdLuQySYSVGKMvyHk8yZUvdNE/rDWUVM/
	bl+lQdPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB8-000000085ZV-3ZAL;
	Sat, 10 Jan 2026 04:02:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/15] turn signal_cache static-duration
Date: Sat, 10 Jan 2026 04:02:07 +0000
Message-ID: <20260110040217.1927971-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/fork.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ddd2558f9431..23ed80d0d6d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -465,7 +465,8 @@ void thread_stack_cache_init(void)
 #endif /* CONFIG_VMAP_STACK */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
-static struct kmem_cache *signal_cachep;
+static struct kmem_cache_opaque signal_cache;
+#define signal_cachep to_kmem_cache(&signal_cache)
 
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
 struct kmem_cache *sighand_cachep;
@@ -3024,7 +3025,7 @@ void __init proc_caches_init(void)
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT, sighand_ctor);
-	signal_cachep = kmem_cache_create("signal_cache",
+	kmem_cache_setup(signal_cachep, "signal_cache",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-- 
2.47.3


