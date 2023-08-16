Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D051177E0B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbjHPLpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244757AbjHPLp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:45:29 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784E1FC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 04:45:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a78a2c0f81so5220581b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692186323; x=1692791123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWGD2d/uMkCqSxd0me0Q4ISo7Gm5FSoOStZxMo1/zp0=;
        b=sd+f40UPYDE+P+Sls7TLuXSr7FWscQafpjeOrF4ag7035710kega+4C/d0a5H5OP89
         MjKJ3FfVXIQQHl48VgqkIBMQezS32EXgUtCC3bkAbvmbWbGtPjSlCNPexTfqZqceU8uT
         FcArEfJiZ5HF14JGWlP7UaUoqUSUnRow5TKSXuT/O13NOVwXy0HFY7bsqPTnfE8EJOgh
         mcbZqJ6oY8Pm/AiqSimwNclPPExTMMTSgbSQ5sRbEF4tTrrQyi68NYvVI73PC8yO5wHq
         Vg1yA0x2EpOiTJHyTDNe0QkocMrENZnIReM4KBXzYBgZZSn9aadE6KrSwr/QmQqFLsaR
         d+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186323; x=1692791123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGD2d/uMkCqSxd0me0Q4ISo7Gm5FSoOStZxMo1/zp0=;
        b=T2ON5BAmFudgf6zGIBjuXFNsqofD+kgh3yrDJEjMWN9GBYUIU1xIRj+1+pmSJb+Lch
         ikO7WRXnzf43hTrFZwk7+FiuFG3XfIdl3bWcEZcANlmxTUSpO/KL/gZuhGYDA4dknrQU
         C4KaE7j5o7VQyoXm4qojrdcziHzWA33buSfHXQKkbnFiyffL7DCeFZDYLPxwhBoUI4pu
         F1hOaLBEcY+GY/7wTEVAnw2kp+qnVg1wlVpCcNGcQakmpFNvWUdjsYlpVQuoRfR72dGS
         hw1/TlHLUec5zere+YtFQvqWy5k1zedaYjrLoF/KLh/ZFLxIKPrHr2VT/GrIyy4k+JTy
         EYvA==
X-Gm-Message-State: AOJu0Yy72L+0n6nOnkjUrQAUVPgpl0Jgjom/deP4RHU1ttWsPSAjc/G1
        Tthj6u0ODEkzeXGY5OgoInw=
X-Google-Smtp-Source: AGHT+IEylSdYgcXCfAiuxDqtRQUzD/mczzUpQVv73N2Gnl/TiPyqid+yDynkOD5c+xurRhcjTEkccQ==
X-Received: by 2002:aca:d0d:0:b0:3a7:a58:e818 with SMTP id 13-20020aca0d0d000000b003a70a58e818mr1723763oin.33.1692186323474;
        Wed, 16 Aug 2023 04:45:23 -0700 (PDT)
Received: from sumitra ([59.89.172.227])
        by smtp.gmail.com with ESMTPSA id e12-20020a63ae4c000000b0055b44a901absm5765307pgp.70.2023.08.16.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:45:22 -0700 (PDT)
Date:   Wed, 16 Aug 2023 17:15:16 +0530
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: Inbox vboxsf not working
Message-ID: <ZNy2zDT6SSUxX9P1@sumitra>
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
 <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:28:51AM +0200, Hans de Goede wrote:
> Hi Sumitra,
> 
> On 8/15/23 16:43, sumitra sharma wrote:
> > Hello Hans,
> > 
> > I am writing in reference to the vboxsf patch [1]. It has been a while since we have talked about this. It is because it took me time to set up the basic environment. I earlier had Windows as my host machine and was working on this project through Virtual Machine. But I see this created many issues and lowered my resources. However, I have changed my host machine to Ubuntu and again started working on the project.
> > 
> > I downloaded and installed the Oracle VirtualBox 7.0, and during the installation, it built and installed the Oracle VM VirtualBox kernel modules: *vboxdrv*, *vboxnetflt*, and *vboxnetadp*. Since they are the out-of-tree Oracle installed modules. I manually removed them and installed and loaded the in-tree vbox modules: *vboxsf*, *vboxguest*, *vboxvideo*. But the VirtualBox still throws the following error:
> > 
> > The VirtualBox Dialogue error:
> > 
> > "The VirtualBox Linux kernel driver is either not loaded or not set up correctly. VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The support driver is not installed."
> > 
> > and the command line error:
> > 
> > sumitra@sumitra:/boot$ virtualbox
> > WARNING: The vboxdrv kernel module is not loaded. Either there is no module
> >          available for the current kernel (6.5.0-rc4sumitra+) or it failed to
> >          load. Please recompile the kernel module and install it by
> > 
> >            sudo /sbin/vboxconfig
> > 
> >          You will not be able to start VMs until this problem is fixed.
> > 
> > Please let me know if there is some other module missing which hasn't been loaded yet. I would be glad if you could help me set up the vboxsf testing environment.
> 
> The mainline kernel modules only support vbox guest functionality. If you are using Linux as a virtualbox host / hypervisor then you do need the vbox out of tree host modules on the host side for things to work.

Hi Hans,

Can you please specify what you mean by "vbox guest functionality"? Are you talking about the guest addition utilities which VirtualBox offers and about which you warned not to install them? [*]

How can I make the in-tree vbox modules run? Is there something else you like me to set up for this? I want the in-tree vboxsf module to be used by the VirtualBox so that I can test any changes I make in the vboxsf files.


Thanks & regards
Sumitra


[*]: https://lore.kernel.org/lkml/2882298.SvYEEZNnvj@suse/T/#m6136855637d2da03a894edf7d1f869484e626694



> 
> Regards,
> 
> Hans
> 
> 
