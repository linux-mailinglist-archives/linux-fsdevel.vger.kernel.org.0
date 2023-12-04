Return-Path: <linux-fsdevel+bounces-4741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363CD802D37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E526E280CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F256FBF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="STO8kui6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989AA1A7;
	Sun,  3 Dec 2023 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=iOBuDxNgWayHfZg8ll4jl4+gQO+POEL5ZSXO0IYskQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STO8kui6mbh1g6598MiaxLRX5mQc341d0YjLWS7Nqws1kfRzH1lwxwoSt5ziD1VFK
	 aSwpZnNYfLd9cTApCGEXs0XYNCcDuD8ICVixi2JcvAH+kMfhWhB0uQW14hHfUy14Br
	 1s7Tge5tpoCyCqnF10AtWRGzNJCAb5+Q0gLsx8Ms=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:31 +0100
Subject: [PATCH v2 18/18] sysctl: constify standard sysctl tables
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-18-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=624;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iOBuDxNgWayHfZg8ll4jl4+gQO+POEL5ZSXO0IYskQo=;
 b=bcxZcbAl3IUbAiyq3MmFXuykvVpQnzM+YWbExIJXohNBpBz3JEWJo7sT7X/oXLjwCNCq/Uf7w
 /af+RETE8JFBNjQumlPQ165901a6AM1OKKo8JHVeUGKYxVfkiX6XZfN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Recent changes in the sysctl allow sysctl tables to be put into .rodata.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d60daa4e36fc..e48a60887c7e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1615,7 +1615,7 @@ int proc_do_static_key(const struct ctl_table *table, int write,
 	return ret;
 }
 
-static struct ctl_table kern_table[] = {
+static const struct ctl_table kern_table[] = {
 	{
 		.procname	= "panic",
 		.data		= &panic_timeout,

-- 
2.43.0


