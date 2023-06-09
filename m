Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC2729ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjFIM5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbjFIM5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:57:01 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EF3C0F;
        Fri,  9 Jun 2023 05:56:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkiB-Kj_1686315376;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkiB-Kj_1686315376)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 20:56:17 +0800
Message-ID: <b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com>
Date:   Fri, 9 Jun 2023 20:56:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Serge Hallyn (shallyn)" <shallyn@cisco.com>,
        Colin Walters <walters@verbum.org>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <CH0PR11MB52997EFC3ECB27D338962536CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CH0PR11MB52997EFC3ECB27D338962536CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/9 20:03, Ariel Miculas (amiculas) wrote:

...

> 
> But aside from the infrastructure discussion:
> 
> This is yet another filesystem for solving the container image problem
> in the kernel with the addition of yet another filesystem. We just went
> through this excercise with another filesystem. So I'd expect some
> reluctance here. Tbh, the container world keeps sending us filesystems
> at an alarming rate. That's two within a few months and that leaves a
> rather disorganized impression.

Just a head up.  Since Rust kernel infrastructure is too premature,
it's impossible to handle page cache / iomap and many useful stuffs.
In the long term, at least (someday) after Rust infrastructure is
mature, I will implement EROFS ino Rust as a try as well.

As for chunk CDC, I don't see it's hard (since we already have some
CDC approach since Linux v6.1) but as an effective disk filesystem
for performance, EROFS on-disk data is all block-aligned to match
storage and page cache alignment.  If it's really needed, I could
update a more complete (but ineffective and slow) index version to
implement unaligned extents (both for decoded and encoded sides).
Yet I really think the main purpose of a kernel filesystem is to
make full use of kernel infrastructure for performance (like page
cache handling) otherwise a FUSE approach is enough.

Finally, as for OCI container image stuffs, I'd like to avoid
saying this topic anymore on the list (too tired about this).  I've
seen _three_ in-kernel approaches already before this one and I tend
to avoid listing the complete names (including FUSE alternatives)
here.  I really suggest if you guys could sit down and plan at least
a complete OCI standard for the next image format (even you don't
want to reuse any exist filesystem for whatever reasons).

Thanks,
Gao Xiang
