Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA153D210C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGVI6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGVI6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:58:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4CC061760;
        Thu, 22 Jul 2021 02:38:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nt18-20020a17090b2492b02901765d605e14so3713377pjb.5;
        Thu, 22 Jul 2021 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rWoKywolpsLaO+fLwhS065JQ8TxoNqZcLux7FKVCf+E=;
        b=aUMFOQ62cj8KgNQfMrZak9npSfuiUFKVuex2Lz6KaoNppN0fl3yd3thHqPkpW5cBXa
         1WIAz8+th/+lcNkl9lPsgK/agEMTecj2c6vEseG9pCsOXOb63lWJOBEJrbwjPTkHBhxL
         aUcsJPf2Yy1prGmwlAFMnuC7k5mVfJZYM1N1GOzRx7FQJmpenyO7J6P7OjdRXkqMkW1G
         OwdFptYyCikK1O101OuJpaopl9Xwl/68BuAzLS3HwTWXad4UsP39DgcnT2VBawdODbot
         rDoSMiEfvXVDUx/92vxTFLfS4IoB+IjKv7D83agxVr5IdhRVLZ4apTAsepnYpMdq6T/q
         iWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rWoKywolpsLaO+fLwhS065JQ8TxoNqZcLux7FKVCf+E=;
        b=rFT7uexz+p7u8/ClMzAA59IN9OD+tr3I3e0FXKM8m8XIPgttjbsaZknBnwJRyRuYVm
         b3sSqJhgJZlkIn9LTtP3rivJj+Npo62s3/jsk+77iAyde5Rbl6nflbNmcSIDAxdZbPhz
         pAS3rUl8+eWmGik0xflBPDmgQR/pKDD971mxLu93VlfeC1e4yMqjiptIyk05zbc9Kt3W
         456RN74EFGZ0oF/Dd9qW17wj3v7iPrYk/F56MlkiLXymXF4tJECpUAfdvPx/194Vo8EC
         i0AJSoeBR/c1pP0z5Oz1thPjh6LtG82LTKt0ODqQE+/YzS/83TaFZSojC6qIKpdmY7DP
         lVCQ==
X-Gm-Message-State: AOAM531CbrIVA4DBiv+5E+ztZFeBshu6Y571ALWUjRAp552s+OAIrkHv
        DkRAxkFNGh+ySD7ocSC1G1eJMqeNC46u3w==
X-Google-Smtp-Source: ABdhPJwHRbtHtlncyO74ZSrMdkFdGZJVI2mbT13Zj/kafRqRgF2ylAPWQDid7HgIbicySX1sgJnISw==
X-Received: by 2002:a63:5fc7:: with SMTP id t190mr3219724pgb.46.1626946727828;
        Thu, 22 Jul 2021 02:38:47 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id m1sm14208741pfc.36.2021.07.22.02.38.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:38:47 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 3/3] misc_cgroup: delete failed logs to avoid log flooding
Date:   Thu, 22 Jul 2021 17:38:40 +0800
Message-Id: <9561f990656620f8b39c83453a857c5c35e3ddd0.1626946231.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
References: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
In-Reply-To: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
References: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since the upper-level logic will constantly retry when it fails, in
high-stress scenarios, a large number of failure logs may affect
performance. Therefore, we can replace it with the failcnt counter.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 kernel/cgroup/misc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 7c568b619f82..b7de0fafa48a 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -159,8 +159,6 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		if (new_usage > READ_ONCE(res->max) ||
 		    new_usage > READ_ONCE(misc_res_capacity[type])) {
 			if (!res->failed) {
-				pr_info("cgroup: charge rejected by the misc controller for %s resource in ",
-					misc_res_name[type]);
 				pr_cont_cgroup_path(i->css.cgroup);
 				pr_cont("\n");
 				res->failed = true;
-- 
2.30.0

