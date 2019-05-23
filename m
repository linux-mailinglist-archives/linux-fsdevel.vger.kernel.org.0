Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E82852F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfEWRnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:43:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35666 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfEWRnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:43:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so3512546pgc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GPbTqA3sKULGXvYjOTM7gfPZ7s4y9WwkUm1EREZ84Ec=;
        b=0KPNMSd1e/ZShlAg1C25np34O9KMTbLFWMGEN4hhgcEhVyzmdg5tjbCMiFs1aybHC6
         Qpem7qqPH7wZ4Y1fpd/on//UTqYR/TJz2wC3p8mAuf4EPSJ+zqxXdvq+cUPYsMcx/dRk
         EJrnBOUKqsEexPUnDc9t4pjTsVMOc/DoL+jt8v9Wyf/nNMNpk+KmMOurhckcCiuYo8aP
         tWxIVyTzlRevLlnAIJgCTLQ7i0JTkhGkeIzFcoQPfXmExNfoNOaGDETbyV6xKsyeqkXF
         EHjzKM3rmL85wy3SZurcNLO0/Vg8m4xth9v1V0hD2M/S/tFuQf+P5py04XOUCNByiOKB
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GPbTqA3sKULGXvYjOTM7gfPZ7s4y9WwkUm1EREZ84Ec=;
        b=qTfLzAu6Sx4VyrvqgvIxHsfM4cS777VqqyTlzRzQ4dKqf3FBFjQNKJrVR0slG1phoj
         nZZYDv164osoKIx/gmgYzVlG7yusdsl/nxvDXLHJjLTz5XEGPCp1POqpXG4cUPMYCbet
         gLbgKE3jIJjMacYhUh7yoArrj8CZA8UCJtZqhMSD1EqnN4U4nLcf/uZT+5juoeqwDra2
         uqLgGS8lxuzpqvGkUWBfRSsiUPbZzmioWcYamrl1oD+CCzgCSwuEXYUVbUxHnzVOMCk1
         RC3cGW49OWZxc2rQHLf9C7zvCvQb62c7AqFXCtvyl/wUUOYpcL2DpPLPSKGraBtXcmu5
         /O9A==
X-Gm-Message-State: APjAAAWlbrl5yS15ngpXGT8KB8cCJMLkKcW9CTnmelj2OHFPkRN8Garj
        TXCUe4pyql4E1Lysf8K3VpobQw==
X-Google-Smtp-Source: APXvYqxxNUBl2ALbzC/oRGpRc2/4PfBhkyFvL2USl2iASHWmjwWhqOT4E5ch4yBkBNmaWJBlon5wXQ==
X-Received: by 2002:a62:4118:: with SMTP id o24mr74875817pfa.17.1558633431910;
        Thu, 23 May 2019 10:43:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:a988])
        by smtp.gmail.com with ESMTPSA id h18sm13255pgv.38.2019.05.23.10.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 10:43:50 -0700 (PDT)
Date:   Thu, 23 May 2019 13:43:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523174349.GA10939@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I noticed that recent upstream kernels don't account the xarray nodes
of the page cache to the allocating cgroup, like we used to do for the
radix tree nodes.

This results in broken isolation for cgrouped apps, allowing them to
escape their containment and harm other cgroups and the system with an
excessive build-up of nonresident information.

It also breaks thrashing/refault detection because the page cache
lives in a different domain than the xarray nodes, and so the shadow
shrinker can reclaim nonresident information way too early when there
isn't much cache in the root cgroup.

This appears to be the culprit:

commit a28334862993b5c6a8766f6963ee69048403817c
Author: Matthew Wilcox <willy@infradead.org>
Date:   Tue Dec 5 19:04:20 2017 -0500

    page cache: Finish XArray conversion
    
    With no more radix tree API users left, we can drop the GFP flags
    and use xa_init() instead of INIT_RADIX_TREE().
    
    Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/fs/inode.c b/fs/inode.c
index 42f6d25f32a5..9b808986d440 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(inc_nlink);
 
 static void __address_space_init_once(struct address_space *mapping)
 {
-       INIT_RADIX_TREE(&mapping->i_pages, GFP_ATOMIC | __GFP_ACCOUNT);
+       xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
        init_rwsem(&mapping->i_mmap_rwsem);
        INIT_LIST_HEAD(&mapping->private_list);
        spin_lock_init(&mapping->private_lock);

It fairly blatantly drops __GFP_ACCOUNT.

I'm not quite sure how to fix this, since the xarray code doesn't seem
to have per-tree gfp flags anymore like the radix tree did. We cannot
add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
xarray api doesn't seem to really support gfp flags, either (xas_nomem
does, but the optimistic internal allocations have fixed gfp flags).
