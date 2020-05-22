Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9861D1DE0B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgEVHS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgEVHS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 03:18:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7FC061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 00:18:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so8540793edw.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=in51jJA8Mu7oKCkIWNSeQ3E1a6Z3kXtKg8VzNNTy0UQ=;
        b=Stz0XkL6PSXCeCJfuF0oo7byMaaO9yT+tf4sJuvMiUsis37y81xDk/LYrW3dx0Z1sG
         h+3UapferdC9mSB0rINgG7eoHVTZYp8fzBXJVq2gcSIZURTdLQ/cBt4z2CEMCuHctoiX
         Km6YufoqUkb2XMfyjuG7zn9xXaq8pfXT6icmsNrgZgN6kKTHUft9ax5Af4CvRCX4JA7N
         5c1dbsk9zh2Vu0R0b4A7Ql5Gbp0+bjoR3u3kwzxjYk3CqmR0fqLCMVRO+8nnl3jjkXMj
         aZuPKW6p6btOUy/2vZAJ9TdW4PiQD4KW011EyAsvkktKm/SFH4YYN6kdhu5vjWPdOHwz
         j6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=in51jJA8Mu7oKCkIWNSeQ3E1a6Z3kXtKg8VzNNTy0UQ=;
        b=mRnenQ6Evwg7UmittCeU7YB8EFbxoD6+Eo2/ChOV/fQZbqmQxdLcji46eEylzROycc
         +gBCKOzfTdIdbiW3MBlgvXlptdFOpGURtFq3Em/XjKBVdvTfvSUTWkTLTFcNpKYAk5bM
         p3vbeZJZ3kU9OKWpBD9ippgEg5EGdJRI39/m3IyYupGsMWExYKbU8ae4ron2C0IUwmYy
         e8s9ZzVToNwFtJZeGtjWDy3LYjqDgyu4ILdyhRXB8+nk05Aw7mkWlB0bD4wxonF6dY21
         WmfGWzcDTHO1Mi4v1JnW/f5s/JZQHPQg0vI82jDuqnPVrVHBuEacs2p19Rp/kinyfHvD
         6Qdg==
X-Gm-Message-State: AOAM533KxQnNm5cs1sHl76uOHq2uMtsP1Pql3EhafoByeHiMMyAiApAh
        haPv4R8vfaT805uMKK17mCDfPZqm6oASHw==
X-Google-Smtp-Source: ABdhPJyOFvm9l7pay4ySoW0TUkuluuWMUy4ykcwXScy8L4/1d/ztFNvLImjtm+nK2E1xJ3AtQsakRA==
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr2012716edb.274.1590131907016;
        Fri, 22 May 2020 00:18:27 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4891:d900:e80e:f5df:f780:7d57? ([2001:16b8:4891:d900:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id lw27sm7293270ejb.80.2020.05.22.00.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 00:18:26 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200521225220.GV2005@dread.disaster.area>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <906f7469-492d-febc-c7ed-b01830ae900d@cloud.ionos.com>
Date:   Fri, 22 May 2020 09:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521225220.GV2005@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 5/22/20 12:52 AM, Dave Chinner wrote:
> On Sun, May 17, 2020 at 11:47:18PM +0200, Guoqing Jiang wrote:
>> We can cleanup code a little by call detach_page_private here.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>> No change since RFC V3.
>>
>>   mm/migrate.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 5fed0305d2ec..f99502bc113c 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>   	if (rc != MIGRATEPAGE_SUCCESS)
>>   		goto unlock_buffers;
>>   
>> -	ClearPagePrivate(page);
>> -	set_page_private(newpage, page_private(page));
>> -	set_page_private(page, 0);
>> -	put_page(page);
>> +	set_page_private(newpage, detach_page_private(page));
> attach_page_private(newpage, detach_page_private(page));

Mattew had suggested it as follows, but not sure if we can reorder of 
the setup of
the bh and setting PagePrivate, so I didn't want to break the original 
syntax.

@@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
         if (rc != MIGRATEPAGE_SUCCESS)
                 goto unlock_buffers;
  
-       ClearPagePrivate(page);
-       set_page_private(newpage, page_private(page));
-       set_page_private(page, 0);
-       put_page(page);
-       get_page(newpage);
+       attach_page_private(newpage, detach_page_private(page));
  
         bh = head;
         do {
@@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
  
         } while (bh != head);
  
-       SetPagePrivate(newpage);
-
         if (mode != MIGRATE_SYNC_NO_COPY)



[1]. 
https://lore.kernel.org/lkml/20200502004158.GD29705@bombadil.infradead.org/
[2]. 
https://lore.kernel.org/lkml/e4d5ddc0-877f-6499-f697-2b7c0ddbf386@cloud.ionos.com/

Thanks,
Guoqing

