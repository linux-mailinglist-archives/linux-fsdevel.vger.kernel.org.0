Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF414D44B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 01:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA3AFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 19:05:45 -0500
Received: from bes.azurecrimson.com ([172.104.212.111]:44384 "EHLO
        mail.azurecrimson.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3AFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:05:45 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 19:05:45 EST
Received: from sekhmet (50-107-163-230.dlls.pa.frontiernet.net [50.107.163.230])
        by mail.azurecrimson.com (Postfix) with ESMTPSA id B40DBF6250;
        Wed, 29 Jan 2020 23:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.azurecrimson.com B40DBF6250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azurecrimson.com;
        s=bes; t=1580342267;
        bh=SW+HnaMOmyjOUGYrYfr2VCXWewEK4mxbj73LzBK3K/E=;
        h=Date:From:To:Cc:Subject:From;
        b=Y8W55IdOxJLLFxbAVq/rfthBlsrqVJ7EKm8LqMaLE+J39btXlR/DxbAscOopxh2YN
         llE9qL/45kpdY6MD5WKKkLj3Pd/lPemG133gp3sSageom8zW+kcATxoslWJqWAwqY9
         BBlW7xbMCDKa6mzlPhfZEFHZArd6niUya+IovFbA=
Date:   Wed, 29 Jan 2020 23:58:23 +0000
From:   Liam Dana <azurecrimson@azurecrimson.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCH] splice: fix splice_pipe_to_pipe() busy wait
Message-ID: <20200129235823.GA32247@sekhmet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not
cursor and length")

Commit 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not
cursor and length") changed the way buffer occupancy is computed. During
the refactor an early-return check in opipe_prep() was inverted, and it
no longer waits for a reader to drain the full pipe buffer. When
splicing 2 pipes (via the splice() syscall, SPLICE_F_NONBLOCK unset, and
opipe full), this causes splice_pipe_to_pipe() to busy-wait.

This bug can be reproduced by running the following command:
$ yes | ./bug | pv -qL 1 >/dev/null
where "./bug" is the following C program:
int main() {
 while (splice(STDIN_FILENO, 0, STDOUT_FILENO, 0, 65536, 0));
 return 0;
}

The above program will spend the majority of its time in the splice()
syscall, and will not return with ERESTARTSYS in the event of a
pending_signal(). Meanwhile busy-waiting causes high power usage.

Signed-off-by: Liam Dana <azurecrimson@azurecrimson.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3009652a41c8..06a21449e030 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1503,7 +1503,7 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	 * Check pipe occupancy without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		return 0;
 
 	ret = 0;
-- 
2.24.1

