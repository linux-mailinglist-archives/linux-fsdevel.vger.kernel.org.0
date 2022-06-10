Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C9546BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiFJRrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbiFJRrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:47:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364756220;
        Fri, 10 Jun 2022 10:47:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id p63so3226923qkd.10;
        Fri, 10 Jun 2022 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YAz+bZr/g5TFMIU51PB2AOx+4yCjcc3R/7cvGuIRiyo=;
        b=hqc887XUGL/83QS0tEfjOQ0/iBXuc7oDz8bl+SwNjlGXZf7i+yLGFlXB89q/8O8dDn
         fgplske5d/lSDl8EtLJzmfPjLw8iV4RkYxsUJRBwU+CAvmpzkMFFDOlVYIj2Pf7FNCvI
         OP9kzaZ3x1+T9/V6XaX3pXB8qvsTkE/hsIteiTJky1X5CJxGDnuB5iA7KMmLzTx3CxJ5
         EfIRem8pbrvbwtdz+xZ6/avuhXvgyI5jvOJMkjFBuyHPqh6LDMbZVP1EovCbnDhMGm+y
         uM3GqGPl33oVQVtYr/Im9sFcDxvdPLaDGUX72iq3uiTCI+f01BemCZJ+WQYokFKdi7Wu
         IatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YAz+bZr/g5TFMIU51PB2AOx+4yCjcc3R/7cvGuIRiyo=;
        b=FW9mPrDLetNRI0z5HItoLL6NX1PAVNdpSIj0Fv6qviLWJCoxGYqp1tJJcr53TMRAFk
         p31COZmgeDRX+MQYb7R33OaLqUM976FhjCrhMG+opAnDOYdzIT+2Pku7NF9XykGcJLmq
         9a/r8OOmMXnetagv9u5W0YJIGhl4UuV0WyLhOtVbwuPxbuLQHpengw9g1wvorA+HGShu
         X0H2VZET0UoL8tS5J2ktFPx6RKYTPW0l83iQ4WYJewcQ8EWHwYk70+TJ+ERSy7sxl+0Q
         qbdvvYZ2V7RtRXXzDg6upBJWtGSnW+in2iMJ8wFXkDPcd9T3l9e6FtV/sUPVDm/IiLH5
         K++g==
X-Gm-Message-State: AOAM531z+urWO2Uovj4/FRiYbgJI60IO0XncoyyyUBnewFD+8c5soBW7
        /KzAJFMBn1thi7apK8ag+w==
X-Google-Smtp-Source: ABdhPJz7p+kepbcy956nMSgnmWWAmGzWLG9BfQ9DnHVidVR4QUb9A9T7+i9f2PROtx7QrKzhyumYNQ==
X-Received: by 2002:a37:a781:0:b0:6a6:a8f5:d111 with SMTP id q123-20020a37a781000000b006a6a8f5d111mr24277439qke.676.1654883223907;
        Fri, 10 Jun 2022 10:47:03 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bz24-20020a05622a1e9800b0030522a969e0sm61264qtb.60.2022.06.10.10.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 10:47:03 -0700 (PDT)
Message-ID: <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
Date:   Fri, 10 Jun 2022 13:47:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Yu Kuai <yukuai3@huawei.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <YqNW8cYn9gM7Txg6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 10:36, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 03:34:11PM +0100, Matthew Wilcox wrote:
>> On Mon, Jun 06, 2022 at 09:10:03AM +0800, Yu Kuai wrote:
>>> On 2022/06/03 2:30, Matthew Wilcox wrote:
>>>> On Thu, Jun 02, 2022 at 04:21:29PM +0800, Yu Kuai wrote:
>>>>> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
>>>>> while it should be 'iocb->ki_ops'.
>>>>
>>>> Can you walk me through your reasoning which leads you to believe that
>>>> it should be ki_pos instead of ki_pos + copied?  As I understand it,
>>>> prev_pos is the end of the previous read, not the beginning of the
>>>> previous read.
>>>
>>> Hi, Matthew
>>>
>>> The main reason is the following judgement in flemap_read():
>>>
>>> if (iocb->ki_pos >> PAGE_SHIFT !=	-> current page
>>>      ra->prev_pos >> PAGE_SHIFT)		-> previous page
>>>          folio_mark_accessed(fbatch.folios[0]);
>>>
>>> Which means if current page is the same as previous page, don't mark
>>> page accessed. However, prev_pos is set to 'ki_pos + copied' during last
>>> read, which will cause 'prev_pos >> PAGE_SHIFT' to be current page
>>> instead of previous page.
>>>
>>> I was thinking that if prev_pos is set to the begining of the previous
>>> read, 'prev_pos >> PAGE_SHIFT' will be previous page as expected. Set to
>>> the end of previous read is ok, however, I think the caculation of
>>> previous page should be '(prev_pos - 1) >> PAGE_SHIFT' instead.
>>
>> OK, I think Kent broke this in 723ef24b9b37 ("mm/filemap/c: break
>> generic_file_buffered_read up into multiple functions").  Before:
>>
>> -       prev_index = ra->prev_pos >> PAGE_SHIFT;
>> -       prev_offset = ra->prev_pos & (PAGE_SIZE-1);
>> ...
>> -               if (prev_index != index || offset != prev_offset)
>> -                       mark_page_accessed(page);
>>
>> After:
>> +       if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
>> +               mark_page_accessed(page);
>>
>> So surely this should have been:
>>
>> +       if (iocb->ki_pos != ra->prev_pos)
>> +               mark_page_accessed(page);
>>
>> Kent, do you recall why you changed it the way you did?
> 
> Oh, and if this is the right diagnosis, then this is the fix for the
> current tree:
> 
> +++ b/mm/filemap.c
> @@ -2673,8 +2673,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>                   * When a sequential read accesses a page several times, only
>                   * mark it as accessed the first time.
>                   */
> -               if (iocb->ki_pos >> PAGE_SHIFT !=
> -                   ra->prev_pos >> PAGE_SHIFT)
> +               if (iocb->ki_pos != ra->prev_pos)
>                          folio_mark_accessed(fbatch.folios[0]);
> 
>                  for (i = 0; i < folio_batch_count(&fbatch); i++) {
> 
> 

I think this is the fix we want - I think Yu basically had the right 
idea and had the off by one fix, this should be clearer though:

Yu, can you confirm the fix?

-- >8 --
Subject: [PATCH] filemap: Fix off by one error when marking folios accessed

In filemap_read() we mark pages accessed as we read them - but we don't
want to do so redundantly, if the previous read already did so.

But there was an off by one error: we want to check if the current page
was the same as the last page we read from, but the last page we read
from was (ra->prev_pos - 1) >> PAGE_SHIFT.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

diff --git a/mm/filemap.c b/mm/filemap.c
index 9daeaab360..8d5c8043cb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2704,7 +2704,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct 
iov_iter *iter,
                  * mark it as accessed the first time.
                  */
                 if (iocb->ki_pos >> PAGE_SHIFT !=
-                   ra->prev_pos >> PAGE_SHIFT)
+                   (ra->prev_pos - 1) >> PAGE_SHIFT)
                         folio_mark_accessed(fbatch.folios[0]);

                 for (i = 0; i < folio_batch_count(&fbatch); i++) {
