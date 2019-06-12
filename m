Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5EF42F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfFLSoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfFLSoL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:44:11 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562BF206E0;
        Wed, 12 Jun 2019 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560365050;
        bh=k6XhKo4tLkZYiTtqJuhymE61FS6ceGjNgw92LnacGLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHvfgg1hqasjQa2CDaeC2qWRoB52XpPScocrDwcWENjw4puUMw9jTrqtm/5N8pYaT
         kF0kZ8InqQCKAwHdx6S2V2v4MmQzp5e8v+2xgeTj9mO/kM20k6MhRzzEdRN2RrQ9Og
         e87pXxd15WbSjzRxnTpxnVahlNd8zXEzkVs0BQ+4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: fsmount: add missing mntget()
Date:   Wed, 12 Jun 2019 11:43:13 -0700
Message-Id: <20190612184313.143456-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610183031.GE63833@gmail.com>
References: <20190610183031.GE63833@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sys_fsmount() needs to take a reference to the new mount when adding it
to the anonymous mount namespace.  Otherwise the filesystem can be
unmounted while it's still in use, as found by syzkaller.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: syzbot+99de05d099a170867f22@syzkaller.appspotmail.com
Reported-by: syzbot+7008b8b8ba7df475fdc8@syzkaller.appspotmail.com
Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236e..5dc137a22d406 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3445,6 +3445,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	ns->root = mnt;
 	ns->mounts = 1;
 	list_add(&mnt->mnt_list, &ns->list);
+	mntget(newmount.mnt);
 
 	/* Attach to an apparent O_PATH fd with a note that we need to unmount
 	 * it, not just simply put it.
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

