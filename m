Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D677B3DCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjI3D1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3D1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:27:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C3B4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:26:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f6441215dso137444967b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044416; x=1696649216; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJer9ozabqTWGrTyLZzHy82X8q3kDfNExG34jhppfvQ=;
        b=wMIcQ/+dS4AwwLKyybFNw8DoqNOiJuTnJ8FkHUqUoh/zQG755xqHxSNKErdpWzj9ne
         3Afh993WJw4H2ZQm+cPo2ivxijiF6o9yvTiA+oGXy+GGckZzV48i6cOh4yCt4xC1kFdW
         icenesc0Qe0UIrHXTM6M0+lw/vI9DjwmL+ElmakEjToPVIPDT4rffLd+4dY3YL283RA2
         GUriBonnTU4rux3MLs7llH2bA/iALKvFhxvs83DY6vgaandorED9f+C24BQBQj6HuORu
         wtciLO21kZzvcHlZeZLR5h2CK4HakY5lUnH84XAOf5oqwxR1+feuhuU7l+8+FChF/w/n
         /X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044416; x=1696649216;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJer9ozabqTWGrTyLZzHy82X8q3kDfNExG34jhppfvQ=;
        b=GKneeQmQs46UKka9grEK6OL0AzZV0tt40euoRBIPJHfp1IddFSCTiYm2EP4b+uXAHJ
         0RA3JlKgsVSTP3goVcrAIpLah9UkuXDUF1nfK+5lQXYkiVQOrgPqnC4alWF6XEn5nYIU
         qDo3tWgsY8/YRmJOFm5/n6XNNLYVpDsd36u+nJu87I48/RfM3uuvPnebLo1DBBJPxzOy
         Yrnzj4BBbfoyP4aF/WxWgClwW7x9m/ZcYdqS9mHs9c1VWzmdCWQ6n7v2ZTXQCCly37Dp
         zUEo0V0iYoDS1jiJlLD3iDw77KhC/lSt8grsMMEztJ5A/6mNpQVCo8AJjEf4ltxrNrYK
         nx2A==
X-Gm-Message-State: AOJu0YzvkIJXn5pNtDtBVpHKSqp/sSkqXTHSyKV3+fdZXkM8PSrvm3jB
        7WpLq5SQlNm08xMtAzu+rfKDjQ==
X-Google-Smtp-Source: AGHT+IGY8b1GCtjEjvU2ttKYxnk/izTsxRAU1oyYCFwLsKOA7sQuqVX2C4n+cWR1fH9H4i0FnhEwjg==
X-Received: by 2002:a0d:cc4d:0:b0:5a1:8b2:4330 with SMTP id o74-20020a0dcc4d000000b005a108b24330mr6138174ywd.10.1696044416338;
        Fri, 29 Sep 2023 20:26:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w5-20020a0dd405000000b00570599de9a5sm2955343ywd.88.2023.09.29.20.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:26:55 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:26:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/8] shmem: remove vma arg from shmem_get_folio_gfp()
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <d9ce6f65-a2ed-48f4-4299-fdb0544875c5@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vma is already there in vmf->vma, so no need for a separate arg.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 69595d341882..824eb55671d2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1921,14 +1921,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * vma, vmf, and fault_type are only supplied by shmem_fault:
- * otherwise they are NULL.
+ * vmf and fault_type are only supplied by shmem_fault: otherwise they are NULL.
  */
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
-		struct vm_area_struct *vma, struct vm_fault *vmf,
-		vm_fault_t *fault_type)
+		struct vm_fault *vmf, vm_fault_t *fault_type)
 {
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
@@ -2141,7 +2140,7 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
 		enum sgp_type sgp)
 {
 	return shmem_get_folio_gfp(inode, index, foliop, sgp,
-			mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
+			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
 }
 
 /*
@@ -2225,7 +2224,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	}
 
 	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
-				  gfp, vma, vmf, &ret);
+				  gfp, vmf, &ret);
 	if (err)
 		return vmf_error(err);
 	if (folio)
@@ -4897,7 +4896,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 
 	BUG_ON(!shmem_mapping(mapping));
 	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
-				  gfp, NULL, NULL, NULL);
+				    gfp, NULL, NULL);
 	if (error)
 		return ERR_PTR(error);
 
-- 
2.35.3

