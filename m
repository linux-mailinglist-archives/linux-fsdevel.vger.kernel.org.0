Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85B4DD03B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiCQVeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQVeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:34:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B43BF514
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:33:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s11so7832169pfu.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z/zGF40uVIpX+AOg+XR0VxHsUDDaBoGb4ODlLG5ou6M=;
        b=IPliZ7HK7zTIvRL5B26u65BZufOtiZ0p43rZcWjpY/v/lBRlyThQA8pCNaViOLS9kn
         E+pu/vY4nq/RL4mUde15Zu7GQzwYYf6dTaNav+m4FH1M2qB6L7DA+u37AEMwVhzgmenE
         fV63iLS4VVdLHiKVdxvo/Q6ebGJ92k6zIKIOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z/zGF40uVIpX+AOg+XR0VxHsUDDaBoGb4ODlLG5ou6M=;
        b=n56E1Cbn5t/MUDAzbxFqZH+IbRkdm0hTvAJc0kNmh7oc1uegTKdaByiRwi48k3EdC4
         puzaQ4wEawbotYdjeC+NEu0Y3qH7rf2yY1/Och7BwEGKG1HJsdmsDE7/wMcGHWFpPsEl
         hADt08sjkiOEF55Wk2bthH1qATUkUdsxKHTuo7znEjFVCafBYzfje+5Py+c1nsDd1nE2
         l74+LgUapwUuQTJ802h6rwIA8tEdpaHinsfkIZ9gJrkRz0SRKyilH0jBme/SGXZASWrH
         jKLAmTiYQ42wTk43EIX0OMbmE13vkmEoaoZATHt/0XHuDw4VnQonHgc+xtC7tWY0HC9R
         z9EQ==
X-Gm-Message-State: AOAM531qQLY6FHhYj2mg3tPr1mbA8p1y6Fj4gRbHQ4qrB/eglNmH38E5
        adBoc1MTTe6duvKtKTdqRoMmMw==
X-Google-Smtp-Source: ABdhPJxjiO0GY+7b17ztd7xbLbz/4BPMxkA9KL+AsO37pndVk9lz8oUI+P4Ur0enJ9LKsHTLVdNsYg==
X-Received: by 2002:a05:6a00:14c2:b0:4fa:3fcc:33f3 with SMTP id w2-20020a056a0014c200b004fa3fcc33f3mr4353824pfu.71.1647552784661;
        Thu, 17 Mar 2022 14:33:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f783abfa0esm7721595pfi.28.2022.03.17.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 14:33:04 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:33:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86: Separate out x86_regset for 32 and 64 bit
Message-ID: <202203171427.692F92D7@keescook>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
 <20220317192013.13655-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317192013.13655-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:20:11PM -0700, Rick Edgecombe wrote:
> In ptrace, the x86_32_regsets and x86_64_regsets are constructed such that
> there are no gaps in the arrays. This appears to be for two reasons. One,
> the code in fill_thread_core_info() can't handle the gaps. This will be
> addressed in a future patch. And two, not having gaps shrinks the size of
> the array in memory.
> 
> Both regset arrays draw their indices from a shared enum x86_regset, but 32
> bit and 64 bit don't all support the same regsets. In the case of
> IA32_EMULATION they can be compiled in at the same time. So this enum has
> to be laid out in a special way such that there are no gaps for both
> x86_32_regsets and x86_64_regsets. This involves creating aliases for
> enum’s that are only in one view or the other, or creating multiple
> versions like in the case of REGSET_IOPERM32/REGSET_IOPERM64.
> 
> Simplify the construction of these arrays by just fully separating out the
> enums for 32 bit and 64 bit. Add some bitsize-free defines for
> REGSET_GENERAL and REGSET_FP since they are the only two referred to in
> bitsize generic code. Also, change the name pattern to be like
> REGSET32_FOO, instead of REGSET_FOO32, to better emphasize that the bit
> size is the bitsize of the architecture, not the register itself.
> 
> This should have no functional change and is only changing how constants
> are generated and named. The enum is local to this file, so it does not
> introduce any burden on code calling from other places in the kernel now
> having to worry about whether to use a 32 bit or 64 bit enum name.
> 
> [1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Rename REGSET_FOO32 to REGSET32_FOO (Eric Biederman)
>  - Drop Kees' Reviewed-by to Acked-by, due to changing enum value names

I think of "Ack" to mean "I am a maintainer of this area and someone can
carry this instead of it going via my tree". While I certainly poke and
ptrace and x86 a lot, I probably wouldn't Ack in this part of the
kernel. But it does seem "Reviewed-by" is a stronger signal[1].

Regardless, v2 looks good to me still. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
Kees Cook
