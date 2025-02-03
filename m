Return-Path: <linux-fsdevel+bounces-40631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C9A26012
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BAE188392E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099E2B9BB;
	Mon,  3 Feb 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jrRD5HS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3720AF98
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600289; cv=none; b=hqx8fBhuF9nPfHRQp49K2ir7yR9APookyAPnl4lNeqMxCKMwf2fYk/QizCDhbuyr4/mE5HLZfQXSl4aBgVmmwcCDPvjufgXgrwg0T3sbpdOt8kPyGOshSnBTdoSjsO+NxcvWR0owWljcKvHZ1a57PbNmo2yQjNKndPF0H6SGzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600289; c=relaxed/simple;
	bh=Lq/TvPbkX+M9fh/ofSu3jq3ZsdO0u7WjpsDGycNAOmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBhzphVCyEMP1qvWjclat/Dlz5gpbuPFoQcVcFq1IPmYakFQrv4RNvRtbWAOSVd8G6XznXWjRiTlI91nGrtvWdDWFxeFHPitOYh06uBsGGmCI9Vpmjuq/txoNQL5niPtkw0bCHtiP3YaDofIu8I3RDjecrevWPANaVJE2ZtCVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jrRD5HS6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844bff5ba1dso323629839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600286; x=1739205086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enUf4uTUQbLHbQ4xi6ZoCFVbZFlA1oPnBMw51mV/SrU=;
        b=jrRD5HS6ruoBQr6xrBFCc2xTCKlY30qqKQnFsx331WjgeN6lVA/6GLIteTbpQzaAow
         87fQ85L/EgsPXg1hfVcblsMPMup1JNYQ46DwzxEpM1ByGSHEogjQ64lxC5jtJdPDHkAp
         2iD5LbU3nr31spW0WBkis7/DnXLz9D/D7ygLRJVcWWpboJBKKDcHU+0vSw/kLqFaTZgD
         9Kp6NbeSYs8MYNIhz14Q4qfiBogUgv9Iiw2rfuPxZ8UQTYVtEE2nAN2zDJ7bSm2tlJcN
         rPI9ENrhRXRKx585D7sz4g/ZHunmPKLCClIKTj/EyF3L8Z1Jl9sQsZFdM7AXKQtM7nZs
         9lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600286; x=1739205086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enUf4uTUQbLHbQ4xi6ZoCFVbZFlA1oPnBMw51mV/SrU=;
        b=CdgbHbUutd/DRzQwSkMWGsIpCD/yzBHDSYscm/GnkCxZ5OcRCQgAWQGlej5TjXXeBX
         x3MYlAOAOUXHKjmfNhAbdYwnNiuTK+Nbpd/1nq/Eg6iANJxDBUYrOxW6hZitI7mzor4f
         7dLTjHAqKt+rHThks76SxD3gGnjEeXhsK2iZ1gzuz6DDhbyWUrk71+99hNYzztJ5UIH+
         BkAuuXVJ/JiZ9wqrhKlSy/cBwGBJkmyNbBTQeU6/TL4042U1PrVZKdck/BltXy2krjEb
         FITWYixkoanj1jSw5M6NkDCqe5PBxCyIq68TBsFk6sFiXDsHjTlaE5zrcvsocBXI/J7k
         qJvw==
X-Gm-Message-State: AOJu0YxlET/gIwlY4p6Hw3tiEkMoxBYG0d8BB+vrUH+Xv1IeaXq1ikIl
	YRGjLMclaFFTdPOi+q0Lju45xX0YZ4dtXhYQfnDOaS/jpO59Bm04EJXd8GV9BPE=
X-Gm-Gg: ASbGnct2kp2yCgnKhoU5/7KbOuNYitoPTD0sY2QQ24tMNzQl0AyGHjIpSZ9chaIHYn3
	qlNWb0piFleS/8xHkctyF0PvO9VrLZbqTYeX5Cmd86gRo0hJrzjIVNeJ4wbWhoMX6ff+aUwUfF7
	Rf9CRGpdI6PhYNbMUFe/ffpPQz0e/v98vwTG0dV1F94CrpInnTYpOiNbx/4FuCqki+mcgu0vZZD
	jJsTlFUKTVSrmosP+NyD9gK0mQX4gsU44YZB+/oflQxqvFtS5KxDJmU6gC3r5/e6mrSxeuTMSmL
	RsHba7zfrH4HcSKnd4Y=
X-Google-Smtp-Source: AGHT+IEN8YdHjbZSshkK/29Wg0w9zSZQjrmgFR62n7cchB5dhcuaotu1SUwqJVpYktG/j/+fEnd5+Q==
X-Received: by 2002:a05:6602:4019:b0:82c:e4e1:2e99 with SMTP id ca18e2360f4ac-85439fa26e6mr2051968639f.11.1738600285975;
        Mon, 03 Feb 2025 08:31:25 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] eventpoll: add struct wait_queue_entry argument to epoll_wait()
Date: Mon,  3 Feb 2025 09:23:42 -0700
Message-ID: <20250203163114.124077-5-axboe@kernel.dk>
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

In preparation for allowing an outside caller to add itself to the epoll
waitqueue, pass in a struct wait_queue_entry. Unused in its current
form, but will be utilized shortly.

No intended functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 5 +++--
 include/linux/eventpoll.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3cbd290503c7..ecaa5591f4be 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2470,7 +2470,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 }
 
 int epoll_wait(struct file *file, struct epoll_event __user *events,
-	       int maxevents, struct timespec64 *to)
+	       int maxevents, struct timespec64 *to,
+	       struct wait_queue_entry *wait)
 {
 	struct eventpoll *ep;
 
@@ -2509,7 +2510,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	/* Get the "struct file *" for the eventpoll file */
 	CLASS(fd, f)(epfd);
 	if (!fd_empty(f))
-		return epoll_wait(fd_file(f), events, maxevents, to);
+		return epoll_wait(fd_file(f), events, maxevents, to, NULL);
 	return -EBADF;
 }
 
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 1301fc74aca0..24f9344df5a3 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -27,7 +27,8 @@ void eventpoll_release_file(struct file *file);
 
 /* Use to reap events */
 int epoll_wait(struct file *file, struct epoll_event __user *events,
-	       int maxevents, struct timespec64 *to);
+	       int maxevents, struct timespec64 *to,
+	       struct wait_queue_entry *wait);
 
 /* Remove wait entry */
 int epoll_wait_remove(struct file *file, struct wait_queue_entry *wait);
-- 
2.47.2


