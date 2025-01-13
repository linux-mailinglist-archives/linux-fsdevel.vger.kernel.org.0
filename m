Return-Path: <linux-fsdevel+bounces-39075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89588A0C03D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2939B7A1CF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0B20767B;
	Mon, 13 Jan 2025 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qan7dPNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22C1CB501;
	Mon, 13 Jan 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793334; cv=none; b=ln0BnL+hm70jmYhv3UEpCumOnnNU70agO4pjrpjU/qalQiNq7tG94kpdXk9WYFAi4+lFgL2UWbKb+oFfXArQADiR17vJ6qDbu3DjJ4J7H7RqB2iGqK+Y+k5BB1bRAx+PX+Cad0aBOuLnu8BWClhvZPhjB+w28XtugBgaqcLwgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793334; c=relaxed/simple;
	bh=QsA1Krjmg5wmxGv8YXarj+7ikJ4Flrmg1BcZiU71ZW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncvdoz4Xm8yBcTKLw5FxATCrnSB/wudCez3VZxWj9aFWl9Pua9GaImK/JLhrR337xmmPiqyZx6OE1JFUfu6xqGu1o1ez9AtB5rCfIy+bUAbCvBqoM56IC3a5ZTL/fTwt+mPV/zy2840cpsFP4UhmDvrsYr0U2+biWaS0G3+vBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qan7dPNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF9C4CEE1;
	Mon, 13 Jan 2025 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793333;
	bh=QsA1Krjmg5wmxGv8YXarj+7ikJ4Flrmg1BcZiU71ZW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qan7dPNe/Q6F1+SekSueUxEJM+3zBaqz4kqVdygfKeKIWfCXi2vktleiHq5QEZ4Pn
	 WXIUFX0ln9onwdG39fi7qHSzIEdZ7AD9PZJEjuXWw2sE0yB7d2h72Nfo2ddgZfP+Ls
	 W5MrU324kGFq2gG4SbuksH4+foem8lGpKHOf4wtPswiC2RHDW++HWUQQWJ3ZpqTHkK
	 A2nzkzV7abuQieNLjY7PRGUpuQ8gIhFyaWPqMFDsw5xGuEdZC1fMm+BUV9rFGexDqo
	 cpw6iGFAaaLPGbivFydtpXwKJFQIvQJ/yCLchFOz3T1oAc9fjpvG3GIwH7iH5GNHqm
	 K7HR7z7JBbJKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Nelissen <marco.nelissen@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/10] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Mon, 13 Jan 2025 13:35:10 -0500
Message-Id: <20250113183511.1783990-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
Content-Transfer-Encoding: 8bit

From: Marco Nelissen <marco.nelissen@gmail.com>

[ Upstream commit c13094b894de289514d84b8db56d1f2931a0bade ]

on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
32-bit position due to folio_next_index() returning an unsigned long.
This could lead to an infinite loop when writing to an xfs filesystem.

Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
Link: https://lore.kernel.org/r/20250109041253.2494374-1-marco.nelissen@gmail.com
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a05ee2cbb779..e7e6701806ad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1095,7 +1095,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		}
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.39.5


