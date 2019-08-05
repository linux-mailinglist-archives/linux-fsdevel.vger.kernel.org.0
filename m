Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED36981874
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfHELxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 07:53:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50527 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHELxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:53:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so74454595wml.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSEFUn+zJ9lWrXGkPUtwAP7Ktu03TxUAHzcVzGIcTF0=;
        b=N05j3MmRLF3evphEMwVzucDNXsLRSnsdv/awwci4zbq7QIwOPLXt3iLd8b84PDqisL
         vGx6wOrcjxl/hiLos9rciSZUlE8VtI22BMPNNFJHtPJNjEGc0URlZehBtAiYWUeczkEb
         5SVBzEDDBjhKEqUks05aXyq8xGo2ZCFxaI3GxwnQ5CutZb5qgSeReOK3nf709SYWTrZT
         QTiW3O8ziZO/IwRbQH/BCboe8UXAklCCpxtkMrOO7aVFgjGOTzwvw9zDmrNEm1maPkDb
         cQYRE+dy9ZBBN0Vi/du972H1Gd17LWkrP7lifgiAiRJhgtr4Ycoko68GbHEvJIXMjVVg
         dDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSEFUn+zJ9lWrXGkPUtwAP7Ktu03TxUAHzcVzGIcTF0=;
        b=Em15xBghvG3CsfkFEWEKhHS0qSHf9qKTZ0KYRgk5duc6nCXCp6wA4cqZTBRvJX6YIi
         mPyyuuu9uEexHMN7BR1Zb+ud9TtfaAVu/xNqrRGuOD0Km6/uPQAaS2dahm7YzuZpeFhW
         FZVeq3oNlf7iNhMCkG2hETLmIgvjpEnA4x4wWjHEWUj5dY6TTVkillKSCU4uP0LE4VYy
         kglqK+Ldw48j6MztXYAMWiUQsrodRusvUAR85+UN95YVRgSKpvI7kiyxZv7WwXuW+Uzv
         SmCWHP189Xi7oM+Js6UP/mPPc/SSav3b8eKTIf9AIaGzl6mPRMCL4SXbA43Da5sFtxiE
         ywYg==
X-Gm-Message-State: APjAAAXmv+CoiJwVZnAEPgZu1LPFvcpQxqr7wyTKjBLpo7d4iAMFRgjj
        646l0JjoWmhneUPGoWyOUiU=
X-Google-Smtp-Source: APXvYqyvzCWiLH3t21ivmky+8PUjC3EOje361Mf4BrdFecAEPyzS4GIztLve62J5vTzwG6RhWUUwbQ==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr18031002wmi.146.1565005992115;
        Mon, 05 Aug 2019 04:53:12 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id x24sm79925372wmh.5.2019.08.05.04.53.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:53:11 -0700 (PDT)
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
To:     Dan Williams <dan.j.williams@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs@redhat.com
References: <20190802192956.GA3032@redhat.com>
 <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
Date:   Mon, 5 Aug 2019 14:53:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/08/2019 22:37, Dan Williams wrote:
> On Fri, Aug 2, 2019 at 12:30 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>> As of now dax_layout_busy_page() calls unmap_mapping_range() with last
>> argument as 1, which says even unmap cow pages. I am wondering who needs
>> to get rid of cow pages as well.
>>
>> I noticed one interesting side affect of this. I mount xfs with -o dax and
>> mmaped a file with MAP_PRIVATE and wrote some data to a page which created
>> cow page. Then I called fallocate() on that file to zero a page of file.
>> fallocate() called dax_layout_busy_page() which unmapped cow pages as well
>> and then I tried to read back the data I wrote and what I get is old
>> data from persistent memory. I lost the data I had written. This
>> read basically resulted in new fault and read back the data from
>> persistent memory.
>>
>> This sounds wrong. Are there any users which need to unmap cow pages
>> as well? If not, I am proposing changing it to not unmap cow pages.
>>
>> I noticed this while while writing virtio_fs code where when I tried
>> to reclaim a memory range and that corrupted the executable and I
>> was running from virtio-fs and program got segment violation.
>>
>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>> ---
>>  fs/dax.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: rhvgoyal-linux/fs/dax.c
>> ===================================================================
>> --- rhvgoyal-linux.orig/fs/dax.c        2019-08-01 17:03:10.574675652 -0400
>> +++ rhvgoyal-linux/fs/dax.c     2019-08-02 14:32:28.809639116 -0400
>> @@ -600,7 +600,7 @@ struct page *dax_layout_busy_page(struct
>>          * guaranteed to either see new references or prevent new
>>          * references from being established.
>>          */
>> -       unmap_mapping_range(mapping, 0, 0, 1);
>> +       unmap_mapping_range(mapping, 0, 0, 0);
> 
> Good find, yes, this looks correct to me and should also go to -stable.
> 

Please pay attention that unmap_mapping_range(mapping, ..., 1) is for the truncate case and friends

So as I understand the man page:
fallocate(FL_PUNCH_HOLE); means user is asking to get rid also of COW pages.
On the other way fallocate(FL_ZERO_RANGE) only the pmem portion is zeroed and COW (private pages) stays

Just saying I have not followed the above code path
(We should have an xfstest for this?)

Cheers
Boaz
