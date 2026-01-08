Return-Path: <linux-fsdevel+bounces-72907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DCD04FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07D6D3093954
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CB34C154;
	Thu,  8 Jan 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTcrMvWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF9F4FA;
	Thu,  8 Jan 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892597; cv=none; b=GnO/H2c/LJ+r9nQbcaZ53h/vJ6RQgc0Jt+HDqNQ0Z2aP/fd4pa+G4h6rCS3Br4JhOk0PRncxAXmYX0JxJoURNU+HEOZyR1HSncL62cTp1U0v2Y6OEF0vGin8XTVhDqQP5KDltkZ1FDg3hX9iy6h3PRwR9iXfvK3DavmqprlsyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892597; c=relaxed/simple;
	bh=NID4NaaK8cNH28A8Rn+v2PbCj8aVd6A2vQHcYBl6XEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnrxtRVYOchpuBaL/bKXHceESgntDKZLMM9kapaqSrxug75YsE0Ly0Ze1eiB5igjsP3y6cOmmFOKDXlngstNBQD7Bw/ZOTdaEleFX3S/5GXaB+Z/bGuRPXHZr4E2dBMiJcrZNEHwbiMCWiedNHHgEexiHhSzJFESue6thEj752w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTcrMvWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2FC2BCB3;
	Thu,  8 Jan 2026 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892597;
	bh=NID4NaaK8cNH28A8Rn+v2PbCj8aVd6A2vQHcYBl6XEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XTcrMvWGmKFvGwAYstJ6dpq7B/a12oideedJX/ThejFncpxpueWE1/8kcHPOQeVZk
	 QFWvIwhXvIK0f0/19xSsSvLDZxcpHacHvMrpL8K57jbA0ztziFoJOozdl4ej7Srsqk
	 IJ0ieRHWcycFHrOQpwYkkWmJEgEeCbWiiqP+kKLCTvF0rMcz4DTKBtnopfo9o+a7A/
	 ALxsVks9p4nDFy19KiMt5fsLyvATj5/h0UOqcjT4fVOW8uedPPmXkZ+k9zyu3Gb0t2
	 f/xnx08CLyXtuwL34A2sbbQNfdmTKLQZ5rLqii0Ytq9MzeBjv1sgSo9/YY+39BK1uA
	 i2jzGPW/BI2AQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:18 -0500
Subject: [PATCH 23/24] filelock: default to returning -EINVAL when
 ->setlease operation is NULL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-23-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NID4NaaK8cNH28A8Rn+v2PbCj8aVd6A2vQHcYBl6XEc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W+cLBRWxzgtw9xiO4SbRJTFDfCZwbur8vgI
 DrUAdciXvKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvgAKCRAADmhBGVaC
 FWxwD/49jq0dpl0tpEt+oaAFd4j0e/fid44vjg5imuwIhXHfcwsVVI4fUx/pz3UE94Qammox6zt
 upvbtem5sWsRhamPvtqVWrJjw3WEV+gTo/v2UllfbGPmh6jphW2/TcVyvTFMYjQZBfVyWLbN3jA
 3EVALc5vqNlMGchvznz54yLVU2RChzyx1XvCDhHwRAeNSAOGO8/1o9yXbGLyvPjSBJHE/68d6ki
 r/PIpu9JbeJugyz6HygQj/YOpchUfZ6FXD6KzyRcth9Fr3t5To8fhQTanvnQzTpe38PVFpxwy8D
 xwiuSY/o3EnGvPHb5b7HRRKCgKbOlvFEDfJWwiUCM6pZumnUrF7XAH3v52LionbfPxfLmcvOU6L
 gpLLdRy2M3uTOACsZavhy0S9lVZnTo4goZFr4ev0RRvmsjX+YTeV2ow/h8Vg4LKuFXUFR+5H3rG
 W30w4jQ5zSEZduWe5iGwnzyrIHJUB1ZloMPctMrzuCHbdMt2PszPfjsvqBlm7yLyj+EsqcH+7eN
 ipQkLEkHcqrbFNjwLbqEKEjK64Kjp9khIJv4PaXVv685x1D7zSSXqqq2QocKVPLs6RoSmQPkUDF
 N3wB/LHoG5Est1DU0o3AQeWJkEbKY5rRS9DAPXxFfP4CE7C7/5Ho4WFA555yX3b5D55WwWYyXRr
 /Y+/b/w6+wP/HzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that most filesystems where we expect to need lease support have
their ->setlease() operations explicitly set, change kernel_setlease()
to return -EINVAL when the setlease is a NULL pointer.

Also update the Documentation/ with info about this change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/porting.rst | 9 +++++++++
 Documentation/filesystems/vfs.rst     | 9 ++++++---
 fs/locks.c                            | 3 +--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3397937ed838e5e7dfacc6379a9d71481cc30914..c0f7103628ab5ed70d142a5c7f6d95ca4734c741 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1334,3 +1334,12 @@ end_creating() and the parent will be unlocked precisely when necessary.
 
 kill_litter_super() is gone; convert to DCACHE_PERSISTENT use (as all
 in-tree filesystems have done).
+
+---
+
+**mandatory**
+
+The ->setlease() file_operation must now be explicitly set in order to provide
+support for leases. When set to NULL, the kernel will now return -EINVAL to
+attempts to set a lease. Filesystems that wish to use the kernel-internal lease
+implementation should set it to generic_setlease().
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 670ba66b60e4964927164a57e68adc0edfc681ee..21dc8921dd9ebedeafc4c108de7327f172138b6e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1180,9 +1180,12 @@ otherwise noted.
 	method is used by the splice(2) system call
 
 ``setlease``
-	called by the VFS to set or release a file lock lease.  setlease
-	implementations should call generic_setlease to record or remove
-	the lease in the inode after setting it.
+	called by the VFS to set or release a file lock lease.  Local
+	filesystems that wish to use the kernel-internal lease implementation
+	should set this to generic_setlease(). Other setlease implementations
+	should call generic_setlease() to record or remove the lease in the inode
+	after setting it. When set to NULL, attempts to set or remove a lease will
+	return -EINVAL.
 
 ``fallocate``
 	called by the VFS to preallocate blocks or punch a hole.
diff --git a/fs/locks.c b/fs/locks.c
index e2036aa4bd3734be415296f9157d8f17166878aa..ea38a18f373c2202ba79e8e37125f8d32a0e2d42 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2016,8 +2016,7 @@ kernel_setlease(struct file *filp, int arg, struct file_lease **lease, void **pr
 		setlease_notifier(arg, *lease);
 	if (filp->f_op->setlease)
 		return filp->f_op->setlease(filp, arg, lease, priv);
-	else
-		return generic_setlease(filp, arg, lease, priv);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(kernel_setlease);
 

-- 
2.52.0


