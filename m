Return-Path: <linux-fsdevel+bounces-57260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E3B2007B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CE73B6878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364772DA768;
	Mon, 11 Aug 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2oFKiqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4651BFE00;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897957; cv=none; b=rZV7iQj0hrh1SSGLNaaFG3aKdfiLQozKCLNzqmgqdKuRhrbKE72F/VxKnDTGDI7G1y16Mest6CMj/XLWKlcHuiIPmBmhE/Jhm6PC+6V+wosKeZSiSva3pQLqRmzF8h+FXtgUpzN5akcTZgfpzWjN9blO0a6qyn3DZAyGQtm9gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897957; c=relaxed/simple;
	bh=OiKe40GZglghieSU5PgnFpjyLGbBmPgEA6lc+Og5PKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAx5nb20dkDkHpkmbDfea1G7MO0HA9uS/sxomdvu10DrhH22cTIMbC3o+4w3YUlar6ArjzeL4PG/z1/FUce0Or7EuBR15jF/dgfBfYbNbee6YFs531LNMXAolK4Y9UImSeV2WMVF1eV/Md3NQTHHaB9QL1IloXjVtXO8b2Uu/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2oFKiqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA4DC4CEF1;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754897957;
	bh=OiKe40GZglghieSU5PgnFpjyLGbBmPgEA6lc+Og5PKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S2oFKiqTCgAf9lHfu+ZPOBGjKFkwcwbEHKt6mtXsCEAyb7mBU9xbGqzP0rzAO/OJe
	 mKs6KcXvEAQSUesuFuYucdrsPDakfGk0rmg8ghrUeWh5/ThnEC0r3WErNu0vMfQvcr
	 3ITgi6BXY00pjz1B5xsF9PCRQ2+7XNtSiM4b656u7c0mNc9LQweDk8vuW36XNyJ3rf
	 Shu/gTH9K/zICnG+9sAHuSBGxnV5NYDadbe9XqFWx4qS8cJ2PYsAvHNhk4VERBwxgC
	 30ruy3bwEwWwOXUXQRs2dIKvMXZpkqHg3nJgUTnoGJLOX3+ze8KK92w3U5Tfl38uJv
	 ZUcSgMUyuRdqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17DCA0EC1;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Mon, 11 Aug 2025 16:39:06 +0900
Subject: [PATCH 2/2] iov_iter: iov_folioq_get_pages: don't leave empty slot
 behind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
In-Reply-To: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=Gnweznn9Yf2tL9n/TItIqJV0L8m6ff7ta3Y3p0JUXrk=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBomZ4juLVGBQDWHE7zCanhXyXfjVv5/SO1+HqYv
 UGZFo18LJeJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJmeIwAKCRCrTpvsapjm
 cCe2D/9AMYNS6PUmG3VauQsdgyu9ikb3/E+f/a2g0lbGg83sq4XtDxWh83GsQXmHgPrlNyDUsCa
 +1cyM7QTyN8k15Pkt83L6noZ14CQIGBnT6ZWcBop0tK+qen0/+WV11y81L26gk8u0CIOoWzLZUz
 HZlLivDANjbXZnx0UipBnWncTwH4yyhcp3jVhpwEeOWqzYlkB+MF8q7sn8KTf3/sjHY6Nf+9Fxx
 fsvZ34ZcuC1GSySo+HSgCQviOwdt3HsbxKiGSTrHnvZjdDrLXECECHh3l6MsAnmZIE36dvRdZ+X
 raXvmlP3fdEIXQp3+ty0DrAswPxvcVIGK+P+TOMc1eLJ4qBhGtppcUJTkCKjP+2nrxeXTJS2IKW
 bXCV1/0hhc7aJS+ReVWbxyMtOWck0ATemIdSU2pwbL5fUcv2Uuc9wL7LFw91H2diUKm9IOQvDLB
 UH4QS3Kg7mxjZSI4MvFnbrNk9oDWAMUEEEaSWfEFNSOlZy0dcpqD27U3h680r0PnVbmh6ljktQy
 O+pCQza+b8RV70SfbHEZp87bGvNi2sc2uApzkuX2eprO7zmaKHHmXXxC6CzLfjAK5UMj4UTHLTN
 lCCM9HjJ+9QAU2GA3MC9YDRnDd9/wVsUq3eAK946tgu5OwU8wEOKSOL2pndP3s9LSCmacgmhcE6
 Gt+u8IJlxOLwKow==
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



