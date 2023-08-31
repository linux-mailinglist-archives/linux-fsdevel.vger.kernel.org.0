Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA978E52E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbjHaDxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 23:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbjHaDxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75770CDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 20:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693453972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4G2J3yaU4Ahm/CeQvnEPj3w1MykmpIHM4D6dSpmIRg=;
        b=Ls+uQYUyVteeuufh1OYlwx4Xdt83phkeQxcee8iVVwhCEqnRUrGYFnDB1rRhdQucP40j4Y
        +btxZxrO4xk8LrRKuT5FlizO+2etJCuzZgflWJMg9ofzqOO6Stjtu8va3wtoxEt9GjhHWT
        tPoO/0BJkvpwkA1NvIrk+Mrs3ezjuGI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-ORS1IQV1MUmWHDT92H_3jQ-1; Wed, 30 Aug 2023 23:52:50 -0400
X-MC-Unique: ORS1IQV1MUmWHDT92H_3jQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f9107479bso383247a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 20:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693453970; x=1694058770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4G2J3yaU4Ahm/CeQvnEPj3w1MykmpIHM4D6dSpmIRg=;
        b=VlYlKVEPxdgZPEVtCXNddthdqHwkSuO5fHoZIgSncHryqjX/zUXqDmzb5r28C/D/0B
         2rqNLB/vbTGR5+0dBYfAnTRO3ULQBh1QyCH9mJsMXSTqgOI/ue5IgIC1MyvSW/GBJMOD
         ndcguKyxlvtV7NyPFaL9LCh2o99dLPVoizpyaP4ZTodVd23mFRu4oxqQTyxbndPdgkvS
         9KN/NNf6421bUGN2X6IcigC0ih1BJm2jiTCNAI7EkQ07iMNRlox7PzZ9I9gQXRFaUZYT
         c5/OUX68lH6xOHd++d+GUZxt57ZFj1pNBfeLKQVUBAcSfRYGJdoRvgy/SvmfYYCF0Zmx
         H8VA==
X-Gm-Message-State: AOJu0YxNIv8R7US2i/v4BKlFEnYyIwxew/NwczG+Qn0aItQ00Ucp5NGS
        bFj7MjZQzfFXzB8Ypfl+gf3YYaFsybJSIFyx7QNS7+FlN/lobGk4tA0oc90uh1I+gSE72CalkUz
        Tx3ryNOlFh+FD9ZBgXoF5pQLWig==
X-Received: by 2002:a17:90a:12c7:b0:26b:3625:d1a2 with SMTP id b7-20020a17090a12c700b0026b3625d1a2mr3734683pjg.41.1693453969820;
        Wed, 30 Aug 2023 20:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQGVy7U4gKVOlStGzV7J8dRoxJwOU6HweEgcUyaYfMNQjS0ve6u6QKzeNdwnuDB8SKWAf5/A==
X-Received: by 2002:a17:90a:12c7:b0:26b:3625:d1a2 with SMTP id b7-20020a17090a12c700b0026b3625d1a2mr3734676pjg.41.1693453969494;
        Wed, 30 Aug 2023 20:52:49 -0700 (PDT)
Received: from [10.72.112.230] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0026b12768e46sm333883pji.42.2023.08.30.20.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 20:52:49 -0700 (PDT)
Message-ID: <b0f42122-8384-4892-7498-e110a0ce4475@redhat.com>
Date:   Thu, 31 Aug 2023 11:52:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-10-willy@infradead.org>
 <ZOlq5HmcdYGPwH2i@casper.infradead.org>
 <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
 <668b6e07047bdc97dfa1d522606ec2b28420bdce.camel@kernel.org>
 <ZO3y9ZixzE4c5oHU@casper.infradead.org>
 <CAOi1vP-jc+GqUKgewEaVRC8TuDjKzh4PeKmWyDf3qxSAWC4dTw@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP-jc+GqUKgewEaVRC8TuDjKzh4PeKmWyDf3qxSAWC4dTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/30/23 18:44, Ilya Dryomov wrote:
> On Tue, Aug 29, 2023 at 3:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>> On Tue, Aug 29, 2023 at 07:55:01AM -0400, Jeff Layton wrote:
>>> On Mon, 2023-08-28 at 09:19 +0800, Xiubo Li wrote:
>>>> Next time please rebase to the latest ceph-client latest upstream
>>>> 'testing' branch, we need to test this series by using the qa
>>>> teuthology, which is running based on the 'testing' branch.
>>> People working on wide-scale changes to the kernel really shouldn't have
>>> to go hunting down random branches to base their changes on. That's the
>>> purpose of linux-next.
>> Yes.  As I said last time this came up
>> https://lore.kernel.org/linux-fsdevel/ZH94oBBFct9b9g3z@casper.infradead.org/
>>
>> it's not reasonable for me to track down every filesystem's private
>> git tree.  I'm happy to re-do these patches against linux-next in a
>> week or two, but I'm not going to start working against your ceph tree.
>> I'm not a Ceph developer, I'm a Linux developer.  I work against Linus'
>> tree or Stephen's tree.
> Agreed.  Definitely not reasonable, it's the CephFS team's job to sort
> out conflicts when applying patches to the testing branch.
>
> The problem is that the testing branch is also carrying a bunch of "DO
> NOT MERGE" fail-fast and/or debugging patches that aren't suitable for
> linux-next.  The corollary of that is that we end up testing something
> slightly different in our CI.  Xiubo, please review that list and let's
> try to get it down to a bare minimum.

Sure. Thanks!

- Xiubo


> Thanks,
>
>                  Ilya
>

