Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8819E8F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 05:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEDjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 23:39:52 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37079 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDEDjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:39:52 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so4925299pjj.2;
        Sat, 04 Apr 2020 20:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ereDF8FGoaOdArxxw03gJ2soJTiibGzd15XhK62QHfI=;
        b=M4FJ3295tQD2F+A/wLM8yVX03ySF9G4O3E/65pZAnvk2aNUWKfsCqOEYSPT3uQCj8B
         +EvbskF86UKuv4AMZ8P1+6D3KNj4bZrnKfkdd278dXN6POB3mAEWfxu/wyJ73O1HNDNp
         PBvUI6k+PKGM+9/O1YZaUxbczg+ni2z5ZOFgtG973fa+3MqtwFTL5kwQ6ZP8ScDeIiWn
         /4Rc/IWfyyGUok/nF9v2DKBQ3V8l6tqlutmjEwwxUABqWhMaGfeEbSm0IwIjno9+O1/w
         q1LCdIXO69+R4tdmARy/yRAcnDy1zuvHeZ1CtE5x7eZ1JEwAeBAnGtoLLbn+CUJRMBo0
         1Cfw==
X-Gm-Message-State: AGi0PubScyQURT/uhnK3a8rseUqDkXDlE4ozxcy+lsAbQ/yceH0t9tvd
        YE8MN5yxO3/LRtu2QZ50A6U=
X-Google-Smtp-Source: APiQypIlhAC5+tCSUz3NsAmxOxfbEh/nWPl6r2rsCE6epnhDERfi9fJSuoS9ddgztKaYvRRI6TdoXg==
X-Received: by 2002:a17:902:9003:: with SMTP id a3mr14409998plp.331.1586057990237;
        Sat, 04 Apr 2020 20:39:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id u3sm8847114pfb.36.2020.04.04.20.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 20:39:49 -0700 (PDT)
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
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
Message-ID: <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
Date:   Sat, 4 Apr 2020 20:39:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402000002.7442-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-01 17:00, Luis Chamberlain wrote:
> korg#205713 then was used to create CVE-2019-19770 and claims that
> the bug is in a use-after-free in the debugfs core code. The
> implications of this being a generic UAF on debugfs would be
> much more severe, as it would imply parent dentries can sometimes
> not be possitive, which is something claim is not possible.
         ^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         positive?  is there perhaps a word missing here?

> It turns out that the issue actually is a mis-use of debugfs for
> the multiqueue case, and the fragile nature of how we free the
> directory used to keep track of blktrace debugfs files. Omar's
> commit assumed the parent directory would be kept with
> debugfs_lookup() but this is not the case, only the dentry is
> kept around. We also special-case a solution for multiqueue
> given that for multiqueue code we always instantiate the debugfs
> directory for the request queue. We were leaving it only to chance,
> if someone happens to use blktrace, on single queue block devices
> for the respective debugfs directory be created.

Since the legacy block layer is gone, the above explanation may have to
be rephrased.

> We can fix the UAF by simply using a debugfs directory which is
> always created for singlequeue and multiqueue block devices. This
> simplifies the code considerably, with the only penalty now being
> that we're always creating the request queue directory debugfs
> directory for the block device on singlequeue block devices.

Same comment here - the legacy block layer is gone. I think that today
all block drivers are either request-based and multiqueue or so-called
make_request drivers. See also the output of git grep -nHw
blk_alloc_queue for examples of the latter category.

> This patch then also contends the severity of CVE-2019-19770 as
> this issue is only possible using root to shoot yourself in the
> foot by also misuing blktrace.
               ^^^^^^^
               misusing?

> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b3f2ba483992..bda9378eab90 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -823,9 +823,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
>  
> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> -					    blk_debugfs_root);
> -
>  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>  
>  	/*

[ ... ]

>  static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index fca9b158f4a0..20f20b0fa0b9 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -895,6 +895,7 @@ static void __blk_release_queue(struct work_struct *work)
>  
>  	blk_trace_shutdown(q);
>  
> +	blk_q_debugfs_unregister(q);
>  	if (queue_is_mq(q))
>  		blk_mq_debugfs_unregister(q);

Does this patch change the behavior of the block layer from only
registering a debugfs directory for request-based block devices to
registering a debugfs directory for request-based and make_request based
block devices? Is that behavior change an intended behavior change?

Thanks,

Bart.
