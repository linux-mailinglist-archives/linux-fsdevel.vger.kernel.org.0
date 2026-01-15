Return-Path: <linux-fsdevel+bounces-73962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D2D26F79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E680303B468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306E3D3D1D;
	Thu, 15 Jan 2026 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM3X45Dk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818343BFE4B;
	Thu, 15 Jan 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499335; cv=none; b=aWKogNfy5j/ovjsrGSGhYbUazwQxxs7j89Ci5QhfC+KqzQbCHCCY6/GznGB2fZkCDSLJtarcto2B7CyVlZmipzMwe6MHjP3Iv/CpDk2daUvRLY1fKnH3dBByNDrX1NIbvNyPT8FM8c+H7hBT6nx8nUDbPlqQNV2cFlVY/ulzY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499335; c=relaxed/simple;
	bh=bjqNmWwoD40Qnk+TzNgJZFwf0QIhVfVk3tp13EbdB2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbDJuzkj0qXZe6LEXwGRSYXE/qvyOaS2YwCbiTtk0EjI6psJF5pbZfv7UX/DkRUWqH2rl0//vJS0B5eu/FIh05L+HccBx6/RT+Apz+SyZhM8s0E1nZrD2kaa1rOFW2NNeCwJZGdQJDYFR8x5EZkMA3LUIJb1cA4FskqroEpN/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM3X45Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EDFC19425;
	Thu, 15 Jan 2026 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499335;
	bh=bjqNmWwoD40Qnk+TzNgJZFwf0QIhVfVk3tp13EbdB2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SM3X45Dk5uYSSa9zWw3XI4I7Ss6sYTSQtClsuuSbca4pRTbsigBy2OSxOWAVI21wR
	 eZ2Fh1LDbYgzQ6voMboihPby2Z1r5nZNmYeAGGwLvaOCqd/5AIKAgWF2Zt58oQCDEn
	 9WuN15JYC7TmHhHEDPO7hUm/HiRvG5zY24QwluGrGzdolaEdJpSPzPJYgp8+EtX1HN
	 j65MdUC0VNymAvQX7V5Bdy9+xqyXvdn1rd0p0de54gL6MLS06X5TAQiqXSFIUW/7R1
	 QyILvgn7ZlION29gYsD4ezO/kSWgzPcuIsJfdl7/fUSbH8RL0iPM5c9vQe2rKPXh0W
	 GMbfwrtSWhKkw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:39 -0500
Subject: [PATCH 08/29] ceph: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-8-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bjqNmWwoD40Qnk+TzNgJZFwf0QIhVfVk3tp13EbdB2U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShGa8nQcABAK5jEXI2cbk8SHUMrCeg06EdMp
 RCwhBgmYRCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 Ff4wEAC2JupfnsVYXONrdaMqx7Rc1TCYHMpOlEnGJ3bdTPbia88mLGCcKDAI5WggJ7XRzIcKHWg
 650uAma7Bno5Mhk90U6+216K/tjZqXt0pzb4+W1kBELjWr4uFeCBB/pUPuH0S3G0p8T0qGT0/TH
 7gtmc5LBWW13mbYVsuobNKq9/GgvX4cR5cH3j8tbU9EXcoH6fVcRiETTdSysAC2+ne7/IdzZ9rb
 4BwiU9ebeLiXmFO37Y6yMQjX5EOr2k3wTZs/r3XMJhh/Ln/HXNa5w8VaRxsO2XO5Vq2r+As561d
 h1986yPq1624DSdy06ZKpUJiMF+roEU0pm0B9gzRlS6VLTaUM/RJIoq9W9foUp7hx2TEdQnF+en
 6vrSImaQZeCd+yBOkQSIUzt9mHiFSIUvxJ3YCmipafSLvhMzVX2jcd6RjE53mi+W1N6cvjmxxRr
 RcyTfuZWdbBsY91RySpnu9RZCgAz73j9EIJgvltd2CBdJaq6iFblaeKSti2sskXks2Oc8+uH86Q
 BN6MElZwK605F/Q+8CeGnP770IaFbHsiDWQ0lT+TI/5RXwU/E4MJQ+i41xWwu2GcQcCTk8CxAIu
 GCWx27MAOo5ADN/9Bj09FzZbltqCtp3P4+ZKEVUNQSvNSllzlVlduvpsl/bH3/ubLxbBdVYsPBp
 kEcghw8IpuKyeOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ceph export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af1046791d8423c91b79556bde384a2fe627..10104d20f736a8092ed847ecb27030be286c0ede 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -615,4 +615,5 @@ const struct export_operations ceph_export_ops = {
 	.fh_to_parent = ceph_fh_to_parent,
 	.get_parent = ceph_get_parent,
 	.get_name = ceph_get_name,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


