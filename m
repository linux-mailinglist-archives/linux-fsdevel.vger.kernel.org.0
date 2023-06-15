Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E307318FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjFOMaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjFOMaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80178119
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686832154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miKGhTsa1C617Jf+rAPO8YcjvbVy2XjmmKexewlCMig=;
        b=UQ8Wxg1WKMHW/nWLy4vm6eQqprH18oIdjAsps64bHu+Hpv5Ifd/qncZ0fpNYJMc8at/sEY
        ZGU8gAk0G/9Ffre0rkYhBuLXgS5Om/k0zOlEGzSc6awgLRfChaCZ/zDvBvcWVmQX5VYYJ3
        +/4JNUwab22zn2DipalWezTxXYOBrRs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-U1hJ1I8SPdGldIMyL7HRmg-1; Thu, 15 Jun 2023 08:29:10 -0400
X-MC-Unique: U1hJ1I8SPdGldIMyL7HRmg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b3e18add74so20465515ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 05:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686832149; x=1689424149;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miKGhTsa1C617Jf+rAPO8YcjvbVy2XjmmKexewlCMig=;
        b=joqwVWVkcScCB/eoKXajkjI6bID0xD66yiSdAGHCoMNHNYVtiShfZyScbM53MKwBUH
         uQTYKALA8Vt9COnSWWK0+ZJZVi90yOMzKEU0i3VVc4ejZNXgtlOPHMU5VmVIBYeSNxGb
         9IntF6OADmKOnVfyjmtvboxGSH6spwWLjnbM2ErUTtdtiFDKx35u+xKDKXQP6KOSpm+R
         /iHu5ZLcjKW26QEj8Yha7s8tNP4mHO0cCUraaBI4PblmHdDlyHyF9X2Gyvne7C4yQd6n
         sOaRKwWrbxGCJ/BTwItJ8NwsLKN8D1gyvw/v7OMtIi+BCw/xJsEaD+QDjP/mFbRzQYTa
         ol1Q==
X-Gm-Message-State: AC+VfDyNVb6E4Ac5ok/ucGVDYnNWt87/+jCUmL1Dw5m+qeHVxjW512Ot
        SExiiOUAzORwgthWj8IEjU51lTkHMh0eoTOJMSFxvYikHwEM4hAoEeufEySut2t88ZItJel/bHQ
        UMeZDuSMaiOtq/rStax82tzWLNQ==
X-Received: by 2002:a17:902:ecc9:b0:1b0:fe9:e57e with SMTP id a9-20020a170902ecc900b001b00fe9e57emr16332665plh.0.1686832149261;
        Thu, 15 Jun 2023 05:29:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47UwUMIaeKjeei4hpwO38mx1dbD0wAapGYqH6wtjkzhQTmhZv/MA3mxt0UYN8TaPs+w9oB1A==
X-Received: by 2002:a17:902:ecc9:b0:1b0:fe9:e57e with SMTP id a9-20020a170902ecc900b001b00fe9e57emr16332648plh.0.1686832149003;
        Thu, 15 Jun 2023 05:29:09 -0700 (PDT)
Received: from [10.72.12.155] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001ab0a30c895sm13953037plp.202.2023.06.15.05.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:29:08 -0700 (PDT)
Message-ID: <bb20aebe-e598-9212-1533-c777ea89948a@redhat.com>
Date:   Thu, 15 Jun 2023 20:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
 <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
 <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
In-Reply-To: <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]

 > > >
 > > > I thought about this too and came to the same conclusion, that 
UID/GID
 > > > based
 > > > restriction can be applied dynamically, so detecting it on mount-time
 > > > helps not so much.
 > > >
 > > For this you please raise one PR to ceph first to support this, and in
 > > the PR we can discuss more for the MDS auth caps. And after the PR
 > > getting merged then in this patch series you need to check the
 > > corresponding option or flag to determine whether could the idmap
 > > mounting succeed.
 >
 > I'm sorry but I don't understand what we want to support here. Do we 
want to
 > add some new ceph request that allows to check if UID/GID-based
 > permissions are applied for
 > a particular ceph client user?

IMO we should prevent users to set UID/GID-based MDS auth caps from ceph 
side. And users should know what has happened.

Once users want to support the idmap mounts they should know that the 
MDS auth caps won't work anymore.

Thanks

- Xiubo

