Return-Path: <linux-fsdevel+bounces-39078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929FA0C05E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129F818882AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB34212D9C;
	Mon, 13 Jan 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np2RYKA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11851212B18;
	Mon, 13 Jan 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793358; cv=none; b=e3aztsm/fWlacndEx75XaMyLiN93imae+f+hifaO7q0jKpWBCxcBnLW2B9kSYdXSXito+jO8cmWYVkR7ia1bpFozoWmQ3u3utUmeG2Axh3qEgEHzOajLPpEiqUH7IjlC/Qh/5BmM3KDqziaddcN+9DqdKGuGnRGWNFilWsyRMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793358; c=relaxed/simple;
	bh=jVhsJjvzz32AdO6tvAcF9a4PjY7qms/GrqQJ2cSoJjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WC6VjQbQcBcF5wEcQPNAxdGq9sCVxhHcDhzRms6hQxjnQM1DjIJ1ZQTEEbssFLp3vASHAofMnIkhhbM0aFt8ncJIatBTB44/AS0J9ODFT2tKQM20aHXFkXHhTrs28+gMvaKkizv6yH6zkzRTZ6sc3mRE0ESf9Y404/fsvMSW1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np2RYKA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047CC4CEE1;
	Mon, 13 Jan 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793357;
	bh=jVhsJjvzz32AdO6tvAcF9a4PjY7qms/GrqQJ2cSoJjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np2RYKA3zHQrjfLA5cY2++bn+dabuN0Vr5arJ+EoXkNZhD7IAuTTBX4knrCC3q/1V
	 my1nmqDZqLZovtkRzkebZWv4VNskYwMd/+Zc0FvTYj9E6yQ+ePQbdd53n82cMCT9qI
	 1Yw9jKtMRGOndY1MkSThN7JzQcOfC+aV3YAY59KaDzMbtwx1vUtSXLcJpyFETWKSQp
	 ohc24hfvyBdYx1x2GlkSlNT5++ZpMd9Ae6QAgnMyHZwGP0IVVQrNV5bR3hUhiEkHQT
	 V+KXtkDRD2GbHx9U8JkJaA8iXVwj7OS/d2e+VSlUYhVa8+YM28J9vjgzCIiqwUrvG+
	 0+yJ0igFGi9zw==
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
Subject: [PATCH AUTOSEL 6.1 09/10] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Mon, 13 Jan 2025 13:35:35 -0500
Message-Id: <20250113183537.1784136-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183537.1784136-1-sashal@kernel.org>
References: <20250113183537.1784136-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.124
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
index 47f44b02c17d..70e246f7e8fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -907,7 +907,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		}
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.39.5


