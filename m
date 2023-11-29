Return-Path: <linux-fsdevel+bounces-4265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A97FE33F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E65B20A98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5A47A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhBEZ/6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96E61FA8;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF7E4C433AB;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=a3Y6lynq44wXodnU5zT/TB2mw/YUwehyzd+izLi+710=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JhBEZ/6PLgihMSRnoKSzznrVZA5XVGhQYgyCRimavQ0hBFN2pHRljsvYLtD0vX49I
	 5V4HYEB1+nw1uUY6tiwEa/cnwsD655UJLuIzjnqj5e3l/BTx8FGYNdEiwdh5UfdkSb
	 4fdzq1KkO+m8kvgVnsJUtYfg/eoocSNFQ5HBKSVAn3ut19I16C0+HNzjheoxXa9oaV
	 YNS+lso1WXhSIdz4V5Q3C5NCzXa/liYZo7tJpHSeHQP0Ilc0WTZy38w9nClxz+pzlA
	 y/o6/RhcvQ14o+kdoXv/ozlhhbT7XvuSacub39Ld9CU8Yb+NMZTGb81AWKO5UFxBFw
	 rqfJTCYEnM5VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D8C4167B;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:25 -0600
Subject: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=a3Y6lynq44wXodnU5zT/TB2mw/YUwehyzd+izLi+710=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I3jkGX0ENxe+x6fg9biSGvz?=
 =?utf-8?q?faFH0+OzJVRhGL1_4G7+T7mJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyNwAKCRBTA5mu5fQxyeKuB/_9fSGpP5pXSOyn3UkRq6j9l/2nr77wJO5nHS?=
 =?utf-8?q?UPVLP5ZWjfcO8vezbperL5n23B6ppF7zSRWMWMK8nc5_RyyQRhW+2y60KxF7sGRyY?=
 =?utf-8?q?hAI434prSE8W5pSf7yj0IjuslabYuvpSVW+1aVPcpLrgHoOlZv0fINTDT_aB0X2HD?=
 =?utf-8?q?zovSJwmMjrbaV8xmVzw6wxyxc+ag8dHIAe+9FYPtEAJc6orS+tYRHGIVwsIgR682Z?=
 =?utf-8?q?djQ5TQ_Rb5zjFwxxkGdTu/udnpVVQb4YujdB+Ds6VuSdPXJOtS8eiLFpJX9NWsGs5?=
 =?utf-8?q?pUJ8RMEjmOBT9Ds0S0uR?= 41HDfP0hKQ7rUTwY1jLx6IQL3V59Sf
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add inode operations for getting, setting and removing filesystem
capabilities rather than passing around raw xattr data. This provides
better type safety for ids contained within xattrs.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..a0a77f67b999 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2002,6 +2002,11 @@ struct inode_operations {
 				     int);
 	int (*set_acl)(struct mnt_idmap *, struct dentry *,
 		       struct posix_acl *, int);
+	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
+			  struct vfs_caps *);
+	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
+			  const struct vfs_caps *, int flags);
+	int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);

-- 
2.43.0


