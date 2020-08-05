Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE223D128
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHET5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgHEQoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:44:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B5C034625;
        Wed,  5 Aug 2020 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=da1gRr0zZ2t7B4lRqNuRkoPDQjMi6ltCJuE8Al1tVCE=; b=HWXVkRHwN832dRG05UXHB0oBIw
        bVIHmST3idcP9ekdGW3zfjwF0Pw9NtKHZriMtDEWG2IfLDr6OCBzltDSMhOl6UaR4VB+MKj5TLP04
        D+y2OfSJNRXduO2wurxCTyIhNrEbjOfxiC3fQ9kowloxLDsXYz+qNZBWskWkV4r67YJb5rni6tnxu
        zEaPdgkZf+diFOhUAogaiUm5PlxPfMHj+JY1pUqMrnKYwv3swkoiKxzB+3OAJw82jZfkAD5C/RvSG
        ZSbD7oGskSaQ/+z+rKi6n9bG70XhVIbZNtZ+0+ODNHwM6cKpRLNKr0S7UXSrAbxLcx/udZsOs7w26
        cmMvbHww==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3J6n-0003pL-49; Wed, 05 Aug 2020 13:05:31 +0000
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f52d43e-29e4-b175-73d5-0aa3c3e79f23@infradead.org>
Date:   Wed, 5 Aug 2020 06:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804095035.18778-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/4/20 2:50 AM, Mike Rapoport wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f2104cc0d35c..8378175e72a4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -872,4 +872,8 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config SECRETMEM
> +        def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED

use tab above, not spaces.

> +	select GENERIC_ALLOCATOR
> +
>  endmenu


-- 
~Randy

