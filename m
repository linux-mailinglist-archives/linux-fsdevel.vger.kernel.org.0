Return-Path: <linux-fsdevel+bounces-57638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D72B24115
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52229727EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993C2C17B3;
	Wed, 13 Aug 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN2v0O2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA82BEC25;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065108; cv=none; b=hWYXcjGFMvo5SO3d2mCCv+JpqImsg5CCKUyC4qUOq3LHDDhv+A9MMi08racK1TMQnpba2/ANb5tnCQpDLDa/XsJ0Foq/DH4X628CgBrotV1GoKqCK+eUdKgjYqqr4S43qG/7FnTUmcHepdCSHraynHikN4gqWnKsFEx0vPYt/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065108; c=relaxed/simple;
	bh=QN0m5GWtPJp7/qt9pQe5ZfZF+f+JOw2bQNcJ/j477Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnzQe2MhoVnCZQy+KEmXsK4kc4Stfc8DW72ylRSnSIRMy3GunBGIRjflht/usXO/byh5BiLOG0d889QNggI0v14x5RXJ6ROpXiBzLyZ72lZRgEKs824wP0b/YBHavddKsTsvvICx/FSmMIiVvncg6SSK9Yhyt941oQ8idyrURrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN2v0O2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1014C4CEED;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755065107;
	bh=QN0m5GWtPJp7/qt9pQe5ZfZF+f+JOw2bQNcJ/j477Lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vN2v0O2D6b7ZNBrVP+aI0EyZqNil4Arrmo09niChnyGCF3ZxneVKyV8YWGJMVxlfk
	 plM5Bp7HBTnc1lDhWi5RNv4Y2fp0W3UkNP5b3JWbocaMVq7bBna90EkFLoKLvXiIAO
	 37qgb9K/qy+7vtOzljExb5SYP6UfNQ7PjheFtUZTBaK/bh9kvMxeYoTIoJP/x+kPvk
	 osSFa6+BUQvYhV66e0NBCHXVuM5ISij5HVMzkO1/xxV9lLb3oKWnTj0z0ewakiv1cn
	 VxJwmzpySOo5lBHuHP6T8uX+FPvTp9YVj3w2c62zXZ/e5b3G0PLh2UxHSQHU/rc7dA
	 9kk0r85xlszXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C0CA0EE3;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Wed, 13 Aug 2025 15:04:56 +0900
Subject: [PATCH v3 2/2] iov_iter: iov_folioq_get_pages: don't leave empty
 slot behind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-iot_iter_folio-v3-2-a0ffad2b665a@codewreck.org>
References: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
In-Reply-To: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=hWtTUCvGG0PvbE6UasHSB7hwyWcYL54anMdr7Xzd+hY=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBonCsS8DBTLsHW8XBOAEFJt6+XqEbzlCN7ATJz5
 Z0/42O1PsmJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJwrEgAKCRCrTpvsapjm
 cB0zEACWziYzUV7u3M9j8x4M7D0PqLTmDhsm+2LNpUdUGwVgEYqYBL80OMm9OztuncWP112oyQP
 0nmA+62qaQDsmL38BAg/PVV2TAz8dgghGiVojmD6ZEyatETk9VubTS4YstNToWX4cLbLKxpvY8w
 BMsIfW6IpwSBhJJifmj/+WQx2trAMD9ir13yPnvU6IUMdebf7Fsl5G4Ser1Vy5V+ViqOkrBgPpU
 uAhi6DKdn6PUaLaZzro/nT3ysBMZjXL3Lw2Mvrt7dRPhSyM3ZCsBazHMRAnUVNjPAJIHMwzCbWH
 Q/Vt0gYuNbuf4jrdwVu4lkQfkIVE0W3PgyJVba+dFE0M+oOavlZ3xLp95r/rLLzDEMH/EIyZRJY
 PK05FQN/I8q2pmNuNpRd6KAd8u0nfcpZ/aDnnE3+CM7K3u9/9tL/zhq4LpLHeF5MBqIt+/iQljn
 h5l+hzwpSJHG28KiwuV6oXWyFhuwMKrAA9OTxICwwKEPRHxWUpthkrXBWDP2kObujVhpUZjDnsc
 eKjXZoznHbqdhmT2VUrxb3wvKAXBmRfqXVKxXix8v9FHziA1ZuGYyhB5eMk8M72Z/ChMXxGpPuS
 6slhyOnhff3Xmv0ydjbZ2ngePhFFWsiBQ/Q5sH/84aqe+o9299b+6scTEQSfjhpKwjqRPISafgY
 rh9QyztOL/OFUDA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

After advancing into a folioq it makes more sense to point to the next
slot than at the end of the current slot.
This should not be needed for correctness, but this also happens to
"fix" the 9p bug with iterate_folioq() not copying properly.

Acked-by: David Howells <dhowells@redhat.com>
Tested-by: Arnout Engelen <arnout@bzzt.net>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 lib/iov_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49945297479483755d68a34c6d4ffe..65c05134ab934e1e0bf5d010fff22983bfe9c680 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1032,9 +1032,6 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
 			maxpages--;
 		}
 
-		if (maxpages == 0 || extracted >= maxsize)
-			break;
-
 		if (iov_offset >= fsize) {
 			iov_offset = 0;
 			slot++;
@@ -1043,6 +1040,9 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
 				slot = 0;
 			}
 		}
+
+		if (maxpages == 0 || extracted >= maxsize)
+			break;
 	}
 
 	iter->count = count;

-- 
2.50.1



