Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88D35F40C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbhDNMjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347293AbhDNMjO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EBBE6121E;
        Wed, 14 Apr 2021 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403932;
        bh=sCIu140N2M8X8njvAIJD2q5fWwQPwFhqqe2kamzPCtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0sENLoUuxP27Jit3VIRQ7Kak18cSwvm6Z3XaiHYdFZmS3oUI0TIBwms2QKYaSBQU
         R5nCu1stPKdcVljp/4wXhB/K3zu1U/7lnD5DW/Ct30x+NaeSw6uZkZPNpHpG4qX7SC
         HWzudJk85K7KWwRwokNM2Q6ATiXrXZqHpifgjWpO1SqUcbmpX9cJ53DRRtcWuewOhf
         9e1BI/SKOFCqyvYWMlHQLVtYWIJeMT57xRfEGBeTZPV4VYQEm4WR93Dts75EK+AvkS
         KkcsTlkRo9xujfbX+hn3u1HHG1ucEBJNsT2beM75vHWNSXUNY4Fky0b7ap+5ZIh9k7
         s4UceYGZsd13Q==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5/7] cachefiles: extend ro check to private mount
Date:   Wed, 14 Apr 2021 14:37:49 +0200
Message-Id: <20210414123750.2110159-6-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=sq3ZzJvntlYHpVF9DUkagn5nQ3VlfP9ykb05/pqtBDE=; m=pMjwapyIHPZh2/jZFihhcFe5DK1wUmIATDV/mlaE9cQ=; p=kPx7pu4bz6rCME+mwYTdOpwBCcQFbCJKRgNcEqqGPKo=; g=32bd3995c45960364db8a408beff14ea96e10a5d
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh3wAKCRCRxhvAZXjcoqmsAP9WTRL HhgjsPj1vt/opz4ujzq/rvgDD88VfrmOjH9S5PwEAwVoUUC1QG5rJugyGy51+fWaZql9taVGW7gR4 6svLOwA=
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
 fs/cachefiles/bind.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 7ef572d698f0..8cf283de4e14 100644
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

