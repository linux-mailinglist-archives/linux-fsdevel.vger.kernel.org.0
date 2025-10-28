Return-Path: <linux-fsdevel+bounces-65882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD5EC13981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57DD1883B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE72DA77F;
	Tue, 28 Oct 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opZtxCUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18996201278;
	Tue, 28 Oct 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641169; cv=none; b=BFC/K+1Pi9XMZ7XDrlO/i3xjDub091wRe+KLgkWoFAOuenVuk/3GEqcE/MyBR1GMJJOJvjs5oF5bpz7FxokWSBoEfyF7miK+5Iw2XspWTSMlMjwjfHG0+0jpu5wERRFk8r2bbZkvzdAAcSlYmS3vlgvV2vg7jjT3/vBkSRcTcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641169; c=relaxed/simple;
	bh=gKW3Kch+DxwyOQ6E7K86XC06vlBSYTzRLn7iujbu9A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7Kj5D/g9GiHXiNGxHfuqlJtIMUfU/rUuORfuu7ohyZC/tD+X4Il6wanKk9FMvwFO3QaQ3hUsOxh1qiaMDbymY4/VDu+ENtyhhreFXTfBXOiVqOnPAswuHpC5WejBJIpGfkFDOZm5Ejj2/CTCGvXjy+m93z3eB8q6CHyXe/214k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opZtxCUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B5C4CEE7;
	Tue, 28 Oct 2025 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641168;
	bh=gKW3Kch+DxwyOQ6E7K86XC06vlBSYTzRLn7iujbu9A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=opZtxCUzzJ/2kSKbZ3zAcnoKuWThg4OLPSoBuDBv6BJxsEbhlozP0bAWJuFhLXWw6
	 LFeSA9z+wcWLwapl+CuH/Jkvd9AeOnv+SRGhtOIUfWTTpKnGkvxWpRGYU690PtpbBA
	 LbFHfImuKq8yTKJedTe+AE7sBkLSUeKju1pIOHULLeEXy00MIEb/ChkNKmd05zpxe1
	 dPFoafggWacHsD6J1cR14GJMQrL3Qg8TVilMmGsh9VvO92XPK8Am/rVRGcRCw9JGn1
	 CixBSkA70Ta3+l7Obzqxdewt0E+DaQ5MjkUDXnQ9sSNySoyUu5GwC9kdwYjII5g+Ez
	 YHrCUfdyKg9qA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:47 +0100
Subject: [PATCH 02/22] pidfs: fix PIDFD_INFO_COREDUMP handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-2-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gKW3Kch+DxwyOQ6E7K86XC06vlBSYTzRLn7iujbu9A0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB38dubvguT8tefdd3G0GkjmR+ad2hzmGe7jmiyRz
 c9zaF9kRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERYvjEyrGmwmGe44ec07onx
 LTOWqJt+5PjyOeyPg+OyEj/ddf3f7zAy/Iw4kZHus9rgg1+N1Hz3cK0Pc2wct7/mPrAsr+LCFK6
 THAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When PIDFD_INFO_COREDUMP is requested we raise it unconditionally in the
returned mask even if no coredump actually did take place. This was
done because we assumed that the later check whether ->coredump_mask as
non-zero detects that it is zero and then retrieves the dumpability
settings from the task's mm. This has issues though becuase there are
tasks that might not have any mm. Also it's just not very cleanly
implemented. Fix this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c2f0b7091cd7..c0f410903c3f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -335,8 +335,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	if (mask & PIDFD_INFO_COREDUMP) {
-		kinfo.mask |= PIDFD_INFO_COREDUMP;
 		kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
+		if (kinfo.coredump_mask)
+			kinfo.mask |= PIDFD_INFO_COREDUMP;
 	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
@@ -355,12 +356,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!c)
 		return -ESRCH;
 
-	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
+	if ((mask & PIDFD_INFO_COREDUMP) && !kinfo.coredump_mask) {
 		guard(task_lock)(task);
 		if (task->mm) {
 			unsigned long flags = __mm_flags_get_dumpable(task->mm);
 
 			kinfo.coredump_mask = pidfs_coredump_mask(flags);
+			kinfo.mask |= PIDFD_INFO_COREDUMP;
 		}
 	}
 

-- 
2.47.3


