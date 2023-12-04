Return-Path: <linux-fsdevel+bounces-4735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360EE802D30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33565B2047D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C4FBE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ebZp+DVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444018E;
	Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=XX/0Dgv+i6b2iH4R1etXfooZRb2dy5KXDGiPQVphnWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ebZp+DVYTEEAfjfaE0tgQxKbgsqYJFjNAFwcUYjBzNwvnbfhz3uNMC236Sa1fPfTw
	 NyY5igxxS9b4fxVKkbyqn/gh+YLiw9R55X5EIHr6YQgzV7wOrcR9JY8Vf91oNlaGDV
	 YtvSFjz8UWu4u5MQAanh2PNkPYJH1h1eebMkon+0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:20 +0100
Subject: [PATCH v2 07/18] utsname: constify ctl_table arguments of utility
 function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-7-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=696;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XX/0Dgv+i6b2iH4R1etXfooZRb2dy5KXDGiPQVphnWA=;
 b=zWbb03OQ8wfovwcUfOlCCPX491ahk1eH62Nq+pjCquKuyWlS5cMqfrOW//ibS7ErluyLMRkWU
 8/+YmIhOrdlDhhbBdhUvQ1jGzJTdwvIKPQmgi1Kr/jqFOIqsESa0dt6
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
index 019e3a1566cf..46590d4addc8 100644
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
2.43.0


