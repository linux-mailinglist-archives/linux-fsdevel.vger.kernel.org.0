Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEBC38772B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhERLMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 07:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:58458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241330AbhERLMW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 07:12:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E575AF19;
        Tue, 18 May 2021 11:11:03 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 17e25bfa;
        Tue, 18 May 2021 11:10:57 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] vfs: fix early copy_file_range return when len is zero
Date:   Tue, 18 May 2021 12:10:55 +0100
Message-Id: <20210518111055.16079-1-lhenriques@suse.de>
In-Reply-To: <877dk1zibo.fsf@suse.de>
References: <877dk1zibo.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The early return from copy_file_range when len is zero should check if the
filesystem really implements this syscall, returning -EOPNOTSUPP if it doesn't,
and 0 otherwise.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Hi!

Since I got not feedback, I'm sending a patch that should fix this issue
reported by 0day.  Probably this should simply be squashed into v9, I can
send v10 if you prefer that.

Cheers,
--
Luis

 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..24b4bf704765 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1498,7 +1498,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		return ret;
 
 	if (len == 0)
-		return 0;
+		return file_out->f_op->copy_file_range ? 0 : -EOPNOTSUPP;
 
 	file_start_write(file_out);
 
