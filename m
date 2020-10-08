Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92514287045
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgJHH41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgJHH4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:56:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F003FC0613D5;
        Thu,  8 Oct 2020 00:56:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y20so2352412pll.12;
        Thu, 08 Oct 2020 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SHquDGzVelfsjqJkv/6UwKJoMQiz81lYZE6AtoNA58c=;
        b=ahiMLnOI29q8bCutF5aZx2p+0pSJS8sKbTXkmJLjGHz1ZrpVDJnUB7Z1xx6vmuQ7dX
         IAMpe242UlgNgGtsdN1aPLiBIE02P8EM7bb5PrYnyEydUwtxf/IyZwqIaKMywamKJtdo
         1mCGIXwTbZQZs7bApmbBJrED7G55v5hT5u/oKzEn5d8vUMUyqyYai0WoRGrYNfarfUCI
         xNGKfTpco5fo66xN4o18GluAGNX9/reuTwavH/4f7dao5pyzIaKFVYHlrOBCoPdGCWeL
         B6Hx+EbLkm+r5hion2bKa39w72uf7GrOGLJFMY1WipZgrhz6LMWrQbp4JdGIFEmLrZoS
         p5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SHquDGzVelfsjqJkv/6UwKJoMQiz81lYZE6AtoNA58c=;
        b=Ztf/9wfVpw0yiLILE2pNKCZHoKbSkmeRhRR1mfk0eX+loot7A2D+6hOx8qqx/FNJBi
         Grw6wxjAtmG9qMRRlwSTWAev78qVq9fXQFErPnnCm71JqEIAqQpW3RjyX2ufAfJuG8Vd
         Q4Wb4motShuCTTVs6E6bu50fxE46sDmigWoCaj4SJw32g+2po4UCvgXtf/By5aqzmL8O
         OM0C83XIZ+n0R5MKJa3AxiYLNaT2ewyA84m8yv6+ddsgAK/b1u+IDT0x71uzhrFA+ecf
         r1HFpA2HNBqsPDcm6X8NCl1fQRbiMxd6buyotGiu6iXxRPyQhxR4ZyoZPhjYo1riOzgC
         pcqQ==
X-Gm-Message-State: AOAM532+U2j/0u4ihA0OjrqphzYm0VlctKfIolh4q7pDc+IIURERH1yJ
        fgtnObbT6vmVxiyB+rrJPMg=
X-Google-Smtp-Source: ABdhPJwAwTpZv8MKyuuOm5FecRpKtxAGzN7uciTS5CimXac0Dl8WRCaZm+3psM+6v5QmKjwCJ8SwDg==
X-Received: by 2002:a17:902:d710:b029:d3:7e54:96d8 with SMTP id w16-20020a170902d710b02900d37e5496d8mr6544962ply.65.1602143769597;
        Thu, 08 Oct 2020 00:56:09 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:56:09 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [PATCH 33/35] kvm, x86: temporary disable record_steal_time for dmem
Date:   Thu,  8 Oct 2020 15:54:23 +0800
Message-Id: <e88ad8b8a7c2e9b3073b7ad21af127770969e577.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Temporarily disable record_steal_time when entering
the guest for dmem.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1994602a0851..409b5a68aa60 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2789,6 +2789,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
+#if 0
 	struct kvm_host_map map;
 	struct kvm_steal_time *st;
 
@@ -2830,6 +2831,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	st->version += 1;
 
 	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, false);
+#endif
 }
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-- 
2.28.0

