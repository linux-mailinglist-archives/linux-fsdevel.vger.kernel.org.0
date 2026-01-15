Return-Path: <linux-fsdevel+bounces-73975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F81D26F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 882FE3028701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEC3DA7F2;
	Thu, 15 Jan 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4LOVrQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C603C00BC;
	Thu, 15 Jan 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499415; cv=none; b=GakLu0syrp3g0CiTbT1xqlx7vTGLbTpnalpE1DD+Jss3ys4TdL7B7JAhANvncSL+A9w7PA7yu5IaDOGtPRbKpuKUQI8XBJMo92+yzVOkumoTJIQ56muGHI1kic8qVfX/u/gDhBUxbjoErwUbUFetqg4n0z/yWrZZvK6R5hDuXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499415; c=relaxed/simple;
	bh=U14CgwQNmpmYm/olsFPDmAvGebUpMmdXLYBcSiJQo68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4aHLnw9Ds48RvyuK6iRHK4P9BI1/XcJXUGMlNdk8keKgLF40jzdMLLSb8QC7Jrdk5ApcPFYGPoHuo8cpuqfqPJurzrMXTJZ32qC5XPIj61Wdv90f2Q0tL6Yl2W/3POyy9fUJF7PLE7q2rvU/jm0B4zsn/gr3Rh4zTAhj/Cx1hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4LOVrQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E799C19425;
	Thu, 15 Jan 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499414;
	bh=U14CgwQNmpmYm/olsFPDmAvGebUpMmdXLYBcSiJQo68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U4LOVrQzZFDe86/JOIxFd/oTbsgvDFVbCPtnJNbJV62tNETnGVQcZbKoD5VbL/PwJ
	 f+gza7nr1wN/rVp0cfVFyiNPnmP2h7xyzhf0lL6Pgjbxf9ja5yS9DCJsGAyi5yN2sy
	 4ue0mFvkb23UAcEXqDIfhhT1l6jADXeh4D2GGCzn5vcFi47mkyVciNWNEAcNyEn+N1
	 1k+iUbFC4J/zNUdYYVPM6f7EiRxfog9ZRuVbC8ETpYpelIdZmtAzDehlXfJNHIhEL/
	 cTjgLsM7yaccBslJ6+uQ5W4Vwp47GREyY/Ad4dVxEPb6+NiRXZswo082ea/IHe7W0+
	 ZfuwxblAnAqhw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:51 -0500
Subject: [PATCH 20/29] nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=U14CgwQNmpmYm/olsFPDmAvGebUpMmdXLYBcSiJQo68=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShJFbXOMj4js450jk2J72PWoFR/JR82AXdQy
 iwgyzXU5QSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSQAKCRAADmhBGVaC
 FSZYD/9uphGdzaGvn2dg4Bd0XX2b8qmIqlYBiw03MYG0trIn0ktMmsuP2fx7I6z6kbKu96A8Sia
 mP/7efimfs1aKaZJr6B3/fmOtBpqwhnDS3kgWOTBu8fDTe5QrkDi+ctDvRVYiIfrAN3+C8bAhrA
 iNy5KeyzvhYkJqb2hf+fJ/zhXqNbv260P6SQ05cNKI9yOiqNnb8npWxgwD/vxA72R0KLkPQngA3
 0iUAXySskZKvUAw6bAmGwc6TeACjpDeXWilP5zP1ejD115mBHRoyPjyH7E0UBwhi/ZwqrQh0Yli
 Q1rmIL1WaF4AqtEA7W1a1ZRqFZwrIxu9SiDRp5xS097OtKgyBRM3YcLEz46iyWojw62Vts/p1yd
 5Zwt0L4bpA7o2oY4CduvIzH4qaBRWnl72mLRhifKBY07v4jEXZo16rcfN1R/TrHWYnvEGK8bVOH
 eveMdSkU99tj3mokzFwkv0xuTwrFRi/Ybi4/OZ3qZhPiaw8jgKHBTSgOzBny17yPp9hLsv3yQoa
 MdwJ48ubetO5oTRrxG5TJQpY6oLaYJ5DfnsyAbylsupYYb7doZ8JEhdLu7WxLMTcUEY06PSoVR8
 Y4467ix83xMvF/LKJBQiPwr5dYhMyx6uNDY3V4tsPAsxBsBErVvgWXjOygYx4my2qfERvrWSmjA
 a18liGFzln9M3yA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to nilfs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..975123586d1b1703e25ba6dd3117f397b3d785c1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -591,4 +591,5 @@ const struct export_operations nilfs_export_ops = {
 	.fh_to_dentry = nilfs_fh_to_dentry,
 	.fh_to_parent = nilfs_fh_to_parent,
 	.get_parent = nilfs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


