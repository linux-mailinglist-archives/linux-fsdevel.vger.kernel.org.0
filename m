Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E796F4E40AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiCVOQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiCVOP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885D4E3B4;
        Tue, 22 Mar 2022 07:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7458B81D08;
        Tue, 22 Mar 2022 14:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7B1C36AE5;
        Tue, 22 Mar 2022 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958427;
        bh=btEIS1j3Ond3ZP9qah9C8gQBs8ZC16Vm5hgbF/uIHr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl87S7YpSbRhvw8gFFY9v18aPQG+x35lGIDEB0ogtbQVwCY9oc1mmNmpno23HCzQr
         pM7oWt5hJu/5ovcKYJIKGL10kWJ6zdtqQOFEYh19NdkzNLGJeJCNhEwdtcoOCeipU/
         xS4RWhOBAtU8LXagat7LgQ6h6N/0RcewTvqAjNsGHh413Ob6qWOEkNROQ+0awx1EXW
         LH/k69NaBimqXAVj2Ejp+DjBnPsFuJ+8zyz2EXMsmH+ZOyb3iNIoYyXLqc8gPKq6Wo
         wGRuKKLmcVGgYcbyUVvk/SZBs+lpoKda4TTyYm0XkfKuSmD4DG9kBq0iz8N/nG6SQj
         qC9zM1AvmjgLQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 30/51] ceph: don't allow changing layout on encrypted files/directories
Date:   Tue, 22 Mar 2022 10:12:55 -0400
Message-Id: <20220322141316.41325-31-jlayton@kernel.org>
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

From: Luis Henriques <lhenriques@suse.de>

Encryption is currently only supported on files/directories with layouts
where stripe_count=1.  Forbid changing layouts when encryption is involved.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index b9f0f4e460ab..9675ef3a6c47 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -294,6 +294,10 @@ static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	/* encrypted directories can't have striped layout */
+	if (ci->i_layout.stripe_count > 1)
+		return -EINVAL;
+
 	ret = vet_mds_for_fscrypt(file);
 	if (ret)
 		return ret;
-- 
2.35.1

