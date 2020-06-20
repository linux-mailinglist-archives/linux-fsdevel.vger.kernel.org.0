Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6520258D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgFTRLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 13:11:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTRLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:11:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id u128so6013153pgu.13;
        Sat, 20 Jun 2020 10:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=51wJr1PqOu83VYK7gxbc2LDTmylRFibUjG3LddkuvYg=;
        b=uODcVYWh1RNYXpnAk/s01Hur/lZAHc4cMOY1TBHpAB6RDZaJ32xusd4cmFn6HZPFgv
         YpZSZ/f7jw7walKZrBQFTr9yihO4OGIh8ve3CdaXjGv/fGza7ws+2ZCrcJyk09nLAHsl
         tOcAFSWhKydDxHmwMzFXr9JKSrK3PSEwvZmm82vK54UaBf3MIeZSAYQ/4QxYxKizl9pK
         I3I0dBBvclztsDEssju6VwlbtATplVb4Dh48mH6lxXrniFtbYK7988Bv6DVuLaHCavIO
         5OvT8U1EYBfrvtT3QEcNT0sBHvnfWq0UylEVFu4zS/YAvYL43b8Qg3t7zgSuz+nb4MAk
         DMIQ==
X-Gm-Message-State: AOAM532XeceN/faI8ZODBG6PzNZt9BVIJX9GdEYBBEggBtiFg8irZ/nX
        sTBsrAHYt1yqsWXkw+4j5eQ=
X-Google-Smtp-Source: ABdhPJxaDf9FepE6EM0QhaljOL11cCKrZwhA42hmUbceUqr3hjsRc1lUgz7jYaEsP2tsVmnvUWsHaA==
X-Received: by 2002:a62:196:: with SMTP id 144mr13044800pfb.316.1592673109068;
        Sat, 20 Jun 2020 10:11:49 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x126sm9348519pfc.36.2020.06.20.10.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 10:11:48 -0700 (PDT)
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
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
Message-ID: <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
Date:   Sat, 20 Jun 2020 10:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619204730.26124-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-19 13:47, Luis Chamberlain wrote:
> Be pedantic on removal as well and hold the mutex.
> This should prevent uses of addition while we exit.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c33bbbfd1bd9..d55e1b52f076 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2402,6 +2402,8 @@ static void __exit loop_exit(void)
>  
>  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
>  
> +	mutex_lock(&loop_ctl_mutex);
> +
>  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
>  	idr_destroy(&loop_index_idr);
>  
> @@ -2409,6 +2411,8 @@ static void __exit loop_exit(void)
>  	unregister_blkdev(LOOP_MAJOR, "loop");
>  
>  	misc_deregister(&loop_misc);
> +
> +	mutex_unlock(&loop_ctl_mutex);
>  }
>  
>  module_init(loop_init);

Is try_module_get(fops->owner) called before a loop device is opened and
is module_put(fops->owner) called after a loop device is closed? Does
that mean that it is impossible to unload the loop driver while a loop
device is open? Does that mean that the above patch is not necessary or
did I perhaps miss something?

Thanks,

Bart.

