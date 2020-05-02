Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672E71C21E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 02:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBAZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 20:25:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39469 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEBAZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 20:25:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id e6so564631pjt.4;
        Fri, 01 May 2020 17:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1PeAqJ5SiUZNxwlPTtwXNjCE1HPrHwFDRiunmDICEv0=;
        b=rLWj60W4gdCQjOKyLTDrKGA5isjU9UVCoX5hsGTq2+XG9Gz4tSZ2OmOml3tsr3DYJv
         AMwqWFHmhOrvpV56Pw9QrmffDXOGR09Hck9cP+oOoUDmbvDxMEshNAeZqcp6qbolAu2h
         UQyA3WL+jkXTpC8i3J7vv0zeLdrm0Exh4khivsMVegqLWy0mjHz/y4P1pFfiCQDyvGit
         4kgTcKjgfe7gx/CPfYptcwMBuHZwgWP7+I6Gasr3qAEAoC6FfULtodpz39wEFJy+TgpB
         3NP/Xcq3gEPXAbCv+eamTvryeAVftISHgymateuXJknd95mVQ6ffu5WljP1VgBWhpyBO
         5Oow==
X-Gm-Message-State: AGi0Pub2mjbQ8fnFD3wHjiVv3s2qhpo+RtwFPg9misPN3EPFbjWR2zOV
        lWBXZc3QxlnINec04WE7K+4RZPn7p5L9qw==
X-Google-Smtp-Source: APiQypI3AkWgWLXFTvQI8oSsZ3tQZEJdUfMLz91z+Ov/ex9nniG4APLSEkrFX3MceTXPt5ttdyuFNQ==
X-Received: by 2002:a17:90a:f698:: with SMTP id cl24mr2624417pjb.71.1588379107454;
        Fri, 01 May 2020 17:25:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3401:2e72:5c00:8ec0? ([2601:647:4000:d7:3401:2e72:5c00:8ec0])
        by smtp.gmail.com with ESMTPSA id 6sm3228408pfj.123.2020.05.01.17.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 17:25:06 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] blktrace: move blktrace debugfs creation to helper
 function
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-4-mcgrof@kernel.org>
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
Message-ID: <cd244b77-fdb1-3249-ecfd-86a306b1d30f@acm.org>
Date:   Fri, 1 May 2020 17:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429074627.5955-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-29 00:46, Luis Chamberlain wrote:
> +static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> +					    struct blk_trace *bt)
> +{
> +	struct dentry *dir = NULL;
> +
> +	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> +	if (!dir)
> +		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> +
> +	return dir;
> +}

Initializing 'dir' is not necessary since the first statement overwrites
'dir'. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
