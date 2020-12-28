Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6312E69FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgL1SXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 13:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgL1SXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:23:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A2C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 10:22:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so15308879ejy.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2QbH8RGPNV6UCpysofOcmKw2kvcdsWtyhs8XyCCINw=;
        b=oK1bIMFlk9+9P3yM6IxgC3sGgIIGBKSSzhxKjcmUmJw7zLxWGUG5Z4FT5RjgRhaBPN
         i7pYF9MtjhuJl7YWB8Sew1jRxwXZSpYdf7aochu1zb+ZWaH/fiz/eL4vSeZrajQE63Mv
         z8yRPyof9nFuCxMdTOpQKJbsFriOk4ifql5kOVecC6wXCqfH3/TJiCf5HKOIcx3H/IHz
         eIH4ub0+o/wzo0oEQ22VsKGEYwpVGASXaadXI+DYrBGeTAtjrCS7Bn2U/ZMS4ZMjCFOD
         I+9SQ2avnuepdBFUxQ4VZoQZyuyE/I1RxB1mpVZUmeo/uUA5VcVuLaaClMMSXkvR+40v
         RCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2QbH8RGPNV6UCpysofOcmKw2kvcdsWtyhs8XyCCINw=;
        b=eoqhwjhugPN+XIrgxML4oyUTUpI2S848BeDVSflDlV+lwtJ+6U75HaumVTxGZzVlm+
         OhrTWFFr1H4M0v5LtBcItUY96Zn2TbeIRjZ6kYQI1hLUKCNNiQaJXx344uxQq2U/DQoA
         riH5AwZQp5zdeR9PXS4hCDOU2eLYbCEwdA56qSL2FmHb8AIvnadnsIH1eGsNnjB/B6O+
         cGiSzhEXh0TNsjVPF8nZdiP/3Vqi5YJqONNijMD+q574QFFXh02t6gfvuyV0nXzoujip
         dc6KbGbPRt6B/S6OuL3qz8TJ15+7MueLE/26Vz42otyvtYmAXOTIJqynQl9q78Ue83Zz
         c3Kw==
X-Gm-Message-State: AOAM533OQz7jM4CkSevh03AK5cAVhYyPCkWAYvaSoNSiW1nkKv20Y4yo
        YW5MYrKaY2wWyqhqhQE4RUwY0hA8lEHOl3tZ3LZPrQ==
X-Google-Smtp-Source: ABdhPJwvPxy4pkRK8okJN0/k8NDFvWE5wVUKTWXkCWpjS8Ii2ZVkfms8OJy9V0jmRbDe+48+k7MFRRK2mCrz0IR2NF4=
X-Received: by 2002:a17:906:447:: with SMTP id e7mr42157038eja.172.1609179752023;
 Mon, 28 Dec 2020 10:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20201013013416.390574-1-dima@arista.com> <20201013013416.390574-3-dima@arista.com>
In-Reply-To: <20201013013416.390574-3-dima@arista.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 28 Dec 2020 10:21:56 -0800
Message-ID: <CADyq12y4WAjT7O3_4E3FmBv4dr5fY6utQZod1UN0Xv8PhOAnQA@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/mremap: For MREMAP_DONTUNMAP check security_vm_enough_memory_mm()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks good to me with a small comment.

>         if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
>                 /* OOM: unable to split vma, just get accounts right */
> -               if (vm_flags & VM_ACCOUNT)
> +               if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
>                         vm_acct_memory(new_len >> PAGE_SHIFT);

Checking MREMAP_DONTUNMAP in the do_munmap path is unnecessary as
MREMAP_DONTUNMAP will have already returned by this point.
