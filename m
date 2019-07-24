Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB24734AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGXRL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 13:11:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34556 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGXRL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:11:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so22274095plt.1;
        Wed, 24 Jul 2019 10:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ITF8T/T4IRmGXwtRff4SYZQW9zAOexuz5C2yXEWqdiw=;
        b=pSA4u0tyJ7JlLMIahu8xE9Nv7IG7n0au5XkeRxFr+NCHw4jU0Me7rb4bQT8OKzrOj4
         jfYPpkmVo5uvTdZklKuAlIDAIXF6xHGnuqCRpmXBsOmHnmEUz6GOln3ay0DWT71Od+LS
         J94HHs1uvvW7DdKiWv8Qiv0wIfSfzfF0nRp4V2XrlKWcX4Mvz1J4oUkupSF8V9JKFqdS
         JyYDdG80MN2yuy4YR3u4/h81tngGYS4153ToixySf4i8oU6nenBeLsFgMAqWK8RyvNLY
         VZMSn0ruAb03gZIi1fuHPxlOc9nkUKcS+NGxVGRkhJx6SQD1ii3+PfQGraq7HV3hPQ2w
         77Sg==
X-Gm-Message-State: APjAAAXMtgnHqGJAXMDOOtWIEhfbovxmleDJf7DbZraBwazyEXDjsi8p
        U4VK76CVy+8ht+8EUea8Ayg=
X-Google-Smtp-Source: APXvYqwoAqWJaD8G9kpqywHtKCy/l+Vyxr3KKHtKTaJVbqukgpdEilFdeN9cgx3TW9bJG3WUBlH/LA==
X-Received: by 2002:a17:902:7488:: with SMTP id h8mr12079513pll.168.1563988285727;
        Wed, 24 Jul 2019 10:11:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h16sm51887353pfo.34.2019.07.24.10.11.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:11:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BEECC402A1; Wed, 24 Jul 2019 17:11:23 +0000 (UTC)
Date:   Wed, 24 Jul 2019 17:11:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH REBASE v4 05/14] arm64, mm: Make randomization selected
 by generic topdown mmap layout
Message-ID: <20190724171123.GV19023@42.do-not-panic.com>
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724055850.6232-6-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724055850.6232-6-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:58:41AM -0400, Alexandre Ghiti wrote:
> diff --git a/mm/util.c b/mm/util.c
> index 0781e5575cb3..16f1e56e2996 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -321,7 +321,15 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>  }
>  
>  #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> -#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
> +{
> +	/* Is the current task 32bit ? */
> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
> +		return randomize_page(mm->brk, SZ_32M);
> +
> +	return randomize_page(mm->brk, SZ_1G);
> +}
> +
>  unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd;
> @@ -335,7 +343,6 @@ unsigned long arch_mmap_rnd(void)
>  
>  	return rnd << PAGE_SHIFT;
>  }

So arch_randomize_brk is no longer ifdef'd around
CONFIG_ARCH_HAS_ELF_RANDOMIZE either and yet the header
still has it. Is that intentional?

  Luis
