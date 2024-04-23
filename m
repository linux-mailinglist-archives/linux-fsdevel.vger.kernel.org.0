Return-Path: <linux-fsdevel+bounces-17480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B248ADF3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7498128713E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E95647B;
	Tue, 23 Apr 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HfImcajL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B84AED7;
	Tue, 23 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859391; cv=none; b=kPWxNxdetgudYRIpH3kT6J9if8bnsCPYlFAvkOLj6A7yX4GA/PwJiRQKyZ0A568g6NxvMbIBJXprtpQlHWC1QKZcA5g3oe1zwRnWntKPEgc7pPVTIam6Yn16FHtmrmGR5gbxRQ6fgeP/v8UD9CbjHE8+pPvz66YO+mAyKm1iVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859391; c=relaxed/simple;
	bh=opGR4gpnAvbs+lyNBq6fdLjOrQBbmIYYx1eB7UGZHV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K95lrzsJwguTIQet5imKocqAVxUeeEAvzGBvL2KH1ax4LHZ0VioqpOkfYPCiAkc+cgh0edOGY2Y2vZ6GM65TMSFwbs5LR5klBekIuKf4x/52WEXHz1O4IaTrl7HfJKFEMBFkX6TJ5kcEK0/xYt4Xg8xDc4xxQD8/vnO892dSsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HfImcajL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=opGR4gpnAvbs+lyNBq6fdLjOrQBbmIYYx1eB7UGZHV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HfImcajLyH9fRAHB6Ui+Edknzu1unFNUQsyZkN6W9dmfU+gHpYzWRB8z1jdPEJfrY
	 Pr+tQUXouYF6Fr8ZB0dJgU5uJKyqI4ZpirRA8P4QYR64pl5zSDWYNSCG1oUxNDMuR7
	 AXYmALCXm31TMp71SE8rzh6qU7YGEq6bCde/2XZw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:39 +0200
Subject: [PATCH v3 04/11] utsname: constify ctl_table arguments of utility
 function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-4-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=696;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=opGR4gpnAvbs+lyNBq6fdLjOrQBbmIYYx1eB7UGZHV4=;
 b=ed5W9yz6Y3PYc8dy+kq6hSu45FqtfkT99vg42nbOB1Ni65LnrRYJQZmla0Oue7XwR99Gbnjaj
 bId0PbgErm0AeGk6gclOc5pv5Xfx6JPwBqf+J7ohAIHsKXAVAE3Ars1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/utsname_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 76a772072557..04e4513f2985 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_PROC_SYSCTL
 
-static void *get_uts(struct ctl_table *table)
+static void *get_uts(const struct ctl_table *table)
 {
 	char *which = table->data;
 	struct uts_namespace *uts_ns;

-- 
2.44.0


