Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB45F71D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiJFXg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiJFXg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:36:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16666E319E
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:36:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so2998521pjo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JHL5/nOgL+eg5+yBZBlYhnDF+FYVmYoVEoDPw2AoYjw=;
        b=IuAJSWUS+kUlf9W/66G6ADY5AQG2S6ZDHpR3oOiinjcR7bN2KYQCh+tRYj2cMf6WIF
         b0+mMrC9RHdji8cGaJTWawvJ+fPUp6Hb1sfp8eQdBQ2Pm5L8JLdKPAIUQyp41P0YHPfV
         s2Bs+sKdsxy9SSMxr5K+WXREsCqDJwfbbLBcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JHL5/nOgL+eg5+yBZBlYhnDF+FYVmYoVEoDPw2AoYjw=;
        b=zUWRUoGFAxrXmonbJHP4+3wjUgUjLoAI1/jc6ngbQ/lfTFzjlPoaPM4EFCeullf7QB
         hSyAPU758OjlIAj+CGOAdmlGSLhq2MbaUsFLf/sF6yts26f/JiSgMvV0Zn0wBujkpzDK
         U6SpxN8OFxL2Mz8bIngt0rjTFDvf6JzRdgLnX5p93Zn/NPN1p2QSHhJQnFgekOm+OwyB
         pyQS01XJxgXsmO88dm/vshSW53RNOkkeJ7v54LLn3woKwyb/8cmmMhbhltgKmxmnKzuV
         xzb6pwalN+t7ht31wVoNu4RI8bnF2grmx2z/Yq64HZ50iq2Dp1nQA8CDxki6loUbyJ4l
         494Q==
X-Gm-Message-State: ACrzQf3kIGI0iHwnnTwSbQBeysH9SZus6bZRMPTpbud/K3si9ECKCjV+
        tCbkG0tytckY0dlnv77CkjDQ6A==
X-Google-Smtp-Source: AMsMyM4WZ+ZwvmjZp51OSBCAXlR0yPaELyehCbMZAoVkGcoGWmu5NNHVb1BRkRZSGEpzeaE96oUILA==
X-Received: by 2002:a17:903:32d1:b0:178:1cf0:5081 with SMTP id i17-20020a17090332d100b001781cf05081mr1967988plr.54.1665099416603;
        Thu, 06 Oct 2022 16:36:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b00540d03f3792sm180277pfk.81.2022.10.06.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:36:56 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:36:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
Message-ID: <202210061634.758D083D5@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-6-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-6-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:09PM -0300, Guilherme G. Piccoli wrote:
> The pstore infrastructure is capable of compressing collected logs,
> relying for that in many compression "libraries" present on kernel.
> Happens that the (de)compression code in pstore performs many
> implicit conversions from unsigned int/size_t to int, and vice-versa.
> Specially in the compress buffer size calculation, we notice that
> even the libs are not consistent, some of them return int, most of
> them unsigned int and others rely on preprocessor calculation.
> 
> Here is an attempt to make it consistent: since we're talking
> about buffer sizes, let's go with unsigned types, since negative
> sizes don't make sense.

Thanks for this! I want to go through this more carefully, but I'm a fan
of the clean-up. I'd also like to get Ard's compression refactor landed
again, and then do this on top of it.

-- 
Kees Cook
