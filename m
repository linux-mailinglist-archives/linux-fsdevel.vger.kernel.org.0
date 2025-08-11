Return-Path: <linux-fsdevel+bounces-57434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF6CB21767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2963B3722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2C2E4248;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZxE9GNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE82C21C8;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947703; cv=none; b=b9vSZCyMZjGwZ4PPZ5r7dcjkGmEwbJquhSbGrQTd8lF8BjfBLrJC3bXRGJL7I/Oc4Puf0sZ/eiiX7/QCF0rtZAMlaoGPdLImHWuM75XQwd06tmSd0iGsX4U8egs7Jm0aRZtenRiCrx7oZ0b9h2sIMkpNOONphmjC8NKMWEwoC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947703; c=relaxed/simple;
	bh=dY1PVAFd9XEs8e/MJYNCi7ex0lhE7IhODRbVQ4vJeGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rbn0VUXDDAnPKbyLXRwHsyFW4LeEdSSOHQAZagAMedvzye1D++PBSMKaj5iaMmi3R6Y3pJQSxsyP9PVlKCz3NbeK3J4ZFNMSRue+aJgIlJQhTXwjPSS46X10/rFmU9G+/qWfOPagWJWQhViegAqtP0lZdQDS5mDyJVPwjobiCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZxE9GNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0698FC4CEF6;
	Mon, 11 Aug 2025 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754947703;
	bh=dY1PVAFd9XEs8e/MJYNCi7ex0lhE7IhODRbVQ4vJeGI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sZxE9GNQgPS+AQtEHNZI3FCiFdW4Xkkn7UgyCpygDh62CpZ7a9BMHSnavN/+/lHXX
	 7vhbRP3byBvEHTT/XgmCCuOpkiZ5hitFYxQTZqR+Kdlm8LgbGdTQRb9/8KvfK8Fwk9
	 CfhrT6E8hTvu6Ov0lbChJcCn7VSS0utjG1F97tC6oYUxZNxob5AGZj4DquH9T47RFJ
	 PNOf7PJRz7kJ2K/tWDB2GfB8WEmea0T9YNVX/jDl8cB0HagJ6yjyGPRVt9x4F9FKhn
	 NUtyROvOkWQaAd4jYp1HSQycLYDJSAI3MvECNpfYE5Jns98RAu5OAcmvNsYkhcnqAF
	 yIxH9xJVjUMwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5ACA0EDA;
	Mon, 11 Aug 2025 21:28:22 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Subject: [PATCH v2 0/2] iterate_folioq bug when offset==size (Was:
 [REGRESSION] 9pfs issues on 6.12-rc1)
Date: Tue, 12 Aug 2025 06:28:00 +0900
Message-Id: <20250812-iot_iter_folio-v2-0-f99423309478@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFgmmgC/3XMQQrCMBCF4auUWRtJUsXElfeQUmoyaQelI5NSl
 dK7G7t3+T943wIZhTDDuVpAcKZMPJawuwrC0I09KoqlwWp71M4YRTy1NKG0iR/EytxO7uCTcwk
 jlNNTMNF7A69N6YHyxPLZ/Nn81r/UbJRW0Qdr6y4mX4dL4IgvwXDfs/TQrOv6BfvAsCqwAAAA
X-Change-ID: 20250811-iot_iter_folio-1b7849f88fed
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=dY1PVAFd9XEs8e/MJYNCi7ex0lhE7IhODRbVQ4vJeGI=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBommByYS/YEkj57+WHP3pSNmFCbk5gUi4C/eEcq
 Qz+AJKrqiaJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJpgcgAKCRCrTpvsapjm
 cM6MD/4lU4rtTTqXPBt8LPIaaV3RWYyUSuJ3w8i5LG0SG27gznjJiWiSut1JeWPBMf14hL93kpj
 WD+w6+GPZAQCd7neQ0twT82jLzyGHHhftQTeC660NweGuy1oTzQwKE8Ggs09IT9BFR9i5mKt/zm
 wp/tGRFAtzgvle3Qk997aLtcKW3d5pAK43HwKVOuVtnRyCP3rycYnIJHuPXDiMno9OSK5AMsOik
 ktASMuTu5+mVjDcRQ4LGVktoBoysVj4iez0+cyTtwWpFBrzpdLcLDl2l7OA6SsXGoDgs52i+Y65
 amDu1gUYZJCZZVnrb9nHX1H1+o0vGi1LiHU3FnHbnjbc2BOYydY+DfCfWW7/dAOytmSn1d1qCF3
 NMn06PXJPTud8n50ojkpxxSKwfid7crUZI9mQqbHGaxN4hx2CotSWmKWRLKrTum3rNIt+UH6nbd
 S74wjVMr/tw/iXHjOpoHry1Dr5JKxjHSIay6VKvKsoF9UpLXejXG7hb4+Q98LggGq7HiP6A3xnY
 5tZF/jJrSoOT3ILP4HSInsnJEIUmBZEqIBXAp8FOOijy7HeeaQ9ok2do58XuH2C4DnTVVZiba4Q
 PTUIjq2iXTy3JqG2M39ECbKe+Qx6DkyyJf88Yi7NebxHjR1/C6g9WVgsuFyTJZ7lBs+NarqtQwO
 oUa4jKvFsnafd5g==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

So we've had this regression in 9p for.. almost a year, which is way too
long, but there was no "easy" reproducer until yesterday (thank you
again!!)

It turned out to be a bug with iov_iter on folios,
iov_iter_get_pages_alloc2() would advance the iov_iter correctly up to
the end edge of a folio and the later copy_to_iter() fails on the
iterate_folioq() bug.

Happy to consider alternative ways of fixing this, now there's a
reproducer it's all much clearer; for the bug to be visible we basically
need to make and IO with non-contiguous folios in the iov_iter which is
not obvious to test with synthetic VMs, with size that triggers a
zero-copy read followed by a non-zero-copy read.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Changes in v2:
- Fixed 'remain' being used uninitialized in iterate_folioq when going
  through the goto
- s/forwarded/advanced in commit message
- Link to v1: https://lore.kernel.org/r/20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org

---
Dominique Martinet (2):
      iov_iter: iterate_folioq: fix handling of offset >= folio size
      iov_iter: iov_folioq_get_pages: don't leave empty slot behind

 include/linux/iov_iter.h | 5 ++++-
 lib/iov_iter.c           | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-iot_iter_folio-1b7849f88fed

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



