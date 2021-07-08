Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15183C153A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhGHOg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHOg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:36:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96EC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jul 2021 07:34:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k4so1520959wrc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDSs2DJpkvmjdy/ldrd95Gbg+L6H4dOWfJtKIIJldsc=;
        b=SW/LJOUOx7PzozM5thktbGLy8B/5yfu3+JZCbtGwoOOzTe37yL2XV5gmnmLe1MHhwt
         AqT9Tzq4vDFhrvr5G6Ws0sJGSqvnlL9mNRARcNwsKhdI5zEoyrtA7ZZLjJNYrvkv/T60
         BCZBxyv8EYjexGGKrnlO1f0IzHQFhmYu4mBhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDSs2DJpkvmjdy/ldrd95Gbg+L6H4dOWfJtKIIJldsc=;
        b=sjcH+OLvluYGRpRc7PMQD/dEVLoYPetkZECly1m3RBxlaMwJj3wgfPGc1a/FyizRl9
         Dy2jwzB1RQcqWCCyYsUxTFgvN/f0hQymGgiMSnuokg2LdyXXlvRD0gz2hbjiAk4UTdVE
         8g5WmPXsbEp05QeqwHFWGg/ktpnLF4FyEzIWbFfKBkLTlV4xUV7FqkqNoJdF2/+L9sd/
         3Nk8EmxisnhJs87f2jRrpSaVzHvZLF3Orv9ml22PYrSMDRGkdArXmU/z6LXNkEZnpfzD
         J0mVV07phuneb1kR8RBDH13pd++Qc6jUSKloAkuO/42uBebGo6hbnD6q1QFKZ7UOnReY
         BsnQ==
X-Gm-Message-State: AOAM532MyvyVxkOBczRaakpoUvzcqIRBCcJDLkkIwCoiOj0WWxiL2XEt
        CV3TdCs1zQ3skLEyXMKt0ueQ/A==
X-Google-Smtp-Source: ABdhPJx3jdm+GjAm44iTp0z+0MpokXmdz+xkinfTZ1cAVy5bA+tq/QFev8+CgKKJxFIjOyK99/KvlQ==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr33994804wru.44.1625754855477;
        Thu, 08 Jul 2021 07:34:15 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id p7sm2396277wrr.21.2021.07.08.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 07:34:14 -0700 (PDT)
Date:   Thu, 8 Jul 2021 16:34:12 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     lijiazi <jqqlijiazi@gmail.com>
Cc:     lijiazi <lijiazi@xiaomi.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix use-after-free issue in fuse_read_interrupt()
Message-ID: <YOcM5AV730F0deDg@miu.piliscsaba.redhat.com>
References: <1625122687-30115-1-git-send-email-lijiazi@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625122687-30115-1-git-send-email-lijiazi@xiaomi.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 02:58:07PM +0800, lijiazi wrote:
> There is a potential race between fuse_read_interrupt and
> fuse_dev_do_write contexts as shown below:
> 
> TASK1:
> fuse_dev_do_write:
>                                TASK2:
>                                fuse_dev_do_read:
> 				 spin_lock(&fiq->lock);
> 				 fuse_read_interrupt();
> 				   list_del_init(&req->intr_entry);
>   fuse_request_end()//now req->intr_entry
> 	            //is empty so put this req
> TASK3:
> fuse_flash:
>   fuse_simple_request();
>   fuse_put_request();
>   kmem_cache_free();//free req
> 
> After TASK3 free req, TASK2 access this req in fuse_read_interrupt
> and gets below crash:

Great report, thanks.

> Put list_del_init after the code access req, if intr_entry not
> empty, fuse_request_end will wait for fiq->lock, req will not
> free before TASK2 unlock fiq->lock.

Unfortunately this doesn't reliably work since there's no memory barrier to
prevent the compiler or the CPU to rearrange those stores back into a
use-after-free configuration.

One way to fix that would be to use the list_del_init_careful()/
list_empty_careful() pair, that guarantees ordering.

However the below patch is simpler and also works since FR_INTERRUPTED is never
cleared, and it's safe to use list_del_init() unconditionally after having
locked fiq->lock.

Thanks,
Miklos


diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1c8f79b3dd06..dde341a6388a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -288,10 +288,10 @@ void fuse_request_end(struct fuse_req *req)
 
 	/*
 	 * test_and_set_bit() implies smp_mb() between bit
-	 * changing and below intr_entry check. Pairs with
+	 * changing and below FR_INTERRUPTED check. Pairs with
 	 * smp_mb() from queue_interrupt().
 	 */
-	if (!list_empty(&req->intr_entry)) {
+	if (test_bit(FR_INTERRUPTED, &req->flags)) {
 		spin_lock(&fiq->lock);
 		list_del_init(&req->intr_entry);
 		spin_unlock(&fiq->lock);
