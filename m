Return-Path: <linux-fsdevel+bounces-4730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289F802D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D58B280D04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32BE542
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SQ4c4OJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73167F3;
	Sun,  3 Dec 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676351;
	bh=IyP3fTXp1SAs7UkxiJUA9xlgTpZMUTTPQdr1Z8WPbb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SQ4c4OJgJJCnisETb9hXUF5YYUf7C0UKd6c5Mww/aO3s77s0vnJ0BYmhq9jI56SXo
	 ZOeCfh0d6Oci9O5gxeD87hctfl1w06lqiP3cEdVC5pjMtWexivDvWbYfte4WFes+8e
	 nV0fUg21Ob0hYeGT65jveRMunFejdMDZjaDXK1Ak=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:16 +0100
Subject: [PATCH v2 03/18] sysctl: drop sysctl_is_perm_empty_ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-3-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1435;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IyP3fTXp1SAs7UkxiJUA9xlgTpZMUTTPQdr1Z8WPbb0=;
 b=+ngBpUV2SiwicZA4ds9XMOzk5Pbxi+vGaZjien+LXgMroK7KKieP5OaWIcOCF+WqNuE4vgwZP
 xT40W0mgomqCFiuD3TvBSNW81r50LHid1h8Ji7pYWOHqATHnrdOYQdq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It is used only once and that caller would be simpler with
sysctl_is_perm_empty_ctl_header().
So use this sibling function.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8064ea76f80b..689a30196d0c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -48,10 +48,8 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
-#define sysctl_is_perm_empty_ctl_table(tptr)		\
-	(tptr[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_is_perm_empty_ctl_header(hptr)		\
-	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
+	(hptr->ctl_table[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_set_perm_empty_ctl_header(hptr)		\
 	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_clear_perm_empty_ctl_header(hptr)	\
@@ -233,7 +231,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
+	if (sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);

-- 
2.43.0


