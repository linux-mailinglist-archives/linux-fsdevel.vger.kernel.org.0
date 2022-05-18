Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC452BE60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiERPL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiERPLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:11:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20B5F41;
        Wed, 18 May 2022 08:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6E33B82161;
        Wed, 18 May 2022 15:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD1C385A9;
        Wed, 18 May 2022 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886674;
        bh=O39hNoKdp2kdUukiFkmASShHZ2jD97pa/tqJ99wtPvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/VcLNQsRtsPalLKYbuQx3y3jHaEVX8oM3Slu5wrNOuB5eQ/01eQJKLThdRgn+1Qv
         gFvp4Fg7k9vbwCpzM4+ZG2K0SBG7QrmDRpJg022ICG1ZXXlniuu+8mRNdIFWt5OIL1
         fWVSUZwcrmgrwBWwQD20/IxUARp5k0InyItQS6M1iLv/PwG8X6KgMADOcTzztmtojQ
         Fn66r3j8SMBf74F0hBw8Pe2pIkTJKsedi9q5o+ZVBAjX5T6WPF4UTTlBrfczr1SxrX
         2V/0fWZa4FzIgGNWe02EbSXT+4Q8kOn8Iy1f0dobOCowGhDCMjtmYYiV/ThjfqXAO9
         C/7dOQeQhKLtg==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 1/4] netfs: fix sense of DIO test on short read
Date:   Wed, 18 May 2022 11:11:08 -0400
Message-Id: <20220518151111.79735-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518151111.79735-1-jlayton@kernel.org>
References: <20220518151111.79735-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sense of this test is reversed. There's nothing that prevents
userland from requesting a DIO read that is longer than the available
data. Conversely, we don't expect a buffered read to be short unless it
hits the EOF.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/netfs/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

David, feel free to fold this into the patch that adds the condition
so we can avoid the regression.

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index e5a15a924fc7..8188d43e8044 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -728,7 +728,7 @@ ssize_t netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 
 		ret = rreq->error;
 		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin == NETFS_DIO_READ) {
+		    rreq->origin != NETFS_DIO_READ) {
 			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
 			ret = -EIO;
 		}
-- 
2.36.1

