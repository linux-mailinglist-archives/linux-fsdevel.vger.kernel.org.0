Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6139869926A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBPK6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 05:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBPK55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4456ED7
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676544979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTgMQWhXxbdOB1s+iJ3y+3uVjK3VfEIrdExBYMmTzrk=;
        b=cgTA8yeBuLVrFQVUmlI+zpc+i1N1YJx/XupkVor1p/PDzbtkrCJaRFBHH5jm5w/+5d51X8
        Bn2kkqyd8oZGSVLCtonsceAAevnNU5H26m5PiLePfMmuSxCWYBhVrrk1glN+9V+nsIJyVa
        6qv75jzAEiTEOdI0A+bzz0LgINFEB2s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-nMZFK_AqPyq9VdabL_wyNQ-1; Thu, 16 Feb 2023 05:56:18 -0500
X-MC-Unique: nMZFK_AqPyq9VdabL_wyNQ-1
Received: by mail-wr1-f71.google.com with SMTP id r15-20020a5d494f000000b002c54d9b8312so189767wrs.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 02:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTgMQWhXxbdOB1s+iJ3y+3uVjK3VfEIrdExBYMmTzrk=;
        b=H6N1fV4R2/lVJGDb/dg4IgSVmoUwBfO4Ngi3+68aOXGFjCXXGNLYX3it5EDqna8sF8
         Ww2khDiaBld7EL1zcWaKvrZoAdG8vTQdKu7Yup2j7C0EwYQntxRvJIIvSxNN0DjslyP2
         9D6o33suu+jHBIXlcY1gRI9an8FGVC3/5xP6tXLFafRe2fREnuaqLshPOprNtrardpv1
         wKLyTWVWPTDS3nAUmlNPVVRFmb0C4COz5ehdicWeL77wjrAP7Pr6D+hvO37ZwJ6FbJCa
         qvzC5AMzvrpijP4ikE6mKqLx1b6fmeg0XJA22psGFi3v9y8/z3ZHbd+gABWEW5VGjIee
         e0Dg==
X-Gm-Message-State: AO0yUKV01MPOOd4vOUHFg+CTT89LI3xTBBu2zZFWTsYsTHubWSxdqgpT
        bGmJXQ14zhcSkg1Uj8x9hL6H8zg9GUCIA7Gbwe9azE8hvZEP0PxQKgfQpJSLTxm2cLsY3tD/Afc
        0HF9n3HvesnWyZ5MxUnquBcB2HQ==
X-Received: by 2002:adf:e701:0:b0:2c5:5331:5516 with SMTP id c1-20020adfe701000000b002c553315516mr4351125wrm.51.1676544976935;
        Thu, 16 Feb 2023 02:56:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9ObTYOMWdJTcJUhFYm6zKW9Smmq8ZljjToRyJseQklHttx5j+GTfa92sWHSmEG8i4fOJ6xDQ==
X-Received: by 2002:adf:e701:0:b0:2c5:5331:5516 with SMTP id c1-20020adfe701000000b002c553315516mr4351100wrm.51.1676544976599;
        Thu, 16 Feb 2023 02:56:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id h16-20020adffa90000000b002c5621263e3sm1221457wrr.19.2023.02.16.02.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:56:16 -0800 (PST)
Message-ID: <909d3cd5-eb64-6901-4e12-00ac5c69f4aa@redhat.com>
Date:   Thu, 16 Feb 2023 11:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] Revert "splice: Do splice read from a buffered file
 without using ITER_PIPE"
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org
References: <20230215-topic-next-20230214-revert-v1-2-c58cd87b9086@linaro.org>
 <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
 <3055589.1676466118@warthog.procyon.org.uk>
 <71078188-1443-d84e-658c-967991f3b590@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <71078188-1443-d84e-658c-967991f3b590@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.02.23 10:10, Konrad Dybcio wrote:
> 
> 
> On 15.02.2023 14:01, David Howells wrote:
>> Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>> next-20230213 introduced commit d9722a475711 ("splice: Do splice read from
>>> a buffered file without using ITER_PIPE") which broke booting on any
>>> Qualcomm ARM64 device I grabbed, dereferencing a null pointer in
>>> generic_filesplice_read+0xf8/x598. Revert it to make the devices
>>> bootable again.
>>>
>>> This reverts commit d9722a47571104f7fa1eeb5ec59044d3607c6070.
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Commit d9722a47571104f7fa1eeb5ec59044d3607c6070 was part of v13 of my
>> patches.  This got replaced yesterday by a newer version which may or may not
>> have made it into linux-next.
>>
>> This is probably a known bug fixed in the v14 by making shmem have its own
>> splice-read function.
>>
>> Can you try this?
>>
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract
> next-20230216 boots fine again, thanks!
> 
>>
>> (Also, can you include me in the cc list as I'm the author of the patch you
>> reverted?)
> Ugh.. I thought b4 would have done that for me.. weird..

Right, and usually it's nicer to comment on the problematic patches, 
asking for a fix or a revert, instead of sending reverts.

My 2 cents.

-- 
Thanks,

David / dhildenb

