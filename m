Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F63F5AD5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfF2Ua1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 16:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfF2Ua1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 16:30:27 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B7E216FD;
        Sat, 29 Jun 2019 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561840226;
        bh=7WeyNmN1MYWVxApjRQ0P0HYJKzZFNyxqnIFPjI0Riyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f46H7K3XMOsf2J2p0SY4LlqNUZ/75bdxYF7d+X6d889ykgXzqNABNu7SteeHPFhZ2
         qidegt0COqFCUX41SNYE1XphQc7p1i2ceeNuqzJbU6ne0CAbCA5NZXPn0AhkN3wuaB
         czxNNDHeYdIdCFkXbf1XRZAeFq0dJuyovLEJ79aQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Date:   Sat, 29 Jun 2019 13:27:44 -0700
Message-Id: <20190629202744.12396-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sys_move_mount() crashes by dereferencing the pointer MNT_NS_INTERNAL,
a.k.a. ERR_PTR(-EINVAL), if the old mount is specified by fd for a
kernel object with an internal mount, such as a pipe or memfd.

Fix it by checking for this case and returning -EINVAL.

Reproducer:

    #include <unistd.h>

    #define __NR_move_mount         429
    #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004

    int main()
    {
    	int fds[2];

    	pipe(fds);
        syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
    }

Reported-by: syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com
Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7660c2749c96..a7e5a44770a7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2600,7 +2600,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (attached && !check_mnt(old))
 		goto out;
 
-	if (!attached && !(ns && is_anon_ns(ns)))
+	if (!attached && !(ns && ns != MNT_NS_INTERNAL && is_anon_ns(ns)))
 		goto out;
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
-- 
2.22.0

