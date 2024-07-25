Return-Path: <linux-fsdevel+bounces-24229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BD93BDAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB262B21D95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D19172BC9;
	Thu, 25 Jul 2024 08:05:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBF16D4E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894744; cv=none; b=S5Pi8f1wRQjJmmwj6zMYvuTCKADbOMXJqgRHbnOQR2cyve6Rx1OLAScIdqjBFLJyRnWNWRLH+BfGjN+proXiRPbi2JCBah/mddD0I0ShWMqbP+7WHtqTdU7QPCgfFL4Q4ZkI+kmPlrAXYboNiLyyN/2hp4sOFvaeA/261wfctbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894744; c=relaxed/simple;
	bh=juiRPFb3ysJvYNyEc/viUX0sORvuirQqenTgO4aqjLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOuExQOnB+X4CXGZNYzchnEgr3zfwUOUE+glkTzZQVjF4OUXMVOhLodFfeOMxSCWl0txAAKSIRtXWzFKqIhSsk9CCYBuWD8y6poYaw4Efb5ZJK3n0JugJa0QSOr0+/SkXX9JK0ou+usGuVySIm2SGm9Ck5qGSt3rx1FnLbIl/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9697:b0ae:59fa:9dc8])
	by andre.telenet-ops.be with bizsmtp
	id rk5b2C00730uYn301k5bjA; Thu, 25 Jul 2024 10:05:35 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWtTO-003PCh-6H;
	Thu, 25 Jul 2024 10:05:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWtTj-008liP-5u;
	Thu, 25 Jul 2024 10:05:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] netfs: Fix dependency of NETFS_DEBUG
Date: Thu, 25 Jul 2024 10:05:30 +0200
Message-Id: <20240725080530.2089573-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration symbol "NETFS" does not exist.
Its proper name is "NETFS_SUPPORT".

Fixes: fcad93360df4d04b ("netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/netfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 1b78e8b65ebc142d..7701c037c3283f27 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -24,7 +24,7 @@ config NETFS_STATS
 
 config NETFS_DEBUG
 	bool "Enable dynamic debugging netfslib and FS-Cache"
-	depends on NETFS
+	depends on NETFS_SUPPORT
 	help
 	  This permits debugging to be dynamically enabled in the local caching
 	  management module.  If this is set, the debugging output may be
-- 
2.34.1


