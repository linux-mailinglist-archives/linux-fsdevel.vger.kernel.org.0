Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE11C968C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEGQbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 12:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGQbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 12:31:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A7C05BD43;
        Thu,  7 May 2020 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3gVdJM0Xac05/DiybGJ/iKfbblmg8k1slb7wrkVhFUM=; b=qI+OiMJGTT/r2plFsf+28wiPCI
        2xuIGAdK5DgYeC9KRbpiSZGpcscy3znvULgRQl4/ouzMBqIIKlcHAjVgi5TIlJ5h1RAb/XaaKf4Hh
        sx9Ab1+0i9/rCgwZtdxmK4sMm0guanzI6yHXKGcGlhzXmDMgLemdTXQm4vstJrMlnY8ML0UcrYf1P
        GST/iKWJScGCRYQKZk4G2cN1h1y6WVAFy2xPBq/KaTS9Q6Q+KP2UT4BNTCzPi89nTUUfidkVCquYO
        6T55jp+vxkDkvvKZL1iWyJEuCc7rMRgdM7ze8AtbgmtGnQAArI8a07xIIhiI40EjUqtcOa4z/dU30
        yHYpQt7Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjQH-0008QS-Do; Thu, 07 May 2020 16:30:57 +0000
Subject: Re: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring
 shmem pages
To:     Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
Date:   Thu, 7 May 2020 09:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/20 5:42 PM, Anthony Yznaga wrote:
> Improve performance by multithreading the work to preserve and restore
> shmem pages.
> 
> Add 'pkram_max_threads=' kernel option to specify the maximum number
> of threads to use to preserve or restore the pages of a shmem file.
> The default is 16.

Hi,
Please document kernel boot options in Documentation/admin-guide/kernel-parameters.txt.

> When preserving pages each thread saves chunks of a file to a pkram_obj
> until no more no more chunks are available.
> 
> When restoring pages each thread loads pages using a copy of a
> pkram_stream initialized by pkram_prepare_load_obj(). Under the hood
> each thread ends up fetching and operating on pkram_link pages.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/pkram.h |   2 +
>  mm/shmem_pkram.c      | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 2 deletions(-)

thanks.
-- 
~Randy

