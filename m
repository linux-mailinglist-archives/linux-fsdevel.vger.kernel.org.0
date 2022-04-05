Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AB4F4D48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581840AbiDEXlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573577AbiDETW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81452488B9;
        Tue,  5 Apr 2022 12:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36D4CB81FA7;
        Tue,  5 Apr 2022 19:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B37C385A5;
        Tue,  5 Apr 2022 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186458;
        bh=MU+8cQqFTauv6+tNkq0uHJULiqNrfH78K6L73eZ6818=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JN5SAAGEHLYlUgFg+9TZNj/pebWMMrIA7EgYMoxx0fGzRk3ZuJwNlY/j1Hy4hNJFJ
         oqXkWbkDXIwbOaG4bHTSjJsnembnIYBwp5EluI+ya77SzSPNbST068KzZKUQ1lhzqr
         V25e6w7C3Ccw32l8ATlFrMkcMROYMMz0iCNdBJB4B/ctCVZaUYnt+ZdKSPhm+ENdhJ
         4ZesVgdu0NRDiKeNRn9hrMsIvhzyMArL9lNy222vZjoWBUcKe4hA9MIN0IcFLbA2oR
         XB3/gMNAneF1+v0WbgSoXU9vAqsL/PMep7JT7pDe2+3ozXmBB0C+nloCBAfmDndN6N
         t+1SU2pehcyBg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 28/59] ceph: fix base64 encoded name's length check in ceph_fname_to_usr()
Date:   Tue,  5 Apr 2022 15:19:59 -0400
Message-Id: <20220405192030.178326-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
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
index eefeaa721b9d..d63e4a583413 100644
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

