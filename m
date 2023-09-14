Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A47A0BDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbjINRh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjINRhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:37:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531B10C7;
        Thu, 14 Sep 2023 10:37:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B111C433C8;
        Thu, 14 Sep 2023 17:37:14 +0000 (UTC)
Date:   Thu, 14 Sep 2023 18:37:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "hughd@google.com" <hughd@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hyesoo.yu@samsung.com" <hyesoo.yu@samsung.com>,
        "kcc@google.com" <kcc@google.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "david@redhat.com" <david@redhat.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "eugenis@google.com" <eugenis@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pcc@google.com" <pcc@google.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <ZQNEyFOcLv+eJkAr@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <0dc2afaf8a976ef8eb9af711fd941f1bbfd71321.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dc2afaf8a976ef8eb9af711fd941f1bbfd71321.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kuan-Ying,

On Wed, Sep 13, 2023 at 08:11:40AM +0000, Kuan-Ying Lee (李冠穎) wrote:
> On Wed, 2023-08-23 at 14:13 +0100, Alexandru Elisei wrote:
> > diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > index 60472d65a355..bd050373d6cf 100644
> > --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > @@ -165,10 +165,28 @@ C1_L2: l2-cache1 {
> >                 };
> >         };
> >  
> > -       memory@80000000 {
> > +       memory0: memory@80000000 {
> >                 device_type = "memory";
> > -               reg = <0x00000000 0x80000000 0 0x80000000>,
> > -                     <0x00000008 0x80000000 0 0x80000000>;
> > +               reg = <0x00 0x80000000 0x00 0x7c000000>;
> > +       };
> > +
> > +       metadata0: metadata@c0000000  {
> > +               compatible = "arm,mte-tag-storage";
> > +               reg = <0x00 0xfc000000 0x00 0x3e00000>;
> > +               block-size = <0x1000>;
> > +               memory = <&memory0>;
> > +       };
> > +
> > +       memory1: memory@880000000 {
> > +               device_type = "memory";
> > +               reg = <0x08 0x80000000 0x00 0x7c000000>;
> > +       };
> > +
> > +       metadata1: metadata@8c0000000  {
> > +               compatible = "arm,mte-tag-storage";
> > +               reg = <0x08 0xfc000000 0x00 0x3e00000>;
> > +               block-size = <0x1000>;
> > +               memory = <&memory1>;
> >         };
> >  
> 
> AFAIK, the above memory configuration means that there are two region
> of dram(0x80000000-0xfc000000 and 0x8_80000000-0x8_fc0000000) and this
> is called PDD memory map.
> 
> Document[1] said there are some constraints of tag memory as below.
> 
> | The following constraints apply to the tag regions in DRAM:
> | 1. The tag region cannot be interleaved with the data region.
> | The tag region must also be above the data region within DRAM.
> |
> | 2.The tag region in the physical address space cannot straddle
> | multiple regions of a memory map.
> |
> | PDD memory map is not allowed to have part of the tag region between
> | 2GB-4GB and another part between 34GB-64GB.
> 
> I'm not sure if we can separate tag memory with the above
> configuration. Or do I miss something?
> 
> [1] https://developer.arm.com/documentation/101569/0300/?lang=en
> (Section 5.4.6.1)

Good point, thanks. The above dts some random layout we picked as an
example, it doesn't match any real hardware and we didn't pay attention
to the interconnect limitations (we fake the tag storage on the model).

I'll try to dig out how the mtu_tag_addr_shutter registers work and how
the sparse DRAM space is compressed to a smaller tag range. But that's
something done by firmware and the kernel only learns the tag storage
location from the DT (provided by firmware). We also don't need to know
the fine-grained mapping between 32 bytes of data and 1 byte (2 tags) in
the tag storage, only the block size in the tag storage space that
covers all interleaving done by the interconnect (it can be from 1 byte
to something larger like a page; the kernel will then use the lowest
common multiple between a page size and this tag block size to figure
out how many pages to reserve).

-- 
Catalin
