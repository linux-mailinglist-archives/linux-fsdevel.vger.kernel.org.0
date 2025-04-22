Return-Path: <linux-fsdevel+bounces-46874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD94A95B6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788CB18972CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C825D1FA;
	Tue, 22 Apr 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDxIhazk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049525C71D;
	Tue, 22 Apr 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288241; cv=none; b=kd/y9eP+N1o45nwMWhnrZ+hvV7YTKK3h+E+0QxhrGpg4y8yT8j5NP5rEnJxN3zlyGGqrcbeQtA1FWwisjpQAoHKzUbJ2FuXNN0JdogqrRsBiUDYI6oeJLsd2e+hWX3UydI1FeH1vGrk439X0VKyosPSs2RP2+J4NwQd/0Hl/TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288241; c=relaxed/simple;
	bh=qxyipcJEF9nFX73cKSAdI23BfVbU1XVJJxhmAjlrpXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXW5+SIPYhaCZCVPPaxQJ5MEn38hp1yBByMBob1UlPEsUin3cCiOZR1OSlE+J56HtY6u6VchrisEinz4rRKlFhYqzuvb2vRFEYB8nyyYVPoHV8hWrSCm4qxlwuMuT0e3zhACQu/Sf8FO1EVepHb5e8y7G5l/MWdE0Dfcvxi8IbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDxIhazk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98AEC4CEEF;
	Tue, 22 Apr 2025 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288241;
	bh=qxyipcJEF9nFX73cKSAdI23BfVbU1XVJJxhmAjlrpXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDxIhazkJjmqo0DZuRZbpBp1lmU6viEPY8MmfdIYUYV8ljB9XOPqvi6gm9V/8/JQJ
	 CvTS4rIe7s85IUKALma8uFSzA1CWmg/hxCWR9K4EL52WZPSxUxAHGRN7LkFncvaR8m
	 9xKOC90Ifp/sitfGXjYL7aejyLqev4ljjHEpuKJeBKM6zO6TyRQDd0nvdNdJ1c72Ru
	 HIGqSh6ldMHsGgbfcgUCh1eEzQM695jIMRm9OivHofYR/j/SoiRirxt+iVfomNVAVE
	 jY7Pb/FCE6fp59Pja8/iqCwvQ35kCeObHXeCKfy7mjl9a/hhZdm+/xhtPN0Rep9sT4
	 KhXzd7VOElTBQ==
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
Subject: [PATCH AUTOSEL 6.12 10/23] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Mon, 21 Apr 2025 22:16:50 -0400
Message-Id: <20250422021703.1941244-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
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
index 1bad460275ebe..d4b990938399c 100644
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


