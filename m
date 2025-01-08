Return-Path: <linux-fsdevel+bounces-38643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68880A055F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774733A6C68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32331F12FB;
	Wed,  8 Jan 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGaVIAWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE151A76DA;
	Wed,  8 Jan 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326578; cv=none; b=WWkclNem8PHqK/b+8xGb9evSXjdqvY+tYFlfYSH9s2TisxrYn7DtFD55ODZvXKoB87vBt0bIayTVpnpzYEKm55HK6Eq7P/rj31zfOZdv4syneF9wyM3DL0oiG7GNWkQJu/4lvWw1NkACxU4L8QG1B7YCvZ6ULmMDMCfSuhsr05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326578; c=relaxed/simple;
	bh=DhZnXtiTJ1FIFK8GMsHlxIaDaWSD8UQCn5mUQ6LGYEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdTW9Ks3f+YK2RJUEiFsav5jf3mU4wx/i+q1TtfyedR1N9QJWQdxT4NA0/jF7XZ2CRl369GBmpwHDxHurLlYvDklpN/N0JIA9lb7kdJ/cr0KxVHSFGJQjsXPbt45o6qaMHlmSgcIPtsVBGhTx/19TALISQ2rFfplGX8y7HxsJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGaVIAWr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xo7BUxJFV4bvhgSHOhh1+Mfex/rfflOgW8x2sCnQfv0=; b=pGaVIAWrfZhAk+xs/T9StkEHNN
	qc3YqrWYSWVfktCDMD5d1ihaUh9VW/Xdh18OooqxImE2wuS33K7q6BhDUx63ZY1jQKXkt6dJUpDT3
	yCg7KMntOtdL/QnlD9MhESavuFtiqZzoG2LvI5GW948w0mh5pXW9t8l7XOql2l3zKgsKRZG/6CYgw
	27D96FuW1SHaOTnYmJkmhN1FyKJtJ3M7iu9+VpeGkmAtd13l8y723CfWQuF2GRlA9GdMwZXAIgdzs
	PMWvf8wEIrRj3tc13lSvaIpkeTYvTsOXe1R0hg1upYA8TomtOyD25viosmHqrx6VCbFouFr0FhiKA
	2XDdhESw==;
Received: from 2a02-8389-2341-5b80-e44b-b36a-6403-8f06.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e44b:b36a:6403:8f06] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRrK-00000007dsg-1iyR;
	Wed, 08 Jan 2025 08:56:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 5/5] xfs: report larger dio alignment for COW inodes
Date: Wed,  8 Jan 2025 09:55:33 +0100
Message-ID: <20250108085549.1296733-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250108085549.1296733-1-hch@lst.de>
References: <20250108085549.1296733-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

For I/O to reflinked blocks we always need to write an entire new file
system block, and the code enforces the file system block alignment for
the entire file if it has any reflinked blocks.  Mirror the larger
value reported in the statx in the dio_offset_align in the xfs-specific
XFS_IOC_DIOINFO ioctl for the same reason.

Don't bother adding a new field for the read alignment to this legacy
ioctl as all new users should use statx instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_ioctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0789c18aaa18..20f3cf5391c6 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1204,7 +1204,16 @@ xfs_file_ioctl(
 		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 		struct dioattr		da;
 
-		da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
+		da.d_mem = target->bt_logical_sectorsize;
+
+		/*
+		 * See xfs_report_dioalign() why report a potential larger than
+		 * sector sizevalue here for COW inodes.
+		 */
+		if (xfs_is_cow_inode(ip))
+			da.d_miniosz = xfs_inode_alloc_unitsize(ip);
+		else
+			da.d_miniosz = target->bt_logical_sectorsize;
 		da.d_maxiosz = INT_MAX & ~(da.d_miniosz - 1);
 
 		if (copy_to_user(arg, &da, sizeof(da)))
-- 
2.45.2


