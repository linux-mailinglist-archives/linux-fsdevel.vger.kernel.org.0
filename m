Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6B2F23FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbhALAbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbhALAbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB8C06179F;
        Mon, 11 Jan 2021 16:30:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d9so498327iob.6;
        Mon, 11 Jan 2021 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAMxIDbTziLFJUvywaK2ZNZ+Q4hesEIu8XKmRJ1p2y0=;
        b=gmi5u04GjO9Ds2D4RL79j/1jn+HXdk+n4+O7fdPDvf7a/9eQqWsZxbMmZciHI1csvC
         2pfMethWqgC5lEqxos+6FCcLOc0B8fqf/UY5by+jz5iMyd2n3vrDd3TyjYUoo71jzLxY
         zPY/58p0lSwPjxzf0gumnso1h6rwGBn81yiyKajGuIPOU92E2QtHG5wSpbq5cFkJRaZ7
         I0QODVkUWTNNjqaLfwIP6vFRptZA/bbVpjakIjtWKR0OfAxqrj6Bl7TRbm8kvoy2Hsc3
         P5tjKt6PXZezm83BjGqNgJzXb5LYCyJlLQ3IIxsLtspWQLwE5YimbAOkYIQ3HDjE6IDl
         2d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAMxIDbTziLFJUvywaK2ZNZ+Q4hesEIu8XKmRJ1p2y0=;
        b=lAhV4+m226hdPHCUWRJFsWsneY5l+Uaplf9Am2mB0XTjZQiQ0vveMmh/3ajvjz0+9R
         MZBa/B1inmLR7N12XIutb3r9AUL8keU87BUtUJU+CPktzDseVwilgGKCNzssH8FX1MP2
         Wlyrg281sLIeTa4nhXmIWlZaHlQDTY6V1ZlHbhzITZgGak8D8Bg/e6z0Qr+WdPBssD97
         9Q/qpE44Uic03yuoex83oK2ApdqvWcyYcjSxhLobmPBZ9ExC8sIs84z7/2rpf1LNLhEA
         j9eHMdu8jxVA6CSPqbkmn5uzP7N6RsdZ0xZrNB94ySf7Gpd7UhBeeGuVQ32qmkTvD0V2
         G2BA==
X-Gm-Message-State: AOAM5334bfzOrhym2UVJR25W2FlLRlb7BuwmnQGJ1TO1S0zGKxxokmRH
        u1V8cXIcjZCKH2IACsHGNxu6s700sjU=
X-Google-Smtp-Source: ABdhPJyPPKTIeR5EuFUFOku6/rJjWP/q97RCtO7qqv7/gaq4ZM1vr1ax14hdkaPqPKYOQ3mMknVYhA==
X-Received: by 2002:a02:2ace:: with SMTP id w197mr1926451jaw.132.1610411426160;
        Mon, 11 Jan 2021 16:30:26 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:25 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 4/6] epoll: deduplicate compat logic
Date:   Mon, 11 Jan 2021 19:30:15 -0500
Message-Id: <20210112003017.4010304-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Apply the same compat deduplication strategy to epoll that was
previously applied to (p)select and ppoll.

Make do_epoll_wait handle both variants of sigmask. This removes
the need for near duplicate do_compat_epoll_pwait.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/eventpoll.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a829af074eb5..c9dcffba2da1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2239,7 +2239,7 @@ SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
  */
 static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
 			  int maxevents, struct timespec64 *to,
-			  const sigset_t __user *sigmask, size_t sigsetsize)
+			  const void __user *sigmask, size_t sigsetsize)
 {
 	int error;
 
@@ -2247,7 +2247,10 @@ static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
 	 * If the caller wants a certain signal mask to be set during the wait,
 	 * we apply it here.
 	 */
-	error = set_user_sigmask(sigmask, sigsetsize);
+	if (!in_compat_syscall())
+		error = set_user_sigmask(sigmask, sigsetsize);
+	else
+		error = set_compat_user_sigmask(sigmask, sigsetsize);
 	if (error)
 		return error;
 
@@ -2288,28 +2291,6 @@ SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
 }
 
 #ifdef CONFIG_COMPAT
-static int do_compat_epoll_pwait(int epfd, struct epoll_event __user *events,
-				 int maxevents, struct timespec64 *timeout,
-				 const compat_sigset_t __user *sigmask,
-				 compat_size_t sigsetsize)
-{
-	long err;
-
-	/*
-	 * If the caller wants a certain signal mask to be set during the wait,
-	 * we apply it here.
-	 */
-	err = set_compat_user_sigmask(sigmask, sigsetsize);
-	if (err)
-		return err;
-
-	err = do_epoll_wait(epfd, events, maxevents, timeout);
-
-	restore_saved_sigmask_unless(err == -EINTR);
-
-	return err;
-}
-
 COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 		       struct epoll_event __user *, events,
 		       int, maxevents, int, timeout,
@@ -2318,9 +2299,9 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 {
 	struct timespec64 to;
 
-	return do_compat_epoll_pwait(epfd, events, maxevents,
-				     ep_timeout_to_timespec(&to, timeout),
-				     sigmask, sigsetsize);
+	return do_epoll_pwait(epfd, events, maxevents,
+			      ep_timeout_to_timespec(&to, timeout),
+			      sigmask, sigsetsize);
 }
 
 COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
@@ -2340,8 +2321,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
 			return -EINVAL;
 	}
 
-	return do_compat_epoll_pwait(epfd, events, maxevents, to,
-				     sigmask, sigsetsize);
+	return do_epoll_pwait(epfd, events, maxevents, to, sigmask, sigsetsize);
 }
 
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7-goog

