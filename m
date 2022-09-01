Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A085A8BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIADVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIADVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:21:40 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468911BE0B;
        Wed, 31 Aug 2022 20:21:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNuYo-Q_1662002491;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNuYo-Q_1662002491)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:21:33 +0800
Date:   Thu, 1 Sep 2022 11:21:31 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
Subject: Re: [RFC PATCH 0/5] Introduce erofs shared domain
Message-ID: <YxAlO/DHDrIAafR2@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jia,

On Wed, Aug 31, 2022 at 08:31:20PM +0800, Jia Zhu wrote:
> [Kernel Patchset]
> ===============
> Git tree:
> 	https://github.com/userzj/linux.git zhujia/shared-domain-v1
> Git web:
> 	https://github.com/userzj/linux/tree/zhujia/shared-domain-v1
> 
> [Background]
> ============
> In ondemand read mode, we use individual volume to present an erofs
> mountpoint, cookies to present bootstrap and data blobs.
> 
> In which case, since cookies can't be shared between fscache volumes,
> even if the data blobs between different mountpoints are exactly same,
> they can't be shared.
> 
> [Introduction]
> ==============
> Here we introduce erofs shared domain to resolve above mentioned case.
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.

As we discussed in the previous community meeting, I agree that is useful
and it's the prerequisite of storage/page cache sharing between blocks
among different images (filesystems).

Thanks for your time and effort on this!

> 
> [Usage]
> Users could specify 'domain_id' mount option to create or join into a
> domain which reuses the same cookies(blobs).
> 
> [Design]
> ========
> 1. Use pseudo mnt to manage domain's lifecycle.
> 2. Use a linked list to maintain & traverse domains.
> 3. Use pseudo sb to create anonymous inode for recording cookie's info
>    and manage cookies lifecycle.
> 
> [Flow Path]
> ===========
> 1. User specify a new 'domain_id' in mount option.
>    1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
>    1.2 Create a new domain(volume), add it to domain list.
>    1.3 Traverse pseudo sb's inode list, compare cookie name with
>        existing cookies.[Miss]
>    1.4 Alloc new anonymous inodes and cookies.
> 
> 2. User specify an existing 'domain_id' in mount option and the data
>    blob is existed in domain.
>    2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
>    2.2 Reuse the domain and increase its refcnt.
>    2.3 Traverse pseudo sb's inode list, compare cookie name with
>    	   existing cookies.[Hit]
>    2.4 Reuse the cookie and increase its refcnt.
> 
> [Test]
> ======
> Git web: (More test cases will be added.)
> 	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain

I'd suggest integrating to erofs-utils testcases directly, see
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

Thanks,
Gao Xiang
