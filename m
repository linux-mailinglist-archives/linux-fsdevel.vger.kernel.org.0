Return-Path: <linux-fsdevel+bounces-25426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEA94C06F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F54BB27ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B318EFE8;
	Thu,  8 Aug 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Y3Qm1zXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAB18C321
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129244; cv=none; b=mE8FpDaL2PC2zZ/dKLaBD5d0ycvaxinlyTsgvNOl4TWIvC9RTZPQX/9EOKvtFjdLjGxcZ+r4wcLc++Trflex8kGHAe0byLhXbZrjMIHyhR63VQHxIyGhrjMl0MaRm1zr9eP9emXjM96OsF5SGEhghEHCdzIJIva8eDqSaC9CUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129244; c=relaxed/simple;
	bh=vuvMWh6YATvbV2e/4JH4NJzWpYvqaaRTdIQvBVZ710s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuRSA3NMP+Hj905kYkXSnGndjpqp+lSJrLflxTRxFkFRF8/jTWzS1j4QE6KHtJCc7SB2VZDqypsaAy1qUra0UZ3tcrvmJuiIm9DWq4gYR2Kuld7RJcNv7JSkUU1S2jdKhWN+egRjYDfwy/W2KySHaoCwHF59jwvvs18dPn7OuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Y3Qm1zXG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so1355008a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723129241; x=1723734041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAu/fAt9pD45BuwjaKWE/kC9nLY3RaeXFsWLxqTj2xI=;
        b=Y3Qm1zXGGB9WN+rnRUikO6VRXtHsRLxrwAzNrb7iZKnFAFXurxCQMBqxnLNUGQvaZg
         gWxv6fq+jooWxp5XE+u+yBu3bCgUVILpqM+8pM9CjgQEmpYwi7QGQ7YeOk8CDxZyD79l
         ZrJi8bmBzR8JANdd73oaX7LY42s5kcT1wiBykqzFg6A41xNnbor/LkV5Q+hmdwEmkrMv
         KECKGhBVC/vh+xZS+Uw8jcbhIaVHo2FA7CYYQhl/yi6v+DU0zf+6rNLLfEKigKiHh+na
         N4R99Ymmi3OtI/nkVcYTr5JyKsI98Qke5zyi0vxMX3MD4fekUVYxKsw7xlrNQiTXzh8f
         KgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129241; x=1723734041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAu/fAt9pD45BuwjaKWE/kC9nLY3RaeXFsWLxqTj2xI=;
        b=pfIXAW+LUYq5cFMNSVxdjnCRowrkTiwp23m0x4qAoT1O91A2tKp716LgHBPfWM3vPS
         +wboR9CAKkeYamKsUBT4iG5//dURMfNysU4+3gDPCwtK1uuBIwLPQlowBzr6Ga3gavDI
         7lF3z1NHQHlrVAq+Cn7dEGQSzydHNNGcpKqo8E7/p8Qe/ohjtZhpa1aBoUiTmCsizk1h
         w3P6i/zqf1LdPTDEWc14/IDor44yTaVnFp/IDJwjzSjUZO/pynWXrQ86VT3BOJmNTanu
         HxZWigS4fIp8co+iqy8PXFapmLRfNy4VmKTa79LTvBioKlLHD6ia7CpS3m/gDzsKi6XT
         7r7w==
X-Gm-Message-State: AOJu0YzI1ZkIO4SSKTuHw9j72TmNT8ijYfdQXVEtmXAET4RNWTVBIfyj
	no4bZBD7i9Qwh9ihoguAExu+B5VLcetm+CJ5e4LBBF0XQpE6lvIJY4hrl1NhbP0=
X-Google-Smtp-Source: AGHT+IHJsIUMLs0BIicJgJK+av1Wa9E1DZrzzBCC/VZUB70rVlhYNgRsGns9/IL3QCsWu+oHUYyEdA==
X-Received: by 2002:a05:6402:3550:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5bbb233a752mr1705181a12.24.1723129241008;
        Thu, 08 Aug 2024 08:00:41 -0700 (PDT)
Received: from fedora.fritz.box (pd9e1640a.dip0.t-ipconnect.de. [217.225.100.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1dbe4sm698105a12.27.2024.08.08.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:00:40 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] fs/select: Annotate struct poll_list with __counted_by()
Date: Thu,  8 Aug 2024 17:00:24 +0200
Message-ID: <20240808150023.72578-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..1a4849e2afb9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -840,7 +840,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 struct poll_list {
 	struct poll_list *next;
 	unsigned int len;
-	struct pollfd entries[];
+	struct pollfd entries[] __counted_by(len);
 };
 
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
-- 
2.45.2


