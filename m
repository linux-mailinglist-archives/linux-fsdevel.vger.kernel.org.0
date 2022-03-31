Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2924EDD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiCaPfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiCaPer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:34:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A5224758;
        Thu, 31 Mar 2022 08:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB59DB82146;
        Thu, 31 Mar 2022 15:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED73EC3410F;
        Thu, 31 Mar 2022 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740714;
        bh=2bGbzNU8WL8xYtzB/Xomv89/+SjVgpyxI6KdNAhCqSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMdTEsOc2/NklRX3ghGwMLs1OERArsJpW+d9cW+5/UQCcStltbktA21JLlDupFtMZ
         vUnAFznC4eNzuXdVY6JDZswBwlR8IFfALi9PsDzNApN0er7adzwfrl72R7o4MRD5b0
         /h1GicjZIdBd657sVm0xswt/3fJHHEgQJq6ex5PpM9U0k/EvrIcf7n0u3x187etfyC
         m0ujoJn1IK3fNaeOZEmjEX+gU/PyLV+NR5JNMKJF4B1MhbnPS5ggbJDZfyiGSPx21Q
         wqmx06k8RQqwTRzAfVuaWdK8UfMyYQ3bcTlsBpmckygvm6WHb11c+/P9kkCEf4rW/y
         gar/gpjjVh78g==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 24/54] ceph: fix base64 encoded name's length check in ceph_fname_to_usr()
Date:   Thu, 31 Mar 2022 11:31:00 -0400
Message-Id: <20220331153130.41287-25-jlayton@kernel.org>
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
index c58897cd30ca..7dee31e1e3bb 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -211,7 +211,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	}
 
 	/* Sanity check that the resulting name will fit in the buffer */
-	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
+	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
 
 	ret = __fscrypt_prepare_readdir(fname->dir);
-- 
2.35.1

