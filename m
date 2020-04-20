Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440DD1AFF3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDTAjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:39:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45296 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTAjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:39:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id w65so4103726pfc.12;
        Sun, 19 Apr 2020 17:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdNUMRhAVT84vFSs1IwKOQ/o9/+SJlOoUnD+T6ObXFw=;
        b=Opd+szIrno7soOEOD9g+QhGvdk3V90KnqV1MVzEg7K15AI7nMC64gXLHzOEBzxfkzK
         RnU/YHz7+Kqe0AGE6KG2uyQ5sdzyk3e/h8uSTckjw3mVW1R/Hcm2HvnBsw+WuXXjTO08
         am+XY5c4RjL8PMbUR5BnmAZYH9GCF7UIiDjrKPNrLYTQQkXhqxygUGuGHlD7tbBbPOhM
         nCbC5IhaYTfHGzoykaoMqFDWml7bbAX72sVFeQjNqZJkckg81bCJjMGVCUbrLWocC9L0
         CgUojLi9cW7r1L2SQaI6dYGWJ36QQhVMPErQIgeEMjttzU/MOjht7KZOcPd+z5BNRNfm
         /duA==
X-Gm-Message-State: AGi0Pubcc5TF7MeCZ7/OpvumR+2depahzyv5JI2EinzlrERotWAE53Iw
        G/btE6D8Rr3KHBlsd2zMN0c=
X-Google-Smtp-Source: APiQypLemCyE2sMdLPxxbXHy9KKBQYlkJRmRqQNH4pz9gt0gi1ZgK7eNY69ge+gaay8LMO3NTcrlEA==
X-Received: by 2002:a63:7416:: with SMTP id p22mr13833579pgc.140.1587343142909;
        Sun, 19 Apr 2020 17:39:02 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.66])
        by smtp.gmail.com with ESMTPSA id j5sm12271672pjb.36.2020.04.19.17.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:39:01 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <91c82e6a-24ce-0b7d-e6e4-e8aa89f3fb79@acm.org>
 <20200420000436.GI11244@42.do-not-panic.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b77a39c1-6010-24a4-0815-2f26664b6208@acm.org>
Date:   Sun, 19 Apr 2020 17:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420000436.GI11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 5:04 PM, Luis Chamberlain wrote:
> On Sun, Apr 19, 2020 at 02:55:42PM -0700, Bart Van Assche wrote:
>> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
>>> +int __must_check blk_queue_debugfs_register(struct request_queue *q)
>>> +{
>>> +	struct dentry *dir = NULL;
>>> +
>>> +	/* This can happen if we have a bug in the lower layers */
>>
>> What does "this" refer to? Which layers does "lower layers" refer to? Most
>> software developers consider a module that calls directly into another
>> module as a higher layer (callbacks through function pointers do not count;
>> see also https://en.wikipedia.org/wiki/Modular_programming). According to
>> that definition block drivers are a software layer immediately above the
>> block layer core.
>>
>> How about changing that comment into the following to make it unambiguous
>> (if this is what you meant)?
>>
>> 	/*
>> 	 * Check whether the debugfs directory already exists. This can
>> 	 * only happen as the result of a bug in a block driver.
>> 	 */
> 
> But I didn't mean on a block driver. I meant the block core. In our
> case, the async request_queue removal is an example. There is nothing
> that block drivers could have done to help much with that.
> 
> I could just change "lower layers" to "block layer" ?

That sounds good to me.

>> Independent of what the purpose of the above code is, can that code be
>> rewritten such that it does not depend on the details of how names are
>> assigned to disks and partitions? Would disk_get_part() be useful here?
> 
> I did try, but couldn't figure out a way. I'll keep looking but likewise
> let me know if you find a way.

How about making blk_trace_setup() pass the result of the following 
expression as an additional argument to blk_trace_setup():

	bdev != bdev->bd_contains

I think that is a widely used approach to verify after a block device 
has been opened whether or not 'bdev' refers to a partition (bdev != 
bdev->bd_contains means that 'bdev' represents a partition).

Thanks,

Bart.
