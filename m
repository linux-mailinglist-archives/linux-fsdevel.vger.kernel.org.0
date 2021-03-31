Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF73506A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhCaSob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhCaSoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:44:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A3C061574;
        Wed, 31 Mar 2021 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=foqFS80zPOxuSFemW+uOI8Rh0rNdKKPnoCESHBhVtec=; b=rLaTSHz/edMFCMAm0d8R9GS5dT
        mzZd5Z683y2gSfufpO6MSi8aCCn+CslJugFCy+o2M2xLpjzsTc/iXp5FfrOq0vBLlmPi9PjXaIPZr
        50eghi+2A+eM6gsSwEfkHDExnMVy8lt5/rqpyUDq2kqL60CZ2uG2VDv1HYJZl6qFyEPhOtGi1vYJU
        LPDaRgLsffbfSHe+VCeOG+ZCDy51UefrT9MdH5imqG8+HlfOGJh76PvSHRgTZ/RNCw8oiVOQjtfyu
        8oth72Zg/wbJvxIE5t9vRKwgIBMLDKjW8QfXralXKcJAWpXjbFfg6iglwgY0i6OagwCVwUULhyPJc
        +H3vYPJw==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfp0-007J0X-Gx; Wed, 31 Mar 2021 18:44:06 +0000
Subject: Re: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
To:     Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
 <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
Date:   Wed, 31 Mar 2021 11:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/21 2:35 PM, Anthony Yznaga wrote:
> Preserved-across-kexec memory or PKRAM is a method for saving memory
> pages of the currently executing kernel and restoring them after kexec
> boot into a new one. This can be utilized for preserving guest VM state,
> large in-memory databases, process memory, etc. across reboot. While
> DRAM-as-PMEM or actual persistent memory could be used to accomplish
> these things, PKRAM provides the latency of DRAM with the flexibility
> of dynamically determining the amount of memory to preserve.
> 
...

> 
> Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/pkram.h |  47 +++++++++++++
>  mm/Kconfig            |   9 +++
>  mm/Makefile           |   1 +
>  mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 include/linux/pkram.h
>  create mode 100644 mm/pkram.c
> 
> diff --git a/mm/pkram.c b/mm/pkram.c
> new file mode 100644
> index 000000000000..59e4661b2fb7
> --- /dev/null
> +++ b/mm/pkram.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/pkram.h>
> +#include <linux/types.h>
> +

Hi,

There are several doc blocks that begin with "/**" but that are not
in kernel-doc format (/** means kernel-doc format when inside the kernel
source tree).

Please either change those to "/*" or convert them to kernel-doc format.
The latter is preferable for exported interfaces.

> +/**
> + * Create a preserved memory node with name @name and initialize stream @ps
> + * for saving data to it.
> + *
> + * @gfp_mask specifies the memory allocation mask to be used when saving data.
> + *
> + * Returns 0 on success, -errno on failure.
> + *
> + * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
> + * case of failure) is to be called.
> + */


b) from patch 00/43:

 documentation/core-api/xarray.rst       |    8 +

How did "documentation" become lower case (instead of Documentation)?


thanks.
-- 
~Randy

