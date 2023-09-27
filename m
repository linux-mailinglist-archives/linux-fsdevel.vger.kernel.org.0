Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374237AFA05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 07:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjI0FXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 01:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjI0FWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:22:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46345FD1;
        Tue, 26 Sep 2023 22:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695791982; x=1727327982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XWRHK3XHMCPUS7DjwBYEn6sN3WEf4Pd1a63R09LlTdM=;
  b=Rn0ykur+VAe+a1zUi7FEh4gFnxrFp628QOzK1Yld8tZhYzThnszJp/w+
   Ywz2A0oi8KtkX4j/5zi+g3SG3duu/9UfmpT5BMmMUt7G6Fx2d3PeegCjk
   8e/8j2kTtqx3d+tlzb2hvCy47F3H+b3hTj8/CWLUnzKfs4YHM6cCA0C6v
   TLqQH/aIfG191BNg9R+LE/gD9lYMoAH4vXBHB6uXNPkmhzW34XHyhmWBM
   eHkfrUGMlBsUoQFi4HPfYCjGistMDujHxTvc6e6zwGuSFzFgimPi38UZW
   +sEoJGpwLdsVYwLJcSCh9le0vKpCGCd5lEyeqJFTr0WfmNwHYazmgFNau
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381633578"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381633578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725676254"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725676254"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.84]) ([10.238.8.84])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:19:32 -0700
Message-ID: <483f9e1e-7d01-5f06-3bfa-3788d2554724@linux.intel.com>
Date:   Wed, 27 Sep 2023 13:19:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-12-seanjc@google.com>
 <d66795f8-e524-2912-4b71-92ca4ffe8807@linux.intel.com>
 <ZQteNbPfx6P3r6B8@google.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ZQteNbPfx6P3r6B8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/21/2023 5:03 AM, Sean Christopherson wrote:
> On Mon, Sep 18, 2023, Binbin Wu wrote:
>>
>> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
>>> From: Chao Peng <chao.p.peng@linux.intel.com>
>> [...]
>>> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>>> +/*
>>> + * Returns true if _all_ gfns in the range [@start, @end) have attributes
>>> + * matching @attrs.
>>> + */
>>> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>>> +				     unsigned long attrs)
>>> +{
>>> +	XA_STATE(xas, &kvm->mem_attr_array, start);
>>> +	unsigned long index;
>>> +	bool has_attrs;
>>> +	void *entry;
>>> +
>>> +	rcu_read_lock();
>>> +
>>> +	if (!attrs) {
>>> +		has_attrs = !xas_find(&xas, end);
>> IIUIC, xas_find() is inclusive for "end", so here should be "end - 1" ?
> Yes, that does appear to be the case.  Inclusive vs. exclusive on gfn ranges has
> is the bane of my existence.

Seems this one is not included in the "KVM: guest_memfd fixes" patch series?
https://lore.kernel.org/kvm/20230921203331.3746712-1-seanjc@google.com/



