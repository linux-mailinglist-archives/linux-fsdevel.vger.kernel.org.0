Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3946CCC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjC1V6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjC1V6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C756172D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so14127479pjz.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040699; x=1682632699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R79gsA40yJKiDnlNR+qOWGBZpFD9m6iccoJTdxyvPj8=;
        b=Ky7wY/MX+8AYcwgA4bCOYSTTltVJtJMhsMli7TDUvoOWsNM1DNPYCMIEdzZX046KU3
         LMdK3IebQaSqbFZGyGbWzIgJ5VosnoPjY5zk+INtEnhypi7xFUkm44zZSHHzRhCk/Dcr
         tpFxPNcRxKVO22vJSoWyZw3YNdXc/GAogmKAU0Wl0acbhicscYHGUqnsbKlWf994jOlJ
         nHwFrCOZoCaUGFizt/bb6zhrxGQ1hFPnICN6q+Bq5S2xpG94plL9+HBbGPKpSx1KNk/S
         1zrxCbIB9OWN1Em75sveD3y/QNdZbTtqLFjPjEZpwykchnYQMu8vErJA2PoO7seUv5+d
         x+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040699; x=1682632699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R79gsA40yJKiDnlNR+qOWGBZpFD9m6iccoJTdxyvPj8=;
        b=1dP9QW061W21pRz22sDFLpWix9YHLVBI9WIqLymDoEYcqINoNanXwXRpawu03+SnO9
         dIKtycX7oS2nQ9vTf9se1HM8by3PkGFi13/HGuT4VXey4VflUNcPOC5TYkYZh5Etz0UX
         YbIfUFUNFzj+nRAnYxX3KTkKSsWM/XElMrGunz5ze4UQty8AlVadjxNC2B1g9GhN8qOl
         pOMy09V9mFyNbKJ9QHsZDbR/cR4VlUXQxAwyPN412275zqTIC6H+QepUvyT0hYPO8Ugr
         uGHknR8cJjx27TURdGxjwbQEEOH4EkNipzdoeE0fmENSRfweUOwCRQ8G/mNb+hQj0ESR
         hfUQ==
X-Gm-Message-State: AAQBX9dqhpXQ953TKFjOFKoPFeriYRKtFeMe3yZeMumtnpS9aiJxA3eD
        Icxx089tP9uV2fk+jFECW5kwpljOE16jTfPMsXbTow==
X-Google-Smtp-Source: AKy350ZbY0h1qHzJ4IiXN3cVJ/L4IxoU4N6KIztondxMm4E+Vh6LlCQIkIGw+o6y0CWHJL/w7IVQOA==
X-Received: by 2002:a17:902:f943:b0:19a:839d:b67a with SMTP id kx3-20020a170902f94300b0019a839db67amr14620048plb.5.1680040698773;
        Tue, 28 Mar 2023 14:58:18 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/9] iov_iter: overlay struct iovec and ubuf/len
Date:   Tue, 28 Mar 2023 15:58:05 -0600
Message-Id: <20230328215811.903557-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328215811.903557-1-axboe@kernel.dk>
References: <20230328215811.903557-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an internal struct iovec that we can return as a pointer, with the
fields of the iovec overlapping with the ITER_UBUF ubuf and length
fields.

This allows doing:

struct iovec *vec = &iter->__ubuf_iovec;

interchangably with iter->iov for the first segment, enabling writing
code that deals with both without needing to check if we're dealing with
ITER_IOVEC or ITER_UBUF.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3b4403efcce1..192831775d2b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -49,14 +49,29 @@ struct iov_iter {
 		size_t iov_offset;
 		int last_offset;
 	};
-	size_t count;
+	/*
+	 * Hack alert: overlay ubuf_iovec with iovec + count, so
+	 * that the members resolve correctly regardless of the type
+	 * of iterator used. This means that you can use:
+	 *
+	 * &iter->ubuf or iter->iov
+	 *
+	 * interchangably for the user_backed cases, hence simplifying
+	 * some of the cases that need to deal with both.
+	 */
 	union {
-		const struct iovec *iov;
-		const struct kvec *kvec;
-		const struct bio_vec *bvec;
-		struct xarray *xarray;
-		struct pipe_inode_info *pipe;
-		void __user *ubuf;
+		struct iovec __ubuf_iovec;
+		struct {
+			union {
+				const struct iovec *iov;
+				const struct kvec *kvec;
+				const struct bio_vec *bvec;
+				struct xarray *xarray;
+				struct pipe_inode_info *pipe;
+				void __user *ubuf;
+			};
+			size_t count;
+		};
 	};
 	union {
 		unsigned long nr_segs;
-- 
2.39.2

