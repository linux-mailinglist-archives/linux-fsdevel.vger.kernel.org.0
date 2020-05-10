Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69E91CC5EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgEJBJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 21:09:42 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53229 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgEJBJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 21:09:42 -0400
Received: by mail-pj1-f65.google.com with SMTP id a5so6006543pjh.2;
        Sat, 09 May 2020 18:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gOcLyyohxD8fco16zhhFVMtG6mh2DzURAsZz1+qZQfg=;
        b=Ylj8y6WB/uCAneP8NB3cNfpzsRxHAVNZoykVmqDT1tYpfUG2Z2dJU8m6zUqkW7TEef
         jHgoLkM7UcmWRNXiHA869jFcXORzLQNMTGPWtWb68fFzoCnQ9cNhDi1QM3gvt4VgQvNj
         dC8NPBkHqqa+RzYTdzXjSQG3LzA7Mp/BBrhPTDdLB+lCtSkjMrdFJMIhZ2pV14UdNagq
         8Yr8kC1RLwZHSbmLTUHMx6Cf1fqiAiOWnlkxmOzVhAJvm8+QPiZPoL2yJpA9ndO3ikBC
         3kE+CdH/lMFgQaqPuiG8waJo7Nh7jocw8ju2zbf7OPs1IwnRI2gJcZTf8jTu+K3UmvmL
         8V9A==
X-Gm-Message-State: AGi0PuaOOaafITySyLwkucHalYue4EfC1f0aQpx4pPaz4tsRG+qBMz3W
        1bCWe9Id0fPjBr/rlXKg0rqTxPco3AA=
X-Google-Smtp-Source: APiQypKXnzTMKz71+jj7Jy5Gm44PD+czEJydMUHxGMcmgw2UJtLGXJebGPFv3iZ4X2dYs6A787wQig==
X-Received: by 2002:a17:90a:3266:: with SMTP id k93mr14580851pjb.118.1589072980528;
        Sat, 09 May 2020 18:09:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ef:746a:4fe7:1df? ([2601:647:4000:d7:8ef:746a:4fe7:1df])
        by smtp.gmail.com with ESMTPSA id go21sm6037539pjb.45.2020.05.09.18.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 18:09:39 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] blktrace: break out of blktrace setup on
 concurrent calls
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-5-mcgrof@kernel.org>
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
Message-ID: <e728acea-61c1-fcb5-489b-9be8cafe61ea@acm.org>
Date:   Sat, 9 May 2020 18:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509031058.8239-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-08 20:10, Luis Chamberlain wrote:
> @@ -493,6 +496,12 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	if (q->blk_trace) {
> +		pr_warn("Concurrent blktraces are not allowed on %s\n",
> +			buts->name);
> +		return -EBUSY;
> +	}
> +
>  	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
>  	if (!bt)
>  		return -ENOMEM;

Is this really sufficient? Shouldn't concurrent do_blk_trace_setup()
calls that refer to the same request queue be serialized to really
prevent that debugfs attribute creation fails?

How about using the block device name instead of the partition name in
the error message since the concurrency context is the block device and
not the partition?

Thanks,

Bart.


