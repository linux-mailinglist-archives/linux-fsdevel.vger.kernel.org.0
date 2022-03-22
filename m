Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC034E40E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiCVORL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiCVOPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4CB6B;
        Tue, 22 Mar 2022 07:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB630CE1E17;
        Tue, 22 Mar 2022 14:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0BC340F0;
        Tue, 22 Mar 2022 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958419;
        bh=OM8m2vgf9kpf1A7HqniobXiZeDExWe17mxuY2MZB19I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjNPuO1KJLR/PKTi/QM2nsjHEW56nQjFTEy/lszzj+QJ/516MrLMf2c5IZCpXg3T5
         Sr/N3c7Pf6+5/S/ZYlGbDxTTam2QHlbLU/WH+ozHlKDSO+/nO5o4uzRbUH9kyb5N0b
         95LzOHqc6UewIJSBJagjSsU97PCin138GeMUi5HFBVUQPsTyuwzPrIX4XV9M1i2oBk
         1OgCZ3k3wviIIOp70H3JOMEe5sKai26U2SJCAt5Gz2V/BcyKkN9UY/khbU7C/zPOeU
         Cz1VrdfkI5oGeBoyXppo3HiXiftS/PKuIMTfIJQkfTxhgju7csrI0ALFzBx0aSjeLF
         jSLQoTyRQGqxQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 21/51] ceph: fix base64 encoded name's length check in ceph_fname_to_usr()
Date:   Tue, 22 Mar 2022 10:12:46 -0400
Message-Id: <20220322141316.41325-22-jlayton@kernel.org>
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

From: Xiubo Li <xiubli@redhat.com>

The fname->name is based64_encoded names and the max long shouldn't
exceed the NAME_MAX.

The FSCRYPT_BASE64URL_CHARS(NAME_MAX) will be 255 * 4 / 3.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 86de8483032f..e56017d66354 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -204,7 +204,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	}
 
 	/* Sanity check that the resulting name will fit in the buffer */
-	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
+	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
 
 	ret = __fscrypt_prepare_readdir(fname->dir);
-- 
2.35.1

