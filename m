Return-Path: <linux-fsdevel+bounces-74466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE6D3B13D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A097031A4455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F813203A9;
	Mon, 19 Jan 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZByvzF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB602E2840;
	Mon, 19 Jan 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840047; cv=none; b=GzoomVH8x+pfRfGT17ALtTNQi5+1xt+f+pdxFdh1lIzwxgcD2/Yh3/Hz78TWqeFbXccm5GU929fm/e9020ZWt8yqYkHv1OeM6X93bcdCv3SusET6d/3FThb7QSukglVndYsXMyg1isK9CBl2gm3IUoY0zTKeX6v8aJNsSJWDibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840047; c=relaxed/simple;
	bh=kHox+Z6m0SGAxt8eN704T4oKG2yhOc62IdYplYhE+GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGF08ZQHfJZSDXc3e8Swhc8vp2VeTmo050Xl3g9H+XrBFwWVRNt6+8qJ0Kt8yltDtm0RrdNuqxBzjI5wH9WzEhjp8KtUiXubEf3QnPIxq1MFHl02VMUk1hE8r/pGphQw6/Gc4HbxPxolatoXJYhocCSTwThFE+IHJ61BsYDOhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZByvzF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED7C19423;
	Mon, 19 Jan 2026 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840047;
	bh=kHox+Z6m0SGAxt8eN704T4oKG2yhOc62IdYplYhE+GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EZByvzF31znoQEmDHc3SC4xaf0M/35g4xjcVwooMk1FV61HXxLESS5MiLKX6tWFeo
	 Hv85bBuLMqHqez3qHBscy+CtxbnArxV4QeHTrTHLdSh1NMKPN6CGz094DCBrAFgM+D
	 AjJf/kL6odSToXoYbC0BwY2wXW9BcS3BGnPOFuFUygBqW+EJJ8lAxaO4a8DC3mSQ8J
	 aALSFez2K6qCZWewncoJbLr2GlmdBWTKm66qurJ4sNUMMc6kZedy35j6ubnv3HJVKy
	 Bvebe3CcZHZIgOiFzpF4s1XQUiXn7842k1apwk6XDZswZtqbHhYTTAxje/WAZfxElR
	 uszu+UWz9bfRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:18 -0500
Subject: [PATCH v2 01/31] Documentation: document EXPORT_OP_NOLOCKS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-1-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kHox+Z6m0SGAxt8eN704T4oKG2yhOc62IdYplYhE+GM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltZnWuxHPCsFVnqSKxTO4m+b3RG7VE55J4gy
 EWLrXp3yVmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWQAKCRAADmhBGVaC
 FVjvEADKTq3x5BhOtt6Qj64fRRaPHGOm6Bc07y6w5GpnNyCiIQM6aVpcn4F9ORvzukxMQVO/XqV
 Gc7pRAymSYI9s+GWvc1x0IU9sGCQpVsndLJ1eMMzaSgzVz8dIezRd7/k/HS4GGz8KNiZ2jDVfnp
 c7wjN+XdRQXpWC2qRBgezSkBBYO58OTuQjDA0xv+b8CbjqBJCbdapflO/lt7ryNb+3XN8JC5dOQ
 YIhjhVdYU3nTYtg8Wq9oRME1R8VCziBOEPSM7OnYvrhhboCQUKPUNwsEEk7C876Ssr6Xwhzg2+s
 rf7n0oAe2dp7xo79Mjf3XuKcCwQcCR0nZmAb0xVbxOvXhbG+BzkFDnwcv6SPu/LgL+Bz3eELxNT
 IvSpL94cTKsI653HKrBxtZAfiJvm/rxot2mjA7pmc+6jWNOm2djCX+Y0VXRCNe8OqjqjcrEnjQT
 IkV/uSXMwte2MxayRUcDLG1rzsUFA2DoS4bR5w6/iwIQIQWtu9+KsQ1oV9LMsta1GV4E2apvumM
 uiSLYCUypySFenb1mq+t71sXvuaLDoDMml58ewc9RqEz+RxUC/4UtXeB2VmTwzcs77p1HyNq6fH
 inBJXCW40vznVwdr14HUSxVYt3p68U3UNWanqZKW2184K08jTVhLuH2KEneZ9ix1b63/moRMZVz
 RNyBzV2Fd0KgbIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This got missed when the flag was added. Document it properly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a204c5460980c898d4ec41fd43d47a..0583a0516b1e3a3e6a10af95ff88506cf02f7df4 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,9 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Some
+    filesystems cannot properly support file locking as implemented by
+    nfsd. A case in point is reexport of NFS itself, which can't be done
+    safely without coordinating the grace period handling. Other clustered
+    and networked filesystems can be problematic here as well.

-- 
2.52.0


