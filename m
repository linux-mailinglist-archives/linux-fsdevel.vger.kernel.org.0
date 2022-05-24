Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E975326DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiEXJvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiEXJvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 05:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C62EA473
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653385867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HROxCg3THyAWJg+stBN26H1YCc49DJ6h7IjqQesEu3w=;
        b=d5S1PqZE2PsAmxmE+QKoUpaO3U1yDdyBdtEvrsr66oLzUM7lWvOBMexNAh0nDiI3VjoD46
        m/Jdrsopj2TG9QI2rqSqJI/npv0GR1mWe7OvKgKQ7LY0RZ3SvpCGPp38KG9PSP9E7qDXuW
        t2FMnKX1TbgpkpQcyxa7Yt2ZwXWUl68=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-vKG8R8dyOcKIEI1xBoWtWQ-1; Tue, 24 May 2022 05:51:06 -0400
X-MC-Unique: vKG8R8dyOcKIEI1xBoWtWQ-1
Received: by mail-pf1-f199.google.com with SMTP id f82-20020a623855000000b005182d5d2cdbso7136260pfa.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HROxCg3THyAWJg+stBN26H1YCc49DJ6h7IjqQesEu3w=;
        b=hFJlYe2b6am6NynbpVKrESlcmbnwm/8VxV9amEKTXJ/hkhm+Z7YTa6z3o2M6UkIs+O
         t8MqwhI0rkIc8C3Rx0y1IEI3d96VviF3mHVp7BUi+B/11u580Q5SKyKTTyY3s4S/Pug+
         0TuaeJpLn6QqINryuF5iN973a4fZtJ6U8NcOgi5kJa3geF8Rp3Uofz/HKZprBWRA8Dy0
         2z+kq1r7nZiWUVpL4XAfzAfI0z0wON/Icajq1ZHBcCpXxdNBlY9zgfsaQzld3IZkjmPr
         XK0A+m5X3o0hnyio/ubzEHrTfRccvt0CixUDeoSlGq5lTeSnFnQCylAdcIwyluwuyqH5
         94/w==
X-Gm-Message-State: AOAM532hOm/JqMKfLYP/mN7UryLQuWvoKsPyjnuPzIIlKHmKAD42r3pV
        2G59MuLVsPEEVvyU6G/YenRrxHYwfXRH17pIQlzfFjzFNUiIpXuJvnKTpMicUbWCACqHz0SAunC
        CYcN8K2GcU8v0YU7aVC7HrB2gDg==
X-Received: by 2002:a17:90a:c682:b0:1df:c4a8:5db6 with SMTP id n2-20020a17090ac68200b001dfc4a85db6mr3684390pjt.43.1653385865312;
        Tue, 24 May 2022 02:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdBOH+gVDMrgyZ041wJ5jZ+2lLXtmmTzIxw/fZE8mPGpSF9hC5I1Teh6Xt19AWnXqr7+s+0w==
X-Received: by 2002:a17:90a:c682:b0:1df:c4a8:5db6 with SMTP id n2-20020a17090ac68200b001dfc4a85db6mr3684372pjt.43.1653385865116;
        Tue, 24 May 2022 02:51:05 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090a7b8c00b001df2f8f0a45sm1308834pjc.1.2022.05.24.02.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:51:04 -0700 (PDT)
Subject: Re: [PATCH v2] netfs: Fix gcc-12 warning by embedding vfs inode in
 netfs_i_context
To:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     keescook@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1b5daa4695b62795b617049e32c784052deabad4.camel@kernel.org>
 <165305805651.4094995.7763502506786714216.stgit@warthog.procyon.org.uk>
 <658391.1653302817@warthog.procyon.org.uk>
 <e4fcdf88a9b35a9f1ca6e75fdf75ad469f824380.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <9945711f-c786-2300-9854-ee7734024a2c@redhat.com>
Date:   Tue, 24 May 2022 17:50:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e4fcdf88a9b35a9f1ca6e75fdf75ad469f824380.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/23/22 7:05 PM, Jeff Layton wrote:
> On Mon, 2022-05-23 at 11:46 +0100, David Howells wrote:
>> Jeff Layton <jlayton@kernel.org> wrote:
>>
>>> Note that there are some conflicts between this patch and some of the
>>> patches in the current ceph-client/testing branch. Depending on the
>>> order of merge, one or the other will need to be fixed.
>> Do you think it could be taken through the ceph tree?
>>
>> David
>>
> Since this touches a lot of non-ceph code, it may be best to just plan
> to merge it ASAP, and we'll just base our merge branch on top of it.
>
> Ilya/Xiubo, do you have an opinion here?
>   

Yeah, agree with Jeff.


