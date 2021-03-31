Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E93509C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhCaVww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhCaVwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:52:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43109C061574;
        Wed, 31 Mar 2021 14:52:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o5so389615qkb.0;
        Wed, 31 Mar 2021 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVgFfy9Gk4TopgDWAZb3OEMFsekIXo3QttoRKgThI1I=;
        b=LlC/3vOcZu0Rh5837wBCMc/jMQBLoS5tu19QTNj1eof7IhHTCSrowwreYpcEeTbT5X
         NlWLfUqhbD9HhkHO9DsT4Tyx2dRlg91X71xYeCMm7fKtrUmafIBq7/LrPrNoupfhFp3m
         GewFfvppFWbs9VRkNf6T/omLtxmxV/Um2gbRVOo+AHZwOoh9mGFiVd9+oTJRsbPr+urV
         9+SzjFJBATN+dQCPHnqvB4BC59ngCo/QcWw7P40soldfgVxjJkBfgZEWDD018mop0vXZ
         RHFwc/5vTY5r72yfm8jOOOnGx6oz9cJw+eVDnJnP827bZO8OihlinIME1rTQWHzKsxKK
         ckUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVgFfy9Gk4TopgDWAZb3OEMFsekIXo3QttoRKgThI1I=;
        b=agDMhbaDAHhjurNo28A9Y1aV0ZC/Zyt/xhO3l+yk31Vamck4ce7KHRm/vpbK+iLv7d
         Wy6a9M6RF+Uhduu77L93Ar3mhuT2m+2/OdcydyCeDcIsBllYc8CVFLlxQJ74lNd0Qt/W
         ZZ4PRKhthAZ4aCENq1pGyu/517QKZvod6UwcUnCWfDwHUaAIE6jOz52ffkQ+wN0yrt5Q
         p6dJPbYNBGC5aoHTk3zyKj9y9AIzI+z3m2jwlnIiWC7PHCJqVIKiyH1tnDmp3vzxzGfv
         xQIBg/aGjzEwZYTBKih505nmNuF7iTi45Io5/Y67q2ZdVAEP2dS0f9Bp9gu6aLkR98Ld
         lWfQ==
X-Gm-Message-State: AOAM533G4wIwFMIZpqZKQPjpNwq5k6JnUGs59f8qpN6bU0TE+I+fvTdK
        ZD3YHFrVtp7CHOPDD0Q6OzU=
X-Google-Smtp-Source: ABdhPJwK1AgyeLn7/B6+lfbSP03Q/ohuFDGUVnzdZCNHOlmGfkjpcbj+5GbXHWQQi4iDLVthXpiBHg==
X-Received: by 2002:a37:78b:: with SMTP id 133mr5361746qkh.109.1617227539232;
        Wed, 31 Mar 2021 14:52:19 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d84sm2453310qke.53.2021.03.31.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:52:18 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:52:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH] memfd_secret: use unsigned int rather than long as
 syscall flags type
Message-ID: <20210331215218.GA3437@yury-ThinkPad>
References: <20210331142345.27532-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331142345.27532-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:23:45PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Yuri Norov says:
> 
>   If parameter size is the same for native and compat ABIs, we may
>   wire a syscall made by compat client to native handler. This is
>   true for unsigned int, but not true for unsigned long or pointer.
> 
>   That's why I suggest using unsigned int and so avoid creating compat
>   entry point.
> 
> Use unsigned int as the type of the flags parameter in memfd_secret()
> system call.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Yury Norov <yury.norov@gmail.com>
