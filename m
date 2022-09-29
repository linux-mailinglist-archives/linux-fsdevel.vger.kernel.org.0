Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17285EFD59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiI2SqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiI2Spd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA591AE22D;
        Thu, 29 Sep 2022 11:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84AE60684;
        Thu, 29 Sep 2022 18:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C995C433D6;
        Thu, 29 Sep 2022 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664477112;
        bh=e3WTV08Ir+tXvT94bmU+LUp1s/VgZmvjJwbeb8yi/w8=;
        h=Date:From:To:Subject:From;
        b=FOlsjTNXSLgvejfQ6LzPsSQ95f0Rmr8REOMLFtjSiQ2tYmoOVKxJMpaEMgi3p+Rob
         HTpQpq2V1/tY9RLfqcccm+4G5ZFmZQEPvkLWKyQ+tcNuGknPh+FLO2nCKungHsR072
         SjNZ37vJnfG5Ms5AlBwUrqz7zgUPgY3QQKytU1ViQp6w4QhvUkVSAjBaG1n960TPau
         GHfu8ScvIPsZprQTmEZKvY4eiZqssFr350TajLsZGyBMHOolymN4FVg/L5W48iAS5p
         Rw6OIoqPJ2nJ83cPNFGdlktx/FeX4Lnzdc3eSKvXGhNCnsCF1kfJ99SiGCAFC5gOZm
         eMDcLhHkgALRw==
Date:   Thu, 29 Sep 2022 11:45:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH] iomap: add a tracepoint for mappings returned by map_blocks
Message-ID: <YzXnt8Qr+IVF38+7@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new tracepoint so we can see what mapping the filesystem returns
to writeback a dirty page.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    1 +
 fs/iomap/trace.h       |    1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 77d59c159248..91ee0b308e13 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1360,6 +1360,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, pos);
 		if (error)
 			break;
+		trace_iomap_writepage_map(inode, &wpc->iomap);
 		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index d48868fc40d7..f6ea9540d082 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -148,6 +148,7 @@ DEFINE_EVENT(iomap_class, name,	\
 	TP_ARGS(inode, iomap))
 DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
 DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
+DEFINE_IOMAP_EVENT(iomap_writepage_map);
 
 TRACE_EVENT(iomap_iter,
 	TP_PROTO(struct iomap_iter *iter, const void *ops,
