Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1946EBB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbhLIPk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbhLIPkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF59C061A72;
        Thu,  9 Dec 2021 07:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B945CCE2693;
        Thu,  9 Dec 2021 15:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824E3C341CF;
        Thu,  9 Dec 2021 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064222;
        bh=PLF91jYxit/a9ReRc+eVVED6cPkr5vRANfwEuaONY+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZ6LLQN6bMOJ7Btcmf1ixk6iK5SibPPbITSlfkM8RUUQE7TCR7XJXKs0vAYltIs5K
         f3D6bY8XHlBVYoY+4brqqFD69B9wOAf4K2xaK2jRJEW6XCUA97TsIC4/CneXCWt4XF
         FTz/IM+LGIR7XZC46stssQvOwPVJ8KfOmrkt1LeWqxGTmbu3Ixyke2UwLwzk/qdnIO
         enykbi84PnCDnr2knhha40F2c0HP76WF3DQxGdZjA8/RbZrbk3mG8ly9gapNeD7FGj
         19l8OqbdbBLXrJ7WA1rGfrrobmK/M/HQEnWjwTTsyz5h0HokirIQdcw5R1xhkQxI3G
         eWs+Rv64EeFIA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/36] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Thu,  9 Dec 2021 10:36:29 -0500
Message-Id: <20211209153647.58953-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
index 288f6f0b4b74..4fa776d8fa53 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -751,6 +751,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
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
2.33.1

