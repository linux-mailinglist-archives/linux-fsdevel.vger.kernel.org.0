Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BC4E408F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiCVOQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiCVOQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:16:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172389302;
        Tue, 22 Mar 2022 07:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C7E8B81D08;
        Tue, 22 Mar 2022 14:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5EC36AE5;
        Tue, 22 Mar 2022 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958438;
        bh=fIQCTp9Y7kfKaBrUj+OULhWKUXCgvBtogiNxMmypJws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8b3GxtRc+f0w14hNQIndEdzTWQr8sRPgEBnpilcVyborBSQaEiS+2lfZHn7wnYVE
         9/bV9NONU1+AFuak6jcuuRK4fAZ5u8YIhbm4svks5f0Mg6jK60UggUs0zd52W7Xudf
         fG9KVC9N0SmJOtpGPxg2US4l870QJTH0Pdy2lt4P4mRMNPuVL/ZTzpZFjTNwgOm4Vz
         UDBb1kOk8Nz9dnNqFSsBILPAepfakUK1Nwxv0tPl4Vp9HjC0W7itvxyjghTP0mL9y/
         LQODQudqtI8Y5zXsHQJ8OJOIX+/N1HOp3wqC6zC/VfiV9jJEgzKLwJOnscPu22wK/C
         N1Eu/bCIDhmcQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 42/51] ceph: disable fallocate for encrypted inodes
Date:   Tue, 22 Mar 2022 10:13:07 -0400
Message-Id: <20220322141316.41325-43-jlayton@kernel.org>
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

...hopefully, just for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 1985e3102533..00e6a5bc37c8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2203,6 +2203,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
-- 
2.35.1

