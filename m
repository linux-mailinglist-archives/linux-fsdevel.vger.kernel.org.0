Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E522E1BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGZRow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgGZRov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:44:51 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E6C0619D4
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 10:44:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so8106615pgc.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rz8PmAevX+AVytGTYCByWyvIy1/4eNHrEUMkdI13ieQ=;
        b=QWRKokJ1jbQuW0PkRJtwvVGJquSmHlRYaYTPngCykthHbtqC79WUZMe9dn94R+JHQ3
         MD6r4dbJ5S5EaTgzrs+PGRazPszQO6zgfKXIJWnhSpchzyta3doIZ1/mZ5P+pYMOJDQz
         H3b5dNV2gTNEO8N8SPevaOxawfoYNgAXdLyr0+yPXY3YUsKjNCb7/MEFYzngumWotZa2
         SRpKioyQgEhCAChtQDAJaDviE+f1X6taWqAtuQ0sMa5r2GQyorbXhCUrIaxkZai+xhQ/
         gE9k0/WeZ7f9KgmR16E5JMvK0QwTmEkUJjdbe7w5yBQg5IhZ/XLHXP1aTWzYshwZtbN7
         T23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rz8PmAevX+AVytGTYCByWyvIy1/4eNHrEUMkdI13ieQ=;
        b=qsGIbJkTvNeoIHNpOfkRBOfxKKuQzeNIwnmdZjJ5C8cw47FGe98qgfKV88m63F6aqC
         fRSZSvQWco6STM7dJ9g1XzX6AVzJsKoiPxJzMAz24tzdDnJ7IntQ2d82+THyzJdsnHzM
         0BSRKuqOv0RbBELZnDoXHTaXsj1Py1YihgFTnxEp9uqQln5y1J1HVRPa53sg6fwmMfRO
         RUDqHrYmKeBtz4Sy4iBAu4jqw4GAJ2Xkz4rajauGi2MABB1c+nZmsYZ+sz/++yAHbSfl
         9WKf5b7U5QESdrKae7nHN4AQLhe/iC7gXy1lXaYnWlxMrkEG8j8wvgfZUfLtfeiTEDSV
         BfSg==
X-Gm-Message-State: AOAM531cyaJdFKQEQI8WeFcFtVrIM5phTb6KRtZ10/9kFuj6ZBbA41zN
        bgvXOx9eUBbuzHONw8k0hYDiFw==
X-Google-Smtp-Source: ABdhPJwMFBKRD5d4MvMpsgEw1KumsNACvODlt+6//ct5AFSF4islz3zAwhx/bKFoMeysRB9OE9FIlA==
X-Received: by 2002:a62:8081:: with SMTP id j123mr30331pfd.80.1595785489483;
        Sun, 26 Jul 2020 10:44:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u2sm12465061pfl.21.2020.07.26.10.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 10:44:48 -0700 (PDT)
Date:   Sun, 26 Jul 2020 10:44:48 -0700 (PDT)
X-Google-Original-Date: Sun, 26 Jul 2020 10:44:45 PDT (-0700)
Subject:     Re: [PATCH 4/6] arch, mm: wire up secretmemfd system call were relevant
In-Reply-To: <20200720092435.17469-5-rppt@kernel.org>
CC:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, luto@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, elena.reshetova@intel.com,
        hpa@zytor.com, idan.yaniv@ibm.com, mingo@redhat.com,
        jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org,
        rppt@linux.ibm.com, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        tglx@linutronix.de, tycho@tycho.ws, will@kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rppt@kernel.org
Message-ID: <mhng-ffb01b1d-16c2-4998-8434-99f1cae575bd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Jul 2020 02:24:33 PDT (-0700), rppt@kernel.org wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Wire up secretmemfd system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/unistd32.h      | 2 ++
>  arch/arm64/include/uapi/asm/unistd.h   | 1 +
>  arch/riscv/include/asm/unistd.h        | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 1 +
>  include/uapi/asm-generic/unistd.h      | 7 ++++++-
>  7 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 977ee6181dab..9e47d9aed5eb 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -9,6 +9,7 @@
>   */
>
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SECRETMEMFD
>
>  #include <uapi/asm/unistd.h>

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
