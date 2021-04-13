Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2DB35E583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347450AbhDMRva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347412AbhDMRvW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 282AD613BA;
        Tue, 13 Apr 2021 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336262;
        bh=K9uDcko6i6zicTPHrpupMnE0DzhL+BRelqEBGN1abCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A94IuSWkqqSufRySXvQ+B97IX2cQP6ZNu1yW/frru7GsIjolk2iMLpZg6OZYM0rWX
         Wcq7vy4/fso0K6fpLVkuGK2bcDlZZyGv6VxoMur7P28SWfyu5q0hCGaAzIB5vSDYUc
         Tq1jcAJckErDDEHIkt3QxrH9aJZFgxqZ6ZTmdxsiCsPG2pBr0x3jzMxdeqRFQqH/Vh
         GA19vyHmdKiEtdZKfOgRK9qWItj5oBV24kYb5PzP6dzlsRYhY1JbZcwf2LksNr/gMM
         jYJWxu3bOhaFyd6bDErixOrwRT8+iObWpokFnCjbTr9YghR9N4qXalkDxnsVP+oD6A
         d0wd9Sy/ba4dA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 13/20] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Tue, 13 Apr 2021 13:50:45 -0400
Message-Id: <20210413175052.163865-14-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is required so that we know to invalidate these dentries when the
directory is unlocked.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 496d24b003dd..72728850e96c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -755,6 +755,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	if (IS_ENCRYPTED(dir)) {
+		err = __fscrypt_prepare_readdir(dir);
+		if (err)
+			return ERR_PTR(err);
+		if (!fscrypt_has_encryption_key(dir)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dentry->d_lock);
+		}
+	}
+
 	/* can we conclude ENOENT locally? */
 	if (d_really_is_negative(dentry)) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
-- 
2.30.2

