Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117C71EF0B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFEEss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 00:48:48 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEEsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:48:47 -0400
Received: by mail-pj1-f65.google.com with SMTP id fs4so2086763pjb.5;
        Thu, 04 Jun 2020 21:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hZJ/8eC3dXgO2wjOVlMTwGutqE9JsxFfUeV6PLxhCNI=;
        b=GkH4AZMcOOS0uJapW5bQb/EqiiT1ipzs0CMY27LrxGg/EtrtdaovejIw989+g+4TM/
         HNW8ZL/wdPyrxXbHfYUcVN3gwF6dV7XMB5H+MGdggIk9cQjk0r2SqNVdkmk3jKm56L52
         HZ0X2y0vEttbVab4P8MqlqxnwrhoAgMK4Ench5KCq8eiDmM8QiklUQxxJPe+9k9DWRLt
         qtgjWpmEx1RsmJFD+HWIBq574BjVdWyd9Gr8lXS26q+jXs/vJFRch1HLAwn6X4B/tvhd
         LNKwChUmfJPhS8aJDNSDtoiiGg1T0RHzBLWT/GZP+FaDTmxk3BKDc7UjRfa6a+YGbYDP
         ZaoA==
X-Gm-Message-State: AOAM530fTP/r27wg/TVg8mo/nDesvvrHkpszroWDEXEtoyd81HAuV+H+
        n0P3fMlQJyOiCZxHPcjE9OM=
X-Google-Smtp-Source: ABdhPJzjpcvMSRc3KdygbaK4reL7DmJ3DtfxVBQks3TRN9he4J7tpkNDbeT/u0niDt9o4m8FuIkAxw==
X-Received: by 2002:a17:90a:2326:: with SMTP id f35mr816617pje.115.1591332526520;
        Thu, 04 Jun 2020 21:48:46 -0700 (PDT)
Received: from [192.168.50.149] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m16sm5798572pfh.187.2020.06.04.21.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 21:48:45 -0700 (PDT)
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
 <20200601170500.GF13911@42.do-not-panic.com>
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
Message-ID: <d4ef5da1-7d11-657c-f864-8b2ca6ea082c@acm.org>
Date:   Thu, 4 Jun 2020 21:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601170500.GF13911@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-01 10:05, Luis Chamberlain wrote:
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index a55cbfd060f5..5b0310f38e11 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -511,6 +511,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	 */
>  	if (bdev && bdev != bdev->bd_contains) {
>  		dir = bdev->bd_part->debugfs_dir;
> +	} else if (q->sg_debugfs_dir &&
> +		   strlen(buts->name) == strlen(q->sg_debugfs_dir->d_name.name)
> +		   && strcmp(buts->name, q->sg_debugfs_dir->d_name.name) == 0) {
> +		/* scsi-generic requires use of its own directory */
> +		dir = q->sg_debugfs_dir;
>  	} else {
>  		/*
>  		 * For queues that do not have a gendisk attached to them, that
> 

Please Cc Martin Petersen for patches that modify SCSI code.

The string comparison check looks fragile to me. Is the purpose of that
check perhaps to verify whether tracing is being activated through the
SCSI generic interface? If so, how about changing that test into
something like the following?

	MAJOR(dev) == SCSI_GENERIC_MAJOR

Thanks,

Bart.
