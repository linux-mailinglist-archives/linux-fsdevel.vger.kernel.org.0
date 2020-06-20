Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2707620259D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgFTRbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 13:31:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33383 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFTRbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:31:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id b201so6129437pfb.0;
        Sat, 20 Jun 2020 10:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=76DjZtVoVNTfIvPgHLxvbVvnnrURAKQR9OKC4ML66Vc=;
        b=NcMZn+Pzxwlz6Gc3cFevOO/D0qwfi7VTEkb0FG7Epa3QXMhJgsnU9SwDHmSF8BPEMI
         WlkH0zPM1wJSlu6mFBuhk86denc+CsLLE5aKvguWZRE8RJRL45a3qdvecpTRufU2mBFW
         66IxZW3dAxmGlUg3YKRHrp4VxhqsY9Bg/kKHoQZ/wTvJfd3P4EDICFMV43nAE1Ud7kG/
         TR4AaqEU19zBeJU4d9futNbyEHsjIQpu5pNVM06fmqKxjC7P5o59bg7OTrkQx7RiQbZ8
         F+vErMFePskpJIJhNfL+Ht9FnjD24vqUUG5P93YRMRcFH12g1aZjrBetNgxn+3Sr15bV
         qn9g==
X-Gm-Message-State: AOAM530vdv7tao7928QS4lfW93Wy3exu4Ua44WtN3X7j3aA2eQR9snQk
        DW9dCaskM2PYdIVAoVElAg0=
X-Google-Smtp-Source: ABdhPJx4WJJeoAZd88UMGoNU0tCyJbSMTb2c+Eg/pyZk/Y8Gvd8ak7lYZIWZRWF80NIVktK7gkeuqA==
X-Received: by 2002:a05:6a00:22c2:: with SMTP id f2mr13824607pfj.187.1592674314328;
        Sat, 20 Jun 2020 10:31:54 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z11sm9592511pfk.141.2020.06.20.10.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 10:31:53 -0700 (PDT)
Subject: Re: [PATCH v7 6/8] blktrace: fix debugfs use after free
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
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-7-mcgrof@kernel.org>
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
Message-ID: <75c3a94d-dcd1-05e4-47c6-db65f074136a@acm.org>
Date:   Sat, 20 Jun 2020 10:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619204730.26124-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-19 13:47, Luis Chamberlain wrote:
> This goes tested with:
       ^^^^
       got?

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 7ff2ea5cd05e..e6e2d25fdbd6 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,10 +524,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!bt->msg_data)
>  		goto err;
>  
> -	ret = -ENOENT;
> -
> -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> -	if (!dir)
> +#ifdef CONFIG_BLK_DEBUG_FS
> +	/*
> +	 * When tracing whole make_request drivers (multiqueue) block devices,
> +	 * reuse the existing debugfs directory created by the block layer on
> +	 * init. For request-based block devices, all partitions block devices,
                                                  ^^^^^^^^^^^^^^^^^^^^^
It seems like a word is missing from the comment? Or did you perhaps
want to refer to "all partition block devices"?

> +	 * and scsi-generic block devices we create a temporary new debugfs
> +	 * directory that will be removed once the trace ends.
> +	 */
> +	if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)
> +		dir = q->debugfs_dir;
> +	else
> +#endif
>  		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);

Can it happen that two different threads each try to set up block
tracing and hence that debugfs_create_dir() fails because a directory
with name buts->name already exists?

>  	bt->dev = dev;
> @@ -565,8 +573,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  
>  	ret = 0;
>  err:
> -	if (dir && !bt->dir)
> -		dput(dir);
>  	if (ret)
>  		blk_trace_free(bt);
>  	return ret;

Shouldn't bt->dir be removed in this error path for make_request drivers?

Thanks,

Bart.

