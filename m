Return-Path: <linux-fsdevel+bounces-62155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF3B860BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C80E1C87032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91AF3164CE;
	Thu, 18 Sep 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tvloj9fx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CB2D781B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212722; cv=none; b=nQ4TcnrFag2O3QEB0gk34KZLqa7frFck9R3/pUkODwwOcUvl7IXLHW4GLuW9KFJEgOBaNgOMdZYgCs0IL7O4LmINqzFh4SZmSJndxdXppspvMZ7YHhV5dFnFEv/Ia3sqXPnXcXCftGrXunu7AjLx/TEfKaHVmCIgJh2lGuFC4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212722; c=relaxed/simple;
	bh=qc9rH8N+MwYr0XbTZLuuHKlcb4fz/VatMafOdMhw8VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHqqFFp3ZNyctf1I2vvxJVzXgO+VTG+2XNlYE6vf6xVxdODtDInvoRGg3qcYzM+EeKH+unftMSqhMadrBHhWqELSPM+qVT4jXvOerXcPQCuwC+hitzF0irGMgozJjAmZyWWv92Eu60CcGOV+5l2WQAcsyBgMAGVAlEg8QmWj5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tvloj9fx; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758212705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ktr+7artqK+DKPq3rxA1E0i5xpWuy9eSkm54v2ZAvwE=;
	b=tvloj9fxbQgLrXkIqAhnoV02GPNkGl2pQUZ+IZCFmP3o3hvALpAU1ItDdinQ6baoaqQCCh
	hxp2QuLBfZIRsFeLo+OqWRgb/h1QiYy17ECj5Wmix6UTRzOO2D/nTFdEyJ5IwtXGGqwtRk
	HuIzrqX1o903GaJ25VcSGfTktpSJbpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Replace simple_strtol with kstrtoint to improve ramdisk_start_setup
Date: Thu, 18 Sep 2025 18:24:47 +0200
Message-ID: <20250918162447.331695-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtol() with the recommended kstrtoint() for parsing the
'ramdisk_start=' boot parameter. Unlike simple_strtol(), which returns a
a long, kstrtoint() converts the string directly to an integer and
avoids implicit casting.

Check the return value of kstrtoint() and reject invalid values. This
adds error handling while preserving existing behavior for valid values,
and removes use of the deprecated simple_strtol() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..79d5375ad712 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -28,8 +28,7 @@ int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
 {
-	rd_image_start = simple_strtol(str,NULL,0);
-	return 1;
+	return kstrtoint(str, 0, &rd_image_start) == 0;
 }
 __setup("ramdisk_start=", ramdisk_start_setup);
 
-- 
2.51.0


