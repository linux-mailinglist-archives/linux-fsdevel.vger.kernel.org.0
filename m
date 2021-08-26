Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614AC3F8BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhHZQVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243184AbhHZQV0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4431561165;
        Thu, 26 Aug 2021 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994839;
        bh=cMmlEJ2/VTmeHHrOae4DPK/zfbSFsdZPbcKf9dis2mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmGEZGYzOb7un3U8VtawWPuy1KUvlA4+6CSHRfRc3zWo6evCX9xMWp6k5YFqbxoB/
         IyncaO4qME9WIsiRuEsVI2PRE4/l6p1sBYHGXJ61BVNP3bHsUyG3uN7BDmEs/NzY8Z
         R3+SfP/yVBpmdJ8CgvVJI68l4e4Fg3P/bRiPvvXAlWerAzGsFrgAW/O2mmpY6K5eaM
         dVGYprUcXOQCWIUHXTki83y9TUh9DrAeGj3IpPv1cDztiS8oPimM3chqq2pwuc3NM8
         ezIne0mpIwZQOnjcWKf6+Sc4HJonmEvwpWGyMiupsPjFFDYys8zhkdiyQE7nBrpOSz
         oKqt/qXtfTcZQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 24/24] ceph: add a new ceph.fscrypt.auth vxattr
Date:   Thu, 26 Aug 2021 12:20:14 -0400
Message-Id: <20210826162014.73464-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give the clietn away to get at the xattr from userland, mostly for
future debugging purposes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index a2a1b47313f2..bdd2144bacfa 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -352,6 +352,21 @@ static ssize_t ceph_vxattrcb_auth_mds(struct ceph_inode_info *ci,
 	return ret;
 }
 
+static bool ceph_vxattrcb_fscrypt_auth_exists(struct ceph_inode_info *ci)
+{
+	return ci->fscrypt_auth_len;
+}
+
+static ssize_t ceph_vxattrcb_fscrypt_auth(struct ceph_inode_info *ci, char *val, size_t size)
+{
+	if (size) {
+		if (size < ci->fscrypt_auth_len)
+			return -ERANGE;
+		memcpy(val, ci->fscrypt_auth, ci->fscrypt_auth_len);
+	}
+	return ci->fscrypt_auth_len;
+}
+
 #define CEPH_XATTR_NAME(_type, _name)	XATTR_CEPH_PREFIX #_type "." #_name
 #define CEPH_XATTR_NAME2(_type, _name, _name2)	\
 	XATTR_CEPH_PREFIX #_type "." #_name "." #_name2
@@ -492,6 +507,13 @@ static struct ceph_vxattr ceph_common_vxattrs[] = {
 		.exists_cb = NULL,
 		.flags = VXATTR_FLAG_READONLY,
 	},
+	{
+		.name = "ceph.fscrypt.auth",
+		.name_size = sizeof("ceph.fscrypt.auth"),
+		.getxattr_cb = ceph_vxattrcb_fscrypt_auth,
+		.exists_cb = ceph_vxattrcb_fscrypt_auth_exists,
+		.flags = VXATTR_FLAG_READONLY,
+	},
 	{ .name = NULL, 0 }	/* Required table terminator */
 };
 
-- 
2.31.1

