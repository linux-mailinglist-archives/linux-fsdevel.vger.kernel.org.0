Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B9287008
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgJHHyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgJHHyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B76C061755;
        Thu,  8 Oct 2020 00:54:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x16so3598881pgj.3;
        Thu, 08 Oct 2020 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1mPWQ3y+ekTW2WnE7lidu19L3jZpv/s0br4tyldlnIk=;
        b=u7N268Ibc1GyZOWe2Vp3htaWdl1D35g97xP1MMM5NTjbKU+P8Jzh+igerBc40RQKgh
         6zkjjA313LKMHX0tL52mWjT2utbTjNyHSK17UImwVFJb7ufJEEyT11XKvdFfJ54UXAR6
         1rgnTcke5IKs0jdm2kmuxF/B3qulSe+tEXX8bipSjOapveRZB0AADfMsjMNJ7XY6K35K
         /qjCs0/CdusCucNvXudHB+r9shZxIBqz+imd9W8a7aiO44Aa9rt2+JOKauTFc2Zjc8gL
         PSRVbVd3V4LwM4sQ+ws8krJvdc1h4FpHxXFjDs+PVzYf8x0hEokWQTNfCKJaH/62Bmys
         ZEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1mPWQ3y+ekTW2WnE7lidu19L3jZpv/s0br4tyldlnIk=;
        b=RH7nQQt+ycO91nxByu3JAuYWVC2B6wt7IloHTQKfkAWN/vkgmL5mszlwFy8m9a/HIO
         PdUgMQE9XMeBVhwUkrxH0sB6+Eq8gnF0e+zTlVue05K7K0W5g351N0zSxQDkNcDoeEKP
         q36SVTyIQ5koDIL3IdE2kvL7Kv6iX1GR0Ee06inYMhVZf4EQQWEN0QVpKuO4B6Fw3u9C
         YKK6jkz5RyNbHUyrcyyDUDTADQjCREey7APCBfh8Y0z4q0tkR7gyQEFEioecjY41/90M
         0kfpW2Qf/hp2/wrw6I3prFgasc4ycKl2AWn36GqIrGk9M8nhK2XiDTZ6KCyInLQIvobH
         rlNg==
X-Gm-Message-State: AOAM533Yyq7bzmXn0JSEZXSsavX3ih3I3YVsGvhgoN5BDPt1V2vRdJYW
        uAWHYtcg1bcLO4ASpt46oPc=
X-Google-Smtp-Source: ABdhPJxvPPJlPTIc7/Sww4pvhKsLUACWnjRw8fA95iAdwKiT8jaYpm8/ZJDRZmCpaRDJhlfUCx9lNg==
X-Received: by 2002:a17:90a:e64c:: with SMTP id ep12mr6750661pjb.43.1602143674884;
        Thu, 08 Oct 2020 00:54:34 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:34 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [PATCH 11/35] mm: export mempolicy interfaces to serve dmem allocator
Date:   Thu,  8 Oct 2020 15:54:01 +0800
Message-Id: <aaac5819def07f59de431ef6e05d19d8cd60e067.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Export interface interleave_nid() to serve dmem allocator.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/mempolicy.h | 3 +++
 mm/mempolicy.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5f1c74df264d..478966133514 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,6 +139,9 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma, unsigned long addr);
+unsigned interleave_nid(struct mempolicy *pol, struct vm_area_struct *vma,
+			unsigned long addr, int shift);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..b3103f5d9123 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1816,7 +1816,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
@@ -1982,7 +1982,7 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 }
 
 /* Determine a node number for interleave */
-static inline unsigned interleave_nid(struct mempolicy *pol,
+unsigned interleave_nid(struct mempolicy *pol,
 		 struct vm_area_struct *vma, unsigned long addr, int shift)
 {
 	if (vma) {
-- 
2.28.0

