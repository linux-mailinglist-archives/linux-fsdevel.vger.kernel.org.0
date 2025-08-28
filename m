Return-Path: <linux-fsdevel+bounces-59575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A3B3AE2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F7583BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C22FC867;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rW/zdGFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7F2F290E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422497; cv=none; b=oR79JJ5Bm2i6HyKVavH4t1pVAgqukhen/FsNQZeCNUqF42OzcaQWwOAFCx0DQpgv4svcXCK//yfb7S4pfI3/VT3hSvw7D9vHXFvzgzbUdFtk6NwSm9cjI2/cV7pPHgO1IzQz4y0VkBFiKVc1ZWlQaj2sSR11HI4FZFIx785omNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422497; c=relaxed/simple;
	bh=HprrJ8lMNSih9z+/WwFkLrh+AKuAjtpEvQtQs0/z/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGL8UzWRid6UOGiJIvrSvAXL3AsHCqlQIXPOaFMyx+etl3eHKcbtD9TVr+Pj3CVCIQJSn02FD7XMb2wVT35OynWAxceyaH34r0JqxYGn5gK5c3D53aguO55zUhDevBx3dAknnY+x85C+2CK5s/ZsRYN9479wDsZRbZ1EX9d2yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rW/zdGFT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ksavQlfrc2GhR04QJyt4PoUv0ebKwJlpwsdKISdY9SM=; b=rW/zdGFTdoYDSs4TePpYgp5lOG
	+DlI1192ttPqQOWALgKJoGWAZoczwBi6Zop4BUyfaZxo/yD1dx10f7XgzRpV1x53zqpp+fA1bR90L
	1X48u237K7TwE+J4BSdWGbydij0WoRiiQsG/kC7LFDKwgWqHNTq649X15LmxXKpDHrKL2Pcpp1dXA
	Lg/VHmfS5AMLfNIuOcJz92qbJgutZproN1oOjtMqyJTXOz7ybniptYT5MZ63qzU5ic8PyqUmasna1
	mBSHJxAi5raV5bvVF/ICt1d4Livt5VFe3SMKXHm73MFL5QUISICLLJ0/MHCfCYvg1jQ0BZ7Wg4Y+j
	/MoiSfpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F298-3rWw;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 49/63] do_move_mount_old(): use __free(path_put)
Date: Fri, 29 Aug 2025 00:07:52 +0100
Message-ID: <20250828230806.3582485-49-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index daca5e3bec38..a57598ec422a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3649,7 +3649,7 @@ static int do_move_mount(const struct path *old_path,
 
 static int do_move_mount_old(const struct path *path, const char *old_name)
 {
-	struct path old_path;
+	struct path old_path __free(path_put) = {};
 	int err;
 
 	if (!old_name || !*old_name)
@@ -3659,9 +3659,7 @@ static int do_move_mount_old(const struct path *path, const char *old_name)
 	if (err)
 		return err;
 
-	err = do_move_mount(&old_path, path, 0);
-	path_put(&old_path);
-	return err;
+	return do_move_mount(&old_path, path, 0);
 }
 
 /*
-- 
2.47.2


