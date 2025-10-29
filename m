Return-Path: <linux-fsdevel+bounces-66190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54EC18A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D5E3B03B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2A831280E;
	Wed, 29 Oct 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vzMc7qz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9193126A3;
	Wed, 29 Oct 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722159; cv=none; b=svXnjNipa7SKFMZVkQCUvfqyk3F8EfZXONYIRRRnSOQXz/3oL47ZBqBo7cJb9CbZHoT4KERd1lN1AUK6rHV3gnTrija5Wu2hD1F1Et8ErV1ANQ99nUZKK2sqEILQuQsCzYI4oTEQlSWSpJTIhgm0z8DBZ3UmLSuarmmv29E0Ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722159; c=relaxed/simple;
	bh=GVssRKPzqWub7y8tI5GYZ2WT9JPRcLQKmvCAXtiAnnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcI4n6Hv1Sqdt96hykrTa8R0DQkl1mI6CmjsXH1LzFJ8srNrxnORlRpmMgb2X3xaxsNuiUzhjdtDSIDREWVXftd6OoFEntamFEPiIWEnK2SID55jSvaPjhsE4I2FkNzT1gJk1ZkLeFsgSRqUXIYvvp0Fubw3YLnbJAdXmB3/ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vzMc7qz1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PPnboS+kMa91t5MZUgcSyTM7DRLWjnY4RO0Lr3qvOb8=; b=vzMc7qz1Ev9TiZOByoaSLDpj3E
	V7mgVJaZQVISu9Xj4CqnqNiNRkN7xGwHbyxkrJuJIcY7iwqExvueGhQjCVLuGyEApprbOQpudqMHN
	c1WXvYjcEYYB3eBWLzUV/guA/9HNF3LhNlPhMbz3weLZuk7ixdQDVxhsff7vdZ9DTPKnbYo0mD1ne
	qVSUomU4aHnABIqW9IqGI83ZV1tL4KXUP2jgesW8AaiHlhcs4puSkO11Y0GuK7GXgMs0VIP/Pv2+c
	YSa1JTRm7oGubfN20shDZ4kiOhZerq5j0XC+BNFNDRbi2PAMPzFMZ9HvBNJVl6HS18sSIkwMZLlAm
	IKZRedkQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0PU-000000002ci-2ZSq;
	Wed, 29 Oct 2025 07:15:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to buffered writes
Date: Wed, 29 Oct 2025 08:15:04 +0100
Message-ID: <20251029071537.1127397-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Doing sub-block direct writes to COW inodes is not supported by XFS,
because new blocks need to be allocated as a whole.  Such writes
fall back to buffered I/O, and really should be using the
IOCB_DONTCACHE that didn't exist when the code was added to mimic
direct I/O semantics as closely as possible.  Also clear the
IOCB_DIRECT flags so that later code can't get confused by it being
set for something that at this point is not a direct I/O operation
any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5703b6681b1d..e09ae86e118e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1119,6 +1119,9 @@ xfs_file_write_iter(
 		ret = xfs_file_dio_write(iocb, from);
 		if (ret != -ENOTBLK)
 			return ret;
+
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		iocb->ki_flags |= IOCB_DONTCACHE;
 	}
 
 	if (xfs_is_zoned_inode(ip))
-- 
2.47.3


