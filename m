Return-Path: <linux-fsdevel+bounces-10023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E088471B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5EDB247E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296DF140771;
	Fri,  2 Feb 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HlGjcscK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546F17C77;
	Fri,  2 Feb 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883297; cv=none; b=Ak6TI6CSRC7JjWHDj5qfR5nOOmnirlNDwHadeZ8mVhD96kf+opWA+G9fi+V2+RKS4T0MBChKbZH6WycuiqJ8pioSquURU7D0VAr6otCJbwt0WnG0dnl/wiytHyoTLG8CU4Zsi/ykU9YGphlz7d94hJyHw18OSKeOjhoRSbKsYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883297; c=relaxed/simple;
	bh=BJQfplmaSyBDDhVs/RstyS/GWbcJ/Hf09yPAoLpwVRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hSNlps2iV6sMIorJIg76+Cda7YLqnUUHalaW3lj6LpkG0e+6wngrxItdsVKgrUgW+HcJonBceLz4UF1Rq8LBhqv0GZzNzWWEljNz2TNJ8CYPmfsMfseNgjYLRLfNHA2nId7GvnpAfKDmsV5RJI+v8JabmcYB9SVG0z9jX3oJA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HlGjcscK; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706882984; bh=utGP6OZSBLpmJu+9Td/7txs00XIiQw4x9gVWwrER68U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HlGjcscKpYIaUpYlkJdx1tCd4V3OAU8gBztf1fOCEJVuYsxtENrCrgHUPuyr+KVeB
	 2uMrmS3gA3miH3DWBn9RjgmlLQdZQNxdmN/NUSiFCfGpI6keBEW5KhgEaqnyfV8nOi
	 JRB134zXODyPzGo49nTXl3yoXG+0tJ1wLF32M+hU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id D329E61; Fri, 02 Feb 2024 22:03:19 +0800
X-QQ-mid: xmsmtpt1706882599tcbkviljv
Message-ID: <tencent_2975FB767367603CED3622962437524A8C09@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2VwOlPHaW7j2tsaSYtv5nx4xX96Q8K3YFvj37RAaq+YBf17GGzv
	 ArWxQSrW//mfyCBLhKljL6oRifpo4iGAx8GJ/Bea5/efYq0zN4jXPfZsSyxeFzr7xqc98q7KOh2E
	 JfG6AWuktRJq8mIlhX6jVhtE3VuMLnq8FEAKm7q+65dvDwLAQVoRh1xAq52WRbgJFFoQ/32YlcD6
	 eJGFtNUJ7B4WMD2ESJSn9ifhCHkuB22E5pm2jmS19XBqcDyq9ZGK4hZ1W8xhdwWabgYXcvwR0qSZ
	 W57mVLGvJ5/ub9VBlvex/ONfMZ53lJl/w0NdRaur+SERaZ5J3P7MSKu73wqh0UCECZJnPf8vgfUD
	 LnGg+VnpYeZyIXsGjrDjbfwouY+A5p/Fh8g7UK3szkmFdwKiAYLo2waBt6ALnY/WwFevedbzPIUX
	 z8EHR+ADf3DrbkmXf6H51uoiu0z2mH4CA+/SjVpLQGsDqmR1OfATo0WfX70lyo4YluhwXpFUeTry
	 40uq6W8XD0vzTw2JnFiTKEn9Bna/CL2GpqMHL5HKZWFMX9tjXKUq7RHhU+2LNs73HOTCK6s6Mcut
	 3BhElnjH9JPhFPOMKJN3YxHkD/fAbyAB3JMg6XE8+N7i6iHxw+ei6MpsoW51Ct+8PD+dVeH6efdU
	 NmJtJb+UxiQMPyCcnAcNPCN7v8rFwZ8YPGmTbTwCU+bpA/SM2qdw+Qpryif0X2IcIDs54Vhlhwr+
	 F3f1i+0LqiAzzVV8t5K3f8tiMvrG5VqdREWgwzI/7mxQZ8sHTHxgkWOEaRTIgfrNA8wgR9I0CPWj
	 Shi2zr51gKhzx8E2Gaw2IMoLSEmEzuzX+LtAePqOQAI7Gur5m0V1QVIuYztVnNEPBB3F07XUOuBP
	 DLA7Bs2cTpxPFOlOpur+IfFcTsqOPQ94sNawXvT70qIIuuV+0igsmTTlupsGk1j0xs+lFnWr4i
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] fs/9p: fix uaf in in __fscache_relinquish_cookie
Date: Fri,  2 Feb 2024 22:03:19 +0800
X-OQ-MSGID: <20240202140318.4147829-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007e7a63061062fcd9@google.com>
References: <0000000000007e7a63061062fcd9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In v9fs_fid_get_dotl(), if p9_client_getattr_dotl() or v9fs_init_inode() fails,
the cookie will not be properly initialized and will result in accessing improperly
allocated cookies.

When the cookie is not initialized, exit the subsequent cookie recycling process
to avoid this issue.

Reported-and-tested-by: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/9p/vfs_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..d27b7ecf7163 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (mapping_release_always(inode->i_mapping))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
 }
 
-- 
2.43.0


