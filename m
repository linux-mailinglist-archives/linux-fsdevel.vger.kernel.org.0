Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32328D8D21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404448AbfJPKAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 06:00:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44909 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJPKAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:00:00 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKg61-0002a8-90; Wed, 16 Oct 2019 10:59:57 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKg60-0000sk-T9; Wed, 16 Oct 2019 10:59:56 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsnotify/fdinfo: exportfs_encode_inode_fh() takes pointer as 4th argument
Date:   Wed, 16 Oct 2019 10:59:55 +0100
Message-Id: <20191016095955.3347-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The call to exportfs_encode_inode_fh() takes an pointer
as the 4th argument, so replace the integer 0 with the
NULL pointer.

This fixes the following sparse warning:

fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/notify/fdinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1e2bfd26b352..ef83f4020554 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
+	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
-- 
2.23.0

