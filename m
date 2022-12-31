Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5D65A320
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLaH51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 02:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaH5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:57:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A033F;
        Fri, 30 Dec 2022 23:57:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m3so7895995wmq.0;
        Fri, 30 Dec 2022 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kckosCj7pS5VlSv2D9XB8a7P6gG7tisCAhaL+kMfg8Q=;
        b=HlUdlkkYBD1VrxQRDfo1VaZXwBxEhqFntD0ER6wxsm9EPnpFBodFw6lecFIvjXyuIR
         NvlJ+xTT8t5F/CFGZO9yoHc4nShURA0oe928dBFywR+fuk2LacZRyP5xOi1S8f09QeOw
         atnvqpN+T60933kWUqTyILbW1GvjmMweIsr16n9Ge0QBUBgCn8xgVhjOaPbBENfxh4gB
         NYicAYWQ/nElKqI/kXLdxKxwvWyKS/OprnFp6ejkj4kCZX3HhcV0CI7PyUZHVb81lIOU
         wbppN/+NbT9RUXKTXaJ+dluuRsgiP7nJ05RDYrLpbYwbMSzD3B+8qWafZu78UsSje+jj
         EZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kckosCj7pS5VlSv2D9XB8a7P6gG7tisCAhaL+kMfg8Q=;
        b=clkMb0TNWR9WFAm4GC0nDXre9XX5im+fATJrauXSCm3et5GHiWjIozZIdfh2RVxdYO
         EYCwrnmBJx7duxt13zoflMiWSlr1YFc3t8EZqYQCU+WbubN90UqOzVSi2KEX2/HXnwYN
         3B9dTuyUHVbSQ3tqA2rcrwoYCA9906Np6J0XtnrS+GVYFHELjC0MaCLfqyKYra/QAwwd
         lPUidvuH72z0kx2FRJWu0w9bcOHgXCDOSM4Li2vlVIOPmVucXTmDT7UFS/0OSluK6LzR
         CL3xPATWfGIW0Ksi5p226EU28bHmupUNAZCk3OwUO5txkaXB2Nil1dpfKJeqfqlMj3Kd
         q0aw==
X-Gm-Message-State: AFqh2krn8SBa7mMh0/TxwgEYfMIM1BdI2kxpo5rcS6N0/aYbpC1s1dIc
        QxUtnTI9p/UPZCLB9N4JtCE=
X-Google-Smtp-Source: AMrXdXtin+pL4n/6G7Y4U1HqpRy2k/RScc2MrKN/HNMs21aam1to4ODLQetyUfhtICbK1/SxdlqEOw==
X-Received: by 2002:a05:600c:154b:b0:3cf:674a:aefe with SMTP id f11-20020a05600c154b00b003cf674aaefemr24413674wmg.22.1672473442218;
        Fri, 30 Dec 2022 23:57:22 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm39389232wms.11.2022.12.30.23.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:57:21 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/4] fs/sysv: Replace kmap() with kmap_local_page() 
Date:   Sat, 31 Dec 2022 08:57:13 +0100
Message-Id: <20221231075717.10258-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

kmap_local_page() in fs/sysv does not violate any of the strict rules of
its use, therefore it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
requires the mapping address, so return that address from dir_get_page()
to be used in dir_put_page().

I had submitted a patch with the same purpose but it has been replaced
by this series.[1] This is based on a long series of very appreciated
comments and suggestions kindly provided by Al Viro (again thanks!).[2][3][4]

Since this is a very different thing, versioning restarts from scratch.

[1] https://lore.kernel.org/lkml/20221016164636.8696-1-fmdefrancesco@gmail.com/
[2] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/#t
[3] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/#t
[4] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/#t

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (4):
  fs/sysv: Use the offset_in_page() helper
  fs/sysv: Change the signature of dir_get_page()
  fs/sysv: Use dir_put_page() in sysv_rename()
  fs/sysv: Replace kmap() with kmap_local_page()

 fs/sysv/dir.c   | 117 +++++++++++++++++++++++++++---------------------
 fs/sysv/namei.c |   9 ++--
 fs/sysv/sysv.h  |   1 +
 3 files changed, 71 insertions(+), 56 deletions(-)

-- 
2.39.0

