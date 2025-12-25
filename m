Return-Path: <linux-fsdevel+bounces-72091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3793CDDB2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFD130124E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD393195E6;
	Thu, 25 Dec 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gsSdh1H6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A22E5B3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766660608; cv=none; b=L7Oq3ya6BpwxrknLSICZe5J1V+NHvgoIeV/y+ctmGuTIdrLJ4isKC73XsKWSPHlkcs9Q8NQJ/krjuI/7GSgy5UZwb+gHCYITsQIE620kBLvcjWSu8hX/TF39iykggmkR7a56SyZzVnXPQCvWYNx/Ip1fvdqzH/qkAjgjoBkHVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766660608; c=relaxed/simple;
	bh=tI1Ypizqxx8Gds2Tmljnz8yWDwROFZD/XML9Err/7Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaUEBdFRVQa2lBPbY2OWs9Mg83lODA1owu34I6LOiChONL6TmVbosxdFP1778HRDc/tZvxSPibsdL1GuzVuzVWto+BTJ7hbU5K8ZH/it4RJKhd1mgO9XldHKLXm2qhysDAQS5hrDObOYvwYcjga9og2A77eqeUJ4lxrziVmnTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gsSdh1H6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a137692691so75390205ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1766660606; x=1767265406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOfAb/cDxM0z/UBeWl882eHVeaGsbb539Q/v1BEVtNA=;
        b=gsSdh1H6QuKsQ6esysbuGI+Pl8pOo5x2iqFd2r4OAu9hrpkmOCsrL4slQU4p9XVHFo
         Y7gK6zRcsfaDuWsiBgal3sOoSwckboEPAiAcNC0bbAHeioJj7OQVxA/mPWg89y6XST+D
         wGFQFjTQetTrxXgJcN9WH9z0dUATgiqtQHN7vXkBNBU8BnPqg70ia03YoV+9/ExZ7wed
         v6XsXKhB/DA7FSTwdOjT9j5UmL4Dvmf7d4Hhb+DVha3QN1xU2oNwEpMO6GYOHrYVTMmf
         aVMgKBwG3/iIXhLZ0hotLfGg0u2nNxe3pvkbRbxgh25/D4xdzYcKPP0NnVqBPurgNsOR
         ZcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766660606; x=1767265406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOfAb/cDxM0z/UBeWl882eHVeaGsbb539Q/v1BEVtNA=;
        b=aZmUZP9GpmcKDeXXGfiiw21r0nXqq/Ki8JprmjTCkkZY/gxuDfG6N6tcrflFnVnYj/
         hAAd1ccRDyAfhIsrCk8oZyl8PvHrwD7UrFRJrpocuRIBpQmbCFdgmitaWmreyaKkdkHm
         sahMa173KctrpXUhBAl2Y4CQ6NojzkRaFA6LAkix7oudgTte70/vkOI30aI/VuwrLo8i
         2oMA/VYQDrxE1y3NS58sH3/VTJPZ0cjG6Vwvzn6h7pNhxXoffleDQAZl2zh7b8VrhP9O
         edR06bU3AvIi9hA9E5Ma+Wa7/bK9Tnhy3ZzlqiKmtObw8di/5/hF70ICdElrF0NeZpdH
         nWJg==
X-Gm-Message-State: AOJu0Yws2P0uMhTL6RLGkkyGaq7NK/BbqPOsaixGsEi0HPtajq0nWwb2
	CQQMHfC4XYvY7i4NfQRFrNHBlhZAd9JxPU8iMJKiAtMu8MpEAkDCFJmZHJBmEm6H4Qc=
X-Gm-Gg: AY/fxX4qkcph4+qlpzbC06WgZ3rPVBEi6q6OEKXoEr3zTFeODkJn07rZ0uqJHxzBtCo
	1TADMF72l4aSpQpy0B2uqzq7RYpy4CLCUg9q2nbN0CE8hKc4S52zfhcQJyD1bGBA+muFiXzWZml
	e8xq5nRcBiynDIrZtAp9YORQvhOl28yQwYDd6k7U6MrDP1wxjENka6IwyPnE2XoKj63FD40hwf3
	IWGb/LjZGsQUxWaFjxwwm0dfA+MRgqgyrOfa4BDuQzQ4RYu57FibSxnDblfVdsH4XFBMlU7Wjik
	CWQVB1bh7mb1Uz2cxC5YJNBrY6IZbmP8bANjO5+QkB7s74Zyy5XpzCzIL6el0SeltOLPi5Cj+pm
	RJ39i7lqbhf/1HXC99qBttP6ZBG6xxtuSFPVgmjFMb0Y7iJ/b+ngQLYRevRkHtFIukIchImxWdO
	S8EXrfSQALXp7Utl0/YJQqWU+Div6UGlpGM98aJkjLCDeZdWVe4g==
X-Google-Smtp-Source: AGHT+IH3XPmY+UAPzt+NqHa7fMAWWV3ZVFeTsNmlT8QpIftTwApy1z3U7dbB5m1U13R9cBXmkgm1LA==
X-Received: by 2002:a17:902:db0e:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-2a2f2736c0emr201540755ad.38.1766660606273;
        Thu, 25 Dec 2025 03:03:26 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e92228b64sm17825760a91.10.2025.12.25.03.03.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Dec 2025 03:03:25 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Geng Xueyu <gengxueyu.520@bytedance.com>,
	Wang Jian <wangjian.pg@bytedance.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] fuse: fix the bug of missing EPOLLET event wakeup
Date: Thu, 25 Dec 2025 19:03:18 +0800
Message-ID: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users using Go have reported an issue to us:
When performing read/write operations with goroutines,
since fuse's file->f_ops->poll is not empty,
read/write operations are conducted via epoll.
Additionally, goroutines use the EPOLLET wake-up mode.

Currently, the implementation of fuse_file_poll has
the following problem:
After receiving EAGAIN during read/write operations,
the goroutine calls epoll_wait again, but then results in
permanent blocking. This is because a wake-up event
is required in EPOLLET mode.

The modification idea of this patch is based on the
implementation of epoll_wait:
After epoll_wait calls ->poll() for EPOLLET events,
it does not reinsert them into the ready list.
In this case, ep_poll_callback() needs to be used to
reinsert them into the ready list, so that the behavior
of EPOLLET is consistent with that of non-EPOLLET.

Reported-by: Geng Xueyu <gengxueyu.520@bytedance.com>
Reported-by: Wang Jian <wangjian.pg@bytedance.com>
Suggested-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---

Here is the reproducer for the bug:

1. Change libfuse/example/passthrough.c's xmp_read() to
   always return -EAGAIN and mount it on /mnt_fuse. 
2. Then create test file:
   dd if=/dev/zero of=/mnt_fuse/test_poll bs=1M count=10
3. compile and run the following test case.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/epoll.h>

#define MAX_EVENTS 10
#define BUF_SIZE 4096

int main() {
    int epfd, nfds, fd;
    struct epoll_event ev, events[MAX_EVENTS];
    char buffer[BUF_SIZE];

    fd = open("/mnt_fuse/test_poll", O_RDWR|O_NONBLOCK|O_CREAT, 0644);
    if (fd == -1) {
	perror("open");
	return -1;
    }

    epfd = epoll_create1(0);
    if (epfd == -1) {
        perror("epoll_create1");
	return -1;
    }

    ev.data.fd = fd;
    ev.events = EPOLLIN | EPOLLET;

    if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) == -1) {
        perror("epoll_ctl: fd");
	return -1;
    }

    printf("Epoll is monitoring fd=%d.\n", fd);

    while (1) {
        nfds = epoll_wait(epfd, events, MAX_EVENTS, -1);
        if (nfds == -1) {
            if (errno == EINTR) {
		continue;
	    }
            perror("epoll_wait");
	    return -1;
        }

        for (int i = 0; i < nfds; ++i) {
            int current_fd = events[i].data.fd;

            if (current_fd == fd) {
                printf("[Notification] Data arrived on fd\n", fd);

                while (1) {
                    ssize_t count = read(current_fd, buffer, BUF_SIZE);

                    if (count == -1) {
                        if (errno == EAGAIN || errno == EWOULDBLOCK) {
                            printf("[Info] Buffer is empty, waiting for next event...\n");
                            break;
                        } else {
                            perror("read");
                            close(current_fd);
			    return -1;
                        }
                    } else if (count == 0) {
                        printf("[Info] EOF detected. Closing.\n");
                        close(current_fd);
                        return 0;
                    }
                    printf(">>> Read %zd bytes\n", count);
                }
            }
        }
    }

    close(epfd);
    return 0;
}

 fs/fuse/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2ba..025eea58232c2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2735,10 +2735,11 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	FUSE_ARGS(args);
 	int err;
 
+	poll_wait(file, &ff->poll_wait, wait);
+
 	if (fm->fc->no_poll)
-		return DEFAULT_POLLMASK;
+		goto no_poll;
 
-	poll_wait(file, &ff->poll_wait, wait);
 	inarg.events = mangle_poll(poll_requested_events(wait));
 
 	/*
@@ -2764,9 +2765,13 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 		return demangle_poll(outarg.revents);
 	if (err == -ENOSYS) {
 		fm->fc->no_poll = 1;
-		return DEFAULT_POLLMASK;
+		goto no_poll;
 	}
 	return EPOLLERR;
+
+no_poll:
+	wake_up_interruptible_sync(&ff->poll_wait);
+	return DEFAULT_POLLMASK;
 }
 EXPORT_SYMBOL_GPL(fuse_file_poll);
 
-- 
2.39.5


