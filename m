Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F564B4BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLMMEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 07:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiLMMEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:04:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116915FF7;
        Tue, 13 Dec 2022 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670933071; x=1702469071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mmu9iz+w3ikTp4SbfrscqkeC55Id70T9EZSgNrTlufI=;
  b=e967PJunPwWLSe4kiRQX43P+//IFrMIQ64q/15C+g0aLGJzx/UbPpVuM
   NY9urI1m4MPM+buI+QuGwhlJj2EBnsAd6sFSirrwPVgQJZteBfp0ddnBM
   rrpboGVQytpHpG5fNvUnz7O7Y/PPokyQFHhpY34nC+bJgAO8NiiYlKG1M
   hgJZ5lJZ3+d/ieM+X9eanV+9Hr5s/htldCtZVsdv3hfUFwGoF8dD8YVwz
   w17jzbgLU/MqpJOIKp1FlCWoNDAYzFVNSGr0GfqZmU3fVo3u2t5th9jYf
   Uq7Z1SvjGBjQuziaJLHbol8UxDaFpMsLAesJMNu7VTGJS8IyzxeLEjDT8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315751828"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="315751828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 04:04:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="598800801"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="598800801"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.31.20]) ([10.255.31.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 04:04:17 -0800
Message-ID: <4d736cc0-f249-6531-c0af-7093c2c2537f@intel.com>
Date:   Tue, 13 Dec 2022 20:04:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <cd950a78-5c5b-16ef-d0a6-ad2878af067e@intel.com>
 <20221208113003.GE1304936@chaop.bj.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20221208113003.GE1304936@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/8/2022 7:30 PM, Chao Peng wrote:
> On Thu, Dec 08, 2022 at 04:37:03PM +0800, Xiaoyao Li wrote:
>> On 12/2/2022 2:13 PM, Chao Peng wrote:
>>
>> ..
>>
>>> Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
>>> and right now it is selected on X86_64 only.
>>>
>>
>>  From the patch implementation, I have no idea why HAVE_KVM_RESTRICTED_MEM is
>> needed.
> 
> The reason is we want KVM further controls the feature enabling. An
> opt-in CONFIG_RESTRICTEDMEM can cause problem if user sets that for
> unsupported architectures.

HAVE_KVM_RESTRICTED_MEM is not used in this patch. It's better to 
introduce it in the patch that actually uses it.

> Here is the original discussion:
> https://lore.kernel.org/all/YkJLFu98hZOvTSrL@google.com/
> 
> Thanks,
> Chao

