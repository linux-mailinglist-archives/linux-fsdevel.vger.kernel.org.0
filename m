Return-Path: <linux-fsdevel+bounces-40802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF3A27BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479657A18A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0391219E86;
	Tue,  4 Feb 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZwGeFWo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94893219A6E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698505; cv=none; b=moZuCdI0MfGIxyOzGLvPxlaBQKKPX7HibickXWVo9MixIDcTGCexa44GhMHPMHqQClF46MoFKtHVEu8drWyUWkYGmMB9Ks9GL7tkYGgm1M1woBzE2LHfV8Dsvukwgc0MJtQSlMWsv93X6iKzFRIsGbh7EinihTg4NRXv5dTLEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698505; c=relaxed/simple;
	bh=Lq/TvPbkX+M9fh/ofSu3jq3ZsdO0u7WjpsDGycNAOmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekMIyhTfGLMuMyyeReDLtOm78aI9uCeO/or+JyxbT0W5mn3rNhkKG3LGCes+Fwu5m11FQZGgPY+47Q6q5eIntUVnlXKG2XNJ2pblVN4PptavTKjIx8BAxLbO1NkC/1yj1JfOwkmfgp+53n41UbeRSMRLgWY1sT/8fyMskt+WSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZwGeFWo3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d01dc5a7f6so9382055ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698502; x=1739303302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enUf4uTUQbLHbQ4xi6ZoCFVbZFlA1oPnBMw51mV/SrU=;
        b=ZwGeFWo3zMUKS9HrCbnBiv/tn63qE7Xgsu88K9cm/VUkuR6mjBqKNrSQG+H61BjtcD
         nxXbIHI7R+jYirPeKiTXyxujvOrPfNB5+UHadKTdf42A94l5aAADp+pBcA9OopN0OPcI
         RZhpIzpFUEn/Utj/n9D03kuHegtGznSlgWLlx7GRDBGjZfB5b37GGCdZlbO2RxGWPezn
         aV2Y5iQY6F0KpoJsz2+GBI4o5o3KlizEebm7v5fDy11Vki+J5t7Wb96Pnah3FvddMCMX
         HJ8t0DcUBko0+k+CjctwUa2pwnxl3CJs9ShL6x4PnJ9xX4U5A6S+9O81kWZ3vLwEVhRY
         FWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698502; x=1739303302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enUf4uTUQbLHbQ4xi6ZoCFVbZFlA1oPnBMw51mV/SrU=;
        b=Ra8V0ut+MCp5d0GedbkkD9fXB2I/RC/srHcwJzbBetvPv9WMHmv9Vs9NGBbkIBZPbc
         tKhio/BRY/6tM2gXCh6cd6OJ3VUvVd+uI0wDfBntbg67D9YD1hcVzY6TfH6Pz9Saa8nW
         xkJZJCA9OPypKmVQWqXlxnRDTYUDoSa9ofOF+S52ijx63+ebFLmI3k775s0vK8hXBgWk
         lhI4e6kDcJlXJMIO3bBUafaw3bj2vnKLHeQNnbZUX7YtBQ8qYVMkDSnua6bIw9AXzI9r
         c9CiqBnvlabOg71LckBRqULcfEAptG+frzld7D1Ak79krtRDHjv1IKsW4CT70KhnMSaw
         aTyA==
X-Gm-Message-State: AOJu0Yx4PyHGPucANZ5Lp7WV8fKr4mLXXo0mvo4iZOQqfs4ffZsylnnS
	Uu87imPNymgcLqNpl2C+RcSK/4Nr2l+GueWFUvnpn93zveazPhDT7yHBV8f6MLI=
X-Gm-Gg: ASbGncvV3D+ikS25FCDMcn6iTYeU1ZO7cIrqN19ZS6Id35U5nVopITz4A2DIiXWoVBJ
	aiFvEepaoG1xo5ahZrjVN+ZhJ/lbTtCN/pcyE+KEF8F1QbO978tr+eR5LnUKfK7eCSmcX1ckQK9
	E+GNJ6Et1G/8KbaesupylL3TezUtjq/lnSgZ8d2dcHwfoCilpkefbUlIA6vXuki/IZavFZkvotK
	QLJn+uQcSUj/Qq+mpY3jG6biV/76yd/ULlDh6m5oWqrDo3/x2LSBByjp8VZbfjaMYD/mmL4cUFQ
	COZsgqxw++jkloPRPs4=
X-Google-Smtp-Source: AGHT+IF/nxjM7bisnj4ikl2AuC0UZKr/Ut8VzJ+BcIeuFUeqlzaZ7Tx/qZxbD+5/2uh2JILKnff/YA==
X-Received: by 2002:a05:6e02:1705:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3d04f4052damr2387755ab.5.1738698502608;
        Tue, 04 Feb 2025 11:48:22 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] eventpoll: add struct wait_queue_entry argument to epoll_wait()
Date: Tue,  4 Feb 2025 12:46:38 -0700
Message-ID: <20250204194814.393112-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204194814.393112-1-axboe@kernel.dk>
References: <20250204194814.393112-1-axboe@kernel.dk>
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


