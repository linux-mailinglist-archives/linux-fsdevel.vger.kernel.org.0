Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8CC782F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHURje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjHURjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:39:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7B10D
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:39:32 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58c5642701fso41585977b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692639571; x=1693244371;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJX7MwjsOoEAU4n1K0Gc7OUpchcxhrveli2zRquYcfM=;
        b=h3oLSE0MPb0Y6Ruphc34mC5EejRltyhCWY0ARZy+OddyslyW4KueR8NGvHkw/fNU/O
         LO7GxPGuKSA5HlxAmMJ7PZkhIGPe/N8dhTWw+siswnce5O95prajQi19L19IhtR9jopE
         MNHTPKqBNzrlFq1fnOvnuSDECn9pTNgwKidiqLJzWtATH6XEovc0+T5uWLSgVvNKZAwf
         gngmJvzGPWuFSXwKkzbZXv70/XSxjLdqMOTgQOTzc5jWW1xaqHotoKHMqr2DdJ2GZrDz
         lyV9HljFHW6Zs556nBEkP0bIBssLD3g40i1bgMYur00mmBdbqw68ULwOVxHEY3Ia0Jdy
         6abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692639571; x=1693244371;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJX7MwjsOoEAU4n1K0Gc7OUpchcxhrveli2zRquYcfM=;
        b=WuZ4BFEal3QgfLrPY974gzXn33wJxbcPSLPdTV+5HVkNmoRWD0XnFWz8cFUKPN1pVI
         a2Hp9GXmG7DOw95Eoe6NrLMZj9+ycojSnWx4QwsMzOxPU3anFkQ5kgHLMvRMl/Oe9z51
         Gg6Wh9SDjLLf7AEOdLY0o1ObICu39xgnW9HQHDpgKzYC0DvjCcEm+QMuZ/86jDnzmDYV
         8cU5NXZYCQrAGOEpaFR4gKcGcDrRGfdqBC2sGiCXbW/7s7Zpi+wKTLTLzb5fGA0W5ioh
         LHtBfuapZSdF1zlET6DGeF+UZmkoFWu/IThIx087lM3Il9TzOlYg0zCJqQyitFG/LVIJ
         zvig==
X-Gm-Message-State: AOJu0YwrYCY9sIoYt/zOmsot42yDfmoVk0FKG6sZSCWIPgQRJxte4j8Y
        uoGwFNN2BkPaGt1r5nwN4RRaEQ==
X-Google-Smtp-Source: AGHT+IETtLD2S7L2QNNi7uG8/ZS7v+I1kKPcz+3JZc2Z9oVGavsZPdSX8iGt/MCKEhW5o5iS6U1RPA==
X-Received: by 2002:a81:9141:0:b0:57a:8ecb:11ad with SMTP id i62-20020a819141000000b0057a8ecb11admr8340512ywg.43.1692639571177;
        Mon, 21 Aug 2023 10:39:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c128-20020a0dda86000000b0058d4eaa6fe0sm2358661ywe.52.2023.08.21.10.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:39:30 -0700 (PDT)
Date:   Mon, 21 Aug 2023 10:39:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Franklin Mathieu <snaipe@arista.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs] tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple
 xattrs
In-Reply-To: <20230810-notwehr-denkbar-3be0cc53a87a@brauner>
Message-ID: <f6953e5a-4183-8314-38f2-40be60998615@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <20230809-postkarten-zugute-3cde38456390@brauner> <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner> <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
 <20230810-notwehr-denkbar-3be0cc53a87a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is particularly important for the userns mount case (when a sensible
nr_inodes maximum may not be enforced) that tmpfs user xattrs be subject
to memory cgroup limiting.  Leave temporary buffer allocations as is,
but change the persistent simple xattr allocations from GFP_KERNEL to
GFP_KERNEL_ACCOUNT.  This limits kernfs's cgroupfs too, but that's good.

(I had intended to send this change earlier, but had been confused by
shmem_alloc_inode() using GFP_KERNEL, and thought a discussion would be
needed to change that too: no, I was forgetting the SLAB_ACCOUNT on that
kmem_cache, which implicitly adds __GFP_ACCOUNT to all its allocations.)

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/xattr.c | 4 ++--
 mm/shmem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 2d607542281b..efd4736bc94b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1093,7 +1093,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kvmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!new_xattr)
 		return NULL;
 
@@ -1217,7 +1217,7 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
 		if (!new_xattr)
 			return ERR_PTR(-ENOMEM);
 
-		new_xattr->name = kstrdup(name, GFP_KERNEL);
+		new_xattr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
 		if (!new_xattr->name) {
 			simple_xattr_free(new_xattr);
 			return ERR_PTR(-ENOMEM);
diff --git a/mm/shmem.c b/mm/shmem.c
index b782edeb69aa..11298c797cdc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3616,7 +3616,7 @@ static int shmem_initxattrs(struct inode *inode,
 
 		len = strlen(xattr->name) + 1;
 		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
-					  GFP_KERNEL);
+					  GFP_KERNEL_ACCOUNT);
 		if (!new_xattr->name) {
 			kvfree(new_xattr);
 			break;
-- 
2.35.3

