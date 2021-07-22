Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7A3D2686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhGVOkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhGVOkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:40:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420CC0613CF;
        Thu, 22 Jul 2021 08:20:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so4840549pjb.0;
        Thu, 22 Jul 2021 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rWoKywolpsLaO+fLwhS065JQ8TxoNqZcLux7FKVCf+E=;
        b=FNAmnyHz9OF8cO1mwm6/P6LMeRdqR/kMONKBrzlhaASHy8MgXpZDGIsxAo+CwZFedV
         OIcWvC/gE/9qAxQTRHnvXPQowGT2zM0Y5E8BgTAc/CW53WD6k0HafIjpvoUv97k7l0ZC
         /4EhjxgP5rFsNx5oE1i0SYMNZ+j74e1BnwNeOnwEaDO66drHOkY74qyTbi7520LNmW7x
         LhT/5RBZT3BBMtj2mRIbTd4/VQEJpLSVNlht/A7N7jpk+03VDqjctGWtE8nwiduHWmDx
         DFPK+0Ps65ovBu9sMq21h1r+ydRiOxuQVgHoXUms6d5imMVhyfJSsstqF3fonCdBoD7s
         FRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rWoKywolpsLaO+fLwhS065JQ8TxoNqZcLux7FKVCf+E=;
        b=PZ9XikxX8cKgRWTUSGlIM3pFxvSDCP7WVqf9LSIQuk14t6h+M4KU2GEncDW6pCDqbY
         hERq08MtlfHFR1JonZ7/+3P8B37rwd1Gpt0h1/2uwON++iJn3pclaalBbV3dqpSeNsYE
         U2IcwhzUl65j1G/jEGWjsvU6kPl+I5RFGH3e0SaAhulsFNG0RqBQvvJoKwlNhRinnwnp
         rjG+fAGn3StsatYybc5+zeDqZJfs7bMfF9KzO5DaxevotIL6BYe2BWvngxZTWu8yNiyb
         toZjkVrMgv1XBy3Ap9vgx7DIb0eqI1EaJDxBvEVVh0tLFfhcXuhSbOeW2ek0iU42MRRi
         89nQ==
X-Gm-Message-State: AOAM533VjmvVRfJugWzRMOFLn+dlMat5bx1tbLG4psDglp4aoEeHb+BT
        IQmfRHg6+2fqUVrj5cVozzk=
X-Google-Smtp-Source: ABdhPJzI2YstmX9Sr8akgUiD7CUc9KWdSM2OtnbOCbvr/aCcrY/u0Jjlg+ASZUbHXuLaY/lwowzXxg==
X-Received: by 2002:a17:902:b707:b029:12a:d3d7:a82c with SMTP id d7-20020a170902b707b029012ad3d7a82cmr136167pls.24.1626967225624;
        Thu, 22 Jul 2021 08:20:25 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id 11sm30768663pfl.41.2021.07.22.08.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:20:25 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH v2 3/3] misc_cgroup: delete failed logs to avoid log flooding
Date:   Thu, 22 Jul 2021 23:20:19 +0800
Message-Id: <e2b0dd55908750bfb0a97efae4f4e2dff2ab6a4a.1626966339.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
In-Reply-To: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
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

