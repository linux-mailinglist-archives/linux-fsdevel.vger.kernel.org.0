Return-Path: <linux-fsdevel+bounces-8497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96952837CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 02:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6F31C220D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FA157E6E;
	Tue, 23 Jan 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KxLuwfNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D2157043
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969732; cv=none; b=nsUXSmMDRya0mVkc+ZU+Zpx+v1L6VtOrkLxeeRAdQ6xaViyebAvQRvbcE2TLV6AzVuOwqSB18F6v0y3yahXsYRKEdQJvcNWA+Qg9VY39yOYOLX+cGM2DeEWpkm3aAcwSJ87IhM5lLhYV5ePGvgRHjEg+1iq3sZIEnh8U3AXaekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969732; c=relaxed/simple;
	bh=PmD97Weq3WllHYy9c/D1C/9IrSV8qUdF4whlDGfFZE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i56M027RTbAh/Y753Mpcu7GXHfEqx86Rji0OTNwjDNpVwwgsXMiKziZS0M9PrW0nwdqWmJt63BDg+osvcCjx+hJiAsmXg4n+C1c3J3VAxkV6Us/uT3IuKL6Uz0tcrcW4YrCjD4CPstu/+homxUvjKm0NAb/Fj0rWG63XiWeO0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KxLuwfNe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so2839238b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969729; x=1706574529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TGYFkY09Xk6GAlz0uNRUAdH36K12Z/wH1iFNj2bT+k=;
        b=KxLuwfNeRJ+hmFoGPgKZdlSk+AYoOwcnwNz/P+4GZsPoSKEZ9HNAHLvM+HANHQRZT4
         IkXcv9H6RXrMOIwSYUYQinVC0WWTcub5AISix0D2fUXvIdSWUUfQmcTkEZYPNnWvb/0j
         MbKKp5qCJvCY3jSKGtEiavNakTz/xerufCI8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969729; x=1706574529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TGYFkY09Xk6GAlz0uNRUAdH36K12Z/wH1iFNj2bT+k=;
        b=OrjYEcA22NfHoKGik13N5D+ASCzp30fOb7n1cZZp0pUwK8TUyaZPRUEnDKM0i+4Ug9
         pjutNyrgq+AACYo8HrusfLcYfXf0PzX2AuZzjvhKeLU5qRs1ZQJNlqgshx1FfvWpXLxZ
         LLf3kyprDDU30dWj6iO8zsRXJb9Fa/luhfXRz5AgwL4xDq64D6KbEuXTbXUw8FYyDFkz
         8/LD69sHDebliLqeF+uj2S4PFnc0BYq8bNE0Wijab+ef9fOKvoXZof3g16I+sUZlPMLW
         YF17o+NQsaz8F3NNH/UIwfU3kd7iwKIHFYe4je8kSgj+EFVpoGx/H/3WjchKvtNrOgVk
         QEBw==
X-Gm-Message-State: AOJu0Yw531W7ffVnXI1PmNWrXfLkdCqfXUIkFTvjvXej4KKTtaYnuCcA
	/s6QaTWHlq60AwlPmwJ28fmsLIhAVXyCaS/3Aes87dl8cOhZ7c04Pz6Qvfxg0w==
X-Google-Smtp-Source: AGHT+IEfA0xPtU78X5p9h/WA+ZnUOTlNVoIOWKUAiv95UE+kyy39ruCd+kJ3jzTf5eQRZGjVvYX/ow==
X-Received: by 2002:a05:6a21:a59a:b0:19b:5b08:1f4b with SMTP id gd26-20020a056a21a59a00b0019b5b081f4bmr5434332pzc.15.1705969729702;
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00130300b006d9c216a9e6sm10138528pfu.56.2024.01.22.16.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/82] select: Avoid wrap-around instrumentation in do_sys_poll()
Date: Mon, 22 Jan 2024 16:26:44 -0800
Message-Id: <20240123002814.1396804-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641; i=keescook@chromium.org;
 h=from:subject; bh=PmD97Weq3WllHYy9c/D1C/9IrSV8qUdF4whlDGfFZE8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEytnksz1bThGRY5DK5TacZnS6Yl60KDnSM
 2MX5BKOiv6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 Jsc5D/4y3WYeKpzWOOCxgpOBEmELwR2i5cXRFClXQT8Dh5kznbNc+qjzrcINPA5tfSMCKqksOx2
 waq122UgLgvDs7kGRlptl6E9Kprq6DsDw7wdLfNoA3H+ez8jQf7JMzOFjWisqc+q+jJGBKio24e
 t5vJf6GnubB4mzBH4cZa61OqBJLmA1GNOx2gzWHE7j2iHZt5Iy2clBMGTO3SJukqU+UEfX1LM96
 E6oSsKlWVm1gG+iB/RYC5pJmH5aFoHPKxdNYXiMUR6/fPhx42TmcBw7unDDy1oG+rxPjMPPMZT2
 leZok2gnYc4BwgPfLMNk9ETxLWf+k36o/uDLrgpw/LraN9jvCqUzOUFCpFPD5+N4O0XII2AdJ+A
 tJK7FysfIpkuh80CwTkFnjC8SIOpbkM+mSyJ7PdArgrVe0L63H/dBv6ZlwKDZ5C/XX09BrbP3QC
 q2Yy0UBMTqv1wOFi9U04tsQ5mQ07h1ZuvDzmUtltQobblFJDqZq8WS6mT/pfB26btDsAJ2hBv6v
 YQEZZaUcq9UKzCcx9V1ZRnULm3/5JmndEptvjMNPeJk7dKuVUADDoSQYcb0YgpFZrwk1LSVwvLY
 wjTpDJn01qEVtVti3Y1lPIiR2B4JRJTy/PVM5W6p1kAdrkPJjFXMwq+zftEur4gCaiNYE5uahWZ R3xr3G8bEQBxjAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The mix of int, unsigned int, and unsigned long used by struct
poll_list::len, todo, len, and j meant that the signed overflow
sanitizer got worried it needed to instrument several places where
arithmetic happens between these variables. Since all of the variables
are always positive and bounded by unsigned int, use a single type in
all places. Additionally expand the zero-test into an explicit range
check before updating "todo".

This keeps sanitizer instrumentation[1] out of a UACCESS path:

vmlinux.o: warning: objtool: do_sys_poll+0x285: call to __ubsan_handle_sub_overflow() with UACCESS enabled

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/select.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..11a3b1312abe 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -839,7 +839,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 
 struct poll_list {
 	struct poll_list *next;
-	int len;
+	unsigned int len;
 	struct pollfd entries[];
 };
 
@@ -975,14 +975,15 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		struct timespec64 *end_time)
 {
 	struct poll_wqueues table;
-	int err = -EFAULT, fdcount, len;
+	int err = -EFAULT, fdcount;
 	/* Allocate small arguments on the stack to save memory and be
 	   faster - use long to make sure the buffer is aligned properly
 	   on 64 bit archs to avoid unaligned access */
 	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
 	struct poll_list *const head = (struct poll_list *)stack_pps;
  	struct poll_list *walk = head;
- 	unsigned long todo = nfds;
+	unsigned int todo = nfds;
+	unsigned int len;
 
 	if (nfds > rlimit(RLIMIT_NOFILE))
 		return -EINVAL;
@@ -998,9 +999,9 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 					sizeof(struct pollfd) * walk->len))
 			goto out_fds;
 
-		todo -= walk->len;
-		if (!todo)
+		if (walk->len >= todo)
 			break;
+		todo -= walk->len;
 
 		len = min(todo, POLLFD_PER_PAGE);
 		walk = walk->next = kmalloc(struct_size(walk, entries, len),
@@ -1020,7 +1021,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 
 	for (walk = head; walk; walk = walk->next) {
 		struct pollfd *fds = walk->entries;
-		int j;
+		unsigned int j;
 
 		for (j = walk->len; j; fds++, ufds++, j--)
 			unsafe_put_user(fds->revents, &ufds->revents, Efault);
-- 
2.34.1


