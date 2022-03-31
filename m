Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAC4ED876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCaL13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiCaL13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01910541A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648725941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6v/pxjtS/nh5kH/fMn5ErzXLtOidoMFG1j3n8OeUoY=;
        b=gbxvYeLooNLLIqbcgBZ9fghthNkInyqdoQvEM2UsMgPetyaDqfAS/BFP25fIVYSWUVh91/
        BI1pp2Q9iVAZ4iiTZ7NtRbl1XZ+BXFwUq+AvLjLITxE1+OYm07YcxxYGFtzTTYRT9VG4Nb
        QvhxLrIopWVunDxslzvtv2SjFSTdrkY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-2ygecy6bMCqNaExH4GWkJg-1; Thu, 31 Mar 2022 07:25:39 -0400
X-MC-Unique: 2ygecy6bMCqNaExH4GWkJg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A88823C11C6F;
        Thu, 31 Mar 2022 11:25:38 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B1F401E67;
        Thu, 31 Mar 2022 11:25:36 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:25:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 0/4] Convert vmcore to use an iov_iter
Message-ID: <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
References: <20220318093706.161534-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

On 03/18/22 at 05:37pm, Baoquan He wrote:
> Copy the description of v3 cover letter from Willy:

Could you pick this series into your tree? I reviewed the patches 1~3
and tested the whole patchset, no issue found.

Thanks
Baoquan

> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.
> 
> This series resends Willy's v3 patches which includes patch 1~3, and
> append one patch to clean up the open code pointed out by Al.
> 
> Al's concerns to v3 patches and my reply after investigation:
> https://lore.kernel.org/all/YhiTN0MORoQmFFkO@MiWiFi-R3L-srv/T/#u
> 
> Willy's v3 patchset:
> [PATCH v3 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20211213143927.3069508-1-willy@infradead.org/T/#u
> 
> Changelog:
> ===
> v4:
>  - Append one patch to replace the open code with iov_iter_count().
>    This is suggested by Al.
>  - Fix a indentation error by replacing space with tab in
>    arch/sh/kernel/crash_dump.c of patch 1 reported by checkpatch. The
>    rest of patch 1~3 are untouched.
>  - Add Christopy's Reviewed-by and my Acked-by for patch 1~3.
> v3:
>  - Send the correct patches this time
> v2:
>  - Removed unnecessary kernel-doc
>  - Included uio.h to fix compilation problems
>  - Made read_from_oldmem_iter static to avoid compile warnings during the
>    conversion
>  - Use iov_iter_truncate() (Christoph)
> 
> 
> 
> Baoquan He (1):
>   fs/proc/vmcore: Use iov_iter_count()
> 
> Matthew Wilcox (Oracle) (3):
>   vmcore: Convert copy_oldmem_page() to take an iov_iter
>   vmcore: Convert __read_vmcore to use an iov_iter
>   vmcore: Convert read_from_oldmem() to take an iov_iter
> 
>  arch/arm/kernel/crash_dump.c     |  27 +------
>  arch/arm64/kernel/crash_dump.c   |  29 +------
>  arch/ia64/kernel/crash_dump.c    |  32 +-------
>  arch/mips/kernel/crash_dump.c    |  27 +------
>  arch/powerpc/kernel/crash_dump.c |  35 ++-------
>  arch/riscv/kernel/crash_dump.c   |  26 +------
>  arch/s390/kernel/crash_dump.c    |  13 ++--
>  arch/sh/kernel/crash_dump.c      |  29 ++-----
>  arch/x86/kernel/crash_dump_32.c  |  29 +------
>  arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
>  fs/proc/vmcore.c                 | 130 +++++++++++++------------------
>  include/linux/crash_dump.h       |  19 ++---
>  12 files changed, 123 insertions(+), 321 deletions(-)
> 
> -- 
> 2.34.1
> 

