Return-Path: <linux-fsdevel+bounces-3803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C863C7F8AE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772352815DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9510942;
	Sat, 25 Nov 2023 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CRG3QeD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E186A5;
	Sat, 25 Nov 2023 04:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700916776;
	bh=BXpS/WrMvo7OTDWmO9J+PqDzo439myYjgk+dpF5igi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CRG3QeD32zcBVzyla/RRsF6DadjHrOG2/e79L8re92+jzT8/IfyAi2DfdoBcCYHur
	 A2k3q/hsqBkuwUecbu+GEGdpdupAbwEVncN+nVgqJugk7OsLZPSTiq0NaWKPTVFFhw
	 WrQ+wDYvJp5KEnU0jRyWQQ4/ErOC0NktBvbHAOxo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 25 Nov 2023 13:52:53 +0100
Subject: [PATCH RFC 4/7] net: sysctl: add new sysctl table handler to debug
 message
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-4-5e881b0e0290@weissschuh.net>
References: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=931;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BXpS/WrMvo7OTDWmO9J+PqDzo439myYjgk+dpF5igi8=;
 b=z+1Fq4ACjRMgDdB2UJc/veEQ9uIu8xVFByIIB2mjo/BjJ4ZvZTeODnNikN1oDZrXJV49ka+Rn
 RVaoHTiMe4rBwUAOOe95hamAjfJyb+bsIZK7oVnnE++MoxZdg9QI0GG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core introduce an alternative handler function.
Log it in the debug message, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/sysctl_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..29d871097ddc 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -132,8 +132,9 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 		unsigned long addr;
 		const char *where;
 
-		pr_debug("  procname=%s mode=%o proc_handler=%ps data=%p\n",
-			 ent->procname, ent->mode, ent->proc_handler, ent->data);
+		pr_debug("  procname=%s mode=%o proc_handler=%ps/%ps data=%p\n",
+			 ent->procname, ent->mode, ent->proc_handler,
+			 ent->proc_handler_new, ent->data);
 
 		/* If it's not writable inside the netns, then it can't hurt. */
 		if ((ent->mode & 0222) == 0) {

-- 
2.43.0


