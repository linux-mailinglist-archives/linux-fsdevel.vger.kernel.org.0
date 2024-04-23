Return-Path: <linux-fsdevel+bounces-17483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0B8ADF65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B2A288D43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A9C61694;
	Tue, 23 Apr 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z4eTOEAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C994F895;
	Tue, 23 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859392; cv=none; b=B9mJr6cIlREq52RSODeNdRyiHuXUKSbOWihnyw29zFkbaRTNroUVs7YyQGW27ZTqPqUrBroP0KyDx5jWoOwPYf/3VP/pcA0I20PTQ0Tl9w30QIpcOaVJnoi92htqWnMo5nVXOdESdanNjiuByRqFvwEU5gEF4gLUuviVIhsFqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859392; c=relaxed/simple;
	bh=D/3OJwMoANYNDnHN43YEhKh/XOzsWgZJBxcvKVpFvHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pgjt2HeOaWpCD3/KmNZSLYs+dNlSDzoHT6KAie1wwV7ioDLlDYliyTUJ8Fa5RdZOB1OZpEKLO+JJZ2KJuHALyFvtV+HkZ6sLlP4WbvMWS4OVwcudrwd6R1kks1FiHDOaCAy/nWFcDTTuWYA9r708tCXeizJkfwjfxcf31o1+vHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z4eTOEAy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=D/3OJwMoANYNDnHN43YEhKh/XOzsWgZJBxcvKVpFvHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z4eTOEAyeZGZRhMLErDlHrOzyIn7K/DlkM60MPZgILl0NsHakg85D489lgcJ2pyps
	 w8ZjrPHlpbLbeknooUuGV8AX44PHoyXa1MFbZ8JyqpCmrdU3drnEDl22/6rS7GAbFk
	 mLBVLjPqI1ce59ORnQdEOqbJ1Zk5A8F74faI2Ijw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:36 +0200
Subject: [PATCH v3 01/11] stackleak: don't modify ctl_table argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-1-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1205;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=D/3OJwMoANYNDnHN43YEhKh/XOzsWgZJBxcvKVpFvHo=;
 b=1RhNomBbqj6XFaD6ZYOxEHBLV6bfBHp2WGUjkt4XBn/Ez17CpMDHBnau1hMCabUBp0fIJIUhv
 lq3ewsWLz9gCbCEhY4DcLZnRRhb9Y2u6rar0aoKgOs7QrHrAJv1mc4Z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers will change to
"const struct ctl_table".
As a preparation for that adapt the logic to work with a temporary
variable, similar to how it is done in other parts of the kernel.

Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/stackleak.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index d099f3affcf1..558b9d6d28d3 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *table, int write,
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
 	int prev_state = state;
+	struct ctl_table tmp = *table;
 
-	table->data = &state;
-	table->maxlen = sizeof(int);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.data = &state;
+	tmp.maxlen = sizeof(int);
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	state = !!state;
 	if (ret || !write || state == prev_state)
 		return ret;

-- 
2.44.0


