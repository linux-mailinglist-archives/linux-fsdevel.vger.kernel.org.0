Return-Path: <linux-fsdevel+bounces-60977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D14B53EC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C2C1726B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF692F3C2C;
	Thu, 11 Sep 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r/zQgCWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A462DC788;
	Thu, 11 Sep 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630792; cv=none; b=tQMdmIH333zjzlN9t9Qcz7zpe0lqjGq36ziVZBm1Ui0mpr4U2GNCcjZasc8jv29a9/HwQBx8ybD6sNdY/kUP+i9ij38/lPrvhmY0eNF/MZdx0WfrbZZjJS/50LuLf9htX7iHlsIx/rwqOm2eLqUDEcn2+uMx/gxAoDSnytmPsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630792; c=relaxed/simple;
	bh=m5/9UpkwJZaF3YJsFeSLKz9CtkPrXjXFV+OY4IAcx4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoGUDhBThYxbYw2ZarNpD8sE3M3nzGmfUOvO60JVdSTg9o/PV1qvVn2vfY0lDdCcCkI6npeRWEaKO5zomq66GLc1eNCW6mR0lrhLGjvVAtoMFrYQ+fkiuiAiKoPeWgmUdZyJXZ/MXWoj9dIokjh8qSkgM0fHvqr/QnCxLsfqhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r/zQgCWZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MhgxfnkCz/kLzZdlx0jjex+3MgivGTL5/T6JYpE7Wec=; b=r/zQgCWZV2WwOpXnz8lv4pB9t4
	1OCYqdGsBuM9PTcUH13o8bo5YdgEQeoD65jBQ3gXSaoufIo6IlAgVqiQZXPi0E2To8yD9aa7eOVMl
	zPSJ057fcDbA8rUz+mF4k1pnFGVWq9rRuy37CU7qgcl0snek7kclcqqNu7KDCZzqyjArx1MHkh8yE
	+NE+B6eDuxjgjmrC7P2FKyAfS5wXs6+sKpiMRnaHhiw9iBzTk/viHIkI8e/kXKiHK+8m+BZadLo9W
	RTLR/elxa/Q8VoNq7h9rdzgT4lLhzC4PJtGkw0iURw2Q3m3PUzcJkV5nuRiF2lOSlKPzqXpJH2PCc
	TXV9Sxxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq3g-00000006g2b-2Gce;
	Thu, 11 Sep 2025 22:46:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name
Subject: [PATCH 1/5] nfsctl: symlink has no business bumping link count of parent directory
Date: Thu, 11 Sep 2025 23:46:24 +0100
Message-ID: <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911224429.GX39973@ZenIV>
References: <20250911224429.GX39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

mkdir should incrment the parent's refcount; symlink should not.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index bc6b776fc657..282b961d8788 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1181,7 +1181,6 @@ static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
 	inode->i_size = strlen(content);
 
 	d_add(dentry, inode);
-	inc_nlink(dir);
 	fsnotify_create(dir, dentry);
 	return 0;
 }
-- 
2.47.2


