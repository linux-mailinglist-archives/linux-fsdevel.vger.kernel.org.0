Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0737FF9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEMVJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 17:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhEMVJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 17:09:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE4C061574;
        Thu, 13 May 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=puMCBatXvbMaxJ2hgetoloHiCLuOQHxAQ0mJZIFbNO4=; b=lnkdnmEFdc96TvOfe+wgZjwi8T
        wHYrRqnF/Q3VjUvdkqzVp4p+/N+PoSHFJsxDq654rkmB8gf6/3iqBGRwec+9BwDP2W7skuy/qlKR6
        xeFwqYaXXfVmdPn8kW1kFGbNaDHXzGTlhV8bwiU7B70Acd6t0SNtHFX4m2GYw0kJ+Q5fUn14XeZCJ
        HMXi9g6UfjrwABORcO+yyWP9wEwtB0ThbvKINLKZjLMgEXopt7o7p0kCbegGfysNVBoCOizzWYhIS
        qtzA7gM4QlCPoQ8K/eqvBLEeCE+veP90WBsul6d/+UGj25k9wZFiO1LexQV2r5rqDuaZZ7R7VuaZD
        8repElig==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhIZJ-00BX4A-TH; Thu, 13 May 2021 21:08:29 +0000
Subject: Re: mmotm 2021-05-12-21-46 uploaded (arch/x86/mm/pgtable.c)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
 <151ddd7f-1d3e-a6f7-daab-e32f785426e1@infradead.org>
 <54055e72-34b8-d43d-2ad3-87e8c8fa547b@csgroup.eu>
 <20210513134754.ab3f1a864b0156ef99248401@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a3ac0b42-f779-ffaf-c6d7-0d4b40dc25f2@infradead.org>
Date:   Thu, 13 May 2021 14:08:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210513134754.ab3f1a864b0156ef99248401@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/21 1:47 PM, Andrew Morton wrote:
> On Thu, 13 May 2021 19:09:23 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>>
>>
>>> on i386:
>>>
>>> ../arch/x86/mm/pgtable.c:703:5: error: redefinition of ‘pud_set_huge’
>>>   int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>>>       ^~~~~~~~~~~~
>>> In file included from ../include/linux/mm.h:33:0,
>>>                   from ../arch/x86/mm/pgtable.c:2:
>>> ../include/linux/pgtable.h:1387:19: note: previous definition of ‘pud_set_huge’ was here
>>>   static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>>>                     ^~~~~~~~~~~~
>>> ../arch/x86/mm/pgtable.c:758:5: error: redefinition of ‘pud_clear_huge’
>>>   int pud_clear_huge(pud_t *pud)
>>>       ^~~~~~~~~~~~~~
>>> In file included from ../include/linux/mm.h:33:0,
>>>                   from ../arch/x86/mm/pgtable.c:2:
>>> ../include/linux/pgtable.h:1391:19: note: previous definition of ‘pud_clear_huge’ was here
>>>   static inline int pud_clear_huge(pud_t *pud)
>>>                     ^~~~~~~~~~~~~~
>>
>> Hum ...
>>
>> Comes from my patch 
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/5ac5976419350e8e048d463a64cae449eb3ba4b0.1620795204.git.christophe.leroy@csgroup.eu/
>>
>> But, that happens only if x86 defines __PAGETABLE_PUD_FOLDED. And if PUD is folded, then I can't 
>> understand my it has pud_set_huge() and pud_clear_huge() functions.
> 
> Probably because someone messed something up ;)
> 
> Let's try this.
> 
> --- a/arch/x86/mm/pgtable.c~mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge-fix
> +++ a/arch/x86/mm/pgtable.c

That also works_for_me.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy

