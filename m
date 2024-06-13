Return-Path: <linux-fsdevel+bounces-21595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662809062E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 06:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FAC1C21EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F34132116;
	Thu, 13 Jun 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="gP61wLFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F2446CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718251322; cv=none; b=oUlkPOyN0CAUaPtjWgTwMrHziVtJ+K7QRTN7wlnWg5/Dq3D0ayKsfA01bPwt8PwpUAC97WW5Eh1lc4rKUkPKETO7dXh3zLxc1UeXoSwTqMrCpoFlie3rCsQl8kKc+Y1CEyasHYcmY+kB7rAXFbIfQwcU+BeRqizdct6g0oDjufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718251322; c=relaxed/simple;
	bh=k+JzPZOLsvElrN1Nr9OpEpVz541f+4V1elWm7203adw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXE8J4QXC6G7zlysbJTM/j/wZ3aFFhUtaKEIpI2jGTCVqGdxHmIgh6DGBVV0yfVjIMen4CDpyjq0LrBLL81gMrq/340XaiG2EjAhhd0RCrbzSZhPhqwCoTBiXyeSCg7zaAs/t4OhHUhYqTwL0JoS7h4NE77vIdJV7uoNLt8Zin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=gP61wLFZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so408984b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 21:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718251321; x=1718856121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4U2F+y3t7r8GSooXgl/s46Avo9/HJoeXnWDx2qZA7jc=;
        b=gP61wLFZfVUXZPT+tj79NKf6YOK+ZqTj3FMNOR86WD0fs5dJ5GW5vsK9ulyMkg3BXQ
         +KKZyRahyk7zHkvkTz5elH7TleXhe5bnK4VsGdMowyoSuffWbeYvvKjdUwC/ipH5C7/+
         7OEMhZGd+qPFATt7GAe9Ht24V31SfN1YxJ+Upr2veg5LhXiLtZnvQjRl3ROsnVBAatMP
         +jswSzGlHNv5REe/BtUbjiz2sp92rM/XOez1ynG+7kPODxBQrvs+u4yDZSZkjubty57e
         KkV3fWy/QNEbL3Ar4sNVosoUDtLod6hf7ITniuyAYMkF57nF8jfnW/mvpK7X6XtT4QHs
         8Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718251321; x=1718856121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U2F+y3t7r8GSooXgl/s46Avo9/HJoeXnWDx2qZA7jc=;
        b=Qrv5nwSBVaH2nhFl+7RN7vCXl7h+eSIXGePqTymQ2V+FZ7rnBBLbjmPm+Hcq1OJ1bF
         XVNagHtXlx0Xidq9X7LBoJONlJQne+/Ezw4+mCsRsjhtr+9JnNraQt4yXmkPYuDYWwV+
         tSWr2fUFyOwAYnTbMFeV01ybnROHoHLLnD/12SgnZymgzg+zjsUnevE1JC1REJpSwQBb
         L/VYzsk4LJPYXe2pj8qR12NEjF0dvKhKpfgVXE3Je+ts1YAYzytQ/tWmCxWiOPKHLaty
         MVpcVa92jlKYUCqcmYGv1u1JLCrlPIWxsqMGZrSdHxC5IfgRx25/vDNy6iz76SNFPdZy
         ekAg==
X-Gm-Message-State: AOJu0YyMGbC3xXEwDmnB8XPC5Z93dok5KJLQPMYivrmrjhw1u6R2Kyi/
	4PuyUwt5iPwGnwjlevQuce1M/OJug9SiBxJVSQYSeGji9YRgXQL80WA8i1ezK2E=
X-Google-Smtp-Source: AGHT+IH+x6StIHK8RC7YOTjzt5vJi3lwi/2nPcPHm+xa6UNRHbldU0DapWAqKmdOuvSl3txiZTnMUA==
X-Received: by 2002:a05:6a00:2e26:b0:704:35a3:f838 with SMTP id d2e1a72fcca58-705bcee9950mr4285489b3a.24.1718251320592;
        Wed, 12 Jun 2024 21:02:00 -0700 (PDT)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d188sm365867b3a.99.2024.06.12.21.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:02:00 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [RFC] fuse: do not generate interrupt requests for fatal signals
Date: Thu, 13 Jun 2024 12:01:47 +0800
Message-Id: <20240613040147.329220-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the child reaper of a pid namespace exits, it invokes
zap_pid_ns_processes() to send SIGKILL to all processes in the
namespace and wait them exit. But one of the child processes get
stuck and its call trace like this:

[<0>] request_wait_answer+0x132/0x210 [fuse]
[<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
[<0>] fuse_flush+0x193/0x1d0 [fuse]
[<0>] filp_close+0x34/0x70
[<0>] close_fd+0x38/0x50
[<0>] __x64_sys_close+0x12/0x40
[<0>] do_syscall_64+0x59/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

The flags of fuse request is (FR_ISREPLY | FR_FORCE | FR_WAITING
| FR_INTERRUPTED | FR_SENT). For interrupt requests, fuse_dev_do_write()
doesn't invoke fuse_request_end() to wake the client thread, so it will
get stuck forever and the child reaper can't exit.

In order to write reply to the client thread and make it exit the
namespace, so do not generate interrupt requests for fatal signals.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/fuse/dev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..5fb830ad860d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -374,11 +374,14 @@ static void request_wait_answer(struct fuse_req *req)
 		if (!err)
 			return;
 
-		set_bit(FR_INTERRUPTED, &req->flags);
-		/* matches barrier in fuse_dev_do_read() */
-		smp_mb__after_atomic();
-		if (test_bit(FR_SENT, &req->flags))
-			queue_interrupt(req);
+		/* Any signal except fatal can generate an interrupt request */
+		if (!__fatal_signal_pending(current)) {
+			set_bit(FR_INTERRUPTED, &req->flags);
+			/* matches barrier in fuse_dev_do_read() */
+			smp_mb__after_atomic();
+			if (test_bit(FR_SENT, &req->flags))
+				queue_interrupt(req);
+		}
 	}
 
 	if (!test_bit(FR_FORCE, &req->flags)) {
-- 
2.25.1


