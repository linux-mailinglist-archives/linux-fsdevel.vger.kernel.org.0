Return-Path: <linux-fsdevel+bounces-59561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A416EB3AE23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B493A4791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FA2F549D;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hvNKA609"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA72D5C92
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422495; cv=none; b=BHyS60HLpOApjdlyFtXXg1ACPRH9cX2BiuljiwWId7yglTgiw6IWB3xXI0Tu1dtimmzMMUEdHDUI8AxwexOGvVUSjFY4FD4v8SMCV5YptqSGBlLcgXlJgbmkAunaIZhuQUBaTM47VEdiP22h/BzpU4vJzb2nyfax1a+oRjHWRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422495; c=relaxed/simple;
	bh=N5+sOBTSgVM9PNB+OyzNSzTCAeLFEnNABp/UfOzVbyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWiCKThd9GJjiZ+WfNQwQHLnRRF7pqStngMC+TV9hYPSEtzLtiKxZA5AV3YiuiLzfOJMCsNVJnjaaFadJanDLNYKI79xodnZZZAsJd9mluSPVVxCC0jlmE7mkWsCwpzeYAVVzUy7eBKQS5hsbBLKJjiLukKn0XD0sVdkovNnCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hvNKA609; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VOIghgwX92edo3B8aadsy4Xa7nZsq7KfKO5WW6ThqS0=; b=hvNKA6099hiP6Y6b8mMlRdrHXu
	Do5FXFQUT/bBW91EhJMuCZLsSJYTVSH+l6NPTiIAAVwyRH8oUfJo89nCNDb/wQMnY/rVFGIMXn8g9
	RaNahVr5FozEIu35iiOmpJdlzoc2A4o120yCVtCHB8dls6q8gFJ94JJNhP0aVClPvsWHoweFIor5v
	GfeftIHjF43HlXzkoi1sBosb7Vvj5aY041iBUENUy7gFLm9LG/mccg+Spl0PvC3LvVW7izZTVwmZd
	wQM1DEeGXdHptvL1ZYhlSyiN0xq9eJS4GuiFUYbCdYM3gGTAmqBca6XFrXlBw71wEcMsjnWt5ywbO
	5f18uy8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F26n-3LZB;
	Thu, 28 Aug 2025 23:08:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 37/63] do_mount_setattr(): constify path argument
Date: Fri, 29 Aug 2025 00:07:40 +0100
Message-ID: <20250828230806.3582485-37-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index de894f96d9c2..5766d6a3a279 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4865,7 +4865,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	int err = 0;
-- 
2.47.2


