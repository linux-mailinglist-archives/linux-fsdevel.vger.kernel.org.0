Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A577DB20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbjHPH34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 03:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjHPH3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF3C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692170936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGm7XliIPugEoZZamLmittr7g4w+/PH3IRJzFWVSgRc=;
        b=N1Sax9fkxb/RiAe7UbF5lYv0AVJh1Z1bBT9sSJB1dH/R/FtzN41oGNCQWFixepIRyiuQqk
        uNzfjOw8Npqr8IrKb9e+0sC2IW37Q7jWYArw5JeLW75tYAi76IsxMn16ngJTSYeQGDEF+L
        2uEDSl8AJmkJRb8pDTuH809mfziGEpI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-jBRAU3h2PruY1Vfg55Q_ZA-1; Wed, 16 Aug 2023 03:28:55 -0400
X-MC-Unique: jBRAU3h2PruY1Vfg55Q_ZA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99388334de6so368617566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 00:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170934; x=1692775734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGm7XliIPugEoZZamLmittr7g4w+/PH3IRJzFWVSgRc=;
        b=id+37OjupQfoi7J2dfDs+cjreSWumKigOcYFk/TrVSVuy/kFdzU1YIQinpwr8X022Q
         YKNAyzBuH7EHCt3a747tCzNAL2CdzC2/Rv/i9lUJszIdwENnDi5y1irCSPYmJHYSru8R
         8iTt9CovPO4yoHBEFXJUbGqC5ds3B9FD/I84SyPtAsZuNprAg75qrd+K7oDMvPm5GOvO
         +m/6zgRIQTRVqthntUNCZpONP8oePIX6fozYPxI0qnSZZ4kknR1YvxsAT0L2xVl39/mA
         nV/0JRGI0penzsYI3VHzf5vh9GCcLowMsOi8846UcsoUeP5tazr94MoNa96GH8+oCWqy
         HOUw==
X-Gm-Message-State: AOJu0YyCsM5eqMMl6u5euL1XqrgUadPeV72MIpyYc8qkmyaRrrWGxMG0
        VAwiL6VfFgi0IE6U2wT9ufB8cNMAOiI5G+Ty0SHuO4jzeZ2fSTCpX/aofJtu840HwdBiPxyQ8dP
        /+P7gcNxApyg5syI0UU3z6ySSpQ==
X-Received: by 2002:a17:906:2099:b0:99c:440b:a46a with SMTP id 25-20020a170906209900b0099c440ba46amr865892ejq.1.1692170933824;
        Wed, 16 Aug 2023 00:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4REXV9nSBS/33CsnWFoBV2S1Tqn0ikTzfUFnEjBpJOlBtybxprL7kbG8e2GWNB/T/ddnEw==
X-Received: by 2002:a17:906:2099:b0:99c:440b:a46a with SMTP id 25-20020a170906209900b0099c440ba46amr865880ejq.1.1692170933535;
        Wed, 16 Aug 2023 00:28:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0099315454e76sm8135122ejp.211.2023.08.16.00.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:28:52 -0700 (PDT)
Message-ID: <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com>
Date:   Wed, 16 Aug 2023 09:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Inbox vboxsf not working
To:     sumitra sharma <sumitraartsy@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sumitra,

On 8/15/23 16:43, sumitra sharma wrote:
> Hello Hans,
> 
> I am writing in reference to the vboxsf patch [1]. It has been a while since we have talked about this. It is because it took me time to set up the basic environment. I earlier had Windows as my host machine and was working on this project through Virtual Machine. But I see this created many issues and lowered my resources. However, I have changed my host machine to Ubuntu and again started working on the project.
> 
> I downloaded and installed the Oracle VirtualBox 7.0, and during the installation, it built and installed the Oracle VM VirtualBox kernel modules: *vboxdrv*, *vboxnetflt*, and *vboxnetadp*. Since they are the out-of-tree Oracle installed modules. I manually removed them and installed and loaded the in-tree vbox modules: *vboxsf*, *vboxguest*, *vboxvideo*. But the VirtualBox still throws the following error:
> 
> The VirtualBox Dialogue error:
> 
> "The VirtualBox Linux kernel driver is either not loaded or not set up correctly. VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The support driver is not installed."
> 
> and the command line error:
> 
> sumitra@sumitra:/boot$ virtualbox
> WARNING: The vboxdrv kernel module is not loaded. Either there is no module
>          available for the current kernel (6.5.0-rc4sumitra+) or it failed to
>          load. Please recompile the kernel module and install it by
> 
>            sudo /sbin/vboxconfig
> 
>          You will not be able to start VMs until this problem is fixed.
> 
> Please let me know if there is some other module missing which hasn't been loaded yet. I would be glad if you could help me set up the vboxsf testing environment.

The mainline kernel modules only support vbox guest functionality. If you are using Linux as a virtualbox host / hypervisor then you do need the vbox out of tree host modules on the host side for things to work.

Regards,

Hans


