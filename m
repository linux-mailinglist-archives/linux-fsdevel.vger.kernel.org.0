Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366FA794589
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 23:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbjIFV7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjIFV7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:59:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E1172E;
        Wed,  6 Sep 2023 14:58:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so305517f8f.3;
        Wed, 06 Sep 2023 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694037535; x=1694642335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUEsUDVRFl9we3IvMz1iDQ5wrm80qIsR/HrhiCU8qwU=;
        b=kQYYj8qGkAuKLI7d7WD/+tivDtKxDqsaxAp5uA1cWYaszSsU8X4wq7G/BRiEfObbIM
         Mla4HSaUaYMxmefL4xy4/uRsxwItsqUPonRO8CoIDEd/WJbwkdTjWXCks1DNeEa9g3nU
         5kvQnDvM92aoYi5Io67y37m26h+eV5mHTh5DlVdDxj99/asYPAVJXk+8XBJYGANIYUBl
         YHtySgm9W2Z8G9YZnUANJysNaozE+kj6hdVaJC/hZVh1LgEqW9Z41R8EKrhtj783uRop
         1B7PHOk6L0ueIJ5lTEt4GCDk8QlmrQMEUt5nhEQM0uIx8hWq29k7oQAglztfmGg3HShx
         0NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037535; x=1694642335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUEsUDVRFl9we3IvMz1iDQ5wrm80qIsR/HrhiCU8qwU=;
        b=YUSbc0rTygLZ5FnH359Jl2n7x6o8ySCb3SC+UIV7tZH+u7g1ieJE7zLPFgbNBN5D9P
         JEBM7Fz+7FZRFg0t1IuWZSHwEFgTIFw2/dqBNScAtidirPlhiKkTt9eI4/xnUiteJPoU
         4IT/Yg0VKrrUihcMJyG+qMVRgIDf+KneYPDYRiPdBiGAj3g1VK5y/XuulsadfR8TM/xN
         UXTxr/l1lq7qybRL6cQhWVPcosIgLFrN1AXXQ4OSLXf9UlXUWYF2Xa/JtN0yEAyhhAJ/
         tss50SZf3X1eXlTNjNdtXs1kgP/D8gGFlNy/f6SzXHsEkPMtdT0fOnwzeR0YBsATViZp
         THcA==
X-Gm-Message-State: AOJu0YxTzhFXU/yPUb9ksfDR0viFF1k19UA7AV2BwowdaryM9O7jAAKV
        H0A2fCl2unEJ2EvuxWKFJ4Q=
X-Google-Smtp-Source: AGHT+IG5nMeuL/VoGmcwCLwFLhOfCIhRsiIb9391lHp1yY958vfciaCR4r3uuUZhhDYYQHGkLNQJgQ==
X-Received: by 2002:a5d:604b:0:b0:30e:3da5:46e5 with SMTP id j11-20020a5d604b000000b0030e3da546e5mr3830642wrt.59.1694037535283;
        Wed, 06 Sep 2023 14:58:55 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b003140f47224csm21447397wrr.15.2023.09.06.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:58:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 6 Sep 2023 23:58:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     j.granados@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        willy@infradead.org, josh@joshtriplett.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 3/8] arch/x86: Remove sentinel elem from ctl_table arrays
Message-ID: <ZPj2F4retSgg3vAj@gmail.com>
References: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
 <20230906-jag-sysctl_remove_empty_elem_arch-v1-3-3935d4854248@samsung.com>
 <d0d30ad4-7837-b0c4-39f4-3e317e35a41b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d30ad4-7837-b0c4-39f4-3e317e35a41b@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/6/23 03:03, Joel Granados via B4 Relay wrote:
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which
> > will reduce the overall build time size of the kernel and run time
> > memory bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > 
> > Remove sentinel element from sld_sysctl and itmt_kern_table.
> 
> There's a *LOT* of content to read for a reviewer to figure out what's
> going on here between all the links.  I would have appreciated one more
> sentence here, maybe:
> 
> 	This is now safe because the sysctl registration code
> 	(register_sysctl()) implicitly uses ARRAY_SIZE() in addition
> 	to checking for a sentinel.
> 
> That needs to be more prominent _somewhere_.  Maybe here, or maybe in
> the cover letter, but _somewhere_.
> 
> That said, feel free to add this to the two x86 patches:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86

Absolutely needs to be in the title as well, something like:

   arch/x86: Remove now superfluous sentinel elem from ctl_table arrays

With that propagated into the whole series:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
