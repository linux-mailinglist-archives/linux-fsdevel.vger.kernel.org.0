Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A34C233E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiBXFQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBXFQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:16:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281816923E
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 21:16:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 75so826915pgb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 21:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srYPL04OWay1dcY8e70dNGhHS9ZwVWkaxq0mw17kle0=;
        b=E+AaIZP0v7bVUhbtnlfQdm0GewhlDSLyFsa4Gc9ttCYc4Wugq3ehabUEmagg6S/HG5
         ZIBO/6RSxYufDXorILKqvIXx/WRBvOtOllmU7CIO+HDmGlm+E2pJTWQQR9ntIuP4IqTi
         SE2nH8yGt6EOujARktNsaPIbSukKsuSizLpvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srYPL04OWay1dcY8e70dNGhHS9ZwVWkaxq0mw17kle0=;
        b=8EubFWupN7BofYnMlUWRINnrQpCTnP+niex4LLZosAgVJKSpcXQbiKddKor11Mko8L
         NkYXGImhb2veE3dVeXSc4C3ciojn0RCZ6ZRIosKZsNFoXDLpKFn2Ok+CpPEAkl+RO2pY
         vsZFl6xMbLo98RX6LX4iFbYZMkZkHKcPAoc3v4ooA0gBBDXVcUCeQDk4Nvus2ZE739R5
         r2py6SlJQiJc9TEXLt4l0TcWtdEU5wbFpIGEb+feCEDFZfkxRxHCZqwBPmTX6G1RUSTZ
         NVCdB8NNUP3rEjsIcrotK5BIDTbhPQzLfZ2PlYxN/MgCjUxmyQn3AGdWQRryjX9I5Aj9
         etGg==
X-Gm-Message-State: AOAM530lxePnVOVn9an4//cuv6eHo9SeLZHYZmkWB0T++xvD4AbHCs4c
        PD4tVEEBjD8us1ZkT6s0mkOwVw==
X-Google-Smtp-Source: ABdhPJyY08KTJaKQ5zKGQ1yFLiRI1Pv8/UxZIiAHPJqb0gnMTYA9nhd/ZhDBm4UZolLnsVTN1dDpkA==
X-Received: by 2002:a05:6a00:23c6:b0:4cf:1e1e:ff4f with SMTP id g6-20020a056a0023c600b004cf1e1eff4fmr1200901pfc.80.1645679767050;
        Wed, 23 Feb 2022 21:16:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm4595800pjc.56.2022.02.23.21.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:16:06 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:16:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Message-ID: <202202232030.B408F0E895@keescook>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
 <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info>
 <03497313-A472-4152-BD28-41C35E4E824E@chromium.org>
 <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
 <9A1F30F8-3DE2-4075-B103-81D891773246@chromium.org>
 <4e42e754-d87e-5f6b-90db-39b4700ee0f1@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e42e754-d87e-5f6b-90db-39b4700ee0f1@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:57:01PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Kees!
> 
> On 2/21/22 21:58, Kees Cook wrote:
> >> I have applied this patch on top of 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6 and it doesn't
> >> fix the problem for me. Reverting 5f501d555653f8968011a1e65ebb121c8b43c144, however, fixes
> >> the problem.
> >>
> >> FWIW, this problem doesn't just affect GCC but systemd keeps segfaulting with this change as well.
> > 
> > Very weird! Can you attached either of those binaries to bugzilla (or a URL I can fetch it from)? I can try to figure out where it is going weird...
> 
> Here's the initrd of that particular machine:
> 
> > https://people.debian.org/~glaubitz/initrd.img-5.17.0-rc5+
> 
> You should be able to extract the binaries from this initrd image and the "mount" command,
> for example, should be one of the affected binaries.

In dmesg, do you see any of these reports?

                pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
                        task_pid_nr(current), current->comm, (void *)addr);

I don't see anything out of order in the "mount" binary from the above
initrd. What does "readelf -lW" show for the GCC you're seeing failures
on?

-- 
Kees Cook
