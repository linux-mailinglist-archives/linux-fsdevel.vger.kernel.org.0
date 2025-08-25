Return-Path: <linux-fsdevel+bounces-58946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C7B3358F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2429482052
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91D2857E9;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bfSMOS+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD6280337
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=UHJf6pNpbezB1EAsX8AF5374N9J/FhlKZMzKTcJuIab1nE/rk2kGCynIucE+b0C5BuJV5vw31YNpJQGoCl+VRXs9atW3q69oqwynMyeLIokTWB8vLvfAVg/1Kffy+MWWS0i/cguPT1DkZVrbqdWkRhEE677lG99vKg2Fs4t/9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=UHLS/XJB7/Ica2fC6dMfXnoVc/tbd8XoQbDSSCzDng8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTGt4ekpNFtLWR4EPGZom5i8LG78c+zQrsF+Np0wwOZDRGpYAEEHl3ldd8ytx5PH46A26St9w0OaPDpuD9QU6xT5khlwZ8pTCr1sswGzACt9sl9kP2CNdYM1v+Ch80DExssUCV17nCgOw9WJg1xXiuIZO16OSGiJPCekWn9/IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bfSMOS+s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Gl2jiYs/z7+3c+2uScvE3iPfQUWpFktZFl6T8ymKSAk=; b=bfSMOS+s/Zhsan8zXLrK8nHUrz
	2H4bOvZbP838ns2rID1bcUXIJoTxByIJSMeu7YTfdvfUUV2+OZOWda8Hs6GPzd5Vivbts86/Q+FdR
	2xA2x7I6f3G+3Yq4A8vXYigqMO0DpjuxoHZ/S/nRXr1qAXbmy8h09W1d/w2RH8DjeRbb0axnI0O2S
	KECeh5rhS61o3Dmvfj7Iq5wuXHugMwQtPDXErqs4rg4jHSJJ/kTSCEGaJjJ0ixPihEUOED2PgQpok
	sJdO6qArUTVmD+boSgg1Fu/UOJiGLdhK9p4cgHlHwDJeFHr14bJdAaNl74qqLWwONpwM3QUGPoglT
	iSKM67/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TFf-3iSE;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 48/52] do_move_mount_old(): use __free(path_put)
Date: Mon, 25 Aug 2025 05:43:51 +0100
Message-ID: <20250825044355.1541941-48-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c6fd5d4d7947..da30c7b757d3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3650,7 +3650,7 @@ static int do_move_mount(const struct path *old_path,
 
 static int do_move_mount_old(const struct path *path, const char *old_name)
 {
-	struct path old_path;
+	struct path old_path __free(path_put) = {};
 	int err;
 
 	if (!old_name || !*old_name)
@@ -3660,9 +3660,7 @@ static int do_move_mount_old(const struct path *path, const char *old_name)
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


