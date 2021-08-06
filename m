Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7B3E22BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 07:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbhHFFAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 01:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhHFFAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 01:00:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FDC061798;
        Thu,  5 Aug 2021 22:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=mfp3lcLiizP+Ov0M2vzQv+FyVnyAM3p7EE1c6hFSDvk=; b=IyhXPpT63kcorJUwTft/59RsDJ
        cU2CHG/+cfemuM+XwBi0Q/c4fLiMlVuGUKEDWvJbM1uwwYUwXX5I+H1zcoOlWmE3KHx/jnYztsg7+
        AO8gm0o1UH/WdMuz4CuCl9u/KJjT/dxCeO5q7rHUIGZJOaMCxNPn+tNy73JEB7doHjUxUuRU+/uG9
        Urgwvz9cqJUBdVEgrGDGLP3tyLDTJZMWAVm/dy1IPnW/ukLqu8IsOUk18YCrxk17Uba8LOUavdWTk
        OKGVbEg4KIt5YuOVJo3IUWxkQC+h/RUnDAoWiqne/17TW+4E3zzwORCpVmV6+vPLf9aV/YD2EGRLA
        YiwcKGZA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBrxx-006GOr-3t; Fri, 06 Aug 2021 05:00:17 +0000
Subject: Re: mmotm 2021-08-05-19-46 uploaded (mm/filemap.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sjpark@amazon.de>
References: <20210806024648.V0Ye_YURy%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43bf8d13-505c-35b3-c865-a62bdcbafcf8@infradead.org>
Date:   Thu, 5 Aug 2021 22:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806024648.V0Ye_YURy%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/5/21 7:46 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-08-05-19-46 has been uploaded to
> 
>     https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

on i386, I am seeing lots of build errors due to references to
some PAGE_ flags that are only defined for 64BIT:

In file included from ../mm/filemap.c:44:0:
../include/linux/page_idle.h: In function ‘folio_test_young’:
../include/linux/page_idle.h:25:18: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
   return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
                   ^~~~~~~~~~~~~~
                   PAGEOUTRUN
../include/linux/page_idle.h:25:18: note: each undeclared identifier is reported only once for each function it appears in
../include/linux/page_idle.h:25:43: error: dereferencing pointer to incomplete type ‘struct page_ext’
   return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
                                            ^~
../include/linux/page_idle.h: In function ‘folio_set_young’:
../include/linux/page_idle.h:35:10: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
   set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
           ^~~~~~~~~~~~~~
           PAGEOUTRUN
../include/linux/page_idle.h: In function ‘folio_test_clear_young’:
../include/linux/page_idle.h:45:28: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
   return test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
                             ^~~~~~~~~~~~~~
                             PAGEOUTRUN
../include/linux/page_idle.h: In function ‘folio_test_idle’:
../include/linux/page_idle.h:55:18: error: ‘PAGE_EXT_IDLE’ undeclared (first use in this function); did you mean ‘CPU_NOT_IDLE’?
   return test_bit(PAGE_EXT_IDLE, &page_ext->flags);
                   ^~~~~~~~~~~~~
                   CPU_NOT_IDLE
   AS      arch/x86/crypto/twofish-i586-asm_32.o
   AR      arch/x86/events/zhaoxin/built-in.a
../include/linux/page_idle.h: In function ‘folio_set_idle’:
../include/linux/page_idle.h:65:10: error: ‘PAGE_EXT_IDLE’ undeclared (first use in this function); did you mean ‘CPU_NOT_IDLE’?
   set_bit(PAGE_EXT_IDLE, &page_ext->flags);
           ^~~~~~~~~~~~~
           CPU_NOT_IDLE
../include/linux/page_idle.h: In function ‘folio_clear_idle’:
../include/linux/page_idle.h:75:12: error: ‘PAGE_EXT_IDLE’ undeclared (first use in this function); did you mean ‘CPU_NOT_IDLE’?
   clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
             ^~~~~~~~~~~~~
             CPU_NOT_IDLE
   CC      mm/kfence/kfence_test.o
   CC      arch/x86/events/intel/uncore_nhmex.o
   CC      arch/x86/platform/atom/punit_atom_debug.o
../include/linux/page_idle.h: In function ‘folio_test_idle’:
../include/linux/page_idle.h:56:1: error: control reaches end of non-void function [-Werror=return-type]
  }

See:
--- a/include/linux/page_ext.h~mm-idle_page_tracking-make-pg_idle-reusable
+++ a/include/linux/page_ext.h
@@ -19,7 +19,7 @@ struct page_ext_operations {
  enum page_ext_flags {
  	PAGE_EXT_OWNER,
  	PAGE_EXT_OWNER_ALLOCATED,
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
  	PAGE_EXT_YOUNG,
  	PAGE_EXT_IDLE,
  #endif


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

