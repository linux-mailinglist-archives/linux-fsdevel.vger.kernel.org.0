Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0A62EA63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 01:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiKRAeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 19:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiKRAeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:34:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A871F0B
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 16:34:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o7so3123675pjj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfKoIXcdSbSCG4X8dhvdkumwWP5cdUHpW/BAvV90utQ=;
        b=hBAITYaklRvHDDl64erxDCykr4u6NNFZ8OfJfZ1JT3AFy1r2suv3k/1rLcyzRXga0N
         /Gxby+KLLrwQV7OBkH8LYJSkKhJPZmRywFIeLAjhWp9a/BDOFymG1t+YxoeVqcooLMOC
         THVmW0Q2Ukz0Y0EPe7mbObmo0p8I/djfdpo1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfKoIXcdSbSCG4X8dhvdkumwWP5cdUHpW/BAvV90utQ=;
        b=z2Or/NTZ41XLNx8aoAp0YiAcYodeyiPrRH8j+H+EHuxKssyuARcrTbRCQfSANi5hU4
         IZX6Die139QrdjTvP6hmQvFIE/jNbJrrL4HmPvwKcueEOO+FjOC9RDviVi/9WCOoc6Xk
         XdLqtPtkq7loyQq/k9eWZLYwiEntlB2JPm6bPdyIvspIbRxYZTQ7XnMiuVGOt1TV8EWK
         ojRo4og77stcFdthkzzUnlWvujRjW+mQ/JLTzMfJeb5ImuGSwD0cuBB3V7cCBrha4XlL
         TCt6FCV5K+2NAUTLA1hvRHCS4/5Wx76zP6+b2CwA6zxnm3GGBWBXQJWpz58uWHSRuc0C
         lMlw==
X-Gm-Message-State: ANoB5pn6e63rrUa8zT4LNRMkKwWoiVD7O9bffZCYveXjc5zEYoHQpzEz
        +8GwYOMk1Qa+iF8danSKgYhRlg==
X-Google-Smtp-Source: AA0mqf6qI1CpK2kkytMt09iK5URjD1iMJmLNXdgwK+fruRzJWWFpW2jfwg3hAMw41jRbyichhCspbA==
X-Received: by 2002:a17:902:9a01:b0:176:cf64:2f39 with SMTP id v1-20020a1709029a0100b00176cf642f39mr5096556plp.93.1668731656837;
        Thu, 17 Nov 2022 16:34:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b0016c50179b1esm2058299plx.152.2022.11.17.16.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:34:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Remove FOLL_FORCE for stack setup
Date:   Thu, 17 Nov 2022 16:34:14 -0800
Message-Id: <20221118003410.never.653-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; h=from:subject:message-id; bh=Q3A301qUeRB8tq7dkiRpjGQmp7qcdEcbj6KnmtW0Kwk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdtMFIHEE/2aFsG+0+1k2j6trtVeqZg6//sNcJ9PZ qpTOZmaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bTBQAKCRCJcvTf3G3AJmxND/ 4nU1/hNVNbDf3WDg7BJbbkga3ERM+KhF9FnAQVu8KD6VPUt+W3bNr9NimO5ebcKzxJIpAWnFFquFte arvoVm5AdjVA997ZUKDrwC3EfEOyszPX6WaRYz6/CTXy7OFJiJKAgdqiz0rM0Jb/VpEyNJFTQNVyxV wMroI6NjViv6G3EUD1FiAkTEyQvtGBfX4ps6mqXa+VFwFlzH56Pqq95o3+RDaekupGblAKIBILa3px 8qchKhd+rbNaM/5Q+krz/xGgEM3pADGVa1Gc7LcICT0swoJlyfl1/5QZCPntj70a0cp50YlpWLkL48 45rCEUBDdCNJ4zVQ8RGTTK7xxjzkZU/6LtVntk/6bvsujeJDTaexOWPF3/qYjPI2jUerZlakCMj4rf Tgd33LBDRv/KHbPWibXCHmOHgWJwjfNWmVbwxsDs+Yksj/1JiO7OX0fLNJpZn9GbNjmBjfKyz4MjzP c5GmSJFRqJPwPubdfziNeJUTx6BpruAG2rBrcZWSPMAW+hvDOXwvycOVf6FcXrKbuxWDN0o4vHAS4B PtDF7gVEHcr/1T1ve6JOKyFcoF5KHZnCDfMJa7DhDf/f6beMa0KDPvcVSZKFe40c//VyjBP88R8yis ZoZVUu2RUXJONdTela0ORVr6/2I+UkBiTe7Sdd4SleuMafvG7eTx4ES95sfA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It does not appear that FOLL_FORCE should be needed for setting up the
stack pages. They are allocated using the nascent brpm->vma, which was
newly created with VM_STACK_FLAGS, which an arch can override, but they
all appear to include VM_WRITE | VM_MAYWRITE. Remove FOLL_FORCE.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/lkml/202211171439.CDE720EAD@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9585bc1bc970..870a707b5d3b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -200,7 +200,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 {
 	struct page *page;
 	int ret;
-	unsigned int gup_flags = FOLL_FORCE;
+	unsigned int gup_flags = 0;
 
 #ifdef CONFIG_STACK_GROWSUP
 	if (write) {
-- 
2.34.1

