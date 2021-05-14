Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BB380661
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhENJmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 05:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhENJmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620985256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
        b=YHwHH2ihE7MF9kaK0vsik5rPLpZbkAUFbP8cqiMPKL842Jxo4sKcRWxdJaKlQxdLN0ogu5
        AhCDbUdwKZBMnFEFSiTR47nPfi/9qV7pOUIxsDX1FeV+S8ay0s+SgT0GdlGvkPlmz0S6Ij
        yW93BW+P5qecf0Cij/30E7Za6KCFfM8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-K5eI14wBNCyGfnpck7gxyQ-1; Fri, 14 May 2021 05:40:55 -0400
X-MC-Unique: K5eI14wBNCyGfnpck7gxyQ-1
Received: by mail-ed1-f71.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so1700650edv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 02:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
        b=Tu3RWj5JdW2uJ8HDjJyZftSl8BTZlRO46d24nlmwsZZuShKgdULMg3YOXyL/iWr5zG
         Zdx/EKIOtdZZzSZ8tVWPiAwBlbM4gWOrQKFIyIHID+euCbU3gAvPlyxqkBkfLB8G/DM6
         1ieY5SaIR9TgfOxBPhes37KN3CxF/Gu02x5H4JEsySgg+MBY7B4eEs0vLuVjtquBjaoY
         aguIrX/lQDfBBwfd0YTCKB0RYcJkdF8e1bp11yJ8YAz4TjFSwjLXr/IYnW776Sz7KVxS
         7Sq42ZWK7Ygo0qJBhczTnA8F02QUCDw4E3VUw+qEqf8P7maIHaJbgr3P828Q/XU5TGYd
         99eA==
X-Gm-Message-State: AOAM530HEPdwMgGbZj7nDaAeNorwH7Cpy0d/00YTxE/puaTz6YNqmwSk
        w5mFh2xJd0jB+Q9GnKBMofRjlay445dPEvmRMfUmu+7lq4S3wV3aAP8wgN0P3FAe938+TBSm15/
        bW3FJtLvgG00nQb1y5IJVv9b3aA==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674455edx.274.1620985253914;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzAwSfBkG72zB94sJxDLgDbZ+DEQn4gYm5J85sFFQeIUDMZK27eq70zvt8ZCsSnIvH+CO+w==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674419edx.274.1620985253764;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id g10sm2885347ejd.109.2021.05.14.02.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-9-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 8/8] secretmem: test: add basic selftest for
 memfd_secret(2)
Message-ID: <a573f11d-7716-46cd-1d08-6840560d6877@redhat.com>
Date:   Fri, 14 May 2021 11:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-9-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The test verifies that file descriptor created with memfd_secret does not
> allow read/write operations, that secret memory mappings respect
> RLIMIT_MEMLOCK and that remote accesses with process_vm_read() and
> ptrace() to the secret memory fail.
> 

[...]

> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2020

2021 ?


-- 
Thanks,

David / dhildenb

