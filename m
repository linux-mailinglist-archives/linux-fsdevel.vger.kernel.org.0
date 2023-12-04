Return-Path: <linux-fsdevel+bounces-4737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A879802D33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65471F21074
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE62FBF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nz3O4Rpu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7F191;
	Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=5+HgEomGEcSfal8KEHbNRv5xkdMmu5uXZxrXCkIqu/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nz3O4RpuvWkpltHlM3RYR9Jf3NvPF4MsnW3PyS389PBHs7UcASGhvDwUxa3ZFViyw
	 SO0u+5I4bzKzYUIEqvVCZftRUMx6dQVMYYTdwPSyzAPN/xYB1m/vA6+4/+qnJy+csx
	 UZK2VBQBwUMeh7KlXYFHy6bMh96GzxGmUhbGU/co=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:19 +0100
Subject: [PATCH v2 06/18] hugetlb: constify ctl_table arguments of utility
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-6-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1138;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5+HgEomGEcSfal8KEHbNRv5xkdMmu5uXZxrXCkIqu/g=;
 b=zd4HWDIvql9ethCYqcpULcNo0aOGOKcNIZoT6kq593C2oMwlIWM/2afb9K5I09ugAwV7Xi7Yb
 FGDJ8iOEM8EDN5I7kHXRLNOjXCxYDRa8gF/KebTpU/Di8j9dEg7L9e7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..2df21a295359 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4835,7 +4835,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 }
 
 #ifdef CONFIG_SYSCTL
-static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
+static int proc_hugetlb_doulongvec_minmax(const struct ctl_table *table, int write,
 					  void *buffer, size_t *length,
 					  loff_t *ppos, unsigned long *out)
 {
@@ -4852,7 +4852,7 @@ static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
 }
 
 static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
-			 struct ctl_table *table, int write,
+			 const struct ctl_table *table, int write,
 			 void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;

-- 
2.43.0


