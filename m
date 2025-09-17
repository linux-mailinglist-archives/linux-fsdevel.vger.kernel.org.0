Return-Path: <linux-fsdevel+bounces-62043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491CB8248F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075922A7A28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B531326A;
	Wed, 17 Sep 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="roUF35uO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C2312815;
	Wed, 17 Sep 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151663; cv=none; b=XwS1dnOSL+DmqAyu+84ImCaBtjtXWfcn/UIQa8Lea27zaGNYXzWU35PHMkBI00bu3XffMNcISb99Y63XmcG0qXJ7k6NOKgfhf8XirFvo5WMgjPGgcQ8sMZlmuIukdYXVdNEKRx0Oz7pMHGYhDvQAiMO2a0mLwIF7nDFlwJsuhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151663; c=relaxed/simple;
	bh=lffsWxejSaazfehEOP18AuoV2PeMK+4woeB1UFDwZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueamgl6ti7pIYPrE1g2JFe0KjZxxSZKkB1YBC09znzwrAHKX5iUa6nmpC1Qke/C32hnOQ3go79uyFMBqJbTzz49uN3XhII+aNNHpWRB7toUgm6rfpfoVnLbY9lK72A1MTjM91X+toH59TMzJHiGpHK6QTP+WPl4Zfjq6ERuRkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=roUF35uO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6MD7xd1qB2M+fEvqpqyJRABbOsCiwqyidgEpkbjiltA=; b=roUF35uO4mHsjgsbtDhr/MbmuC
	8LobmU92HohNt5bP47txaTX0YrbdrFK3Hf2l4iPA+UP/goDmGjFai6w2Aak8QMuHvzDhOnbF4TjUa
	YZTb2TWW8tQL7ExcdU4OJKrpzvr8S27ZpGAyxAKVIJH9e1ZOwhK6ww2kfUXVC9l9E8sIr7jAK//XT
	YuEC+IRDwiGTCnBWM2T5MTbCE4/PUAMcUzND5/ZWXPdH5l+U4U/3Sy608bB4zIQlNwy/+FExhkRrv
	wQ0fXwgHjU0hEW/8qQp56t3CqiHaF/0F1BjI3UiLBxfig3tg/dqG+V6NIGyALWiLBDlENVJwC3jAv
	cJY2zPSw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj5s-1Uwo;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 4/9] simplify cifs_atomic_open()
Date: Thu, 18 Sep 2025 00:27:31 +0100
Message-ID: <20250917232736.2556586-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

now that finish_no_open() does the right thing if it's given ERR_PTR() as
dentry...

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/dir.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 5223edf6d11a..47710aa13822 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -484,8 +484,6 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	 * in network traffic in the other paths.
 	 */
 	if (!(oflags & O_CREAT)) {
-		struct dentry *res;
-
 		/*
 		 * Check for hashed negative dentry. We have already revalidated
 		 * the dentry and it is fine. No need to perform another lookup.
@@ -493,11 +491,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 		if (!d_in_lookup(direntry))
 			return -ENOENT;
 
-		res = cifs_lookup(inode, direntry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		return finish_no_open(file, res);
+		return finish_no_open(file, cifs_lookup(inode, direntry, 0));
 	}
 
 	xid = get_xid();
-- 
2.47.3


