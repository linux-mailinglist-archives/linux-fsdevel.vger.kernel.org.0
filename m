Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97524942C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiASWEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 17:04:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60704 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiASWEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:04:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07BB721101;
        Wed, 19 Jan 2022 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642629839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=itHvYp06aE543pFuixs0a/YyyFcOqlgcA05drNupapE=;
        b=uehwR/QyOF4lVbQgoAzU+vVmySkOUJuAAsgqmqPT/em4lIEOfaBICWKKg+CuXbTlrO6lPE
        rTXXH0gDsQY6MmcKB2NjDvejm5RQUELuxpzSOKAUxiufOiZB/VoVJu0aqd306WZEQjkQpR
        CgBebnu4NrtBzLmTU+Q5+0gR5neFxaI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC45913BB5;
        Wed, 19 Jan 2022 22:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rxFlOc6K6GFdLQAAMHmgww
        (envelope-from <ailiop@suse.com>); Wed, 19 Jan 2022 22:03:58 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devtmpfs: drop redundant fs parameters from internal fs
Date:   Wed, 19 Jan 2022 23:02:48 +0100
Message-Id: <20220119220248.32225-1-ailiop@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The internal_fs_type is mounted via vfs_kernel_mount() and is never
registered as a filesystem, thus specifying the parameters is redundant
as those params will not be validated by fs_validate_description().

Both {shmem,ramfs}_fs_parameters are anyway validated when those
respective filesystems are first registered, so there is no reason to
pass them to devtmpfs too, drop them.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 drivers/base/devtmpfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index f41063ac1aee..ad5f304e2b30 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -81,10 +81,8 @@ static struct file_system_type internal_fs_type = {
 	.name = "devtmpfs",
 #ifdef CONFIG_TMPFS
 	.init_fs_context = shmem_init_fs_context,
-	.parameters	= shmem_fs_parameters,
 #else
 	.init_fs_context = ramfs_init_fs_context,
-	.parameters	= ramfs_fs_parameters,
 #endif
 	.kill_sb = kill_litter_super,
 };
-- 
2.34.1

