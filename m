Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9280549F7F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348063AbiA1LKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 06:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244239AbiA1LKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:10:41 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C6C061714;
        Fri, 28 Jan 2022 03:10:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d18so5608715plg.2;
        Fri, 28 Jan 2022 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpTrB1w23BF+6DdwaMHxzpTYFKzu4pd5U9VeSzFiuIk=;
        b=TEa5rKjcEAzmYaI8wm9Q8shd5d//zVYo+GOFi0bjEUmFAQQk5c4kszeX+FiVZ6U8lT
         HOvbO3+0T+Etk2lWwVJYdu8+4UGtManVzfTlNIA2vq/4qIUWFq37I0+gw8Ahi4xNI1sM
         +uOfNU2at/xQdgTxhQcV3eZNh5iePI1ZHqAr8lBGP8ZkqzWpoZ/DRTePHWW+t1wWEQB7
         CQLWg/RbpT6QMvbwH69fNtTFdki4k+FVq5iYOQkx+NJVJQJiYVsIIi00GuYz95apJIXy
         LL1chaId7hbhoPXE1iyV1ytsMqMbGXLm3xppAJ8W/9yIdtZoVm2f0lkqrRxTwVwAvGO/
         kajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpTrB1w23BF+6DdwaMHxzpTYFKzu4pd5U9VeSzFiuIk=;
        b=7JbuqkCY9azNrzGnp24sUVECC8jiIOmUKnDa6Q0DPGDV8jzSSvc7v5vIYuevOm3w7Q
         tIgSU/SPgr71yk4DEvUfsGHaNfb1ohhYTysj6n20Za/ijep54dWnsU0QyokRRNf7SJbZ
         sGKvpJTdJkaH4vp5CXRNwMkKcXtZ727lrBHbFxgTFb7zGaMY7UfdWcMSWDEt1BYABaQ/
         xCxHwK9a0rg6lOrwTJXFacViJ2m7gXhDmpVH1aFr9QYbybEvCAWnTHCTjwPawPZBh64J
         djvQzCdMxYGRF7Ah0CBOUwrOSNCxnRR6lirudodjsJAfmiaSddzJAZ0zCWaz6I+Iy6A/
         14cg==
X-Gm-Message-State: AOAM531ssg//eXRUkFANGlV3PYnmi9sOhTtMx+bSnH6Zl4E9LIDB2SC7
        fqFm7RVYD+aR3/ayprasecw=
X-Google-Smtp-Source: ABdhPJyOvOGiB3YatvCcD4+nTrrJ7xiYRe6nG5qS1A/UKHW4RWfqd58+hQ1Bs8dyF7NHZLQohQoILg==
X-Received: by 2002:a17:90b:1e45:: with SMTP id pi5mr7409150pjb.237.1643368240594;
        Fri, 28 Jan 2022 03:10:40 -0800 (PST)
Received: from gmail.com ([2400:2410:93a3:bc00:7019:fa7:ccfe:b136])
        by smtp.gmail.com with ESMTPSA id g9sm5566280pgi.84.2022.01.28.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:10:39 -0800 (PST)
Date:   Fri, 28 Jan 2022 20:10:34 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <20220128111034.jf3i4arhahfwwd6n@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-2-akirakawata1@gmail.com>
 <202201261955.F86F391@keescook>
 <20220127125643.cifk2ihnbnxo5wcl@gmail.com>
 <202201270816.5030A2A4B5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201270816.5030A2A4B5@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:23:51AM -0800, Kees Cook wrote:
> On Thu, Jan 27, 2022 at 09:56:43PM +0900, Akira Kawata wrote:
> > On Wed, Jan 26, 2022 at 09:01:30PM -0800, Kees Cook wrote:
> > > [...]
> > > 1) The ELF spec says e_phoff is 0 if there's no program header table.
> > > 
> > > The old code would just pass the load_addr as a result. This patch will
> > > now retain the same result (phdr_addr defaults to 0). I wonder if there
> > > is a bug in this behavior, though? (To be addressed in a different patch
> > > if needed...)
> > >
> > 
> > It is better to return NULL from load_elf_phdrs when e_phoff == 0, I
> > think.
> 
> Yeah, right now it just returns a pointer to file offset 0.
> 
> I also wonder if we should sanity-check e_phoff vs PT_PHDR? Right now
> Linux ignores PT_PHDR. Should we reject loading when e_phoff != PT_PHDR
> file offset? (And I wonder if there are "broken" binaries right now that
> have bad PT_PHDR segments that have gone unnoticed...)

I agree that unnoticed broken binaries exist. I checked glibc rtld and
there is no check of e_phoff != PT_PHDR file offset.

> 
> And now I'm thinking about the excellent ELF loading analysis at:
> https://nathanotterness.com/2021/10/tiny_elf_modernized.html
> 
> ;)

I think you have interested in https://shinh.skr.jp/obf/bingolf.html
also.

> 
> -- 
> Kees Cook

Akira Kawata
