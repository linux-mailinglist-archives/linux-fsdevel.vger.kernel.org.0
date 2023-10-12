Return-Path: <linux-fsdevel+bounces-183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4037C7053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1B1C208F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D1266C7;
	Thu, 12 Oct 2023 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jUQ27btT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E48266B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:30:44 +0000 (UTC)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C83B8;
	Thu, 12 Oct 2023 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1697121039;
	bh=o1kg+AGvKdB61U4poXd0za0hN5gEmhGNi+P9Mbfn6eg=;
	h=From:Date:Subject:To:Cc:From;
	b=jUQ27btT8YKJCuioIZSEDXbZBsXqxhwNXLkT4ykSVnwwoAF3vdbcJMc5QV3r7x0z2
	 YGVeRBw12o2yq+bEyH8DM+KSibg8MQ8FSRK3TOPTpf5G2Kf8uHL1WCQVtxkY71Fnom
	 IbnMMzuvb2KSdH1IftvhoBtNf/RJcSlXMyFwZJl0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 12 Oct 2023 16:30:38 +0200
Subject: [PATCH] const_structs.checkpatch: add xattr_handler
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAA0DKGUC/x3MTQqAIBBA4avIrBPU/qCrRITZWLPRcCSE6O5Jy
 2/x3gOMiZBhEg8kvIkphgrdCHCnDQdK2qvBKNNqpY28Pctic06ri4GztH7vlOnVuA0ItboSeir
 /cV7e9wNhjrUJYQAAAA==
To: Christian Brauner <brauner@kernel.org>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697121038; l=904;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=o1kg+AGvKdB61U4poXd0za0hN5gEmhGNi+P9Mbfn6eg=;
 b=AhaVBR9UW982Byqh7WkLNRE4oNV1ZYqKwiBMQtMwWsvezWr6GcNPcEsuQsAsIpdy9cCs2/lif
 zacngGK2pz4ApJDG3AYjtDUo2sJUQTMHJlAMhfnNGIwsPnxHYc21u5C
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that the vfs can handle "const struct xattr_handler" make sure that
new usages of the struct already enter the tree as const.

Link: https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This should be applied on top of the vfs.xattr branch of the vfs tree.
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index dc39d938ea77..188412aa2757 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -94,3 +94,4 @@ vm_operations_struct
 wacom_features
 watchdog_ops
 wd_ops
+xattr_handler

---
base-commit: 295d3c441226d004d1ed59c4fcf62d5dba18d9e1
change-id: 20231012-vfs-xattr_const-afd402507b6e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


