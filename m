Return-Path: <linux-fsdevel+bounces-41313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E7A2DCB3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1636018868C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E6190692;
	Sun,  9 Feb 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoismmyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EF1684B4;
	Sun,  9 Feb 2025 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739098575; cv=none; b=rlKhosSqRH9brfgfPJlupqeooRm54TVXwK82qblXm9F/vgJOmDf/0+DoxtLW5i+i+HgMaXrtUqZCeqVnddocHj3jjl9eGgzC2+peyvz7deSdkt8xD6mW+iD0aFlLsGJcnBewAXj5nMrRWtsrr6ukK2ulr95OtxrPyhaOr3JPjSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739098575; c=relaxed/simple;
	bh=LNRBaLU6n3SSswnYQMTXgXBJNyg5anDMPmBQtlZCdYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnoZo5yCgA80BmBqGSHMw5BibOExXQtO4cG25JN25G5e6Li5j5xFqtKhJl8WHh/mWwMOpbR61Vfr1qF1ZsPPzEh7xE7n7ovg8iqBaGBLs9eMwnW4vI5bt2++CDpS0uAgNXSk6AWRyw79O5iVqq+0SEY8tMuwfuIovp7S5hWaOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoismmyF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so2264903f8f.3;
        Sun, 09 Feb 2025 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739098572; x=1739703372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuqNM4OrcH8qX6ei9TmPLzMmYDM1c1NblMlEWwW3XBc=;
        b=XoismmyFKKSKa7E1YzfQuhpiPD92kCgiZNPfrsQ0tViJfokpU7UtIc7og0PklWLpv8
         lR22xTWea/qpM37AfmhyMGFDsRcVMO1QpXb97rlnrR5Z53in/GdpS1xF7TwImEVooPHi
         DZe5fzQJh3k5TtyoAsq6MT8Juw+/ZBzeSH3ClYm8f1sc0eoOeJGaAuIQdUgV0GQ3vCu1
         i+emfb+zvrF0SJVfuTYjO3ArYDtb/YHksqw+CCXCXJoOrpUNNJItRdq6Z7Bf46iHerka
         O/Yxg58nL6VsNwGgafVW+c8nR4/d0Bujdl0QG8Qv04s8qfSx+QJqWuck1eEbjOHMbgix
         bAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739098572; x=1739703372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuqNM4OrcH8qX6ei9TmPLzMmYDM1c1NblMlEWwW3XBc=;
        b=jvxOk+yaVOvEmR4teGrkWNUd3yIclnVxzfe+PMANI659THI+CtLcFJOlu37z7aBtMa
         kExeXPw4TZA2nXkzRhkXhMqJ46Ywoeu/6OeqKDwEmvq3Uc997suz7mAsOkyAFRteeR/H
         Wmnx0zPEAckp3p/Ltr4pXFRTY9O/3Y4ZzErDTVcPWwiNxsLuRoI38RI/65I6YZuTzvmn
         +GGZYoRnSHkd60esngjIvQjPxPD0MOeNg170bQkI1iIhhzwiDAd3lgsBjEhbNo6ssOG1
         bDjVp6HnU8dyKbBQ1vJw3T0NXe+nBhJ0nsY5OBaq3oYZXM8Qppw/kagxYVxN7NvdSyra
         eZQw==
X-Forwarded-Encrypted: i=1; AJvYcCUW5xvIkkI5HdHjovlOgGq3BcfPe/jLrHkow91tFm8YpP1pucpaEzPUOryJUfFC3wghcPTlpzsU78eV/N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWaiXgvPWkPN/gwufyw2WQTEnAIorjrqByna1n0b89ZZcc4Q14
	CbQN4ctruKzXXQNIB0XGIzLfuQmvzTzBzyEZQ+uNkZyfXR565gBKXsZf9Q==
X-Gm-Gg: ASbGncvmU4lzfMGsZW6p/rev9CWK/6EBG6YXwuMTlxb4ZmAMr5NSGqzOdYlJflnIL+p
	iRnCHBhEPn0mLu0Ntg4i/4aPSxoznbPN/lOT1iB92ccZhZeC6Op/ycdBZF2Cc1ZiDwgUr8ft2kF
	wVOvfJhdfUJN2aFFbv5jLC0MOHOGl02UNsgzduusKUphPPmhF9FtIjBaDLRAo07ux/uENDvAwbS
	ZTC2XrxMfodwqHhhp4/qdvBFaj8ZMPxLHjlYcvARNDMvaPF23/Dk2KoBWT2X6tCZh2V+uJqTxSa
	ulfagsD7T+liTbSwuWsq+AM/YpbiC2uYrLZkxBVbME0arjEBzi6BvcDXEmOts+n6mSKzO2QS
X-Google-Smtp-Source: AGHT+IG5+0w3d+vA8DrljBFuEDJlBTRXom8zYj1WGrZaU1rYNUcVtb+uklcUd37Ibmt6WpDnmBRu/w==
X-Received: by 2002:a05:6000:1549:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-38dd0cb7163mr4534918f8f.14.1739098572307;
        Sun, 09 Feb 2025 02:56:12 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb781bdcsm6325791f8f.23.2025.02.09.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 02:56:11 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 2/2] fs: Use masked_user_read_access_begin()
Date: Sun,  9 Feb 2025 10:56:00 +0000
Message-Id: <20250209105600.3388-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250209105600.3388-1-david.laight.linux@gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2865baf54077a changed get_sigset_argpack() to use
masked_user_access_begin() and avoid a slow synchronisation instruction.

Replace the rather unwieldy code pattern with
masked_user_read_access_begin().
Make the same change to get_compat_sigset_argpack().

Use masked_user_write_access_begin() in do_sys_poll() to avoid
the size calculation and conditional branch for access_ok().

Code generated for get_sigset_argpack() is identical.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 fs/select.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 7da531b1cf6b..abe2c1a57274 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,9 +776,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
+		if (!masked_user_read_access_begin(&from, sizeof(*from)))
 			return -EFAULT;
 		unsafe_get_user(to->p, &from->p, Efault);
 		unsafe_get_user(to->size, &from->size, Efault);
@@ -1009,7 +1007,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	fdcount = do_poll(head, &table, end_time);
 	poll_freewait(&table);
 
-	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
+	if (!masked_user_write_access_begin(&ufds, nfds * sizeof(*ufds)))
 		goto out_fds;
 
 	for (walk = head; walk; walk = walk->next) {
@@ -1347,7 +1345,7 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
 					    struct compat_sigset_argpack __user *from)
 {
 	if (from) {
-		if (!user_read_access_begin(from, sizeof(*from)))
+		if (!masked_user_read_access_begin(&from, sizeof(*from)))
 			return -EFAULT;
 		unsafe_get_user(to->p, &from->p, Efault);
 		unsafe_get_user(to->size, &from->size, Efault);
-- 
2.39.5


