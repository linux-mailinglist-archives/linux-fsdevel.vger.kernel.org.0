Return-Path: <linux-fsdevel+bounces-46875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DAA95B9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC58173AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE332641CA;
	Tue, 22 Apr 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7NlhajG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55671F3D21;
	Tue, 22 Apr 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288289; cv=none; b=fOf5NzNYtmemGzM/42JdlKoDrzPS1Ny0eSw+h2ru0UWMb0u43HUs/zamO0PgxgBIPDn/Gko+tu2r5LAAVr58YMpq+TnJf3lTl856Jgc4oSbc2YG/vXHZR6ZYMdiBhq5BYeu8xc/vJUZxchGMpLGexYv9d56iGGIUsvCjtAcABEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288289; c=relaxed/simple;
	bh=olKNm6l2mt1yuke8IEo25bsaZ6K7UUmzwNfiKP4qxSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+1ijwiRiybsPFJLX6+iP9l9cEQOVuF8osUq67Uh9kC6nVLLjwkTVy6noHGhw9kw9F/uty4syCrJIqqFFwdG2sJLxsxqMwLBCthdl5OHRRdZWa2OYcKfQd5TnX+UjKBUJvtxEI2ymCIx7nSl16SjjNP3ShnDllmuhK6DDK3RKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7NlhajG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB855C4CEEF;
	Tue, 22 Apr 2025 02:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288289;
	bh=olKNm6l2mt1yuke8IEo25bsaZ6K7UUmzwNfiKP4qxSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7NlhajGgycaaQ1zyztIy3YzQSi2vImcq285LCeISBxxKVdrKGqb/bbTtviXt5RVO
	 S/pU+PVriQ3eSawnYIbGQs6uP67p5XzbX6d3tIHj/I0v/SB9SfslTfacXt+Cc6powX
	 yF2nY36ZxiKZV0HTETB08gwi/iriRWMDr1aMSgXYgfHzYEf9j0QV9Xa9G8w1cZeAWn
	 TDz3j8o5HxlTUu3HXybUzU60PEa5h5SYJJ2dGRYMcCBppKSstp48dqjuQar0C3jmBN
	 8I+UnpcgNZDVuz2BkkiHz532gvXpCNdVUhgzS6J5QbGfxHzsJ2826bInWHA6GQcFLc
	 oykxmzvzgD2ZA==
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
Subject: [PATCH AUTOSEL 6.6 05/15] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Mon, 21 Apr 2025 22:17:49 -0400
Message-Id: <20250422021759.1941570-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021759.1941570-1-sashal@kernel.org>
References: <20250422021759.1941570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index e7e6701806ad2..7ffdf0d037fae 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -224,7 +224,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
+		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
-- 
2.39.5


