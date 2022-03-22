Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A234E40B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiCVOPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbiCVOPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2D4C7B5;
        Tue, 22 Mar 2022 07:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9BD8615D4;
        Tue, 22 Mar 2022 14:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338EC340EE;
        Tue, 22 Mar 2022 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958425;
        bh=lVmRbo/Yqwtaeh9CAL98bk9QWDa/T4bzwxEXkoS7RR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtgDjoyITb0DyUy9pojlR6rreee8ZpNJC/7VZ/vot3qAfi017DWm4OCczBVrdZ0+v
         HBFZxrC7rntyLI7YIdBybi9MZWsDXtqm2ltcgifi4XTxOrIeyQUJGCSX1LHVPSvQSC
         WmMr2VuGgtqSfGA76+KfYVFj6XlYWJtX0LJ1X9HnQ0jGLqwGY+egu6IABNNvCJeJsi
         EbDAE49liKm9AI1LOCufgn+3mcOeIljKsBx6Rsrpld6NKz/AL5ORPG9ccNmeCziQlk
         AnAlAYAG2my4HVz273NjqBCW5r65egUEJ9JAIWc52Pb/DS0AQkpovq9o1Fs4uRMxRe
         ApWWLz2zCAWLA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 28/51] ceph: add a new ceph.fscrypt.auth vxattr
Date:   Tue, 22 Mar 2022 10:12:53 -0400
Message-Id: <20220322141316.41325-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give the client a way to get at the xattr from userland, mostly for
future debugging purposes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 58628cef4207..e080116608b2 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -352,6 +352,23 @@ static ssize_t ceph_vxattrcb_auth_mds(struct ceph_inode_info *ci,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
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
+#endif /* CONFIG_FS_ENCRYPTION */
+
 #define CEPH_XATTR_NAME(_type, _name)	XATTR_CEPH_PREFIX #_type "." #_name
 #define CEPH_XATTR_NAME2(_type, _name, _name2)	\
 	XATTR_CEPH_PREFIX #_type "." #_name "." #_name2
@@ -500,6 +517,15 @@ static struct ceph_vxattr ceph_common_vxattrs[] = {
 		.exists_cb = NULL,
 		.flags = VXATTR_FLAG_READONLY,
 	},
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	{
+		.name = "ceph.fscrypt.auth",
+		.name_size = sizeof("ceph.fscrypt.auth"),
+		.getxattr_cb = ceph_vxattrcb_fscrypt_auth,
+		.exists_cb = ceph_vxattrcb_fscrypt_auth_exists,
+		.flags = VXATTR_FLAG_READONLY,
+	},
+#endif /* CONFIG_FS_ENCRYPTION */
 	{ .name = NULL, 0 }	/* Required table terminator */
 };
 
-- 
2.35.1

