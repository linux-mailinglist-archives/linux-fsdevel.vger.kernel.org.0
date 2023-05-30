Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088A77166C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjE3PPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjE3POx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:14:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B2D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:14:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760dff4b701so23852639f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685459689; x=1688051689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tp/ySIwwm4tl/YIed7+PvRfuzdgg1UhCSe2CIK+Ly+s=;
        b=xOkOoj4cDaSXirzk4uIboFQnwwINYWkE41mSD75bBat4nxEXJuipsA9ArGyo2UeBqx
         Kq9+mAB55iKthDhGAImEFsxB+rRsmEMgs6FpMVpSTjHfjf+dcWciLu166pMGZmx0Cbom
         D2CnJp0JOlcSk+AtYAprigutEBdADB/JeK1MfqKHq6SU5zjqHVQvSYnJ/tZe15ZHCmZw
         obheJiX+2Ze0w6gCDga10r1butszL/v1bdNLsPQJxdDk5hqhOOPZOPc/F51qTRMTFSK9
         BVTLgTLAJU3vvbHG1HC9noz2HJsQ7wD6E5CGkvfADErM+d/V4AMklilsjXurfBo7Qg1G
         9ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459689; x=1688051689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tp/ySIwwm4tl/YIed7+PvRfuzdgg1UhCSe2CIK+Ly+s=;
        b=OKBd8gaLOsvXYz2zv6domo4O46XKe0H/VhsMZHURu5SBMhwpnxoz65NQWyjKGUlOlw
         edD3eI8VPbncrnTEi/DgX6bD9jnbiPodWyRXB0jeUh6MekPJTr3WstiIpoiEBUM5o09O
         znwiOBPzVFFTzbOFRRNTjiaUmY3Ho+D8wVU8oQ00L5YtupHQdhIfkAon4KtGVLGZSH4e
         /p2g5jYb4D0jfK2lUZlc1bfGsl3atFXTPpmmAlJ6F5Pmp/ZpPSSAdiwBCqPAM8lzmGsZ
         pBBZKT/a1h5M0fM00rnpPenOgSU9AShnenh3zHJ39js46V6F7RdE6WCv0FuUquzmPA5+
         0QGQ==
X-Gm-Message-State: AC+VfDzHKuIMt4Otv7N3gBV+VQBupWQG7zkLmPwmg3Dl4eXjsH9d2ZqU
        xZcA9kBjwRVeC5T74uHQ/bnrfA==
X-Google-Smtp-Source: ACHHUZ5N9fZwp0C4udilf2wbvP/vXNdHUtnkR6kuIJ7hXoCHV8PblKq9G6f5VgAxs1O6gmhEp8JA/Q==
X-Received: by 2002:a05:6e02:ef3:b0:33b:85f4:2edf with SMTP id j19-20020a056e020ef300b0033b85f42edfmr1197714ilk.1.1685459689656;
        Tue, 30 May 2023 08:14:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e02054900b00325df6679a7sm2575003ils.26.2023.05.30.08.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:14:47 -0700 (PDT)
Message-ID: <bc5833bc-1c78-8d9b-69f8-1401b673b861@kernel.dk>
Date:   Tue, 30 May 2023 09:14:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/20] bio: check return values of bio_add_page
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>
Cc:     "agruenba@redhat.com" <agruenba@redhat.com>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "rpeterso@redhat.com" <rpeterso@redhat.com>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <3235f123-0638-b39f-f902-426059b87f81@kernel.dk>
 <efedff15-af48-31e5-2834-d8a879f1e6d2@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <efedff15-af48-31e5-2834-d8a879f1e6d2@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/23 12:37 AM, Johannes Thumshirn wrote:
> On 24.05.23 17:02, Jens Axboe wrote:
>> On 5/2/23 4:19?AM, Johannes Thumshirn wrote:
>>> We have two functions for adding a page to a bio, __bio_add_page() which is
>>> used to add a single page to a freshly created bio and bio_add_page() which is
>>> used to add a page to an existing bio.
>>>
>>> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
>>>
>>> This series converts the callers of bio_add_page() which can easily use
>>> __bio_add_page() to using it and checks the return of bio_add_page() for
>>> callers that don't work on a freshly created bio.
>>>
>>> Lastly it marks bio_add_page() as __must_check so we don't have to go again
>>> and audit all callers.
>>
>> Looks fine to me, though it would be nice if the fs and dm people could
>> give this a quick look. Should not take long, any empty bio addition
>> should, by definition, be able to use a non-checked page addition for
>> the first page.
>>
> 
> I think the FS side is all covered. @Mike could you have a look at the dm
> patches?

Not the iomap one, that was my main concern. Not that this is tricky stuff,
but still...

-- 
Jens Axboe


