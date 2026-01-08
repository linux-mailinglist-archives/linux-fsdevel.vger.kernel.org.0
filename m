Return-Path: <linux-fsdevel+bounces-72903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E6D05731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50C230BC95E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0808346AEF;
	Thu,  8 Jan 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3j/8ZnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C02F12D6;
	Thu,  8 Jan 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892567; cv=none; b=lfpNJm+QWNq5S2adOQTophvuKjNsbcCdAVD5Hj55ql4zGMzb+OrSdGEM9mCmVI9t3IwmI+7I3IuLJ/yeS1k5qtNWOKgcs7bfvDatP4nVPsp7OdsuarQYWnZC2nAW2VFBxBK40YX//IKZuAKnWqgr5bSiocUFWJnbrGHIq/+ae98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892567; c=relaxed/simple;
	bh=JE4GNVPNVKkNcA1jpqmX8IvYzHB+7PmSrfcDyeXRZLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/OXA6qV3QQqq/pXzQjBIAWxEhFHPABh1zOhgd9doTP7L45v3vQI4mrPTqd4XmtgnXa5zFKzQ1grFE2HrCgKXlc63r1DyT5pAvBfQSbvPKJUNvFbox/GKV+OgWGmPXYDbu+fyIDdHer/1ekP8Y+8hi0u5TVj6IfP15/VUwK3R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3j/8ZnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A71C116D0;
	Thu,  8 Jan 2026 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892566;
	bh=JE4GNVPNVKkNcA1jpqmX8IvYzHB+7PmSrfcDyeXRZLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O3j/8ZnOjlQ0r4lnYmPtsUkuQLHckXO+a7lG3tqb9TexBpJCI54gOjdY+y8cCsSsQ
	 IxvwGEq3OuP4iFsa+dfO35ddGb2HgrELjQ3ao8l3pK8jjF+Rjy20EonfaYh8Llt5bn
	 /RB0tjx0w8p0Z73/B/w0EDupGFZC6EL5Ujzfd5x4fov1xGuwtJQ2yYnkADQmROHfwj
	 vsL2HbTZgjFTrxJnnt1JgX9uon1ZUYyi2U3LH7fBkbHEoUA/5KeCjcqPEx8Q1c2XKb
	 ox1Hu8zNl8p9EtF8EvUx/ekvx2wfL1yY6MIxC64QcUBwdDJOmA+8NHq3bU3g6XawLT
	 nDl4cYMCkWQAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:14 -0500
Subject: [PATCH 19/24] tmpfs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-19-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JE4GNVPNVKkNcA1jpqmX8IvYzHB+7PmSrfcDyeXRZLs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W9gK75PTtPWqOZdqkgSnHiF5/+OLjav5BQh
 LQ6WSLzNoSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvQAKCRAADmhBGVaC
 Fc2MEADKg6yklkAvCj4E7HbZuYhukcahYUkhiJr6s9Cmx08ysx8VeUMh6v2VkTsecYbC4+70tAV
 l8nv4WOUsUTDowp1tvc0/sz7/2Hzf+BrQ+/oLXazFQWMU+qAIDE2KG1fZ4eXH5/RziCIzTjsyVV
 WQfLt52vOVUhkx2Q9O2OsO8mq0omg1wvLgAwAtHGrvKOAP9KLOriK/cA5dyUAchlKMIgFpuo3UL
 naSDa/ODULEppeZRcUSiegKPxpZHgpJUzekiHgNKO1ef1uGJWyPmadrRMQTxDKgHU3d0QUBFPRy
 e4vMD3bsfS/hnKP+Q3YGKp4vT8pZBvAp3S0nY7TbIF8Gno7YQ6wLMTrwNRF7Ksus564DZpikQyQ
 Z1vp/C0eCi6Y1/9BACOuv/AaxipBGDR2sU43QFy7S3g1dFlmiokwOIZFB2+jvgiptQ+2Kqv+OkG
 2Et3Hg81At5S+sSz/MRyswGtr///ik0I7sPxkuHS72u0fhJxRBf92xon93aDj6aTIs+psF2EefR
 HUU5h7Km3+IAmuCDehZFAfanpbV4j2wEDY2a6PvPJ6QpsGWA7AB5705Oh8k3uV4EThmdpqmcqJc
 aSve0hv+Cc2HgVoaAFhypkfr9I4QNt1+P+/3feGfcoYp9R1OzGlgDJE4iURN4iMA6uvvliMP9FA
 /t5jn5rkkAqVo3w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation pointing to generic_setlease to the
tmpfs file_operations structures. A future patch will change the
default behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c | 2 ++
 mm/shmem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 591eb649ebbacf202ff48cd3abd64a175daa291c..697c6d5fc12786c036f0086886297fb5cd52ae00 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/export.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
@@ -570,6 +571,7 @@ const struct file_operations simple_offset_dir_operations = {
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
 	.fsync		= noop_fsync,
+	.setlease	= generic_setlease,
 };
 
 struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d2bd47db9d7506e4d6a565e092185..88ef1fd5cd38efedbb31353da2871ab1d47e68a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/fileattr.h>
+#include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched/signal.h>
@@ -5219,6 +5220,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.setlease	= generic_setlease,
 #endif
 };
 

-- 
2.52.0


