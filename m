Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE15E354430
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhDEQEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 12:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242045AbhDEQEc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:04:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E49F613B8;
        Mon,  5 Apr 2021 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617638665;
        bh=V/EI5/0USRO1S1Novl45CCqwydSlfLph0clCRaXR6B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlFx9UwnZjXztBgUIIf4i9mlRefc8wPW8BSbwp+Ybu3UZFufQaBiTGlD+uQOig95a
         1wyXkH4YtT5yEAKM6bN+nSQ5cp0TMn5s7ybdLaVef/XiiB2cEGhmmpKwfHh2GtHy6t
         CGzxHkjZ9UXcUmIpzUVhtrlK4QyjRgKJwFGDSeODfrCPlGkL2OLda72CJ2uQgaFanY
         M0FwhRwjr1ss/9YSRxL0ka3wAOFp/mPwP0FHUSJ6gw22KLhv8Sm7B23C2Qt3RFimAp
         XXdCioxgHVMY3JJQoI5OMqmjw5qUZY39QtSHWk1Fk1fC4ERbopLWgFxA07P8z6TrZg
         IGOjM7zup5dyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 17/22] idr test suite: Create anchor before launching throbber
Date:   Mon,  5 Apr 2021 12:04:00 -0400
Message-Id: <20210405160406.268132-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405160406.268132-1-sashal@kernel.org>
References: <20210405160406.268132-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 094ffbd1d8eaa27ed426feb8530cb1456348b018 ]

The throbber could race with creation of the anchor entry and cause the
IDR to have zero entries in it, which would cause the test to fail.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/radix-tree/idr-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 4a9b451b7ba0..6ce7460f3c7a 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -301,11 +301,11 @@ void idr_find_test_1(int anchor_id, int throbber_id)
 	pthread_t throbber;
 	time_t start = time(NULL);
 
-	pthread_create(&throbber, NULL, idr_throbber, &throbber_id);
-
 	BUG_ON(idr_alloc(&find_idr, xa_mk_value(anchor_id), anchor_id,
 				anchor_id + 1, GFP_KERNEL) != anchor_id);
 
+	pthread_create(&throbber, NULL, idr_throbber, &throbber_id);
+
 	rcu_read_lock();
 	do {
 		int id = 0;
-- 
2.30.2

