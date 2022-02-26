Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BF4C55B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiBZLxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 06:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZLxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:53:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA527FD3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 03:52:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l9so6475733pls.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 03:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ea3QXOZbjOPzaxGsgfBM/mqvgonT3tPPaz+lhJkrk24=;
        b=dDjYm27p2iHctpRQWBncoiN/lzoby+WoFLXLLz+T89Azj+MrhaJOEVvy++LKcdoCcF
         9lx1OHwjGH4NPU5N8+aOKyoDf0nZXkmfkP84HVkgFkdtUg+Atyb9qjeizEPRutokbicS
         ohi0uKx9whk6V3ICv1k/rP8NZq8rPBeLtcv30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ea3QXOZbjOPzaxGsgfBM/mqvgonT3tPPaz+lhJkrk24=;
        b=gZKyqkvVgHp0JvkBQwTHsJ7TdW9wawOu1KmMDDWe7rcZN1+dAObJkiluff8kswXavs
         vkbqVVSW1z+4Kq4CdFLnvKkOvUm9gtjHcdB4M0lTGDUIDv0969KT/WtzoSvR/i/LHL4n
         /W6BShV9c/zqGtijY6BkZRxZ3SwEO1IS2/v9liAHb1aH8vyw3M9ms3WWp6ieNghSvwha
         6OCA+B1fxaVh/MR8OgwxXM+8yfPHawRhe/zPf5qgff6AxeG6tyJci9No1/RJne+Z9mkN
         +k6oUUJowXnYrGkQTCkCo00eCexwk5Cyn2D+fExlGOSK10dcg/KS/5M7PUxj3OnHHtxM
         K86w==
X-Gm-Message-State: AOAM533Jcj5YkU+sxNjvuZ92RTTDv6lsZm95BovFDI081aluNRNFgFXd
        ZecHUmrc5D3oRyb1J1WJsyubHQ==
X-Google-Smtp-Source: ABdhPJw2XLKnFy89w02qNG9y5DyM0OT5B3soxq7XFIM2db/DXxS2nhBst3JBTbw2/wKSZniCT3SIdA==
X-Received: by 2002:a17:902:6942:b0:14c:b20e:2b1a with SMTP id k2-20020a170902694200b0014cb20e2b1amr11954656plt.112.1645876349209;
        Sat, 26 Feb 2022 03:52:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm6757095pfh.84.2022.02.26.03.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 03:52:28 -0800 (PST)
Date:   Sat, 26 Feb 2022 03:52:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        regressions@lists.linux.dev, linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Message-ID: <202202260344.63C15C3356@keescook>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
 <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info>
 <03497313-A472-4152-BD28-41C35E4E824E@chromium.org>
 <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
 <9A1F30F8-3DE2-4075-B103-81D891773246@chromium.org>
 <4e42e754-d87e-5f6b-90db-39b4700ee0f1@physik.fu-berlin.de>
 <202202232030.B408F0E895@keescook>
 <7e3a93e7-1300-8460-30fb-789180a745eb@physik.fu-berlin.de>
 <65ed8ab4fad779fadf572fb737dfb789@matoro.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ed8ab4fad779fadf572fb737dfb789@matoro.tk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:22:04AM -0500, matoro wrote:
> Hi Kees, I can provide live ssh access to my system exhibiting the issue.
> My system is a lot more stable due to using openrc rather than systemd, for
> me GCC seems to be the only binary affected.  Would that be helpful?

Thanks for this access! I think I see the problem. Non-PIE (i.e. normal
ET_EXEC) ia64 binaries appear to have two very non-contiguous virtual
memory PT_LOAD segments that are file-offset adjacent. As seen in
readelf -lW:

  LOAD           0x000000 0x4000000000000000 0x4000000000000000 0x00b5a0 0x00b5a0 R E 0x10000
  LOAD           0x00b5a0 0x600000000000b5a0 0x600000000000b5a0 0x0005ac 0x000710 RW  0x10000
                 ^^^^^^^^ ^^^^^^^^^^^^^^^^^^

When the kernel tries to map these with a combined allocation, it asks
for a giant mmap of the file, but the file is, of course, not at all
that large, and the mapping is rejected.

So... I'm trying to think about how best to deal with this. If I or
anyone else can't think of an elegant solution, I'll send a revert for
the offending patch next week.

In the meantime now I've got another dimension to regression test. ;)

-- 
Kees Cook
