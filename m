Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095C61CA42B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEHGjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 02:39:00 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8DC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 23:39:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id E6CA2C028D
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:38:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rxfrAlxaMMkT for <linux-fsdevel@vger.kernel.org>;
        Fri,  8 May 2020 08:38:58 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id C8338C0271
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:38:58 +0200 (CEST)
Received: (qmail 3890 invoked from network); 8 May 2020 09:55:18 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 8 May 2020 09:55:18 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 9F32F461450; Fri,  8 May 2020 08:38:58 +0200 (CEST)
From:   Max Kellermann <mk@cm4all.com>
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Max Kellermann <mk@cm4all.com>
Subject: [PATCH v2 2/2] fs/io_uring: remove unused flag fd_non_neg
Date:   Fri,  8 May 2020 08:38:46 +0200
Message-Id: <20200508063846.21067-2-mk@cm4all.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508063846.21067-1-mk@cm4all.com>
References: <20200508063846.21067-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 fs/io_uring.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d24f8e33323c..0aa7cd547ced 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -604,8 +604,6 @@ struct io_op_def {
 	unsigned		needs_mm : 1;
 	/* needs req->file assigned */
 	unsigned		needs_file : 1;
-	/* needs req->file assigned IFF fd is >= 0 */
-	unsigned		fd_non_neg : 1;
 	/* hash wq insertion if file is a regular file */
 	unsigned		hash_reg_file : 1;
 	/* unbound wq insertion if file is a non-regular file */
@@ -4572,8 +4570,6 @@ static int io_req_needs_file(struct io_kiocb *req, int fd)
 {
 	if (!io_op_defs[req->opcode].needs_file)
 		return 0;
-	if ((fd == -1 || fd == AT_FDCWD) && io_op_defs[req->opcode].fd_non_neg)
-		return 0;
 	return 1;
 }
 
-- 
2.20.1

