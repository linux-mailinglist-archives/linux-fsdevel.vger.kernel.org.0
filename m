Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52D81E52C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE1BPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 21:15:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38196 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE1BPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 21:15:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id q8so12670456pfu.5;
        Wed, 27 May 2020 18:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zEJC/keMYsw/lXDxPakt60ru3sfh7fcbE4KUupGoOkQ=;
        b=HCQsNBJSbczI7dNVQIO+QyS3nCwB1T9CPXzoMf1L+x1JO3yH297IkTisg6lOkE9bpM
         jXbCxHNzsVUglWLtEur5EJt+x4h+4qsegCvlb1JrGxMw4zL7sx2g69vZ/71KgBr8n1kP
         8b2wlr5GBwyPxfTBsrshDNc/vNGbugfwaDqjKkL7J2np78xV8DbnrxWzJxgfoizeHGAr
         GEpt46YXqwQXTsSoCLYP1LmEFbOlp1lLkONvz0lLOSQVIPxLrPYSfc+GmtefCPDVn0Vs
         arOJhogbtEZhEa2uGaX3sVX+6JcIXKNiwisE/jd3/cXReSMwe/JX4KPTJWlpAvx3/0iA
         uJ7w==
X-Gm-Message-State: AOAM5334n7Vqxd1j2dGf4WLAHdsv7CFmGiNqUp0Jq+wlzmuowMZXe6a8
        SAyYrMF+CSoqlf66uWF0vRs=
X-Google-Smtp-Source: ABdhPJyqPA/THaMvlBvffYtpFjaHUygj7US/vRrk78f1KaFUQY7e03pJm6bTtPjhVfjiDP3EQ1a2FA==
X-Received: by 2002:a62:1b87:: with SMTP id b129mr520581pfb.162.1590628513969;
        Wed, 27 May 2020 18:15:13 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s102sm3295368pjb.57.2020.05.27.18.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 18:15:13 -0700 (PDT)
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
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
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
 <20200527031202.GT11244@42.do-not-panic.com>
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
Message-ID: <3e5e75d4-56ad-19c6-fbc3-b8c78283ec54@acm.org>
Date:   Wed, 27 May 2020 18:15:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527031202.GT11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-26 20:12, Luis Chamberlain wrote:
> +	/*
> +	 * Blktrace needs a debugsfs name even for queues that don't register
> +	 * a gendisk, so it lazily registers the debugfs directory.  But that
> +	 * can get us into a situation where a SCSI device is found, with no
> +	 * driver for it (yet).  Then blktrace is used on the device, creating
> +	 * the debugfs directory, and only after that a drivers is loaded. In
                                                        ^^^^^^^
                                                        driver?

> @@ -494,6 +490,38 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	/*
> +	 * We also have to use a partition directory if a partition is
> +	 * being worked on, even though the same request_queue is shared.
> +	 */
> +	if (bdev && bdev != bdev->bd_contains)
> +		dir = bdev->bd_part->debugfs_dir;

Please balance braces in if-statements as required by the kernel coding style.

> +	else {
> +		/*
> +		 * For queues that do not have a gendisk attached to them, the
> +		 * debugfs directory will not have been created at setup time.
> +		 * Create it here lazily, it will only be removed when the
> +		 * queue is torn down.
> +		 */

Is the above comment perhaps a reference to blk_register_queue()? If so, please
mention the name of that function explicitly.

> +		if (!q->debugfs_dir) {
> +			q->debugfs_dir =
> +				debugfs_create_dir(buts->name,
> +						   blk_debugfs_root);
> +		}
> +		dir = q->debugfs_dir;
> +	}
> +
> +	/*
> +	 * As blktrace relies on debugfs for its interface the debugfs directory
> +	 * is required, contrary to the usual mantra of not checking for debugfs
> +	 * files or directories.
> +	 */
> +	if (IS_ERR_OR_NULL(q->debugfs_dir)) {
> +		pr_warn("debugfs_dir not present for %s so skipping\n",
> +			buts->name);
> +		return -ENOENT;
> +	}

How are do_blk_trace_setup() calls serialized against the debugfs directory
creation code in blk_register_queue()? Perhaps via q->blk_trace_mutex? Are
mutex lock and unlock calls for that mutex perhaps missing from
compat_blk_trace_setup()?

How about adding a lockdep_assert_held(&q->blk_trace_mutex) statement in
do_blk_trace_setup()?

Thanks,

Bart.
