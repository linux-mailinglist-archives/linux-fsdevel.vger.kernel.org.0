Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF377E28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjHPN1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbjHPN1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95142D42
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692192352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEXu89esqoxxEpF1AChXHLKGp6RO1uQjjxa9SK93Lbk=;
        b=AshGCu2gM3tl+yeie6heRIfxZeamcMZJiWNHJrXwuuwZpIez/wjreHVQI1DIGpzJvZlJGb
        5v3zfny3qxAbHEQaXwxf1qjLl54xPls4pIrBBHrGz1oXUH6oawcwnIRPJq46Y4MmbYr7+Z
        ZGCobNklZv3h7TSj7Ggyb2utdZIEJBA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-31QGe07oMVGK2AKAHVSGcQ-1; Wed, 16 Aug 2023 09:25:51 -0400
X-MC-Unique: 31QGe07oMVGK2AKAHVSGcQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-523204878d9so4029347a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 06:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192350; x=1692797150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEXu89esqoxxEpF1AChXHLKGp6RO1uQjjxa9SK93Lbk=;
        b=O6rJ7eDWEsjBjwvmjxFhvHI/2P0j5aqwWcd+vemthnzwN23CLlOSJiGrEd3kvd9zOY
         Y2U52bjO33tREMoQNxE2Hx+cSuJ++xjuyGNzWYceiSKrLqi9oEUOxaG1H7CWBdtDMCPe
         zsAa4IkEqC3ZpbYlwL9DOmQjhUxf1e37Ge+AeK6roRMfSGRWlplSZEiSUGay3V3ypdTN
         uqYXE5UcKrVlpcGnyTM31Q9exb/KlhD8ofzgP+PVLMdujfHd5WPNYHbwVWD4LFcAeRuI
         dW8X0DVEMvN8BoDBWhJ7ZGJAZ58zgFHpYSp8j5FlomdIwsbLMFiGagv5ukdrUWd0ETTQ
         cSqA==
X-Gm-Message-State: AOJu0YyOT31XM1DOExLK4oECbhnK8e03eYxO6M0qru2iJ56xZz+MTE8b
        pAhyOcCgWfE+BGIbSGjAz411139nqNmRPJmiZwuW9J7P4PIMMS3S+mMEgBemklZRfnbSWFJsP6V
        z26QKjF0zWmjQ/XgI2vkw8lPGPw==
X-Received: by 2002:a05:6402:1350:b0:523:493e:929c with SMTP id y16-20020a056402135000b00523493e929cmr1493360edw.10.1692192350149;
        Wed, 16 Aug 2023 06:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBQ/xO9uizZsZZDoQ9/Gd3MdWT3szcIooQWuWJqEr+2//aPhtn+XOtbNzFMUfeOp6wl3umRw==
X-Received: by 2002:a05:6402:1350:b0:523:493e:929c with SMTP id y16-20020a056402135000b00523493e929cmr1493349edw.10.1692192349853;
        Wed, 16 Aug 2023 06:25:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7d446000000b005234e6cc6d5sm8332551edr.90.2023.08.16.06.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 06:25:48 -0700 (PDT)
Message-ID: <2d29fd54-b8c9-6efc-49b2-c83c56463db7@redhat.com>
Date:   Wed, 16 Aug 2023 15:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Inbox vboxsf not working
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
 <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com> <ZNy2zDT6SSUxX9P1@sumitra>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZNy2zDT6SSUxX9P1@sumitra>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/16/23 13:45, Sumitra Sharma wrote:
> On Wed, Aug 16, 2023 at 09:28:51AM +0200, Hans de Goede wrote:
>> Hi Sumitra,
>>
>> On 8/15/23 16:43, sumitra sharma wrote:
>>> Hello Hans,
>>>
>>> I am writing in reference to the vboxsf patch [1]. It has been a while since we have talked about this. It is because it took me time to set up the basic environment. I earlier had Windows as my host machine and was working on this project through Virtual Machine. But I see this created many issues and lowered my resources. However, I have changed my host machine to Ubuntu and again started working on the project.
>>>
>>> I downloaded and installed the Oracle VirtualBox 7.0, and during the installation, it built and installed the Oracle VM VirtualBox kernel modules: *vboxdrv*, *vboxnetflt*, and *vboxnetadp*. Since they are the out-of-tree Oracle installed modules. I manually removed them and installed and loaded the in-tree vbox modules: *vboxsf*, *vboxguest*, *vboxvideo*. But the VirtualBox still throws the following error:
>>>
>>> The VirtualBox Dialogue error:
>>>
>>> "The VirtualBox Linux kernel driver is either not loaded or not set up correctly. VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The support driver is not installed."
>>>
>>> and the command line error:
>>>
>>> sumitra@sumitra:/boot$ virtualbox
>>> WARNING: The vboxdrv kernel module is not loaded. Either there is no module
>>>          available for the current kernel (6.5.0-rc4sumitra+) or it failed to
>>>          load. Please recompile the kernel module and install it by
>>>
>>>            sudo /sbin/vboxconfig
>>>
>>>          You will not be able to start VMs until this problem is fixed.
>>>
>>> Please let me know if there is some other module missing which hasn't been loaded yet. I would be glad if you could help me set up the vboxsf testing environment.
>>
>> The mainline kernel modules only support vbox guest functionality. If you are using Linux as a virtualbox host / hypervisor then you do need the vbox out of tree host modules on the host side for things to work.
> 
> Hi Hans,
> 
> Can you please specify what you mean by "vbox guest functionality"? Are you talking about the guest addition utilities which VirtualBox offers and about which you warned not to install them? [*]

Yes.

Virtualbox consists of 2 parts:

1. The hypervisor / hw-emulator on which virtual-machines run. This hypervisor itself runs on the host.

2. The guest addition utilities which can be installed inside a guest / virtual-machine running on top of VirtualBox. These allow things like copy and pasting between the guest and host and sharing  a folder on the host with the guest.

The host always uses out of tree kernel-modules.

The guest can use the in tree kernel modules.

> How can I make the in-tree vbox modules run?

You can use these and specifically the vboxsf and vboxguest modules by installing Fedora 38 Workstation x86_64 as a virtualbox *guest* / inside a virtualbox vm and then share a folder on the host with the guest.

Regards,

Hans

