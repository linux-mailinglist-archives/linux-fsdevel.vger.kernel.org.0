Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914E617C365
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFRBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:01:52 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.61]:17313 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgCFRBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:01:52 -0500
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 12:01:51 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 48A121D792
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2020 10:41:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AG2fjT4iJAGTXAG2fjahBP; Fri, 06 Mar 2020 10:41:41 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YGd4yOt6uoISkY81G59OqxRmykcrtE06U9TVbe/QucQ=; b=c1Z0UpyHFgs/ANLeLX1hAufEn4
        vLKduJy9pbBG77cCmwNLTBWfzDETINqrHJwsnGmeV6NoSoYtn756/scrbX8FjAbLqpzKpmXj7ftR0
        4Nz7xpxeEynkSnAd2S8/Ock0nYBWt3QfynaBfkwaxxLak05WHeg1EYsYxzU9kNxOxvTUrR27XaMkV
        72TZw1kT231uWQhKVAiiK3s0V3YMXLj09kYH5CeAWOdX0WF+evQGnFZhNeO2yvvQvpRrJ6O/P66JP
        ohl2HdtfLoJJAK1jUfOUOsNEiHYN523zbdc0bFZxTJsi98IDOouCHMwanp2vMp6rM2Cx0H35S0B8k
        wClzpDaw==;
Received: from [201.166.190.53] (port=51758 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jAG2c-001q4M-Nb; Fri, 06 Mar 2020 10:41:39 -0600
Date:   Fri, 6 Mar 2020 10:44:46 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] aio: Replace zero-length array with flexible-array
 member
Message-ID: <20200306164446.GA21604@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.190.53
X-Source-L: No
X-Exim-ID: 1jAG2c-001q4M-Nb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.190.53]:51758
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 94f2b9256c0c..13c4be7f00f0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -68,7 +68,7 @@ struct aio_ring {
 	unsigned	header_length;	/* size of aio_ring */
 
 
-	struct io_event		io_events[0];
+	struct io_event		io_events[];
 }; /* 128 bytes + ring size */
 
 /*
-- 
2.25.0

