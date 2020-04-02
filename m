Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4037019BAB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 05:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgDBDjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 23:39:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33362 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDBDjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:39:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so1127793pfc.0;
        Wed, 01 Apr 2020 20:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=deA2AJzh3bek5pKuAEwf37MExnIeixofNMpvV3Hvxac=;
        b=HPhWmAzxVHhFdsYkYtQa6ouNEae4/5PHmvzaEb1yeyp4UAx4jtWozTK8iIV1cx//fo
         Y+Ixx03dUkf8L6h18eLZ9ZingCJI8pCCi0xfVdBoDDpGUxsO5J7rqKcF/KlRMTJsX14U
         1mHNBcQ/7tEaUUXMEIoKcAfKlUBYl8x+zKJ5D4KJloz2rv8VVMfZLui+ULgHdiF0tF+C
         4YBSX+Va5uznAU0FPv74gonJmPgtb5ywOsaVRAMOa5O5DrS53zHokIJo2Ar8c2xcNgUn
         Vtp7naArUze6ImCTu2aie6SOX3KaetGWZrEuYhkmoC9WKB0T8nPr/zajBVDAu7vkR+gD
         CBbQ==
X-Gm-Message-State: AGi0PuZJMyu9mF+/eVnAVajl+eXeDixAVij2s4J3Kbe5wGSR2IjoE1qU
        7vSLfwiIEur+br2K8Dj/hwk=
X-Google-Smtp-Source: APiQypK26pnnoN47IlH6wbId76ykzfXSBHo/nHtn525FPlcTDmtGhlfoif0JhR4MxFnuOvxn7zfohA==
X-Received: by 2002:a62:1dd3:: with SMTP id d202mr1123969pfd.47.1585798792022;
        Wed, 01 Apr 2020 20:39:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d5ca:bbdc:67fa:c3da? ([2601:647:4000:d7:d5ca:bbdc:67fa:c3da])
        by smtp.gmail.com with ESMTPSA id a185sm2716969pfa.27.2020.04.01.20.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 20:39:50 -0700 (PDT)
Subject: Re: [RFC 3/3] block: avoid deferral of blk_release_queue() work
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-4-mcgrof@kernel.org>
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
Message-ID: <774a33e8-43ba-143f-f6fd-9cb0ae0862ac@acm.org>
Date:   Wed, 1 Apr 2020 20:39:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402000002.7442-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-01 17:00, Luis Chamberlain wrote:
> Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") moved
> the blk_release_queue() into a workqueue after a splat floated around
> with some work here which could sleep in blk_exit_rl().
> 
> On recent commit db6d9952356 ("block: remove request_list code") though
> Jens Axboe removed this code, now merged since v5.0. We no longer have
> to defer this work.
> 
> By doing this we also avoid failing to detach / attach a block
> device with a BLKTRACESETUP. This issue can be reproduced with
> break-blktrace [0] using:
> 
>   break-blktrace -c 10 -d -s
> 
> The kernel does not crash without this commit, it just fails to
> create the block device because the prior block device removal
> deferred work is pending. After this commit we can use the above
> flaky use of blktrace without an issue.
> 
> [0] https://github.com/mcgrof/break-blktrace
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/blk-sysfs.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 20f20b0fa0b9..f159b40899ee 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -862,8 +862,8 @@ static void blk_exit_queue(struct request_queue *q)
>  
>  
>  /**
> - * __blk_release_queue - release a request queue
> - * @work: pointer to the release_work member of the request queue to be released
> + * blk_release_queue - release a request queue
> + * @kojb: pointer to the kobj representing the request queue
>   *
>   * Description:
>   *     This function is called when a block device is being unregistered. The
> @@ -873,9 +873,10 @@ static void blk_exit_queue(struct request_queue *q)
>   *     of the request queue reaches zero, blk_release_queue is called to release
>   *     all allocated resources of the request queue.
>   */
> -static void __blk_release_queue(struct work_struct *work)
> +static void blk_release_queue(struct kobject *kobj)
>  {
> -	struct request_queue *q = container_of(work, typeof(*q), release_work);
> +	struct request_queue *q =
> +		container_of(kobj, struct request_queue, kobj);
>  
>  	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>  		blk_stat_remove_callback(q, q->poll_cb);
> @@ -905,15 +906,6 @@ static void __blk_release_queue(struct work_struct *work)
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>  }
>  
> -static void blk_release_queue(struct kobject *kobj)
> -{
> -	struct request_queue *q =
> -		container_of(kobj, struct request_queue, kobj);
> -
> -	INIT_WORK(&q->release_work, __blk_release_queue);
> -	schedule_work(&q->release_work);
> -}
> -
>  static const struct sysfs_ops queue_sysfs_ops = {
>  	.show	= queue_attr_show,
>  	.store	= queue_attr_store,

The description of this patch mentions a single blk_release_queue() call
that happened in the past from a context from which sleeping is not
allowed and from which sleeping is allowed today. Have all other
blk_release_queue() / blk_put_queue() calls been verified to see whether
none of these happens from a context from which sleeping is not allowed?

Thanks,

Bart.


