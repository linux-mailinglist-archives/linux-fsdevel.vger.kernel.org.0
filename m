Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFF35678E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349869AbhDGJCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 05:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhDGJCh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:02:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E5F61205;
        Wed,  7 Apr 2021 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617786148;
        bh=IIB7VZP9yOaFh+hQR7xo0lAcT2Uy88pm0TtUV00kk/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFUcbivu2cMtD+voMVXXQpBCSREe9dOG2kQKAyPCnxHTdNsyYjVRm2u3EfQ4EhBlE
         lt9JbU04NpPbjgQZ3X7/1kc0y500a00x1TvUp/U2NwDmz2d9oR/SbXBqzg18B62CEh
         cV1hRAFKlgh0/ibBkVyjxYFjJKzCuV22pdJTZhSoFtkrYh6f86I98gVIOazI16wJIO
         zfNWpOeoh1hI8I9roigTh+sPvgLi8MaqvGBosbEQhHcsnN6ep2GuIP/8ngtU0fFj9I
         WzuCrJf8ramGdoors1d72X6H1c8jBtMh6/CIITdC+9Kh7Hbnk72ksQPbn5SZzPKp0m
         aYEdrfDQ+ALOQ==
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/2] cachefiles: extend ro check to private mount
Date:   Wed,  7 Apr 2021 11:02:08 +0200
Message-Id: <20210407090208.876920-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210407090208.876920-1-brauner@kernel.org>
References: <20210407090208.876920-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=sq3ZzJvntlYHpVF9DUkagn5nQ3VlfP9ykb05/pqtBDE=; m=pMjwapyIHPZh2/jZFihhcFe5DK1wUmIATDV/mlaE9cQ=; p=Uc8mMKheClJdERLiWJ7Lw09770QvIlKFHVuOwKAXN6Q=; g=32bd3995c45960364db8a408beff14ea96e10a5d
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYG11CQAKCRCRxhvAZXjcojjOAP93pj9 xLL8bF12+gHx7jH9eqVIt4ed1AkDimG0Um2UzZwEA4VUIsFDUcJDSE8acwlSVAZmdnmcdMUs7CHVB iQG+dw8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

So far cachefiles only verified that the superblock wasn't read-only but
didn't check whether the mount was. This made sense when we did not use
a private mount because the read-only state could change at any point.

Now that we have a private mount and mount properties can't change
behind our back extend the read-only check to include the vfsmount.

The __mnt_is_readonly() helper will check both the mount and the
superblock.  Note that before we checked root->d_sb and now we check
mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
this is only syntactical change, not a semantic one.

Here's how this works:

mount -o ro --bind /var/cache/fscache/ /var/cache/fscache/

systemctl start cachefilesd
  Job for cachefilesd.service failed because the control process exited with error code.
  See "systemctl status cachefilesd.service" and "journalctl -xe" for details.

dmesg | grep CacheFiles
  [    2.922514] CacheFiles: Loaded
  [  272.206907] CacheFiles: Failed to register: -30

errno 30
  EROFS 30 Read-only file system

Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
---
 fs/cachefiles/bind.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index bbace3e51f52..cb8dd9ecc090 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -141,8 +141,13 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	    !root->d_sb->s_op->sync_fs)
 		goto error_unsupported;
 
+	/*
+	 * Verify our mount and superblock aren't read-only.
+	 * Note, while our private mount is guaranteed to not change anymore
+	 * the superblock may still go read-only later.
+	 */
 	ret = -EROFS;
-	if (sb_rdonly(root->d_sb))
+	if (__mnt_is_readonly(cache->mnt))
 		goto error_unsupported;
 
 	/* determine the security of the on-disk cache as this governs
-- 
2.27.0

