Return-Path: <linux-fsdevel+bounces-74478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45063D3B251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BE9E30769F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4283A1A5D;
	Mon, 19 Jan 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLSidMGq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47811318EE3;
	Mon, 19 Jan 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840133; cv=none; b=Yq/t+wQ0+/sBwn5KCQ6+MSXpoq6HGSMYb4kE0Vszdnmb9mF9NuKcCxALSvYsnfgeqVzHSfR4/QwDq9aWekBwchxQ9o5jiRm3bIVi1RClndRLZZDh/ww9M3YfKmVOAZ7w+C/EjIF7r2XSL6J+VLMQeSaz6FqIRTDUhKh4DVNGxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840133; c=relaxed/simple;
	bh=DOe7Zr+SC0SYYE7gHRN3EzdcslwerK27BkcLvt/YLFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxaRUARn4Wtkdgw9YGIsgzm/VCVAYAQpFfK/TpTiQCC1Srjg2Amaw//trJ2r/vqUANUjZbUs0gpDQ7IJ6PjJkKrFQVqLcHaRd23ZKlOZLradhx5Y3A8NiRrkOuHTLaHm16kWThfyyrdbHu1SnUTuZzuG0VnFSWAmSB3imTMmjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLSidMGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27114C116C6;
	Mon, 19 Jan 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840133;
	bh=DOe7Zr+SC0SYYE7gHRN3EzdcslwerK27BkcLvt/YLFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLSidMGqIduwhhiZBRl97kiG2r0WSem//2Bu5eDamZwGlTsr9LrpoWaTD9OIQfiWG
	 PIcjpOsrKsKKoBTdH0RVx2h9oNObYSeGccUXe0tJOExLbMz6brRFhHfwX/xW4p00iT
	 0Aapwu+EBjx7X/ebQKY2u7Oc8Xm18MDBtNma1ZzvpgTWbbE40PXPlZWrfrPbUzljXx
	 ti2hbcDLHS2Mtd0BBszkVSvql1u5IKlKWMkfPiUeXlny3aVa3EZJYwuW6qOP2hLnJa
	 Sg5Vh/88liPis+95Wn+gdIj3gOvrNfxxM7In62NU0dbDOMh6+HROaUGGYnEd+tPfR/
	 KjdC6A4vI7Quw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:30 -0500
Subject: [PATCH v2 13/31] udf: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-13-d93368f903bd@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
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
 Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DOe7Zr+SC0SYYE7gHRN3EzdcslwerK27BkcLvt/YLFc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltcB67I3Cfm08JpbcXHGEkrLfaJbcvd3qnwq
 BhDRd4AN+OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXAAKCRAADmhBGVaC
 FbS8D/432THFEGWROgX8dP/qCEuSNPHNLeycBv+YXQdISlJtiHD4iuhGoQ+OgERyuJmu3TcYkEQ
 P0eYFomKXV8jqpqGO2/2SDRE8CSame7BrqEo+F6vqJ6h4aVkE6ufeuJybyvumep1nUmlsIk2DsU
 u0fENt3ExKeLea7brus3iT8xHM0CItU8XQS5RVMuiU/SxqPPEs6Gb5NrQ0Nb/yKLHlN0JpOjBD1
 u5kv+v0F3ZlB9nG8fp17BTBsCD/QSUkuv/VXguesgG1a1OdU1QlUIJf1bvZTI1eDySl/V1zJ/ys
 pB7kAyYPYpDzTxPmSOSrYVzGbRdfgIfCzChXnUTHchfvlYDkLqmoNjSVx4VcTmBHGy0wZq+p3Ij
 gw4LUOedWkbXdEWCD1VLGQ2lmsKA6KzmNxKG2DguLX57oTKI9hKSx1QkPTgioRhhpjAffxxzZzK
 YG/0f5pV4d15jKegKxjp7WbBOW2h9cYTfkca9b3NtC/IUE/cP6DzojeN7GJRXhtM/23HU+stsUF
 PYmwauk2mN1n1kuL/EXO+pG81cd36tlZ+q+6noHC81NKX6rfqcujUI2rrAH+gabLD5BcxHCkrQM
 nn8xl4i9spqRbsniTmZPDusVh+1BEp/XL0fHi6MMd2JHyHZaS6gOgg4V3V4ygHuuECMOaIqJVcC
 YlFVQwsgmBIRBJg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to udf export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/udf/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..7b8db8331c77bb43d9a3c4528aee535eac2bbd37 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1012,6 +1012,7 @@ const struct export_operations udf_export_ops = {
 	.fh_to_dentry   = udf_fh_to_dentry,
 	.fh_to_parent   = udf_fh_to_parent,
 	.get_parent     = udf_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct inode_operations udf_dir_inode_operations = {

-- 
2.52.0


