Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7914F17E9DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 21:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgCIUTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 16:19:38 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.154]:47259 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCIUTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:19:38 -0400
X-Greylist: delayed 3633 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 16:19:37 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 756174036C7EE
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2020 13:10:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BMr5jyIJREfyqBMr5j0w2A; Mon, 09 Mar 2020 13:10:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RyR+AnHFtg8ENe4FqD1p4qkHhSuKpxiB0Z6NTI7dKPk=; b=zjAn8OAcZerZeuOTAPs7yu0wq7
        NZ0gyMiRZ1hSKI0AlWbcWHF8HOurzuz1D7KN3dy7B1Jj2EETPYetwmXZnrhofciakuRqq3HL0AD/c
        EmoGKNvhqjhAfb9ein4ilFbJlf+BWgzra1OAEuSzRisBFB28h3z7KcpbeeD2zdIyUBtOTRmmdXzaK
        LZIcBwBr1eeBshrSI2Zp8dz3bitl4AnNZHrs1q5adc5Bcl0xo8edyiE6ydF3FmGmvnMHg9wpdQD0K
        Ywk2bl4gThm55+yR7X0MpC9Hmb/SxSA4JSpfbkyI9NlcZFCO5Uun5iTsrhLYFiVE+rc0z5Ad9BeuI
        4gM/I0YQ==;
Received: from [201.162.240.150] (port=7181 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBMr3-004FeC-G9; Mon, 09 Mar 2020 13:10:17 -0500
Date:   Mon, 9 Mar 2020 13:13:29 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] hfsplus: hfsplus_fs.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309181329.GA3925@embeddedor>
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
X-Source-IP: 201.162.240.150
X-Source-L: No
X-Exim-ID: 1jBMr3-004FeC-G9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:7181
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
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
 fs/hfsplus/hfsplus_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3b03fff68543..a92de5199ec3 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -117,7 +117,7 @@ struct hfs_bnode {
 	wait_queue_head_t lock_wq;
 	atomic_t refcnt;
 	unsigned int page_offset;
-	struct page *page[0];
+	struct page *page[];
 };
 
 #define HFS_BNODE_LOCK		0
-- 
2.25.0

