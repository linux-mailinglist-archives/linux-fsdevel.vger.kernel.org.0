Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D84AAA59
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380528AbiBEREd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiBEREc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46EC061348;
        Sat,  5 Feb 2022 09:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C2361113;
        Sat,  5 Feb 2022 17:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2294C340E8;
        Sat,  5 Feb 2022 17:04:30 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/7] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
Date:   Sat,  5 Feb 2022 12:04:29 -0500
Message-Id:  <164408066975.3707.17686323228643818652.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; h=from:subject:message-id; bh=JvwdN/hMjxDOVzCApefTJrDnpUJjGi+Sb1bkoJN+VGk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4d/SpzJCaqxrqjXnUv0En8Q9o9DHJ5QOXIq2og MWdRGXqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uHQAKCRAzarMzb2Z/l2/fD/ 95oQVZnNCYSjhgXUqY1OWMrb8oUOD78+ewcFpNnKmn1cDtGKOFayc6xw85QN8i2Jk/7tLHUB9URC7J yqec1aQRm9jVdd6dQ2+Ub2Rny+SiiZ6zWxN6S/bDRDv5yeJTHhBgJ0l2GKCkubkWZWaUWPNLhHPpuR v63w1IVmBFXVxHpsfvUm5PXG1ZIcUrY2g2VK6SyD5IOaYntLym3zC/PSwqILDLj5WgQg7gmfbpeMME mZwyaD7Z13OoAuXYJZU6MwKAQ+Bx64ncWxkql0jzLFLIfZST6EMDDrV/o0lmxUisompzluf0dq1cgH s5HiICmeu0EIUjbbjDQnFf20qFWjPTQl6TV/03pY6mLfW5t8Pc+1E+OhVpj49pfNs1EHkW/m3TQBa8 Hoj5eR/j8OLEwLQ/2Wnw8XL1X39vtaoCX9KIQWbaWaIzDyGSpJbQvgpIANBz5JolZE0C0ORJQenH8T hyd7NpQwrA9bU2BEP1RqdtfdoPJkMfJ0YbPbSFAH4BXBRv9GiGMeOUMZBh/vEnVkVnBtEZ/QXBnxNl EU5lW8dB5ERIaMmlE/tKU1d2ctdxlQl5q4iAbflX/i0oNc/sdbV/yABoalmwSgUHNKm/72z4BiJmSA 7kHIFX+Gwitov0bjgjtOzRrAwornAvUHPXDtPbYJgTC8WTnCkQwkASTvxzhg==
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

iattr::ia_size is a loff_t, so these NFSv3 procedures must be
careful to deal with incoming client size values that are larger
than s64_max without corrupting the value.

Silently capping the value results in storing a different value
than the client passed in which is unexpected behavior, so remove
the min_t() check in decode_sattr3().

Note that RFC 1813 permits only the WRITE procedure to return
NFS3ERR_FBIG. We believe that NFSv3 reference implementations
also return NFS3ERR_FBIG when ia_size is too large.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 7c45ba4db61b..2e47a07029f1 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -254,7 +254,7 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (xdr_stream_decode_u64(xdr, &newsize) < 0)
 			return false;
 		iap->ia_valid |= ATTR_SIZE;
-		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
+		iap->ia_size = newsize;
 	}
 	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
 		return false;

