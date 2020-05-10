Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF471CC5DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 02:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEJA67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 20:58:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40702 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEJA67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 20:58:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id x2so2943976pfx.7;
        Sat, 09 May 2020 17:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yfUa5/GMebpHoQEUALnocZ9Dgl1/06CN6EeJFJKAbNQ=;
        b=bzmEGyFEbKHMm76nA8qtbSXiofedTme8vxEbJidS4JVG9Z7ZIN/pc6ILxvRUyXzGrG
         dwN3YptxMaexKNNKW+bp72wqC6fBmgbT+yqhVYrqi+8Nyw2JC1gS5PE4R4nTnQhZ3+e8
         77xf9X9GmJPUOPwqWgAshYr96qIHSU/lWKwQdgv79y3B5zCP8+fWA3U4DcbXMJ4/cCpr
         Z3V0uZZC36g4wclPzcwZzZaE0hajGXm1T3ILVneyddYVJk/iSs7KmgiSpJg3XtE6d8UA
         Bv8gbLwTkK8c1NImuKw87Dp3E+miiBppUyhpiIzu/WrT/ScRSI4MXM04K74rH3uuhELD
         EcWw==
X-Gm-Message-State: AGi0PuYBP08aas0v9XjHDqEbXLCSY83Y3BBKflyqQTFWy+6ZsKQFyeVh
        pBrzA1NCSQjkIFoDZQ6omzo=
X-Google-Smtp-Source: APiQypLYkSBo0TBjhEQ+R96aJthWe8iLfsZ+cHLA2raK3w24x3SiMYwkLmSdk5dalLwBo3nuhevZxA==
X-Received: by 2002:aa7:9ae5:: with SMTP id y5mr9892469pfp.294.1589072337962;
        Sat, 09 May 2020 17:58:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ef:746a:4fe7:1df? ([2601:647:4000:d7:8ef:746a:4fe7:1df])
        by smtp.gmail.com with ESMTPSA id c4sm4526784pga.73.2020.05.09.17.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:58:57 -0700 (PDT)
Subject: Re: [PATCH v4 3/5] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-4-mcgrof@kernel.org>
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
Message-ID: <16fe176f-1dbd-d14c-bfc2-5aee1ca8c64e@acm.org>
Date:   Sat, 9 May 2020 17:58:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509031058.8239-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-08 20:10, Luis Chamberlain wrote:
> Screenshots of what the debugfs for block looks like after running
> blktrace on a system with sg0  which has a raid controllerand then sg1
> as the media changer:
> 
>  # ls -l /sys/kernel/debug/block
> total 0
> drwxr-xr-x  3 root root 0 May  9 02:31 bsg
> drwxr-xr-x 19 root root 0 May  9 02:31 nvme0n1
> drwxr-xr-x 19 root root 0 May  9 02:31 nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p1 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p2 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p3 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p5 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p6 -> nvme1n1
> drwxr-xr-x  2 root root 0 May  9 02:33 sch0
> lrwxrwxrwx  1 root root 0 May  9 02:33 sg0 -> bsg/2:0:0:0
> lrwxrwxrwx  1 root root 0 May  9 02:33 sg1 -> sch0
> drwxr-xr-x  5 root root 0 May  9 02:31 vda
> lrwxrwxrwx  1 root root 0 May  9 02:31 vda1 -> vda

So this patch creates one soft link per partition at partition creation
time instead of letting the blktrace code create one directory per
partition when tracing starts? Does this break running blktrace
simultaneously for a partition and for the entire block device?

> +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> +						 const char *src,
> +						 const char *dst,
> +						 enum blk_debugfs_dir_type type)
> +{
> +	struct dentry *dentry = ERR_PTR(-EINVAL);
> +	char *dir_dst;
> +
> +	dir_dst = kzalloc(PATH_MAX, GFP_KERNEL);
> +	if (!dir_dst)
> +		return dentry;
> +
> +	switch (type) {
> +	case BLK_DBG_DIR_BASE:
> +		if (dst)
> +			snprintf(dir_dst, PATH_MAX, "%s", dst);
> +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> +			snprintf(dir_dst, PATH_MAX, "%s",
> +				 q->debugfs_dir->d_name.name);
> +		else
> +			goto out;
> +		break;
> +	case BLK_DBG_DIR_BSG:
> +		if (dst)
> +			snprintf(dir_dst, PATH_MAX, "bsg/%s", dst);
> +		else
> +			goto out;
> +		break;
> +	}
> +
> +	/*
> +	 * The base block debugfs directory is always used for the symlinks,
> +	 * their target is what changes.
> +	 */
> +	dentry = debugfs_create_symlink(src, blk_debugfs_root, dir_dst);
> +out:
> +	kfree(dir_dst);
> +
> +	return dentry;
> +}

Please use kasprintf() instead of k?alloc() followed by snprintf().

Thanks,

Bart.
