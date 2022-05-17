Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4C529616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiEQAed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 20:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiEQAec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 20:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDF9C2715E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652747669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFzmceO8lMMO/+kL1LxPWjlpYtFkd84SSop/Z3TUE1w=;
        b=gNzjf7NIB1phsGNmtMmw9Ku6VAaTcGG2ve7ouZQmAR8lBJrZB9YMaCjOtcMoMBMMQs6JDo
        7DfTa56slCs0s0k1tjt6AaEAz6Y9SboZFmQNfvKGJgb0WOPTnf/3B2ZdQg57KTCCKdoI3e
        n++GPyWNv/2guqLrEdyZpQ+rZx3AzNc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-xJ6dP8qtN4CgcahUteTk8Q-1; Mon, 16 May 2022 20:34:28 -0400
X-MC-Unique: xJ6dP8qtN4CgcahUteTk8Q-1
Received: by mail-pl1-f199.google.com with SMTP id x23-20020a170902b41700b0015ea144789fso8754881plr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 17:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bFzmceO8lMMO/+kL1LxPWjlpYtFkd84SSop/Z3TUE1w=;
        b=wO88a+ycIr57euWmxaKKaZwViWPTm+Mf0CCxilpfeyVNl/S9zh2JE02xdo4XRJZlJv
         hA5zZfpH2Ev3z7H2H+iGagPuqgtQnBAIiBSq6UYUYlJtT1NEEc4A4lgrc6tR56/hqS0m
         MwUaWRppNPV1Kn6qGhHraAc4/BQVxq53hntPfcUNrMfFTPScwiMpq0n9JPUNx91XEtlr
         3JdMKIw3MK+E0aYwZo/RunF/WK/qaENY0Je3+aTmeiSjaFfZDS5TBCK8p/zeRrTa80uz
         VqNKbTqgQaiYgAo529KMIDM0Vf/P7HVyhJlpBQ5pfFbVX86iaphBBS2/Df7ZJQKzJJLf
         EDCg==
X-Gm-Message-State: AOAM531Ntb5fGjZgx0ewCuaZVJ1S0UIY3wlSifD5cS7ykzEEanXdcYDQ
        g/wpNF8iHWZ1NhKNs2/6F95h76d+G+WLIyUFLipNYvmkmIS0S/HDOMXrWWb4l0/VdEdEEf34nkd
        lw5n+5YHYs5/QGVWeaVpZlbzr4g==
X-Received: by 2002:a63:91c4:0:b0:3c6:2334:3ca1 with SMTP id l187-20020a6391c4000000b003c623343ca1mr17580698pge.53.1652747667597;
        Mon, 16 May 2022 17:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+xhUzIhGcYO+zKBk4VrEJOB5fFKVxWWc4Sx5d0Gme43WJtY7QUsx+wllrZBb+F2NrxKnQsg==
X-Received: by 2002:a63:91c4:0:b0:3c6:2334:3ca1 with SMTP id l187-20020a6391c4000000b003c623343ca1mr17580681pge.53.1652747667319;
        Mon, 16 May 2022 17:34:27 -0700 (PDT)
Received: from [10.72.12.136] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902e14400b001619cec6f95sm820122pla.257.2022.05.16.17.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 17:34:26 -0700 (PDT)
Subject: Re: Freeing page flags
To:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
 <Yn3FZSZbEDssbRnk@localhost.localdomain>
 <Yn3S8A9I/G5F4u80@casper.infradead.org> <87sfpd22kq.fsf@brahms.olymp>
 <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <1a86330d-d1a4-7c74-241e-11cc263254cf@redhat.com>
Date:   Tue, 17 May 2022 08:34:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/13/22 8:53 PM, Matthew Wilcox wrote:
> On Fri, May 13, 2022 at 10:40:05AM +0100, Luís Henriques wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
>>>> On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
>>>>> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
>>>>> out a plan for removing page flags that we can do without.
>>>>>
>>>>> 1. PG_error.  It's basically useless.  If the page was read successfully,
>>>>> PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
>>>>> doesn't use PG_error.  Some filesystems do, and we need to transition
>>>>> them away from using it.
>>>>>
>>>> What about writes?  A cursory look shows we don't clear Uptodate if we fail to
>>>> write, which is correct I think.  The only way to indicate we had a write error
>>>> to check later is the page error.
>>> On encountering a write error, we're supposed to call mapping_set_error(),
>>> not SetPageError().
>>>
>>>>> 2. PG_private.  This tells us whether we have anything stored at
>>>>> page->private.  We can just check if page->private is NULL or not.
>>>>> No need to have this extra bit.  Again, there may be some filesystems
>>>>> that are a bit wonky here, but I'm sure they're fixable.
>>>>>
>>>> At least for Btrfs we serialize the page->private with the private_lock, so we
>>>> could probably just drop PG_private, but it's kind of nice to check first before
>>>> we have to take the spin lock.  I suppose we can just do
>>>>
>>>> if (page->private)
>>>> 	// do lock and check thingy
>>> That's my hope!  I think btrfs is already using folio_attach_private() /
>>> attach_page_private(), which makes everything easier.  Some filesystems
>>> still manipulate page->private and PagePrivate by hand.
>> In ceph we've recently [1] spent a bit of time debugging a bug related
>> with ->private not being NULL even though we expected it to be.  The
>> solution found was to replace the check for NULL and use
>> folio_test_private() instead, but we _may_ have not figured the whole
>> thing out.
>>
>> We assumed that folios were being recycled and not cleaned-up.  The values
>> we were seeing in ->private looked like they were some sort of flags as
>> only a few bits were set (e.g. 0x0200000):
>>
>> [ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:0000000022e0d3b4 index:0xd8 pfn:0x74e83
>> [ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"faed"
>> [ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=1)
>> [ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a088 ffff888003491948
>> [ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002ffffffff 0000000000000000
>> [ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)
>>
>> [1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redhat.com/
> I remember Jeff asking me about this problem a few days ago.  A folio
> passed to you in ->dirty_folio() or ->invalidate_folio() belongs to
> your filesystem.  Nobody else should be storing to the ->private field;
> there's no race that could lead to it being freed while you see it.
> There may, of course, be bugs that are overwriting folio->private, but
> it's definitely not supposed to happen.  I agree with you that it looks
> like a bit has been set (is it possibly bad RAM?)

I don't think so.

Please see the values I saw from my tests locally below.

>
> We do use page->private in the buddy allocator, but that stores the order
> of the page; it wouldn't be storing 1<<21.  PG flag 21 is PG_mlocked,
> which seems like a weird one to be setting in the wrong field, so probably
> not that.
>
> Is it always bit 21 that gets set?
>
No, from my test I can reproduce it locally very easy and almost every 
time the values were different, which were random values, just like:

0000000000040000,0000000000070000,000000000002e0000...

More detail please see https://tracker.ceph.com/issues/55421.

I am sure that for all the none zero values the lower 16 bits were 0000.

-- Xiubo


