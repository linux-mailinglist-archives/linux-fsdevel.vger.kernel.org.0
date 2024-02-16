Return-Path: <linux-fsdevel+bounces-11891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6398586AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658091F236F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FEB13958B;
	Fri, 16 Feb 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BREFQPUE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF67135A6F;
	Fri, 16 Feb 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115039; cv=none; b=W/ZyNW0UflRYyP/hmXQHFwKevKoSJQBFZd4dYHrOPJYjYpqymjw9GkZzgW6IUMle+qlvhjTNaHqbRtN4kRpq1z4ClT9eEZ9t2oJ08J6FrfRCMbztZ1QiLcwGuh6tMTj5HROpeBLEJtcNk08qnUcL/oJopeVfwM0H/ScVeLTwnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115039; c=relaxed/simple;
	bh=Sq/Mpf4CU1DDxAJaU5smyIB6OI93uNYISckA1rqgEqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iB1ruXJJeSyQXtiVpWlmnoVzK6HCFHMjd4QBpMlOuamQeIvWRME/wgHBBDc17nUNExiTZ0Yc0DrdMtsoYC5p6HwA1LbeP6FVs4d0AQOhqcuH1j1CjmpdgCWEFJOYqNV9KcjGpEBgv/jAHRJ7/KC39Zx79RFpHrBv88yDA6IDe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BREFQPUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DD7C433C7;
	Fri, 16 Feb 2024 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115038;
	bh=Sq/Mpf4CU1DDxAJaU5smyIB6OI93uNYISckA1rqgEqc=;
	h=From:To:Cc:Subject:Date:From;
	b=BREFQPUE+Lg3oFG94/XQbjW6/X+N9Fgw8T5AM64uUsoM72l6MQ59lraq2doPeAmw0
	 gDuJLNl+241uzB2b51z9SyZ4hC6DZvvm8yLd+PNsKAmnUOL68zlMmfjN0bfQWpM0pd
	 Ars2RqyFjk6GCUfQyBKbiffJqgbSCHUu46VLLSCSBmyGaMUALsTwJlygoySG7izBUr
	 6eivxdVnqLOuY8O6W2m+xBwAjiQN5gdxr7EYCRV6hBsrzlx5tWGshcsXdz0XtpvgtM
	 AepxHs04hMDnSrPQU+THAkdsqYO1fmCnnMVMRLhwc6uL3gfRhk411oeGOh0wolXfkP
	 qZaPK+/EP9M6w==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] fs/select: rework stack allocation hack for clang
Date: Fri, 16 Feb 2024 21:23:34 +0100
Message-Id: <20240216202352.2492798-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A while ago, we changed the way that select() and poll() preallocate
a temporary buffer just under the size of the static warning limit of
1024 bytes, as clang was frequently going slightly above that limit.

The warnings have recently returned and I took another look. As it turns
out, clang is not actually inherently worse at reserving stack space,
it just happens to inline do_select() into core_sys_select(), while gcc
never inlines it.

Annotate do_select() to never be inlined and in turn remove the special
case for the allocation size. This should give the same behavior for
both clang and gcc all the time and once more avoids those warnings.

Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/select.c          | 2 +-
 include/linux/poll.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 11a3b1312abe..9515c3fa1a03 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -476,7 +476,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
-static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
+static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
 	struct poll_wqueues table;
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2..d1ea4f3714a8 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -14,11 +14,7 @@
 
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
-#ifdef __clang__
-#define MAX_STACK_ALLOC 768
-#else
 #define MAX_STACK_ALLOC 832
-#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
-- 
2.39.2


