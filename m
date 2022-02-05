Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF34AAA58
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380525AbiBERE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiBERE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7CC061348;
        Sat,  5 Feb 2022 09:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE6C60F35;
        Sat,  5 Feb 2022 17:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCEC340E8;
        Sat,  5 Feb 2022 17:04:24 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/7] NFSD: Fix ia_size underflow
Date:   Sat,  5 Feb 2022 12:04:23 -0500
Message-Id:  <164408066303.3707.7534844149556688938.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; h=from:subject:message-id; bh=PKE7EX542q+oCOuAqPrZqoJscmIsNzGDaCx3tCm9R6s=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4XNLfMp7qYgQpJd8CcNgvglwi0Kt4ImQoDVzf/ ZLKg10eJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uFwAKCRAzarMzb2Z/l2riD/ 9pSi4MYB8Y0r/G5X7d120oPA3awT5guDUXXMO0yBRagibeKNh1YWqDhRTnoSKyAIH3dvHoZr10xt2J aRB9Q+1++iwR2fdYfM0yPnMxB57RIekW2lr9vubGQOecH5uA4ANfXAB1UKM7tCa9HPPqW85G+rnirW JyCa57RrCBLvc/dKE2Y1bjVnYt3/EqwtzOHJBEjE10VlyldnbbgeiBmZ5/olr8L+yhsjvcKtlyAEEG 4+ArDgLW7V+egXWDH/forv+KEJvqYVk5ETBGfsC154CUplv2mrEat91ahhQ8/pSqkgXUWLNvhn+vRl pm/A8WInRHu2Y3nJnFCRjUHjJtaiA1Getd41fhajIVENxe4QHNuou1R7o/kC+/NElUkQgpPmnV7iR7 Slj8De0bfsyVHvMAFTnP6dEAb5sYo+Bu8RY4gidk/RZLBvEksmnAbd+tu0Pvtfz9VJPbHBc/u80h2a bUEvCxvXjr1ijNzKElZ9p972QetLIJC8TaxtXnuFoUcZvobg2ymwGl1RX1yqQ7Hy3+2r6S2OyVub9v nCOIUUu1OS6oSgbkXoExlFJQ/X39uU/GUtpTU6336pom+YZnOIXQY8I5oW+ZiBOCBgjePwpGva2ePA 0xshXYliLd1O3VV9XTxcUu1X8ZeLikpfKPMuzPDZTEKV0XPgtJfNOctnkxgQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iattr::ia_size is a loff_t, which is a signed 64-bit type. NFSv3 and
NFSv4 both define file size as an unsigned 64-bit type. Thus there
is a range of valid file size values an NFS client can send that is
already larger than Linux can handle.

Currently decode_fattr4() dumps a full u64 value into ia_size. If
that value happens to be larger than S64_MAX, then ia_size
underflows. I'm about to fix up the NFSv3 behavior as well, so let's
catch the underflow in the common code path: nfsd_setattr().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 99c2b9dfbb10..0cccceb105e7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -435,6 +435,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			.ia_size	= iap->ia_size,
 		};
 
+		host_err = -EFBIG;
+		if (iap->ia_size < 0)
+			goto out_unlock;
+
 		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
 		if (host_err)
 			goto out_unlock;

