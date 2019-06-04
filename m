Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0334E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfFDRHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 13:07:12 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.164]:15994 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfFDRHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:07:12 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 13:07:12 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6B0E5CBF2
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2019 11:42:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YCW9hjp2t2qH7YCW9hwTYE; Tue, 04 Jun 2019 11:42:33 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=39676 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYCW8-001WsQ-1y; Tue, 04 Jun 2019 11:42:32 -0500
Date:   Tue, 4 Jun 2019 11:42:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] fs: select: Use struct_size() in kmalloc()
Message-ID: <20190604164226.GA13823@embeddedor>
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
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYCW8-001WsQ-1y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:39676
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kmalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/select.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 6cbc9ff56ba0..2a179ab68c60 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -966,7 +966,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		struct timespec64 *end_time)
 {
 	struct poll_wqueues table;
- 	int err = -EFAULT, fdcount, len, size;
+	int err = -EFAULT, fdcount, len;
 	/* Allocate small arguments on the stack to save memory and be
 	   faster - use long to make sure the buffer is aligned properly
 	   on 64 bit archs to avoid unaligned access */
@@ -994,8 +994,8 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 			break;
 
 		len = min(todo, POLLFD_PER_PAGE);
-		size = sizeof(struct poll_list) + sizeof(struct pollfd) * len;
-		walk = walk->next = kmalloc(size, GFP_KERNEL);
+		walk = walk->next = kmalloc(struct_size(walk, entries, len),
+					    GFP_KERNEL);
 		if (!walk) {
 			err = -ENOMEM;
 			goto out_fds;
-- 
2.21.0

