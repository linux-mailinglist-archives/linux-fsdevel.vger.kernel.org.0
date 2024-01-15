Return-Path: <linux-fsdevel+bounces-7919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941E82D3B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 05:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F71C20E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFD4409;
	Mon, 15 Jan 2024 04:42:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 842AE3D65;
	Mon, 15 Jan 2024 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A054C601ACDBF;
	Mon, 15 Jan 2024 12:42:01 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: mcgrof@kernel.org,
	keescook@chromium.org,
	yzaikin@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] proc: proc_sysctl: Optimize insert_links()
Date: Mon, 15 Jan 2024 12:42:00 +0800
Message-Id: <20240115044200.27922-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Optimize the err variable assignment location so that the err variable
is manually modified when an error occurs.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/proc/proc_sysctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cdda684551599..737071754a6e5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1258,13 +1258,14 @@ static int insert_links(struct ctl_table_header *head)
 	links = new_links(core_parent, head);
 
 	spin_lock(&sysctl_lock);
-	err = -ENOMEM;
-	if (!links)
+	if (!links) {
+		err = -ENOMEM;
 		goto out;
+	}
 
-	err = 0;
 	if (get_links(core_parent, head, head->root)) {
 		kfree(links);
+		err = 0;
 		goto out;
 	}
 
-- 
2.18.2


