Return-Path: <linux-fsdevel+bounces-67648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331BC45AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42186189137C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D062FD697;
	Mon, 10 Nov 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXL142WQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkbLEZKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485691E47C5;
	Mon, 10 Nov 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767536; cv=none; b=lYhUfyFZj9RdhA9gdpYg7tDseCxZ+iQdyCusCLdh5OyTOEBpnSCXn0w/qz089rDuzPL4UKfWhQuI4p3TuKJpwnUaRW6oM0kdo3r52jYIO8PG7yaJgEnOKM9EefDjq7GFwh49rvLdawcYYNI2HuZuIuS8aPzYOaxsDdMKYlz8E34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767536; c=relaxed/simple;
	bh=bOymtkoDVvZ87u8tWZSqE4AiRYmMaF98Yb65HdGbuaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F0Wvn+98aXqoqRA7VYWkVMHjtUkeuthV2FkANG1C+VRJgdciQ9RATRMBF/kFPOC7cKoghvnc4Qr7yW99cur1ELkt3VtRSPrsjJ0sT1Tv3C+ZBRDwq55hyclAd3fHgyaTJVaY8tWtXLl6SGcezoxji1T3NGPSooE4UVr3CQf3CEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXL142WQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkbLEZKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762767533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioFDhGGPuRIEAGyIKEA1Py3fjRxOSLAW9uu+nRAqXhs=;
	b=KXL142WQtcAjjbP2LokskF4W7YP69gAMR1u56sk23NL1mHudDpPA5QnGzmZ48I6FEQI6ex
	cWgXfp5Wo6B6XgFygMgmFayU3PRKgev0etppfl0MiPKtcb6FR0qVzrjiEHfSvu57d2UP5s
	l824F2gXMkV3glZAl9t7lUAclbXB1PbbF4eeugJAK2piTqmJH1pj3iC9K8J79W105zOQ+K
	hR3Byf6GhbMkepBFY/io6KGktcEkC4Tytin5L8QmZ925p1gdosHceNV9h9OqN3z02AqtoX
	5AWLStcq3is0a7LI0cXKDaSQFphAIAPZzHni8njWnD2DiGsuxXGB9iSFMWbocQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762767533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioFDhGGPuRIEAGyIKEA1Py3fjRxOSLAW9uu+nRAqXhs=;
	b=PkbLEZKPW6j6E2HjmZ4yI1knODEqzwAYqUvpKJqeCyy7PLN1PDW0Q6tuATDbvm8DGk8Zoe
	Gp8vWgbEnucgJCDw==
Subject: [PATCH 0/3] restart_block: simplify expiration timestamps
Date: Mon, 10 Nov 2025 10:38:50 +0100
Message-Id: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKqyEWkC/x3MSwqAMAwA0atI1gZMsfi5irioGjUoKmmRgnh3i
 8tZvHnAswp7aLMHlG/xch4pKM9gXN2xMMqUGkxhLFFRobIPTgMO+zluyPESdSEhtKYhW9pyqmu
 CxC/lWeK/7vr3/QABDnSYagAAAA==
X-Change-ID: 20251107-restart-block-expiration-52915454d881
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762767533; l=894;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bOymtkoDVvZ87u8tWZSqE4AiRYmMaF98Yb65HdGbuaY=;
 b=+dBZS5v7Vry8v1AqqpszjtukJz/UNxsguR2E6b28n+YwPeFgLJoHG/wIVWlTepJ/2CtBD7Gbo
 tAwxg1/Z3mCDLJn78SXFdz3UKz5JE0dCFyDl8uWTuG8lovQGNbsEF0C
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various expiration timestamps are stored in the restart block as
different types than their respective subsystem is using.

Align the types.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      select: store end_time as timespec64 in restart block
      futex: Store time as ktime_t in restart block
      hrtimer: Store time as ktime_t in restart block

 fs/select.c                    | 12 ++++--------
 include/linux/restart_block.h  |  8 ++++----
 kernel/futex/waitwake.c        |  9 ++++-----
 kernel/time/hrtimer.c          |  4 ++--
 kernel/time/posix-cpu-timers.c |  4 ++--
 5 files changed, 16 insertions(+), 21 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251107-restart-block-expiration-52915454d881

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


