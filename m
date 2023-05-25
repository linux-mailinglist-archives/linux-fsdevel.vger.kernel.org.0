Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2727107B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbjEYIia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEYIi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:38:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA8E64
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 01:37:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so3264805e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685003872; x=1687595872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXlTQR3mkNIo3HOsZ1H2pP7ShXmOplvHz6L0vbceCUg=;
        b=qu/k/5DqECU9IbtboDrmFdRe89GYbH/trzXYk46C81yh5N44aQ5AB8n1P9VgUTF2jr
         Pkzkz8LEDnbGKS4sBH4ih5c2wyA2YC9PKKmd2wKx5pAFDuDf4b2oDg1CS1zTaDgucn6m
         ON8DlaOXjbGcWZW7MNN4yXRY1wvMjUSZNW/RjnKstC/e/lBFrkbd8OOzXkrEzJxmYGDr
         o+TK08/PDV/2z/066/yeCOWiiLxoJanzMAtkAFwHW+O0KFadXb5bRzKrPDb2QwvameTt
         nFXPvrFBszyWzQahUYcz9VEtD+pxWmCaNPOGFkidZtfcwylEwyMAm4xbeUjXcScQqKpG
         If0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003872; x=1687595872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXlTQR3mkNIo3HOsZ1H2pP7ShXmOplvHz6L0vbceCUg=;
        b=LIOUdsK+nuiX/vdofEkSG6wC0Re61QZaNwdxVDcFf2mTpY0bcnJyDy65xXVY3Az+Yw
         R2/jruiGfFO0fggR0PXmEppziBuj0jC+6NzELZRhw+eL6mgZ00Buuu6oZtabCoGIFDft
         b2ReJSoV2VOCrT9YkqtoJkEhhkIk2AFADvSd4+iXZpyvqODWmbNa6pVn5gh6NH40C2ls
         kbb97qP8Uoo1+3voALXipEuaqcYq6axAAgQ15wg0U+6D3tNw2NRQgkNI2iN0QNDhJ8pG
         n1ut5a8N1oriVEUAPtH45XXJ0uaRMWu6e+m5ygqaDIXR866J/DMglylA8W4Mr+aSvWhe
         T40A==
X-Gm-Message-State: AC+VfDz+gx7fdBsHL1JlTYmMaULfdxxQfvwBEwPCyEzIhOwD2KpZCNd4
        jTsVzZ5Z/bEZJ5DhJd/Aos5tximOGcM6TrK8hqw=
X-Google-Smtp-Source: ACHHUZ5SQQPDiVagKO/3USB3C9hbvuAr4jLS4JAHKciIaqgDydWaTXDgss8FAtTEX5yhdCX/1oPNAA==
X-Received: by 2002:adf:f84c:0:b0:307:8694:44e0 with SMTP id d12-20020adff84c000000b00307869444e0mr1764181wrq.55.1685003872049;
        Thu, 25 May 2023 01:37:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b002c70ce264bfsm976048wrv.76.2023.05.25.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:37:50 -0700 (PDT)
Date:   Thu, 25 May 2023 11:37:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 7/8] sysctl: Refactor base paths registrations
Message-ID: <c97bfda5-cecf-4521-880b-02c6da987120@kili.mountain>
References: <20230523122220.1610825-1-j.granados@samsung.com>
 <CGME20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3@eucas1p1.samsung.com>
 <20230523122220.1610825-8-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523122220.1610825-8-j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:22:19PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. The old way of doing this through
> register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
> call to register_sysctl_init. The 5 base paths affected are: "kernel",
> "vm", "debug", "dev" and "fs".
> 
> We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
> macro since they are no longer needed.
> 
> In order to quickly acertain that the paths did not actually change I
> executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
> same before and after the commit.
> 
> We end up saving 563 bytes with this change:
> 
> ./scripts/bloat-o-meter vmlinux.0.base vmlinux.1.refactor-base-paths
> add/remove: 0/5 grow/shrink: 2/0 up/down: 77/-640 (-563)
> Function                                     old     new   delta
> sysctl_init_bases                             55     111     +56
> init_fs_sysctls                               12      33     +21
> vm_base_table                                128       -    -128
> kernel_base_table                            128       -    -128
> fs_base_table                                128       -    -128
> dev_base_table                               128       -    -128
> debug_base_table                             128       -    -128
> Total: Before=21258215, After=21257652, chg -0.00%
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> [mcgrof: modified to use register_sysctl_init() over register_sysctl()
>  and add bloat-o-meter stats]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

This needs a Fixes tag so it doesn't get backported by some weird fluke.
Or you could just fold it in with the original patch which introduced
the bug.

Probably add a copy of the output from dmesg?  Maybe add some
Reported-by tags?

regards,
dan carpenter
> 
