Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1A6CCC72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjC1V6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjC1V62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A22133
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o11so13077131ple.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040705; x=1682632705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=MTVixB4gdxpihVL1VGQWs5h5wNMMUS/gfef/ejNAZ5guuyhHrUtFCx29PeOdr2y+HR
         hwkUgBoFc94Vw7bz2OErGxr9W3FJjDfKMARKDcAhlgr+PsNIAEnK7Ts5ay5Ab6B6Bp8c
         x5/N+E8clWHS1g5x+ekIdCgJUdO/r4VYc35V5SNwlN+4Z1JG/jAKNsZF8IbPm//o4fcj
         +AQec/iDjPlyDpq6FDHmnlx1+tAOOjrUtL5UCyVzRRAvNU1OfpZIjufmx2BJfVF5gtjy
         hK3RgITIWW7QNsO6rdBVmuL/E+cyYcpLVVkAKS711vog4GHDc4HoKv/QKcVmjj3UpENR
         cDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040705; x=1682632705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRuLnY8LfItYmha1a1+5ihq4yOs2ex342r7sq+hJ1lo=;
        b=RBXwm4Lpyw0j0qYAqbud3gtKdjCK+N+nglsqPpyGVQnnNrEkMWwx2PwCafzI4+NHWt
         MIQdmfPW+ewjq1hrb4DZoiQKd/icCZ8qeDCtgC8kUf05fvekuDxyHzgO4/m2rNDaMcp3
         Fu+HhwU4x0DL9kcUSVt0Hh20+93tb2u6v84etAj8XsTJFhmgNQ/F4VIDnZO3WfpqU85Z
         WY56qFc5sB3wi/A6gBDVN6vF+RsQGvfNrzLjFvMtqEQBh0bV1erp6+/yUI8251yOfkgW
         MvUSZmSvUxLkJvZSZ3De/VCGr3s2wxRWS71SyQOLrTwTWh6pGR2OE6JEOF9+TrbhKyzt
         PoxQ==
X-Gm-Message-State: AAQBX9cBFhnQZu5Bwgye+A8rwZrBXXNJwsuUSUJa7SSDVch/M87+LETI
        KBhekOz2l3BCr7djydT6gyvl0L/MnvAkznJzeQIRGQ==
X-Google-Smtp-Source: AKy350bTARPh+OLDk+YoaIZ1t9lgnmu5eizU5k8KG6Jqs5dOkgP1MDvtEeat17jk6NfcYDPjTEB/aA==
X-Received: by 2002:a17:903:788:b0:1a1:bf37:7c2e with SMTP id kn8-20020a170903078800b001a1bf377c2emr14314208plb.4.1680040705379;
        Tue, 28 Mar 2023 14:58:25 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 9/9] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Tue, 28 Mar 2023 15:58:11 -0600
Message-Id: <20230328215811.903557-10-axboe@kernel.dk>
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

Add a special case to __import_iovec(), which imports a single segment
iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
to iterate than ITER_IOVEC, and for a single segment iovec, there's no
point in using a segmented iterator.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fc82cc42ffe6..63cf9997bd50 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1780,6 +1780,30 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
 	return iov;
 }
 
+/*
+ * Single segment iovec supplied by the user, import it as ITER_UBUF.
+ */
+static ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
+				   struct iovec **iovp, struct iov_iter *i,
+				   bool compat)
+{
+	struct iovec *iov = *iovp;
+	ssize_t ret;
+
+	if (compat)
+		ret = copy_compat_iovec_from_user(iov, uvec, 1);
+	else
+		ret = copy_iovec_from_user(iov, uvec, 1);
+	if (unlikely(ret))
+		return ret;
+
+	ret = import_ubuf(type, iov->iov_base, iov->iov_len, i);
+	if (unlikely(ret))
+		return ret;
+	*iovp = NULL;
+	return i->count;
+}
+
 ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat)
@@ -1788,6 +1812,9 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 	unsigned long seg;
 	struct iovec *iov;
 
+	if (nr_segs == 1)
+		return __import_iovec_ubuf(type, uvec, iovp, i, compat);
+
 	iov = iovec_from_user(uvec, nr_segs, fast_segs, *iovp, compat);
 	if (IS_ERR(iov)) {
 		*iovp = NULL;
-- 
2.39.2

