Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173A5B96CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIOJAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIOJAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:00:01 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA62B634;
        Thu, 15 Sep 2022 01:59:54 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 78so16690781pgb.13;
        Thu, 15 Sep 2022 01:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LgyjDSHm06cPee7hqq0YhgTi9iCJukSRg0rhaRDNcHk=;
        b=QEh3Wa7oETLzEJVYfPdZq+coHi82ecqj0dGk9ICEMhD/J/t6WAjPzFBRV8qbi5gebe
         VF+H1k2Rz6h3h9JiJtYksmqAAnHleI+uxnyq0LM8E73J6u53FFc6SKJBaS2bZNJwH7lF
         I3AZ3J2+iOldDE/HtlMtEEvaW6Bwl4ORxwrkQYrdQibgJwXix1Q7YobpDL9UAQeq1BHd
         /CovHybA/DBORCeflx18aP0Nopj6cCbjVNCpX0Lx5lZPV6HUAoq5GKrRVmAG6x6cOb8l
         kqXSj/FE4LYYJbHoTO4R+bCMhM6VFLh5Q/zkOMLhNHlEneyJdxbTzRMxkMWW4C2+lr8A
         9nDQ==
X-Gm-Message-State: ACgBeo0bdk6AIAExC9AkGiUxbIuiCmpcCzmwZy7NxwYxpgJQffKV1wFJ
        ogBHru7BIcnpD+k77Fg4W3EGNDi7QAywKN4w
X-Google-Smtp-Source: AA6agR4WU7ZFHbHVFtlrqh6Z/nov+94pXR2gXasc4E3LWh/IVzcVIhhv4YrnTj6lp0euM6VzNvlMaw==
X-Received: by 2002:a63:ff59:0:b0:439:db5:5da9 with SMTP id s25-20020a63ff59000000b004390db55da9mr15350857pgk.88.1663232393120;
        Thu, 15 Sep 2022 01:59:53 -0700 (PDT)
Received: from [192.168.123.231] (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id a23-20020aa79717000000b0053e3112e84bsm11908800pfg.50.2022.09.15.01.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 01:59:52 -0700 (PDT)
Message-ID: <1a2ac6fb-1a02-de99-1b4e-18360bd34d55@kylinos.cn>
Date:   Thu, 15 Sep 2022 16:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/filemap: Make folio_put_wait_locked static
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>,
        linux-fsdevel@vger.kernel.org
References: <20220914015836.3193197-1-sunke@kylinos.cn>
 <44af62e3-8f51-bf0a-509e-4a5fdbf62b29@kylinos.cn>
 <YyLUlQbQi3O0ntwY@casper.infradead.org>
From:   Ke Sun <sunke@kylinos.cn>
In-Reply-To: <YyLUlQbQi3O0ntwY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022/9/15 15:30, Matthew Wilcox wrote:
> On Thu, Sep 15, 2022 at 08:45:33AM +0800, Ke Sun wrote:
>> Ping.
> Don't be rude.  I'm at a conference this week and on holiday next week.
> This is hardly an urgent patch.
So sorry to bother you. Some duplicate emails were sent due to issues 
with mailbox app settings.
>> On 2022/9/14 09:58, Ke Sun wrote:
>>> It's only used in mm/filemap.c, since commit <ffa65753c431>
>>> ("mm/migrate.c: rework migration_entry_wait() to not take a pageref").
>>>
>>> Make it static.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>> Signed-off-by: Ke Sun <sunke@kylinos.cn>
>>> ---
>>> include/linux/pagemap.h | 1 -
>>> mm/filemap.c | 2 +-
>>> 2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>> index 0178b2040ea3..82880993dd1a 100644
>>> --- a/include/linux/pagemap.h
>>> +++ b/include/linux/pagemap.h
>>> @@ -1042,7 +1042,6 @@ static inline int
>>> wait_on_page_locked_killable(struct page *page)
>>> return folio_wait_locked_killable(page_folio(page));
>>> }
>>> -int folio_put_wait_locked(struct folio *folio, int state);
>>> void wait_on_page_writeback(struct page *page);
>>> void folio_wait_writeback(struct folio *folio);
>>> int folio_wait_writeback_killable(struct folio *folio);
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 15800334147b..ade9b7bfe7fc 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
>>> *
>>> * Return: 0 if the folio was unlocked or -EINTR if interrupted by a
>>> signal.
>>> */
>>> -int folio_put_wait_locked(struct folio *folio, int state)
>>> +static int folio_put_wait_locked(struct folio *folio, int state)
>>> {
>>> return folio_wait_bit_common(folio, PG_locked, state, DROP);
>>> }
