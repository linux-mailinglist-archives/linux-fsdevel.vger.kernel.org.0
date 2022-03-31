Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C834EDCFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiCaPey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiCaPeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085E223BF3;
        Thu, 31 Mar 2022 08:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944AE61AEA;
        Thu, 31 Mar 2022 15:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F16C34110;
        Thu, 31 Mar 2022 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740711;
        bh=40bz7fgcSkfmSJmWJDKxd9JZxineBbUvX30XOIb7qbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caozGSf/CuDcqFTb6TrjUIAYQ3evghyb7gsgmeOpey5I5RD9peeRt/oyMmCuW6AiS
         pV1Ff5eDu25QzV2Cme3FIjZ/Ed6nzatM4uNZtMRddBl0Ileda2ZTnGwr96RAE2KzpR
         Osx6R1cjQIdLHscSfuV4Kjx5RkYReVamosSu1YkXGrZ/hn2VGyl5mfnGgO3zLmYQno
         TCUUawtXR46B7zQjY7MzmJ7A+razlp0FSEdtTGjUDQKDVLJfPMuIyyX0jZ854BfRlY
         szUdsZusUfDx5vax//53U3E6ugqYiMuYEvb6DH1x4R9H11QwH0008CLDPZhfNpewDH
         S6rLscCC2h2fw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 20/54] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Thu, 31 Mar 2022 11:30:56 -0400
Message-Id: <20220331153130.41287-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 8cc7a49ee508..897f8618151b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -760,6 +760,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
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
2.35.1

