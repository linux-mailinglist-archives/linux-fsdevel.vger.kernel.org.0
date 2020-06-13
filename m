Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1A1F8071
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgFMCmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 22:42:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45727 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFMCmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:42:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id a127so5169576pfa.12;
        Fri, 12 Jun 2020 19:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8EIm1ytLyvfKq4wo51mDirXPq09qojINRyvoAwJXTTI=;
        b=MzoM6GBfqh57K/ipi8bcRDzNYnm+/FpauCSsWqWlJ+03jecH/PSKrMfbYAoYyaWA2P
         eJs9c2EVcqzVyozqywCUeWKeL8NDG3VgWN0XjU+V4alR8gEFE6EOjHBu/HMblXjEfczn
         fekJ1XJn7Fx42hoGdldf3gXA3mcs5H4fqu80Uu/7Fqj2eJrcqD+DEDhLrwSVBecvOMJa
         7VXAkTWgbnGdN9NMoq3RmCBm5+KVP5EgHN+Gh+lwdSv3Mcd0k603NhohO6NG+u5dtRJT
         XhXBA2rkjOOQq0JaSZVZmDcVWVTO0teUCTDEwNiA9nRLDxMMKyTv100ssxBKxkjqKHiF
         zUaA==
X-Gm-Message-State: AOAM531m6dav0yp2CxUvDhEHwzn9G6Q0ZMVsSNWRnii0t9HSO/EnqUs/
        wu/4wQLiE2ue+7z+EdyZGto=
X-Google-Smtp-Source: ABdhPJzRKqJooT/WNnq6D7zXsMVh6/yf0SqDijB0meAnmXfPO+ZbgvjuwwPi2qaSXvJkQ/oOjt7akA==
X-Received: by 2002:a65:6446:: with SMTP id s6mr13588266pgv.59.1592016134716;
        Fri, 12 Jun 2020 19:42:14 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id n1sm7763197pfd.156.2020.06.12.19.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 19:42:13 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <ec643803-2339-fe8d-7f58-b37871c83386@acm.org>
Date:   Fri, 12 Jun 2020 19:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608170127.20419-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-08 10:01, Luis Chamberlain wrote:
> +	/*
> +	 * Blktrace needs a debugfs name even for queues that don't register
> +	 * a gendisk, so it lazily registers the debugfs directory.  But that
> +	 * can get us into a situation where a SCSI device is found, with no
> +	 * driver for it (yet).  Then blktrace is used on the device, creating
> +	 * the debugfs directory, and only after that a driver is loaded. In
> +	 * that case we might already have a debugfs directory registered here.
> +	 * Even worse we could be racing with blktrace to register it.
> +	 */

There are LLD and ULD drivers in the SCSI subsystem. Please mention the
driver type explicitly. I assume that you are referring to SCSI ULDs
since only SCSI ULD drivers call device_add_disk()?

Could the above comment be made shorter by only mentioning that blktrace
may have been set up before or concurrently with device_add_disk() and
that device_add_disk() calls blk_register_queue()?

>  	case BLKTRACESETUP:
> +		if (!sdp->device->request_queue->sg_debugfs_dir)
> +			blk_sg_debugfs_init(sdp->device->request_queue,
> +					    sdp->disk->disk_name);

How about moving the sg_debugfs_dir check into blk_sg_debugfs_init()?

Thanks,

Bart.
