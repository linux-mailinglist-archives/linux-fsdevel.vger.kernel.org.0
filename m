Return-Path: <linux-fsdevel+bounces-60092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE16B413F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814B46816ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FBD2DA757;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cLusl1sD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542D2D5410
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875350; cv=none; b=pxkxIMGjGcJEgZSLWB/3Ox8oAyzeFYLn8s969hTi3HAny4h2WGdNQR//7T0AZp1DA4qv1EV0/LsxGlfKJItiry1AulJ1Sk6eCVH8wd3Cm5P2TRFOcK+uFenjRrlTfPoFEE0PPM97xtns1f4xjaXDd/PYNUzvDiCuEmDniZzAXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875350; c=relaxed/simple;
	bh=DqqnGiShqXsp+EmUTAi7iFU/ouFLDT5+2/mpgB7zKOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf/bPeL/GTLTxN2/FRM1WKb+wY0aS9MPPtOOhFH27FekBcEzE0ouBdvBqokmr2TCEB4fr/q3+junHc9+m+EbUnNIppR8c1Dr8JdsqLm92fFdNxKKVoWXIMnoedikzW99P0cx5+yS8r2xHSCWTefdJlAdvbwuyoRe0BLOZhaJE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cLusl1sD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e7q+W4OOJySgaFy38p/0SiEx5HIcLj8IGzQEXMoL5Yg=; b=cLusl1sDQiecDUrFaygx20dLSF
	8Ld5AQB+4qQlwca9DQ/S+UjsMq5YVH1uIES4x4d0RqP4Pk0mFwTMeGKQiNT/HUpspTjYXtsqRIbXT
	uRxiN+1Dou5cAa5q+uWL2CJUwDUz8oq6JQYg2YlWbtSsiU52sWLMxkDcc2taPYNzJLCfpKxAX2DFr
	4QhuzUd+nPni3QIMrRhjEBSrjQE4A0TlMlpvsxhTznNwDPjcO8nZizrLaEOeB4Q439DdoYfQLy64S
	lwnKtVdMuY0isl+jANSCM++8KWokqtxUZdhzMZOhGMMH9dUCuOk1rRJjk63/MR46cYziQF+9zB1HH
	Evwr+/pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApER-3Hgu;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 49/65] do_move_mount_old(): use __free(path_put)
Date: Wed,  3 Sep 2025 05:55:11 +0100
Message-ID: <20250903045537.2579614-50-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
index 18229a6e045d..5372b71a8d7a 100644
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


