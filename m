Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF54A90DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 23:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355890AbiBCWuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 17:50:01 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36722 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiBCWuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:50:00 -0500
Received: by mail-pg1-f180.google.com with SMTP id h125so3506658pgc.3;
        Thu, 03 Feb 2022 14:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxtKotbKYVVDliBEkS/8NGZxxXzsaCF/Ghrn8g2asII=;
        b=LIIPVp0HL8qiKEreu3/+nk642YQe6WGAc9utl7oIW3tRE8j/olOD0PUdoHZMrEtKjc
         TiMttlExwij87RhkRkisLxjSZSNf/NFcEkwOLXXRSjKqPdcDLBGdGNhAcju/DdEaVK5Z
         r0EqWCHpB+ZfQM0CQJH1KJu59B+M4xWmS6dTX8E3K1ofY3uX0VBFWRQLHCHeILBkUHDb
         C1Dye9evBJ80xxNMp7f4THh9bAfsUyuyu36zX1CRXO+JdOZ6fLx0k8Q2vnQo58CXnSD7
         Gq5F01muUosFoeKB/oHLKQvy+RvV21GFlx8Qxz1sA1jxgjQvsls9UBLVgrudCnHXtkFt
         CbtQ==
X-Gm-Message-State: AOAM533G1JdQ5yQrRVyIREcEWDpIiKbUcuEQbz7u4jnaavpYE0FsS3Ve
        Mju7voYEhl3Fw57xL/KPjBM=
X-Google-Smtp-Source: ABdhPJxbVDWLXFrYyts1WDQEZT5xMfsQOnoKDmtKT7LXmg2Sy357f0iLUMQzn3wbo7lsO987Ifcecw==
X-Received: by 2002:a63:91c3:: with SMTP id l186mr225003pge.558.1643928600285;
        Thu, 03 Feb 2022 14:50:00 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h11sm48342pfe.214.2022.02.03.14.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 14:49:59 -0800 (PST)
Message-ID: <a2ec9086-72d2-4a4e-c4fa-fe53bf5ba092@acm.org>
Date:   Thu, 3 Feb 2022 14:49:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
 <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/22 10:50, Mikulas Patocka wrote:
> On Tue, 1 Feb 2022, Bart Van Assche wrote:
>> On 2/1/22 10:32, Mikulas Patocka wrote:
>>>    /**
>>> + * blk_queue_max_copy_sectors - set maximum copy offload sectors for the
>>> queue
>>> + * @q:  the request queue for the device
>>> + * @size:  the maximum copy offload sectors
>>> + */
>>> +void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size)
>>> +{
>>> +	q->limits.max_copy_sectors = size;
>>> +}
>>> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
>>
>> Please either change the unit of 'size' into bytes or change its type into
>> sector_t.
> 
> blk_queue_chunk_sectors, blk_queue_max_discard_sectors,
> blk_queue_max_write_same_sectors, blk_queue_max_write_zeroes_sectors,
> blk_queue_max_zone_append_sectors also have the unit of sectors and the
> argument is "unsigned int". Should blk_queue_max_copy_sectors be
> different?

As far as I know using the type sector_t for variables that represent a 
number of sectors is a widely followed convention:

$ git grep -w sector_t | wc -l
2575

I would appreciate it if that convention would be used consistently, 
even if that means modifying existing code.

Thanks,

Bart.
