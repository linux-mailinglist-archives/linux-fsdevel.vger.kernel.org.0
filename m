Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA841AAAA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392306AbgDOOp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:45:26 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33209 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbgDOOpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:22 -0400
Received: by mail-pj1-f68.google.com with SMTP id ay6so77791pjb.0;
        Wed, 15 Apr 2020 07:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pBJo/JQSnidWIsZkfJsj1QT0fRaerLE2o4j81aCDQl4=;
        b=XY5CPSn6z+RdSSJgvwljbJj0V06TGZIQtXQ7QsurU7HyY2kZyA2Ie27+taAcZuN2kL
         f7ApyYNJpyvOt97FVz/OHMpqPus2UWZO3aC+qa8b38hXalo/lMvcBbDiqRojsMnmthDA
         EhMaGkasqpsXYunTfvII6ax7QCrQA158Atbcc9F4sX7+xlYIjBFgQlxI0Y/lXkbHOqtx
         jgyJ4QzvQK9Xxc5/KaM4rMo4baLW2ILaV4DZQU9KPswgCzTZ6CD7Jbb5iZGXcufTW6iC
         OyL3yPAmr8YH6dQVoAA4ZhuG8hXSrVfOH+THHnZqj3uB8i4iYyed4Lf/ZUVDCZ4Wx0ad
         qD8A==
X-Gm-Message-State: AGi0PuZa68HUFFZiuIOyy4ivlp+JXWYCGgLK58kxFQBjXZdNnmsJWkUD
        nPkVJv/VJf3vfWUZFZ2Vnrs=
X-Google-Smtp-Source: APiQypKUu9JDV3E8NnRbxbNWJAsd3dksGpoqMVJtTMB0nvp0uezQYXkIIqv1ZWREFaMB8ztY9s+DMA==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7mr5227310plq.330.1586961921350;
        Wed, 15 Apr 2020 07:45:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:74a5:f25a:9320:53da? ([2601:647:4000:d7:74a5:f25a:9320:53da])
        by smtp.gmail.com with ESMTPSA id o15sm14773001pjp.41.2020.04.15.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:45:20 -0700 (PDT)
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
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
        Michal Hocko <mhocko@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
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
Message-ID: <49bfcbe0-2630-5c82-f305-fcee489ac9ea@acm.org>
Date:   Wed, 15 Apr 2020 07:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415061649.GS11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-14 23:16, Luis Chamberlain wrote:
> On Tue, Apr 14, 2020 at 08:40:44AM -0700, Christoph Hellwig wrote:
>> Hmm, where exactly does the race come in so that it can only happen
>> after where you take the reference, but not before it?  I'm probably
>> missing something, but that just means it needs to be explained a little
>> better :)
> 
>>From the trace on patch 2/5:
> 
>     BLKTRACE_SETUP(loop0) #2
>     [   13.933961] == blk_trace_ioctl(2, BLKTRACESETUP) start
>     [   13.936758] === do_blk_trace_setup(2) start
>     [   13.938944] === do_blk_trace_setup(2) creating directory
>     [   13.941029] === do_blk_trace_setup(2) using what debugfs_lookup() gave
>     
>     ---> From LOOP_CTL_DEL(loop0) #2
>     [   13.971046] === blk_trace_cleanup(7) end
>     [   13.973175] == __blk_trace_remove(7) end
>     [   13.975352] == blk_trace_shutdown(7) end
>     [   13.977415] = __blk_release_queue(7) calling blk_mq_debugfs_unregister()
>     [   13.980645] ==== blk_mq_debugfs_unregister(7) begin
>     [   13.980696] ==== blk_mq_debugfs_unregister(7) debugfs_remove_recursive(q->debugfs_dir)
>     [   13.983118] ==== blk_mq_debugfs_unregister(7) end q->debugfs_dir is NULL
>     [   13.986945] = __blk_release_queue(7) blk_mq_debugfs_unregister() end
>     [   13.993155] = __blk_release_queue(7) end
>     
>     ---> From BLKTRACE_SETUP(loop0) #2
>     [   13.995928] === do_blk_trace_setup(2) end with ret: 0
>     [   13.997623] == blk_trace_ioctl(2, BLKTRACESETUP) end
> 
> The BLKTRACESETUP above works on request_queue which later
> LOOP_CTL_DEL races on and sweeps the debugfs dir underneath us.
> If you use this commit alone though, this doesn't fix the race issue
> however, and that's because of both still the debugfs_lookup() use
> and that we're still using asynchronous removal at this point.
> 
> refcounting will just ensure we don't take the request_queue underneath
> our noses.

I think the above trace reveals a bug in the loop driver. The loop
driver shouldn't allow the associated request queue to disappear while
the loop device is open. One may want to have a look at sd_open() in the
sd driver. The scsi_disk_get() call in that function not only increases
the reference count of the SCSI disk but also of the underlying SCSI device.

Thanks,

Bart.
