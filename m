Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0E77E7B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjHPRfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbjHPRen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AF270C
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692207238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beKo3zDIAR96vqrm91w9ZHX233AjCWpn6fcs2sFC8wc=;
        b=Ux4kQUbUVx43MCJwgMDTXupn3WPHy62WKS5Zw3EB1eaga3YmEdQd7BNIMMPopDVbMngDOD
        pAsdK2kWcvbiaAVj443XV7BrlGa+8CvR5sfo48tUpZqlJCosBnnILgBW1Vcv5h7lrHz5S4
        7k8BBIUN61fk46Sjtdjh9RNwzNJMFog=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-FVqaCZGfPEqvBMNPBpo4pw-1; Wed, 16 Aug 2023 13:33:56 -0400
X-MC-Unique: FVqaCZGfPEqvBMNPBpo4pw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-524547bf57cso3204133a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 10:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207235; x=1692812035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beKo3zDIAR96vqrm91w9ZHX233AjCWpn6fcs2sFC8wc=;
        b=YpmMZd7msyQgxgE/rEQhi13KifcHavvsBCUAQ5D+mrQAcHMiuKJy0JgjnBE23J5pic
         zfgl6KbW0rWQl6+EEgGzDNlAzbVzGvSe7O47m1NHNASd42DPmsD4bjB8GZfAyXHbbGQd
         5N2gEQ5jsXcbQqNNSJAsEeLMgoAKouEkGsifzmAnhT+vy020hmwerHX6CPPwqVzn6BQO
         Y2eQhxBBoALN+RYvsnP6mta/RDWUYE1nEzfql5i3Mp/U1+hcQWDe2HCz4IKKmwcfvrw4
         MUud1mw1uIwdQzD4TH/S0195VQjjxvLKxtCZVTVxRSw9BI1sP12ajHn+VTlc4hx4uw3H
         z28g==
X-Gm-Message-State: AOJu0YzoDMZ9RbWOr8TXZZHH7fKC7/+udayKVJVl9aTxry4uUQKxNBIh
        sZBrKVaNXcyHCCBSNeT4UjcxXfce8HEjxhK8KXBEq2syoDdxfys7bv/xRFCsV0pxAoB17IEV3QN
        LXFocoRypEdLPsJ3y0fSSXMKRqg==
X-Received: by 2002:a50:fb18:0:b0:525:6d74:7122 with SMTP id d24-20020a50fb18000000b005256d747122mr2154019edq.30.1692207235484;
        Wed, 16 Aug 2023 10:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuHUa/FpMTnCrv16w8FW1UMu7tqL5gfUQ1mGmLSbcKfCB4Y5F8ToLyHBgETPb4zMsNUu6dSQ==
X-Received: by 2002:a50:fb18:0:b0:525:6d74:7122 with SMTP id d24-20020a50fb18000000b005256d747122mr2154010edq.30.1692207235234;
        Wed, 16 Aug 2023 10:33:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v26-20020a056402185a00b0052565298bedsm4478253edy.34.2023.08.16.10.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:33:54 -0700 (PDT)
Message-ID: <5a01e5fd-cc79-4323-57e6-c861aaf0f08b@redhat.com>
Date:   Wed, 16 Aug 2023 19:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Inbox vboxsf not working
To:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
 <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com> <ZNy2zDT6SSUxX9P1@sumitra>
 <2d29fd54-b8c9-6efc-49b2-c83c56463db7@redhat.com>
 <64dd0138c68f2_2a8edb294d5@iweiny-mobl.notmuch>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <64dd0138c68f2_2a8edb294d5@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

On 8/16/23 19:02, Ira Weiny wrote:
> Hans de Goede wrote:
>> Hi,
>>
>> On 8/16/23 13:45, Sumitra Sharma wrote:
>>> On Wed, Aug 16, 2023 at 09:28:51AM +0200, Hans de Goede wrote:
>>>> Hi Sumitra,
>>>>
> 
> [snip]
> 
>>>
>>> Hi Hans,
>>>
>>> Can you please specify what you mean by "vbox guest functionality"? Are you talking about the guest addition utilities which VirtualBox offers and about which you warned not to install them? [*]
>>
>> Yes.
>>
>> Virtualbox consists of 2 parts:
>>
>> 1. The hypervisor / hw-emulator on which virtual-machines run. This hypervisor itself runs on the host.
>>
>> 2. The guest addition utilities which can be installed inside a guest / virtual-machine running on top of VirtualBox. These allow things like copy and pasting between the guest and host and sharing  a folder on the host with the guest.
>>
>> The host always uses out of tree kernel-modules.
> 
> Hans,
> 
> Thanks for this clarification.  This is my fault for leading Sumitra to
> believe that the in tree modules could replace the guest additions for the
> VirtualBox hypervisor.

Actually the in tree modules can replace the *guest* kernel modules which are shipped with the guest additions from virtualbox.

>> The guest can use the in tree kernel modules.
>>
>>> How can I make the in-tree vbox modules run?
>>
>> You can use these and specifically the vboxsf and vboxguest modules by
>> installing Fedora 38 Workstation x86_64 as a virtualbox *guest* / inside
>> a virtualbox vm and then share a folder on the host with the guest.
>>
> 
> I took your original email to mean that some in tree modules could be out
> of sync with the interfaces used by code coming from Oracle.
> 
> I'm curious are there also out of tree modules for the guest support?

Yes the guest-additions contain out of tree modules (1). Since Sumitra plans to work on the in tree modules, those should NOT be installed.

The easiest way to avoid installing the out-of-tree guest modules is to just not install the official guest additions at all.

Fedora comes with pre-packaged guest additions which only contain the (FOSS) userspace parts, relying on the in tree vbox guest kernel modules.

Regards,

Hans


1) When I worked on mainlining the guest modules the idea/hope as that virtualbox upstream would switch to the in tree version, at least when the guest has a new enough kernel. But unfortunately this never happened.

