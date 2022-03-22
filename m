Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E54E35B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiCVAwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiCVAwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:52:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8D275C2;
        Mon, 21 Mar 2022 17:51:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk12so1284543qvb.13;
        Mon, 21 Mar 2022 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=2yh3eeY6mtNkWo8Z5mBcuKeO1GX7Ddd7cVaBFvCLdqY=;
        b=T1AELz7TXpicUIyDb5QZbA+4pQnpQWobSFXoQ2oGtPnx/PNHES0PpfTNln/mzS9+cE
         jZ32TaAssTlfIkmAYzpUS2/jXB3TsJlCXZB1Nn943LxRVYI9IG6M0sPcfPF0ySlPHzm3
         gAnLQivzAkgi2YQvhKmi21SFYRDWq4/E3QygKLTWi7z5pKtOeTKsB+mDfzq2pAe2iwQ4
         GAPdKN9JsQanuFxmSkYEihQQBNqxCkRDFH2LqxAYLAJlVBVVCALCgVT+/CccZ4vqUrtl
         /ECmO3eKRwmLBLxT//6YO9dbGwEvGxj8sQ8q5nr38Z5+AIt2WKquf7KM2F5Gkcb3sPSp
         g9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=2yh3eeY6mtNkWo8Z5mBcuKeO1GX7Ddd7cVaBFvCLdqY=;
        b=mctVM0bnCuOm6SMMLCq/ek1UJPg+ULv7uxUdNXdpZLUbI91aWLPXBSKeCKJUptiydk
         gHxGFh1cT6UQXEV2AdtRwkcZakDyHyosGacVVcvE1mlDXVgN72zSqDFmCMIwUq09yTlJ
         w787lvql0cV39rq0pq0I/7SL2AKv5KzjO+SzrhQT3IbshLZBeErT5AvHvP/jT9tHpY3g
         eNiQIsndmodhmJtcTypekn3zBInA8DZZqhRI4YvAx2KFN4tWggaArfMzld+q8zDT11aO
         lxH7BF7RGzIv7RtavdNZtjg5bp1BsHsZX1jBhG3+/mrHmqK+JEkYcKe8k8e9Di6KArsO
         S+rw==
X-Gm-Message-State: AOAM5314C2F2o1wXIiY5Vea7J5tza1wfrjJ1MZ22m456wJ/n3LZVyrQv
        lNwiFvNbcNqCjZt7grvkYs3EJEq9w8e5
X-Google-Smtp-Source: ABdhPJyi1+KUHGTwPd9f7MTj0Iy15QPqAMe7NH2nWXXVcPZ2VNiKCcWGMKm6ugMmcUrXiUKHlCQw+g==
X-Received: by 2002:a05:6214:19e3:b0:440:da81:34e9 with SMTP id q3-20020a05621419e300b00440da8134e9mr18153251qvc.31.1647910263462;
        Mon, 21 Mar 2022 17:51:03 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm12658207qtj.33.2022.03.21.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:51:02 -0700 (PDT)
Date:   Mon, 21 Mar 2022 20:51:01 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM TOPIC] Improving OOM debugging
Message-ID: <20220322005101.actefn6nttzeo2qr@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Frustration when debugging OOMs, memory usage, and memory reclaim behaviour is a
topic I think a lot of us can relate to.

I think it might be worth having a talk to collectively air our frustrations and
collect ideas for improvements.

To start with: on memory allocation failure or OOM, we currently don't have a
lot to go on. We get information about the allocation that failed, and only very
coarse grained information about how memory is being tied up - page granural
informatian aka show_mem() is nigh useless in most situations, and slab granural
information is only slightly better.

I have a couple ideas I want to float:
 - An old idea I've had and mentioned to some people before is to steal dynamic
   debug's trick of statically allocating tracking structs in a special elf
   section, and use it to wrap kmalloc(), alloc_pages() etc. calls for memory
   allocation tracking _per call site_, and then available in debugs broken out
   by file and line number.

   This would be cheap enough that it could be always on in production, unlike
   doing the same sort of thing with tracepoints. The cost would be another
   pointer of overhead for each allocation - for page allocations we've got
   CONFIG_PAGE_OWNER that does something like this (in a much more expensive
   fashion), and the pointer it uses could be repurposed. For slub/slab I think
   something analogous exists, but last I looked it'd probably need help from
   those developers (in both cases, really; mm code is hairy).

 - In bcachefs, I've been evolving a 'printbuf' thingy - heap allocated strings
   that you can pass around and append to. They make it really convenient to
   write pretty-printers for lots of things and pass them around, which in turn
   has made my life considerably easier in the debugging realm.

   I think that could be useful here: On a typical system shrinkers own a
   signifcant fraction of non-pagecache kernel memory, and shrinkers have
   internal state that's particular to each shrinker that's relevant to how much
   memory is currently freeable (dirtyness, locking issues).

   Imagine if shrinkers all had .to_text() methods, and then on memory
   allocation failure we could call those and print them for top-10 shrinkers by
   memory owned - in addition to sticking it in sysfs or debugfs.
