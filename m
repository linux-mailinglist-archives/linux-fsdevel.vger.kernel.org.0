Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01B91C2433
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEBI44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726745AbgEBI4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 04:56:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F3C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2020 01:56:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so4291777wrt.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2020 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cWUrhtBOQPhFHdJtWzGRrwgjHQevNUoIVdoMuVU6lG4=;
        b=Oi3p35hRAPZ/9x5okgKKF+rzEJ0k4NVnQcL5o8zVWmyvFff1FH0nLxq+PilKhUSVAx
         TabSMKGYuKHPDwIUIFDQ6mpIXOO33K8MRbuShb1KqPnI/7YGIgfCgYMEbA8Bv6dR+N/C
         Lz3cTZTnKGuEKc82beI/8hMgAhOquzUTGlekS6a6yf1+rmesrR3Yl2JZYac2/NQwqMcy
         f63eLL5rFio6Y+OwlbJuJCRzBFTJxEkSlw1cqwWh11nbH6g+E0L7hdcaIDlJ07KWgNkK
         lHeLeiS0/q5JJ9iE/6W0qdtdZ4FGtYuVbiaY6sbeNxLgwO1YD1LMbu6u8kjlxVzRLStb
         IoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cWUrhtBOQPhFHdJtWzGRrwgjHQevNUoIVdoMuVU6lG4=;
        b=QbeN/hCeeVOFX2ztuimALeQ2pDJ8l3Fr+4kJf3G1fr1UNEYECI3ljweuE7Lm5nxaBF
         ss5MOo5JfqzH9Ngtvy/msaZegc7x6IkOjocGfz6fbKe5hGlXbEQwSju5IgvQFSAxYKWi
         l92Zu+Z95v0jQyF0bBIJuU3cMXmIY+D911pqkJOZEB1U1el16qXKTUKgB/MFVtCOvXcJ
         JJ2UNpz/ioZ8JcpDllxm+x9OBxZmWAhLWWe2VCKYyTbKupVo4/XnNswxC7kB37Itzag4
         UZhvaVF0kKftn2TLPEeEg0Rlj0uFCD9Z+2weUmplu+KmKG87/+eSKdHe1/Ytgfd9mVuo
         BNOA==
X-Gm-Message-State: AGi0PuZzrR2eutsDq8bJn+YSbx2cDJ77PiVrdYve3JvgjZ0Z4TNor49C
        5xYo2N1XH4qb6CdLPA9VwDVnMw==
X-Google-Smtp-Source: APiQypKDMZLDoMmUhch880vqn0lUpntebEsdFyCBeYqF2KDIZoyMBsFUe0BxMB4juMNuVtJhvB8ibA==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr8082018wrx.62.1588409813753;
        Sat, 02 May 2020 01:56:53 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48f0:a800:e80e:f5df:f780:7d57? ([2001:16b8:48f0:a800:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id 91sm762421wrj.57.2020.05.02.01.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 01:56:52 -0700 (PDT)
Subject: Re: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to cleanup
 code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cl@linux.com, mike.kravetz@oracle.com
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200501221626.GC29705@bombadil.infradead.org>
 <889f9f82-64ba-50b3-147b-459303617aeb@cloud.ionos.com>
 <20200502004158.GD29705@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e4d5ddc0-877f-6499-f697-2b7c0ddbf386@cloud.ionos.com>
Date:   Sat, 2 May 2020 10:56:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502004158.GD29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/20 2:41 AM, Matthew Wilcox wrote:
> On Sat, May 02, 2020 at 12:42:15AM +0200, Guoqing Jiang wrote:
>> On 5/2/20 12:16 AM, Matthew Wilcox wrote:
>>> On Thu, Apr 30, 2020 at 11:44:41PM +0200, Guoqing Jiang wrote:
>>>>     include/linux/pagemap.h: introduce attach/clear_page_private
>>>>     md: remove __clear_page_buffers and use attach/clear_page_private
>>>>     btrfs: use attach/clear_page_private
>>>>     fs/buffer.c: use attach/clear_page_private
>>>>     f2fs: use attach/clear_page_private
>>>>     iomap: use attach/clear_page_private
>>>>     ntfs: replace attach_page_buffers with attach_page_private
>>>>     orangefs: use attach/clear_page_private
>>>>     buffer_head.h: remove attach_page_buffers
>>> I think mm/migrate.c could also use this:
>>>
>>>           ClearPagePrivate(page);
>>>           set_page_private(newpage, page_private(page));
>>>           set_page_private(page, 0);
>>>           put_page(page);
>>>           get_page(newpage);
>>>
>> Thanks for checking!  Assume the below change is appropriate.
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 7160c1556f79..f214adfb3fa4 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct address_space
>> *mapping,
>>          if (rc != MIGRATEPAGE_SUCCESS)
>>                  goto unlock_buffers;
>>
>> -       ClearPagePrivate(page);
>> -       set_page_private(newpage, page_private(page));
>> -       set_page_private(page, 0);
>> -       put_page(page);
>> +       set_page_private(newpage, detach_page_private(page));
>>          get_page(newpage);
> I think you can do:
>
> @@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>          if (rc != MIGRATEPAGE_SUCCESS)
>                  goto unlock_buffers;
>   
> -       ClearPagePrivate(page);
> -       set_page_private(newpage, page_private(page));
> -       set_page_private(page, 0);
> -       put_page(page);
> -       get_page(newpage);
> +       attach_page_private(newpage, detach_page_private(page));
>   
>          bh = head;
>          do {
> @@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
>   
>          } while (bh != head);
>   
> -       SetPagePrivate(newpage);
> -
>          if (mode != MIGRATE_SYNC_NO_COPY)
>
> ... but maybe there's a subtlety to the ordering of the setup of the bh
> and setting PagePrivate that means what you have there is a better patch.

Yes, it is better but not sure if the order can be changed here. And seems
the original commit is this one.

commit e965f9630c651fa4249039fd4b80c9392d07a856
Author: Christoph Lameter <clameter@sgi.com>
Date:   Wed Feb 1 03:05:41 2006 -0800

     [PATCH] Direct Migration V9: Avoid writeback / page_migrate() method

     Migrate a page with buffers without requiring writeback

     This introduces a new address space operation migratepage() that 
may be used
     by a filesystem to implement its own version of page migration.

     A version is provided that migrates buffers attached to pages. Some
     filesystems (ext2, ext3, xfs) are modified to utilize this feature.

     The swapper address space operation are modified so that a regular
     migrate_page() will occur for anonymous pages without writeback 
(migrate_pages
     forces every anonymous page to have a swap entry).

Hope mm experts could take a look, so CC more people and mm list. And
the question is that if we can setting PagePrivate before setup bh in the
__buffer_migrate_page, thanks for your any further input.

Thanks,
Guoqing
