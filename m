Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0FF789FE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjH0PTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0PS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA62DC
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693149487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQgrH6086PijRe341uvonhJl7o1Xk5U3vx/ltSx2zME=;
        b=iBaOWilyVaprj5+g3/Z3eM3PrdU4pNrVr/8JsVuWDzQuiA05lVHT8LKWpTzP3YmIMRU6XB
        GqEy5W1f/mr7Vpx9WPb+VRWyXxqLvpQ5muRf20YK3WGaxMmXxBtJP7dTnOrTTA2rVw12Ow
        EPKVIw+R52SBl5c0MoIegf/3wUX8XBQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-lzZ6zg-WP_aaqIiZll45UQ-1; Sun, 27 Aug 2023 11:18:05 -0400
X-MC-Unique: lzZ6zg-WP_aaqIiZll45UQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51da39aa6dcso2106697a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 08:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693149484; x=1693754284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQgrH6086PijRe341uvonhJl7o1Xk5U3vx/ltSx2zME=;
        b=ST+F8AhaLmGAiO+OAjt3FUuRlupv5Jfe7AmIPawfhE1+n9+5OnbgbC8jec1orCHXvq
         XOcNrF1yLU5sXHUyV8Y0K4579G3WWZg4DnPoCO8Cm7jZuSfDY4fGlJleDV28fyYpcj5G
         SmeE/f9o+K5ZxrV12UMKRGj+/JQcoW7kglib+hkCfZoaAETzFLPm0JX80vNw+uwybFLp
         82dBouZcBUde7KWcZz/WzTggiO+GLXYgO/CIP+qY1bsN6CMmYrxNzSbEv1JeRrgVvMxM
         7wUMlX24TdNaPUFpUyJaRInbY5Fxcw66n/+QinOH77ayFcwodMMfTU2OIt9fNQN/APyd
         hrbQ==
X-Gm-Message-State: AOJu0YyPUHrA5wWuR1kBR0Px/rZG6/40kabQb/pUYEI7VxzgaDmwlyzU
        Amlyf8seiLxUPiHw0Q9JyB78z54zIp4M0wxYJ/+PXokbtA6qlGkzNg2smyfwN7F9hi3zYgxCnzx
        LEIiGtqOhmzQIiKRJT9ImDLaMWg==
X-Received: by 2002:aa7:c6d8:0:b0:525:7046:1da0 with SMTP id b24-20020aa7c6d8000000b0052570461da0mr18480692eds.19.1693149484591;
        Sun, 27 Aug 2023 08:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoOYf3NOFKFbjqclhSf7WabmQcU7e+mLsWALTQeleWidu7ZXiTgdVBmke3CsEQc6eRqStBJw==
X-Received: by 2002:aa7:c6d8:0:b0:525:7046:1da0 with SMTP id b24-20020aa7c6d8000000b0052570461da0mr18480681eds.19.1693149484253;
        Sun, 27 Aug 2023 08:18:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7c74f000000b00522828d438csm3410262eds.7.2023.08.27.08.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 08:18:03 -0700 (PDT)
Message-ID: <e5dc72c4-f5a2-ef66-e30e-74ee183c5ba9@redhat.com>
Date:   Sun, 27 Aug 2023 17:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Inbox vboxsf not working
To:     sumitra sharma <sumitraartsy@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
 <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com> <ZNy2zDT6SSUxX9P1@sumitra>
 <2d29fd54-b8c9-6efc-49b2-c83c56463db7@redhat.com>
 <64dd0138c68f2_2a8edb294d5@iweiny-mobl.notmuch>
 <5a01e5fd-cc79-4323-57e6-c861aaf0f08b@redhat.com>
 <CALPt=azRw4YxH+0r=CJfY+pZhAsGB9Am0n04gJ0kqpiND3q2sw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALPt=azRw4YxH+0r=CJfY+pZhAsGB9Am0n04gJ0kqpiND3q2sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/27/23 14:54, sumitra sharma wrote:
> 
> 
> On Wed, Aug 16, 2023 at 11:03 PM Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi all,
> 
>     On 8/16/23 19:02, Ira Weiny wrote:
>     > Hans de Goede wrote:
>     >> Hi,
>     >>
>     >> On 8/16/23 13:45, Sumitra Sharma wrote:
>     >>> On Wed, Aug 16, 2023 at 09:28:51AM +0200, Hans de Goede wrote:
>     >>>> Hi Sumitra,
>     >>>>
>     >
>     > [snip]
>     >
>     >>>
>     >>> Hi Hans,
>     >>>
>     >>> Can you please specify what you mean by "vbox guest functionality"? Are you talking about the guest addition utilities which VirtualBox offers and about which you warned not to install them? [*]
>     >>
>     >> Yes.
>     >>
>     >> Virtualbox consists of 2 parts:
>     >>
>     >> 1. The hypervisor / hw-emulator on which virtual-machines run. This hypervisor itself runs on the host.
>     >>
>     >> 2. The guest addition utilities which can be installed inside a guest / virtual-machine running on top of VirtualBox. These allow things like copy and pasting between the guest and host and sharing  a folder on the host with the guest.
>     >>
>     >> The host always uses out of tree kernel-modules.
>     >
>     > Hans,
>     >
>     > Thanks for this clarification.  This is my fault for leading Sumitra to
>     > believe that the in tree modules could replace the guest additions for the
>     > VirtualBox hypervisor.
> 
>     Actually the in tree modules can replace the *guest* kernel modules which are shipped with the guest additions from virtualbox.
> 
>     >> The guest can use the in tree kernel modules.
>     >>
>     >>> How can I make the in-tree vbox modules run?
>     >>
>     >> You can use these and specifically the vboxsf and vboxguest modules by
>     >> installing Fedora 38 Workstation x86_64 as a virtualbox *guest* / inside
>     >> a virtualbox vm and then share a folder on the host with the guest.
>     >>
>     >
>     > I took your original email to mean that some in tree modules could be out
>     > of sync with the interfaces used by code coming from Oracle.
>     >
>     > I'm curious are there also out of tree modules for the guest support?
> 
>     Yes the guest-additions contain out of tree modules (1). Since Sumitra plans to work on the in tree modules, those should NOT be installed.
> 
>     The easiest way to avoid installing the out-of-tree guest modules is to just not install the official guest additions at all.
> 
>     Fedora comes with pre-packaged guest additions which only contain the (FOSS) userspace parts, relying on the in tree vbox guest kernel modules.
> 
> 
> Hi Hans,
> 
> I set up the Fedora-64bit machine to test the vboxsf changes. But I was also trying to create another 32-bit machine and enable the HIGHMEM 4G option to test the kmap changes in the vboxsf. I discovered that all Linux distros other than Fedora require installation of the Virtualbox guest additions to share a folder between the host and the guest [1]. It is because Fedora has open-vm-tools inside its repository and is part of the default installation, which other distros do not have. Is there any other way to create a successful 32-bit machine to test the vboxsf changes without installing the Virtualbox guest additions? I tried Ubuntu, Debian, and OpenSUSE.

You can install the vbox guest additions and then after installation remove the vboxguest and vboxsf modules which the virtubal-guest-additions installer will have installed under /lib/modules/<$kver>/updates I think.

After removing the modules from the updates dir run "depmod -a" and reboot and then check if they have not been re-added by some startup script ...

Regards,

Hans


