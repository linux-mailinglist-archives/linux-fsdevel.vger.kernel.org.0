Return-Path: <linux-fsdevel+bounces-57435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD2BB2175F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B690B1A24B26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E22E4268;
	Mon, 11 Aug 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmLvWZDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884762E336F;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947703; cv=none; b=rWfSZL47MmX+Is7cXRX+0c5nsNSqcC/zDfWCJE10vroY090ppTIaeGPcmT0Gc1Z3uo2AI+VweaMeaMZ/Pk5E4Lc3npUsjOJ8NA3qv3WdgeMTH/ug26gmtce8U/+G9SN+JJ5TleV0BTyKcWcZGeIhHb4KTC/TIvibnlytRgos6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947703; c=relaxed/simple;
	bh=QN0m5GWtPJp7/qt9pQe5ZfZF+f+JOw2bQNcJ/j477Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwhYgF2A21X2IiRypCSGjMv4n37LPGtpuDbl9fEnFcQi7/7Dpq2082agXzF+r6GQlrkpJbPavX2x3qFmyd9towED6OoYi/qoIKzrp00pJOjKLJiYeOhKPALu0GYoJv7s5z73qfVRVv/D1TVCaBKoOPVGvVCcnDNlhU7OYqlrZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmLvWZDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2912DC4CEF1;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754947703;
	bh=QN0m5GWtPJp7/qt9pQe5ZfZF+f+JOw2bQNcJ/j477Lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jmLvWZDdhKvxJ3ULu0XqJ9ONvu/UlBPARRMeUh2b42oQ/2PO9TmDtvFePbuKlUQle
	 9HNXl1PX+FOQt8A7bS842GwkWmysrGBO6PqRUJ4CEXZ2/VkZnsQJKXQ07x7D9L6oXz
	 +/uVUjSKFlo/hVozHwyIsLo4gl2CUD6VE4J7xjd7cFUpzwdA2AxR58Y20Reh92Fr7r
	 HNNkdw5j86hFXaVWcXm3iwAM1L1W1eC2X7LEGbBMjlWbH4O1LVOf0ds1/+xZBzrbU4
	 iJ1SmtbypsSZOAK543LzF07hdwAeDtYDPSdyos5tzZ2LHLZg9XpCkGFuYdU63tRqAl
	 4ZD8Ru5KbA10w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13007CA0EDB;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Tue, 12 Aug 2025 06:28:02 +0900
Subject: [PATCH v2 2/2] iov_iter: iov_folioq_get_pages: don't leave empty
 slot behind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-iot_iter_folio-v2-2-f99423309478@codewreck.org>
References: <20250812-iot_iter_folio-v2-0-f99423309478@codewreck.org>
In-Reply-To: <20250812-iot_iter_folio-v2-0-f99423309478@codewreck.org>
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
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBommB1jlBau7xcwTcqmY8qrpOsUxyecm2YZfnGb
 RD0o4qZhZmJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJpgdQAKCRCrTpvsapjm
 cEb8D/9an6eblnzeoL0M2VSMUQ7QI7IMsT4MlMEeRG5w+2Lfijjtb+z92PO1JsMMYdLjP2ecPF6
 gs7b7OLUpbc6WSRODpT713hfswV+Sc+d4AEBGNCna0Tr9caRapg8JSiC1nMvL4TmlBnHlWfRfx8
 D5X57VtMAsqkaIoY0fs5yu8Ik6W+DXU5MT1TNz4MeI4sRAJc8heC+lXwgcA+gyPJAiW0rYyJVPe
 qUwFP6iq+udqTBRqiV5BOC7RvEU0onpuxdDz/sZk9h88Tpb7S8ZeJgVfaAehBkjaTTs2E/CcMtx
 0xk1QN/JR4W/Xb9gIqB98G+YpdgpAECCH53nmNC0tGD4IzQkO7f35Jjmds6/6NSdzQ9PHmPPf54
 JOYIHEdepLhQoYj7PM5BgCn/UdVslFjYVRkBAFb+TLRMCKqTxMox3oR5dwSJuKmtSgRLAWL8sU+
 X4sZs46mogw9PuvFFxlvR6tYNeZp9qC3iXzprDYxaKYFppZxBpLVFXFFw5F5kUoR9/H5gM7jUgQ
 NRT/KRc1y7a8UkC+uWRzrd4zhT/O1LfM+hCmFOHxLPw3q4XlVoavqlZ1AJO60vLcIActCf+2z/l
 HS+ecvMMzlx+0FtND9QBIJ6e+WIOCH7XAG88mNVTBKPjAfyzYOkbZ4Mtdo3aHNquSSPjgNS/hba
 eWKqMemYBhQyNTg==
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



