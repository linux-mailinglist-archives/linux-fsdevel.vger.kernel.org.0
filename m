Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4676B570
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjHANFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjHANFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:05:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C751B0
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 06:05:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb7b8390e8so34236015ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690895142; x=1691499942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNAKszskixaa3hgdlCtn/3Bo9V9ma0+ARvrVT7ws8lk=;
        b=ZCuzNn6APf7Wf5WKyrW32GNHO/80jBoq1pCrGN0t5E5cwIUsRt+Tn/GES+T/KnDh4A
         tLt6wMhodhapCC063cH2e2hxFD7fuxIe89FyLyk+MflUnbkZo8wAf0AgiYflVFpkd6Aj
         CmmBUe/FhROpxJgkVL/zskys1dhqdnbpSPxtQc3cTvda5v/yzQ3tAZlzNg7/DPyQmQ/2
         sTGb8bcyYVIKLSZ6XRVJ+gVxZYwqnq8oYBn5fJPqdJe0e0iEc+hAOhC4VH3eP9MOVmjt
         nT+pq2XgFtqGgZIfqTE6OWa4Z+V0satqrO3PoJ/gpvEvpAdOpMA0RxY6pQQhp7zoD/yF
         JWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895142; x=1691499942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNAKszskixaa3hgdlCtn/3Bo9V9ma0+ARvrVT7ws8lk=;
        b=PG595qnMH5BMLs88msefL0Tdmqb/DwIuGJbKI/IOrhMn6GyRGUDYHqcvwPk/iy9d8q
         JbU9h1yyHr9hEUVfLIM8c5PHiz0RQOTdYSACY0l1jbSebQagb8w/Lc9ekSWCBu916B3C
         gjs9XrwwIZ3hp1uGaIRjnvbQEpO/9hnR18hppOgJg6/ZeO+/cNvxpw3WNB5X1Wsjrh/z
         +h+kvy68HdMeQMMGasf8RyUDILVZ8GleRjQIajamIj+FaaGQePbDOewY5Tch+v13nCBw
         4BJ/EG2RS5bfLDROhh8AazDdyqFfLitOG4UUDQHclJPX8YIy2lVO8QeM8dnG8n5CLRs8
         WhdA==
X-Gm-Message-State: ABy/qLYnvXO3Oz/sRrQkZZkslh4kKOvWnrDykQNLHKnWmy4GFBvt3i8L
        rLEvR76HaN5FDsDzaCK378hMlA==
X-Google-Smtp-Source: APBJJlFjj/UQBxDKWUdx/frDQYBFVDCh2370GVmNUaRC5O6568WBwiYbCtNgfs0MZwMCvU9A3D5z4A==
X-Received: by 2002:a17:902:bd48:b0:1b5:4679:568f with SMTP id b8-20020a170902bd4800b001b54679568fmr10179994plx.45.1690895142060;
        Tue, 01 Aug 2023 06:05:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001b9fef7f454sm10388131plf.73.2023.08.01.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:05:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qQp4F-002ma2-5I;
        Tue, 01 Aug 2023 10:05:39 -0300
Date:   Tue, 1 Aug 2023 10:05:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMkDIxFQQljY8Ah1@ziepe.ca>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n>
 <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
 <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:00:06PM +0200, David Hildenbrand wrote:

> Their logic is "if it's directly in the page table, create, hand it over. If
> not, please go the slow path.". In many cases user space just touched these
> pages so they are very likely in the page table.

I think it has become pretty confusing, overall.

In my mind 'pin_user_pages_fast()' should be functionally the same as
'pin_user_pages_unlocked()'.

Places call fast if they have no idea about what is under memory,
otherwise they call unlocked if you are pretty sure something is there
that needs the mmap lock to resolve.

If we need different behaviors a GUP flag makes the most sense.

> Always honoring NUMA faults here does not sound like the improvement we
> wanted to have :) ... we actually *don't* want to honor NUMA faults here.

Yeah, I think that is right. We should not really use the CPU running
PUP as any input to a NUMA algorithm.. If we want NUMA'ness then the
PUP user should specify the affinity that makes sense.

Jason
