Return-Path: <linux-fsdevel+bounces-4738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656ED802D34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206BB280CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C8FC03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Az7F8rfS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B79136;
	Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=TZdNqn1SiSNc5YcuC4mCIk7Ynn2gUU/Or228atMtaJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Az7F8rfSpThZ1n25BdEvJp2p9E/AzY0X3wozV/MY1/PAa1/Qj0RAhj7z6fiRqI7kK
	 7HDAJXx5XOu/S6imHwuojXsRcbfmd6OiQSZzb0GGBpHVT+IA2v6TKvAaAa/d2HWf+4
	 /NehtYiQxYEIopU8YBWhQpz/RtDsgc+T9zG7k1jA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:18 +0100
Subject: [PATCH v2 05/18] seccomp: constify ctl_table arguments of utility
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1238;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TZdNqn1SiSNc5YcuC4mCIk7Ynn2gUU/Or228atMtaJs=;
 b=+bb7R1dzvflk2V91q1B3apYuSZNzsswX5hsEfkK3Q7Bi6c2nVr2JfTll1pVlMP5bZS2K4J5GB
 XaPAF3lxcvpDah0XCW1ntvvsW9fI5ifFd/kDIevoOjVDZbSHl4zCMEZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..a23672674ff6 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2334,7 +2334,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
 	return true;
 }
 
-static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int read_actions_logged(const struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -2352,7 +2352,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
 
-static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int write_actions_logged(const struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];

-- 
2.43.0


