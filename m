Return-Path: <linux-fsdevel+bounces-22752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20691BAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064841C237CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5CA155C83;
	Fri, 28 Jun 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7HoDE6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF7155747;
	Fri, 28 Jun 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565569; cv=none; b=FElxpa5CwhT6F0EEVE+3wS5tYwFYuQoBIXNHEXCGvcM5W1JDpK79dcDtmEYqGa6NrP9Xybj7eK7+qA3f1QmW8ZnNdK22ccwNhRssrKI44DIFvD1sRxTyV4ZrUIEo0XgoxcS5omyj6Lim9XHOz/6/vtDztGlreY/uQTJp9ve1dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565569; c=relaxed/simple;
	bh=bu1CYcoPH46NrrB7Vm16hCPiv2fWyMUG+bX0JU8hjFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkIvQrttU/wN210nTvh+/ZVV4f1nrPAm2nrle/W+SeoW8LKgRpLC9cefGaTnfg3WuGjeJuM6EMrSCvCkY1AqxDV9L65tCZUjChDoXCCM8uJWhGZADEYeu4zaVq0qIkP6IVziinoHvESqOAPYo49B1czBsd+RXu3J1zwXCQC32RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7HoDE6G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa07e4f44eso1913455ad.2;
        Fri, 28 Jun 2024 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565568; x=1720170368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/nz1JHR4z8p+ajw1D912vGA5V6XqUcGmzMFKN4JA2M=;
        b=Q7HoDE6GAbFzH26ArtsU8PmiWntFEdSDalJLzI25IQCfEvOlS0kfdnE9GENY9AdOOq
         U7FCiMmF86pHrTA3eEKdvvWweZTrzQPU4rNCGee4vU5xr2BcmpxhBM/lqSYAY5O/muaZ
         iFNykK7vQQbEo6m3Md+epm8n+LuOC6aR47mNaIA3iD7wWTrVWz/dienEiVi9Y/F7Ee6E
         57t1T1lME8WZAFC4z9Ctpp98oopKbSkJlwF4IXyHs7orpNwSzTYS8Yki5T4gSGE0rlS3
         I12C9ZyOOA2tNSSvWx0+h7+lax4scJrS/QVNyDj2TXDdkzfkfOG+PsLteoWtbM9+c0mL
         CUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565568; x=1720170368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/nz1JHR4z8p+ajw1D912vGA5V6XqUcGmzMFKN4JA2M=;
        b=H8LRy6BKdoHHMHX2coVtrLR+p/wUFsF+fnAQ3fH2euZTkSGAdHpHnSefbXc8nYxmze
         2kbZ21akJPbPWsvvKdSBnne15ck13cKkeIubpB1cm+AZCSuDPCZBtksUHq7oZ7vdHRSD
         //tzwBsQC5UarBKyMiAYEqCzAmQjIqYzUN6wIrjzqfgAP+gEZt+PzJWLL7wedoIIF/7j
         ry5fwdGG0IoBB0Qy3cYXDAatf15wehYJ1kMnEkmMGATjmEYsytXG4OC0OYwn5sYYom1K
         J3MFzacSRN+RTd7ju/vt91DBb0sM/+qV6M/V027RZhnqyASWTwCDJstgD2uSJAEF3wa5
         G2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX93kwKLhzYQKUKLhSfI5405i/8h92I84OMiTJuSeR6rrmCAAgcSmh13/k87+H6K1BAsoIsQBSnJH5YYDHNiIee7uPkKh5cTC9vuB/KUJMaoDSI/zQWm67pwUJfXVE13ji/gPEIBUzgiRTef3Sba1yxausjJCzLSbsgjxEDZihETOOglLWlvVIW3J1thx31eZXI0Lp/kyb2ZOTVcr4tMPT/3cQU7AMzbwOVZsYW5F4QXbzbluxswu3DYfhoQfyU7V7Olp8Svx+iK2TUFDTl6sx8AQ/7tnCL1mfd1zHAkVmqotiyH/AN9rzX76eM6XLr32LQqVdUMQ==
X-Gm-Message-State: AOJu0Yz93plRc/ZCfKtewK/kXKsbcCQXDKcDJLi9/kzuTsVFJUKVtwFk
	d0KlOxuZ/ZCODsNwWjqoryJ/OCexByWsYds+Ih/6usJT+nrQuvLz
X-Google-Smtp-Source: AGHT+IHdHlMsiSxDneCpl0Z+k+h/q/UIRrZYdoSU24sjr9+9ved5pPcYJylJrzwg3G+ZaraRZ/+k4g==
X-Received: by 2002:a17:902:eccb:b0:1fa:ab7c:a483 with SMTP id d9443c01a7336-1faab7ca748mr37580565ad.5.1719565567694;
        Fri, 28 Jun 2024 02:06:07 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:07 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 07/11] mm/kmemleak: Replace strncpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:13 +0800
Message-Id: <20240628090517.17994-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task lock was dropped from __get_task_comm(), it's safe to call it
from kmemleak.

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kmemleak.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d5b6fba44fc9..ef29aaab88a0 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 		strncpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
 		object->pid = current->pid;
-		/*
-		 * There is a small chance of a race with set_task_comm(),
-		 * however using get_task_comm() here may cause locking
-		 * dependency issues with current->alloc_lock. In the worst
-		 * case, the command line is not correct.
-		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		__get_task_comm(object->comm, sizeof(object->comm), current);
 	}
 
 	/* kernel backtrace */
-- 
2.43.5


