Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D0143411
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 23:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgATWek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 17:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgATWeT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:34:19 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8125524125;
        Mon, 20 Jan 2020 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579559658;
        bh=z2Y0IHglkKCvSNW3HrTdG8/6BD+OKkO7hiP7aqvSJao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZB3SVJ8mSzoYzK9TQg1dPhopO5UVnGDpovyzD09WXgRSNwFHyvEGuEnJuXKB8QU0M
         PwAjhqcs/SkmEahZUDCqWX/w8vAfdZ7DzKFpXQHyzzwViiMZ8WwPjBUBOy2vdNNi/P
         /gzyfLaRHRr2ZdmVU0xfBIzVXnFBcyFDVqXiNG6M=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 4/6] ubifs: don't trigger assertion on invalid no-key filename
Date:   Mon, 20 Jan 2020 14:31:59 -0800
Message-Id: <20200120223201.241390-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120223201.241390-1-ebiggers@kernel.org>
References: <20200120223201.241390-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If userspace provides an invalid fscrypt no-key filename which encodes a
hash value with any of the UBIFS node type bits set (i.e. the high 3
bits), gracefully report ENOENT rather than triggering ubifs_assert().

Test case with kvm-xfstests shell:

    . fs/ubifs/config
    . ~/xfstests/common/encrypt
    dev=$(__blkdev_to_ubi_volume /dev/vdc)
    ubiupdatevol $dev -t
    mount $dev /mnt -t ubifs
    mkdir /mnt/edir
    xfs_io -c set_encpolicy /mnt/edir
    rm /mnt/edir/_,,,,,DAAAAAAAAAAAAAAAAAAAAAAAAAA

With the bug, the following assertion fails on the 'rm' command:

    [   19.066048] UBIFS error (ubi0:0 pid 379): ubifs_assert_failed: UBIFS assert failed: !(hash & ~UBIFS_S_KEY_HASH_MASK), in fs/ubifs/key.h:170

Fixes: f4f61d2cc6d8 ("ubifs: Implement encrypted filenames")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 636c3222c2308..5f937226976a6 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -228,6 +228,8 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	if (nm.hash) {
 		ubifs_assert(c, fname_len(&nm) == 0);
 		ubifs_assert(c, fname_name(&nm) == NULL);
+		if (nm.hash & ~UBIFS_S_KEY_HASH_MASK)
+			goto done; /* ENOENT */
 		dent_key_init_hash(c, &key, dir->i_ino, nm.hash);
 		err = ubifs_tnc_lookup_dh(c, &key, dent, nm.minor_hash);
 	} else {
-- 
2.25.0

