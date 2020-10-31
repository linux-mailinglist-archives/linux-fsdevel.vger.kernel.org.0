Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA61F2A121E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgJaAqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 20:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaAqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:46:39 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559C62076D;
        Sat, 31 Oct 2020 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604105199;
        bh=ISyUlobbmPUX9wWHknornWz4uwFa5M+PTGKhUXL5ucY=;
        h=From:To:Cc:Subject:Date:From;
        b=oN57/YPPqMXqj510wP541wnbVFTpOGLaG3EX5wWxm0UqyXXG0w3n/NILIipEUgCgT
         vDxJNiVnA/+X0EMs4I7CsizEIRON4oI7egWUX+LY2x+rwlGIyJJyTnnzbK6cLyaUIU
         8tLcZenphNxO8B+NIDFH7kEknRh7uJZ1WP/efxR0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: [PATCH] fscrypt: remove reachable WARN in fscrypt_setup_iv_ino_lblk_32_key()
Date:   Fri, 30 Oct 2020 17:45:56 -0700
Message-Id: <20201031004556.87862-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

I_CREATING isn't actually set until the inode has been assigned an inode
number and inserted into the inode hash table.  So the WARN_ON() in
fscrypt_setup_iv_ino_lblk_32_key() is wrong, and it can trigger when
creating an encrypted file on ext4.  Remove it.

This was sometimes causing xfstest generic/602 to fail on ext4.  I
didn't notice it before because due to a separate oversight, new inodes
that haven't been assigned an inode number yet don't necessarily have
i_ino == 0 as I had thought, so by chance I never saw the test fail.

Fixes: a992b20cd4ee ("fscrypt: add fscrypt_prepare_new_inode() and fscrypt_set_context()")
Reported-by: Theodore Y. Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index d3c3e5d9b41f7..d595abb8ef90d 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -269,9 +269,7 @@ static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
 	 * New inodes may not have an inode number assigned yet.
 	 * Hashing their inode number is delayed until later.
 	 */
-	if (ci->ci_inode->i_ino == 0)
-		WARN_ON(!(ci->ci_inode->i_state & I_CREATING));
-	else
+	if (ci->ci_inode->i_ino)
 		fscrypt_hash_inode_number(ci, mk);
 	return 0;
 }

base-commit: 5fc6b075e165f641fbc366b58b578055762d5f8c
-- 
2.29.1

