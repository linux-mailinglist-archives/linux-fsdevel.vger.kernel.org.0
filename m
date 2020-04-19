Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733041AFE78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 23:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDSVzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 17:55:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSVzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:55:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id r20so3970153pfh.9;
        Sun, 19 Apr 2020 14:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Br4qVD6vNcOTeGAPUTvXdaMBJRDE1FMGq+EEBulVyKA=;
        b=HvvLL0OcZZ1bO0VhqygCu2a/3agaSD8bIGaoA5TyCemvfAvwMCUOWEpKw0GwvpHoVF
         wVqxvbHAOA1o1YUJiBWHctCaanntEF8zi7PP9ohtah8I4MTGZZ/jRoW5QFl5AbdncZmo
         IYK/LA6ZWY7pV5Zw1rv69RopcPv3dTNobpM2Vw88Jqhs1GV/zLsJ5g3hkFXDGUL6JulW
         GvZ7YUO95/kD0GhEtORikQBld6wbQL69dcX+xFLczky0RVdz/QeR7bcd0FpYSzyCMo3u
         1SPUbHMo/Av9FJofP0O/dLZxPgbhHBTHBc3I0SeRytLeb3fOmTDZyQHuaQVH2zAXmRRx
         3dHQ==
X-Gm-Message-State: AGi0PuYibJc/+rGrYfXM8hKy+Ycu24G/ZOEFfXmFm66lb4Zh2dl/3yit
        qFOgBrx6NHB+tHalI4WuceU=
X-Google-Smtp-Source: APiQypILUJeV066/FeccQlF/yOmA6aYxTTF0zi1MK6KK770wqgS/jEy9+PKiMhVDohfqUAoAFP9Tjw==
X-Received: by 2002:aa7:8429:: with SMTP id q9mr13601282pfn.205.1587333345858;
        Sun, 19 Apr 2020 14:55:45 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.64])
        by smtp.gmail.com with ESMTPSA id 80sm24479420pgb.45.2020.04.19.14.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 14:55:44 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <91c82e6a-24ce-0b7d-e6e4-e8aa89f3fb79@acm.org>
Date:   Sun, 19 Apr 2020 14:55:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> +{
> +	struct dentry *dir = NULL;
> +
> +	/* This can happen if we have a bug in the lower layers */

What does "this" refer to? Which layers does "lower layers" refer to? 
Most software developers consider a module that calls directly into 
another module as a higher layer (callbacks through function pointers do 
not count; see also https://en.wikipedia.org/wiki/Modular_programming). 
According to that definition block drivers are a software layer 
immediately above the block layer core.

How about changing that comment into the following to make it 
unambiguous (if this is what you meant)?

	/*
	 * Check whether the debugfs directory already exists. This can
	 * only happen as the result of a bug in a block driver.
	 */

> +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> +	if (dir) {
> +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> +			kobject_name(q->kobj.parent));
> +		dput(dir);
> +		return -EALREADY;
> +	}
> +
> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> +					    blk_debugfs_root);
> +	if (!q->debugfs_dir)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

kobject_name(q->kobj.parent) is used three times in the above function. 
How about introducing a local variable that holds the result of that 
expression?

> +static bool blk_trace_target_disk(const char *target, const char *diskname)
> +{
> +	if (strlen(target) != strlen(diskname))
> +		return false;
> +
> +	if (!strncmp(target, diskname,
> +		     min_t(size_t, strlen(target), strlen(diskname))))
> +		return true;
> +
> +	return false;
> +}

The above code looks weird to me. When the second if-statement is 
reached, it is guaranteed that 'target' and 'diskname' have the same 
length. So why to calculate the minimum length in the second 
if-statement of two strings that have the same length?

Independent of what the purpose of the above code is, can that code be 
rewritten such that it does not depend on the details of how names are 
assigned to disks and partitions? Would disk_get_part() be useful here?

Thanks,

Bart.
