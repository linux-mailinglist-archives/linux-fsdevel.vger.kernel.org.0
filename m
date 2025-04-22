Return-Path: <linux-fsdevel+bounces-46871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB739A95B18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA753AE516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEE218E97;
	Tue, 22 Apr 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENj6VofG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9D1F2BA1;
	Tue, 22 Apr 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288176; cv=none; b=QooQ6Jzt8IBu/hRHwySwSatbhFco3+JBH5V+wnSszafUlbQLkZPFrGGVMNKLFNXcKJvcd/NRnuR/6EjztgIvtksali8ZHk/A3/3VQQfd5YO7YLrs8viUBiqPczGy51kYMsfTwzllQWyaUcf+qGbuwAz47C16VpdTlWV6sd7P2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288176; c=relaxed/simple;
	bh=c9j7EFIcKM4M56ND5mZ6VcjyKAs7PlbJZ73+LDc0lNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciPEEjWde2LYLawGpnAGdPf43aGgd22nl/XoAU3ZErTeh21yUxUmYkV+QneS3D/0SmUKKmwvdr12ndqUpi9p7ncr0onpKjFDMuGBuob6QmwMSlnwXSOMGsHihkCEJpVurrojwN3wSt/CG0cwZPGnUKbxQfJse7w1tcXnRf2/TVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENj6VofG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC07C4CEE4;
	Tue, 22 Apr 2025 02:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288176;
	bh=c9j7EFIcKM4M56ND5mZ6VcjyKAs7PlbJZ73+LDc0lNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENj6VofGgCmGTUcIOyGpOqwXzHFeUMQrjCxdwrnKhwG//Ds59hQC48F5/CQC353f0
	 3qmQohX7huRBJoQ0HmWLNSPzxRBvRxI3YqrQiFWvIGcn0ttfKV6qDkVgk30Leoxbjp
	 NYa6aPGyJpKuOmbKlTtu43UsmnTRXZNBfCLkEM4w92OF3D/vY2k07nFsFuQ0tOM3X0
	 WDTXQUyneWdrCshoBTvYWZKevbaMM4D0UK87x9GDsxstAHHPlGiwgslnFxcvzOQcFd
	 +z8PxE++/zQLhDwzrPSXiG9kxVNtT5ds/rBsk3PagRym6psa3zIz7BPaiJNukfw3s2
	 2fHPpvs+cG3Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gou Hao <gouhao@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 13/30] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Mon, 21 Apr 2025 22:15:33 -0400
Message-Id: <20250422021550.1940809-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Gou Hao <gouhao@uniontech.com>

[ Upstream commit 8e3c15ee0d292c413c66fe10201d1b035a0bea72 ]

In iomap_adjust_read_range, i is either the first !uptodate block, or it
is past last for the second loop looking for trailing uptodate blocks.
Assuming there's no overflow (there's no combination of huge folios and
tiny blksize) then yeah, there is no point in retesting that the same
block pointed to by i is uptodate since we hold the folio lock so nobody
else could have set it uptodate.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Link: https://lore.kernel.org/20250410071236.16017-1-gouhao@uniontech.com
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d303e6c8900cd..a47e3afd724ca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -263,7 +263,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
+		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
-- 
2.39.5


