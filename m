Return-Path: <linux-fsdevel+bounces-58924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA9B33580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901363A8998
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D12797B8;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mSFJ5WjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653E27700A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097042; cv=none; b=U0LbRl+bNBe0ORDml3C3uoA4Gg3OicWFMj6HT1cYTnSFkq1Dzis4DUsdrnKDxsdufMbymM4ebcLUt+3MtSL8P8+2AAz/Tl1xf8GfC9/uSbeyeTYvExDjuHsrn46M7BbSEqlyfdQGsoS+F7sPiu3U5HFoI0FOSaQ12E4hyXdoTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097042; c=relaxed/simple;
	bh=GWy+b++k78mru9wu/QIuQjAanTEe7VqDiaXXmkZ/uUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpwyXvKKJ9yAwBDvBfIDx9G5EMnY3bWQ4IE2xoAoB/ciPTZfXAaUuuRKc5uA2hjc/i5Snojctyk4mjtM4l80hxvN3jbEQK/xqsIHvq/lMis0+bwiZoCRLyuIXKLliSO0HZQ2QoDUiIKPAGch6vyKB+1zNuKH5cyIcWGdKh0dMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mSFJ5WjJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=47f7tvmpPIZJwdGBenojhR2Z9ZzbSaLc94MRFOAyp5o=; b=mSFJ5WjJD0ZNulJnRwZqkL6G9I
	mH78pkvombBCeEutsRbiTR0qQBycwih6+xnAzLzPBIk3D7gAHFRyYO4Qh4N5TLuGjbUoZqZhYcXxG
	2hNvJ6wdoRku/cdIVGW5gy4iBBwur4hwdS0SdCC5SQC8yK7fXFFWTDtHs6B13muUSBD3bAfyweEb1
	s9g+63KuFwEnpTxap0uYMxMIja5LN/G+983U6kLgcZBsovUK8/26ijqZbwE7lzROb85aiB+sTYB9p
	o9fjz6w5v8u9r4CPUspMz6lPVDKinzIY9qVyQlXh83rXtXUB0yT6qbQ4ugmrkwtHvIbMXcaDHa25W
	i23wI5Zg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBR-1OsC;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 22/52] do_loopback(): use __free(path_put) to deal with old_path
Date: Mon, 25 Aug 2025 05:43:25 +0100
Message-ID: <20250825044355.1541941-22-viro@zeniv.linux.org.uk>
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

preparations for making unlock_mount() a __cleanup();
can't have path_put() inside mount_lock scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5c4b4f25b5f8..602612cbd095 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3014,7 +3014,7 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 static int do_loopback(struct path *path, const char *old_name,
 				int recurse)
 {
-	struct path old_path;
+	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL, *parent;
 	struct pinned_mountpoint mp = {};
 	int err;
@@ -3024,13 +3024,12 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (err)
 		return err;
 
-	err = -EINVAL;
 	if (mnt_ns_loop(old_path.dentry))
-		goto out;
+		return -EINVAL;
 
 	err = lock_mount(path, &mp);
 	if (err)
-		goto out;
+		return err;
 
 	parent = real_mount(path->mnt);
 	if (!check_mnt(parent))
@@ -3050,8 +3049,6 @@ static int do_loopback(struct path *path, const char *old_name,
 	}
 out2:
 	unlock_mount(&mp);
-out:
-	path_put(&old_path);
 	return err;
 }
 
-- 
2.47.2


