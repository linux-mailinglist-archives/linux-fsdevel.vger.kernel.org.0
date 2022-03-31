Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6394EDD3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiCaPgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiCaPfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:35:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A49223220;
        Thu, 31 Mar 2022 08:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0553AB82173;
        Thu, 31 Mar 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE4C340F3;
        Thu, 31 Mar 2022 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740722;
        bh=btEIS1j3Ond3ZP9qah9C8gQBs8ZC16Vm5hgbF/uIHr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gt5zLeFvbOmKADZ3Nc1U5vnNg6n5heXOW+pNPqmwMkV1z1PbFJGaYoG9D0VmgWopg
         WHO8FEo0Qkglho8RBr4vMDuMDCK0ff/obpnccUDnkOHz51q25LUI5WCUPYjbMa7mk6
         rRLqZxf+NAa3iRUEAVAvXcPpMCeIQS9f1j800I3H+SmON0fgtQFi9vsFM+h64qzP7q
         0Gmng0zEjmQJGDbq1+5ocybDr3T/8NgDkSn77dkgEhi9DFSNSAY9SmSlCqpCjL74J+
         CvRk77nh0qEPgDrcEqg9+DvUrKCPqL812MvkiO+lsPXNUDDLpNcWtzxUXFutUpJQqM
         Nu9akOOBmlVVQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 33/54] ceph: don't allow changing layout on encrypted files/directories
Date:   Thu, 31 Mar 2022 11:31:09 -0400
Message-Id: <20220331153130.41287-34-jlayton@kernel.org>
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

