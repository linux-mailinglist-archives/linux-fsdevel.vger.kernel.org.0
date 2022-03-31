Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8714EDCDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiCaPdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiCaPd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA521D7C6;
        Thu, 31 Mar 2022 08:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F058E61AE4;
        Thu, 31 Mar 2022 15:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD003C3410F;
        Thu, 31 Mar 2022 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740699;
        bh=tkoLrTZWKBctCbblY4MYsiwuYddX5IPu9A+9p2q2SpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saBZ2x/byTxtLOnPhw+5L957PsNCS3e3lhsfsChhlR7C+tPdXIqI/Nx5v3XphZkx2
         Asc0t9njwaQFBdEDA+cOsPlbeY+Ag0m1MQdzPHlQBs11qjaH+Gb8zNp9fbTZTm9fDa
         9aqcp2UETnkPquQZsY+wy8BD9vmAmtzx+PxBsbm0f4AAA2eObwWctbV9JB4MvRfzHi
         7SKfVsuwkZmYO/oZ/oJWulRJyvXYEdlOfQmCEn+Zw4f377wYb45+v89SvnTSv9d6yV
         5lhCJMnRAP7Vni6VEZyNu2eAAXB38pBUZKqgV5cGTSl8bDdwVHAWrbDR1GXbJbNnp5
         uL6Ky0ID1u9cw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 07/54] ceph: support legacy v1 encryption policy keysetup
Date:   Thu, 31 Mar 2022 11:30:43 -0400
Message-Id: <20220331153130.41287-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Luís Henriques <lhenriques@suse.de>

fstests make use of legacy keysetup where the key description uses a
filesystem-specific prefix.  Add this ceph-specific prefix to the
fscrypt_operations data structure.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index a513ff373b13..d1a6595a810f 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -65,6 +65,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+	.key_prefix		= "ceph:",
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.empty_dir		= ceph_crypt_empty_dir,
-- 
2.35.1

