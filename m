Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BA3E85BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhHJV4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhHJV4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:56:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8EC061765;
        Tue, 10 Aug 2021 14:56:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bj40so1322688oib.6;
        Tue, 10 Aug 2021 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JhQsCvjsX4aQ7AO0EcBhog4UmHjKzja8YKewWn/brBE=;
        b=NW6MnPyrxBCjdUNnbAdmDsnldUDzEXZD36UQwc7aL97R33BDGIc/OHc9ppOitiH2lE
         0jYNPSNPthFpMB5rIgY+POar807qjsE8bwv7pAFb82Ia4c0eakrMfq0ioZth6y5tKnJy
         2UzPnKG2J95PKPW+dC6i8cXlP5EWxfcc8UDn4Vdhh4dF50iyqL7Q6HIVEQZ91mtwI8dK
         qZkcKgmA1qvebHnr9ZAWPW0pLDjaygLbXIm+jrPc7EJZENzxE/FrF69cg/uhoeivFIIu
         kifuuPta/ThocQD8ZiJyb2UxrmtwUtyLRXTzLs7x0InuuhV8u5AHFtZM6+8HZrcGAXxn
         vO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=JhQsCvjsX4aQ7AO0EcBhog4UmHjKzja8YKewWn/brBE=;
        b=RWSC/ImwisAg40J+qVUHcig7HJifKrcp8sBhETIX4Qvoq0kPNT3g7Yi334DHkLLLlA
         6okmIZPZoxCOHo6m0M6rehg7uWLrWxPsTgl5PuVfN//kZG+lf1avhcO342kUucVyTHGf
         2mxkowHru8qMVXW/bLCFBGFcMLkIYZtWPMJUbECFXnxzBgeIwr0byLSn/V5cBz1P0/w7
         tIjlyfyKYlYd3y/ExGekED8oVBGDmUzrkKXDAeGwcdQe4edCGfJWB4/Lk1fKTojRogRM
         qylCLaHApAMv21BAGaqB9GjoYk8TMictQJTZZG5caVcDeWd4FwJjo5t243TURyVCYX2D
         NqwQ==
X-Gm-Message-State: AOAM532BhsZH9WzyRH1cIwyxs9mCxWE58GeouLm1pwuAwCixXPqwRpSg
        vK+eroYpOOlMqwyS51uUFE8=
X-Google-Smtp-Source: ABdhPJw6/9eEqccmAinCUXjeXr3qCuw+fiIj44SxsWN9sSw4bECkVmOOmTmRzmqaEcSTW0NcExehIg==
X-Received: by 2002:a54:468d:: with SMTP id k13mr5181021oic.125.1628632584113;
        Tue, 10 Aug 2021 14:56:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26sm4129659otu.38.2021.08.10.14.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:56:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Aug 2021 14:56:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the
 BDI API
Message-ID: <20210810215622.GA874076@roeck-us.net>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809141744.1203023-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:17:40PM +0200, Christoph Hellwig wrote:
> Don't leak the detaіls of the timer into the block layer, instead
> initialize the timer in bdi_alloc and delete it in bdi_unregister.
> Note that this means the timer is initialized (but not armed) for
> non-block queues as well now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Just in case this hasn't been reported yet.
This patch results in a widespread build failure. Example:

Building x86_64:tinyconfig ... failed
--------------
Error log:
mm/page-writeback.c:2044:6: error: redefinition of 'laptop_sync_completion'
 2044 | void laptop_sync_completion(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/memcontrol.h:22,
                 from include/linux/swap.h:9,
                 from mm/page-writeback.c:20:
include/linux/writeback.h:345:20: note: previous definition of 'laptop_sync_completion' with type 'void(void)'
  345 | static inline void laptop_sync_completion(void) { }
      |                    ^~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:272: mm/page-writeback.o] Error 1

Guenter

---
bisect log:

# bad: [92d00774360dfd4151f15ab9905c643347b9f242] Add linux-next specific files for 20210810
# good: [36a21d51725af2ce0700c6ebcb6b9594aac658a6] Linux 5.14-rc5
git bisect start 'HEAD' 'v5.14-rc5'
# good: [01dda625c9b7cfd3bf5ac05f73da8c512792f94c] Merge remote-tracking branch 'crypto/master'
git bisect good 01dda625c9b7cfd3bf5ac05f73da8c512792f94c
# bad: [75cadd49361c6650764d35bcbb6c9cb9f0a9d9a3] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
git bisect bad 75cadd49361c6650764d35bcbb6c9cb9f0a9d9a3
# good: [511b0c991c9d49fd6d8188f799b10aa0465cecf3] Merge remote-tracking branch 'drm-intel/for-linux-next'
git bisect good 511b0c991c9d49fd6d8188f799b10aa0465cecf3
# good: [f3b48aa06fb8b4384b90e41220da8be5a4013a6d] Merge remote-tracking branch 'input/next'
git bisect good f3b48aa06fb8b4384b90e41220da8be5a4013a6d
# bad: [87470038c43f9577a300a29ba6c2c95d28039464] Merge remote-tracking branch 'regulator/for-next'
git bisect bad 87470038c43f9577a300a29ba6c2c95d28039464
# bad: [e1796683109e4ba27c73f099486555a36820b175] Merge remote-tracking branch 'device-mapper/for-next'
git bisect bad e1796683109e4ba27c73f099486555a36820b175
# bad: [a11d7fc2d05fb509cd9e33d4093507d6eda3ad53] block: remove the bd_bdi in struct block_device
git bisect bad a11d7fc2d05fb509cd9e33d4093507d6eda3ad53
# good: [a291bb43e5c9fdedc4be3dfd496e64e7c5a78b1f] block: use the %pg format specifier in show_partition
git bisect good a291bb43e5c9fdedc4be3dfd496e64e7c5a78b1f
# good: [2112f5c1330a671fa852051d85cb9eadc05d7eb7] loop: Select I/O scheduler 'none' from inside add_disk()
git bisect good 2112f5c1330a671fa852051d85cb9eadc05d7eb7
# good: [ba30585936b0b88f0fb2b19be279b346a6cc87eb] dm: move setting md->type into dm_setup_md_queue
git bisect good ba30585936b0b88f0fb2b19be279b346a6cc87eb
# bad: [5ed964f8e54eb3191b8b7b45aeb52672a0c995dc] mm: hide laptop_mode_wb_timer entirely behind the BDI API
git bisect bad 5ed964f8e54eb3191b8b7b45aeb52672a0c995dc
# good: [d1254a8749711e0d7441036a74ce592341f89697] block: remove support for delayed queue registrations
git bisect good d1254a8749711e0d7441036a74ce592341f89697
# first bad commit: [5ed964f8e54eb3191b8b7b45aeb52672a0c995dc] mm: hide laptop_mode_wb_timer entirely behind the BDI API
