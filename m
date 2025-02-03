Return-Path: <linux-fsdevel+bounces-40632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23775A26014
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A882A166FC1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DD2063C4;
	Mon,  3 Feb 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZJoRKj/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043720B1E2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600290; cv=none; b=Q8kJ0tJtUSl1XrU1VSCt/MIjgIia+hdkvz8zrXVRvxE4msqzvvcFcYfJsfOQWEtkWW+dYJHHNaexesbRNxWsDwENuKWWQQbbC7Tp5LNdjd/ha9v5sKjfcvxB2AKcJYIkIobzV9+MgjE9YxlbFcp6u9KJ2vdfaug0P+uyGwZD3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600290; c=relaxed/simple;
	bh=AJ4EpG+a/HnjEaQKeFR8lZf7Ex4++mtSxvprrt1iy8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmZmbz+LlR5GDGQgph6fr+D97glgUHF9sHJfn6n0pLK8avku3Tq75Lpd3nIQHywQubqfjIYNFRewE0iEnNtrt74P/Utoja/JEsGsSUWp05F239PBJQ/HTfru6Fz+PlCgwX4QRP6lLLKTMA4qCrXMoVpQc+wW4BuxityyULpwpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZJoRKj/w; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8521df70be6so18535939f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600288; x=1739205088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl4I89AW9N+9ZjPLUSwNXzZLneK6YdFoM+i0fKJ0Giw=;
        b=ZJoRKj/wU9yHgIyliRh6uYcJDLsHUg87VbXXz9WrMywx571IQHJSZvPWT+pehE6zwt
         XPJVDW+HJuvBUCcEY3dulA5y+us00W5xVqfja+guAPugN+752p/tYE64d3ZYUFaoNzqo
         bB/O+lZGQ/7RHcdgwEE/LA9ngEG1mXOl+SEJ7UhavRIv+I4huyEKASbtQ7wzEZ9DtQGA
         kIVZ/Q9FtD3miB/DDvoOctkkWrErtnhHBAOgDZPauz+AEJpcmxEqAKxZOV8XDQzVLGPl
         6wCxQv8IGNEUmY+/173HHd8Gac4cbefpo4iWkLJhIEPwk2m+AEO2WJ88Jtr7KOxlbBky
         /Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600288; x=1739205088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl4I89AW9N+9ZjPLUSwNXzZLneK6YdFoM+i0fKJ0Giw=;
        b=IQ75/8mshS4os5TwXE3fiI41DfPeS5XkQVNP+eOCGSpaEg87nomfPllkG8yvWNeHa0
         eW3rzwpB5uJS4h+PCPHUlKOGHzctzP1QbMVyWVr2lOLB7myx/eAAvc6+rUgVQG3PFEYw
         r5a0bI2EI2+mEB5e7huYcLp+mJVMZXpEXKL6RM0t6mfQzooWSKtI5U37HIjDrXnn9F9k
         5zVWtB4Ytb80CS859TqV0z+rKCLbJ/QhqQJ/bQfL68rs/rA37tnQ/+cbqJJHaVSQ+cDQ
         1lOVm2fGgmV6jx9mRsz6oqogd/1Rt6VtqoCnES12RxO3032N3flBL6E2LSnroW5IuEhn
         5krA==
X-Gm-Message-State: AOJu0YwwgtD9cECGSZIRpoFq1PglAr5Keehr7XoBT3EPkWXogjCHNE3K
	q87JidxL/tyIHOdMBpsn3rl/+6qSDQ4jORA3dD8PgoOPSeu0vTcNrved+LdNkKpurGFBrsP6Vpp
	Oy7w=
X-Gm-Gg: ASbGncuY1mOTpyj/IGAE2j3eExlpcL985p7vAMsFD61qvdQqBIU2jY+k3q2nifdQf5P
	7gqvxKkqwCTAcQYzztjho+iyf/KrnOe/JY0XJWPYG69oDqLUnPAy8pJjlOP9I/krP1YwIf9+13g
	6mltLJPDfUH9gz6zxsRFFujOu/1HPTNHB3GLL8M+yUlul3ahUeUJWUCQGl7wjP7UiyuRfdr1pNz
	tYO7eYyvRLe4XFvG6vTVjulcHzIZ1tnPgJ0iRUzklyhfcp+K7EWMLYMAcEZIZUYf8s5id0fGY+J
	Ti18tXCNmRnl9iNbrYI=
X-Google-Smtp-Source: AGHT+IE2WgIanOs+ot0lC6WutrqrC2QvvTTTNdZSFULo/ROZk+MFEGYpcigt6bnj4gvbuMhY+oEQZA==
X-Received: by 2002:a05:6602:3818:b0:84f:41d9:9932 with SMTP id ca18e2360f4ac-85427df1edbmr2081256039f.9.1738600288562;
        Mon, 03 Feb 2025 08:31:28 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] io_uring/epoll: remove CONFIG_EPOLL guards
Date: Mon,  3 Feb 2025 09:23:44 -0700
Message-ID: <20250203163114.124077-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203163114.124077-1-axboe@kernel.dk>
References: <20250203163114.124077-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just have the Makefile add the object if epoll is enabled, then it's
not necessary to guard the entire epoll.c file inside an CONFIG_EPOLL
ifdef.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/Makefile | 9 +++++----
 io_uring/epoll.c  | 2 --
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/io_uring/Makefile b/io_uring/Makefile
index d695b60dba4f..7114a6dbd439 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -11,9 +11,10 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					eventfd.o uring_cmd.o openclose.o \
 					sqpoll.o xattr.o nop.o fs.o splice.o \
 					sync.o msg_ring.o advise.o openclose.o \
-					epoll.o statx.o timeout.o fdinfo.o \
-					cancel.o waitid.o register.o \
-					truncate.o memmap.o alloc_cache.o
+					statx.o timeout.o fdinfo.o cancel.o \
+					waitid.o register.o truncate.o \
+					memmap.o alloc_cache.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
-obj-$(CONFIG_NET_RX_BUSY_POLL) += napi.o
+obj-$(CONFIG_EPOLL)		+= epoll.o
+obj-$(CONFIG_NET_RX_BUSY_POLL)	+= napi.o
diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 89bff2068a19..7848d9cc073d 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -12,7 +12,6 @@
 #include "io_uring.h"
 #include "epoll.h"
 
-#if defined(CONFIG_EPOLL)
 struct io_epoll {
 	struct file			*file;
 	int				epfd;
@@ -58,4 +57,3 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
-#endif
-- 
2.47.2


