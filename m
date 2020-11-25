Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BBC2C3561
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKYAYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 19:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgKYAYr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:24:47 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4682168B;
        Wed, 25 Nov 2020 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606263886;
        bh=sW9kCpHg/sDmA6ymdn9CX3KA5XvEp3ayB2EpWqKWKAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K69+GBBXBn4aXkvDANL2m4C3Uwm2MG/DwglSUIEvtrVbRom0kW3lKn/v51W6I0AZp
         EvfWZAt+vU9ps1TyC4Wvoe5R3WKuIPEKEhV1Vzt5W5ypvumvcCCi1wlnBF2IXXMHGW
         NihS0BQPZCcwny3n3ocL9m7Mvn5puvL49h16c83w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
Date:   Tue, 24 Nov 2020 16:23:31 -0800
Message-Id: <20201125002336.274045-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125002336.274045-1-ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The call to fscrypt_get_encryption_info() in dx_show_leaf() is too low
in the call tree; fscrypt_get_encryption_info() should have already been
called when starting the directory operation.  And indeed, it already
is.  Moreover, the encryption key is guaranteed to already be available
because dx_show_leaf() is only called when adding a new directory entry.

And even if the key wasn't available, dx_show_leaf() uses
fscrypt_fname_disk_to_usr() which knows how to create a no-key name.

So for the above reasons, and because it would be desirable to stop
exporting fscrypt_get_encryption_info() directly to filesystems, remove
the call to fscrypt_get_encryption_info() from dx_show_leaf().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 793fc7db9d28..7b31aea3e025 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -643,13 +643,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 
 				name  = de->name;
 				len = de->name_len;
-				if (IS_ENCRYPTED(dir))
-					res = fscrypt_get_encryption_info(dir);
-				if (res) {
-					printk(KERN_WARNING "Error setting up"
-					       " fname crypto: %d\n", res);
-				}
-				if (!fscrypt_has_encryption_key(dir)) {
+				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
 					ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
-- 
2.29.2

