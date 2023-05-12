Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6570129B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 01:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbjELXtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjELXtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 19:49:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A11FCE;
        Fri, 12 May 2023 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4ZX1QbsgnACMl0+ymHQsi7obj3p2dLgG+1DiJQQXZaI=; b=PBbOYC+NOlIoS5pfqNH91W5qdP
        Lypac0GxOHWHQPUFjrnL4t6UzKo3Tgn48jI9YOhzyZng7ngSzHlF8/ZgA/sF1EbYoIemLKSm6xhE6
        sMbpW+5+KueIg3FM+2IHnk8+/7rCMSBT+NZGsOMWR54pCzPYgdE+LfpPLdfs8HXK3OoViWIelNmsZ
        +uA6edXGoUzaB+BFsGpvr2nEJsGuULIQdvrS7Q6lA68T/+4/GW259XPlClcTZ+WOb8c3HTrSyk7+m
        XoycMIjqwuq5pJlzizqLAHRyjPVfIM3W/XYiPPK+mk4RyVHxGhkTLbUWWbNWI3ak6xvgnk8g//Plw
        HW4iy7JA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxcVW-00DJRO-24;
        Fri, 12 May 2023 23:49:06 +0000
Message-ID: <d0c0488e-d862-fd4d-1687-5c9fec42ef76@infradead.org>
Date:   Fri, 12 May 2023 16:49:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Jan Engelhardt <jengelh@inai.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-5-kent.overstreet@linux.dev>
 <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
 <ZF6oejsUGUC0gnYx@moria.home.lan>
 <o52660s0-3s6s-9n74-8666-84s2p4qpoq6@vanv.qr>
 <ZF7LJdKoHj44KzVu@moria.home.lan>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZF7LJdKoHj44KzVu@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/12/23 16:26, Kent Overstreet wrote:
> On Sat, May 13, 2023 at 12:39:34AM +0200, Jan Engelhardt wrote:
>>
>> On Friday 2023-05-12 22:58, Kent Overstreet wrote:
>>> On Thu, May 11, 2023 at 02:14:08PM +0200, Jan Engelhardt wrote:
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>
>>>> The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
>>>> please edit.
>>>
>>> Where is that list?
>>
>> I just went to spdx.org and then chose "License List" from the
>> horizontal top bar menu.
> 
> Do we have anything more official? Quick grep through the source tree
> says I'm following accepted usage.

Documentation/process/license-rules.rst points to spdx.org for
further info.

or LICENSES/preferred/GPL-2.0 contains this:
Valid-License-Identifier: GPL-2.0
Valid-License-Identifier: GPL-2.0-only
Valid-License-Identifier: GPL-2.0+
Valid-License-Identifier: GPL-2.0-or-later
SPDX-URL: https://spdx.org/licenses/GPL-2.0.html


-- 
~Randy
