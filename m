Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CBC20472A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgFWCQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 22:16:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34289 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgFWCQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:16:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id t6so1339602pgq.1;
        Mon, 22 Jun 2020 19:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M/lKgw0WIqHsOqIn5qkk2P21mZzLktylguXH7Jx+OVk=;
        b=tqxq8Wgo3F6HifXAj6ZoPlu5n2aUQidj+j5DJPbbRbMNYSt/ewAArz93QpfqH5H64T
         NeCpjtJjUnJ6qvHzun2OT6fZqIMJDZ67SbcWf4Ptwm2hwUMbZ+jKN5BHy3WXM958+uFV
         dzNWB/7qFm6LoUTm1hA1BXVP7OEifKLvA6YDJKkukoar+EBAeVeOOthJ6CC5SfVr8Yxj
         Z+pDqch5KXutT6kL4IYYbP5mYzfiYSmgmpoE7VwCeZPF3ohAgNqJrgWGzHbJxMG1rlxu
         3a/n4JhTWDW8wLh0zsD1vSehPXVnD2PNgf3mrdiVn86QXow9ZhUw0ZNEHLtyPMn/tOwy
         hMgQ==
X-Gm-Message-State: AOAM533/meih7OltlveyYgom5SgPpffYOwv9s5Q5DqBhklLMQsu43j2V
        pZ8tI32qbLqUrvqXDQWseTQ=
X-Google-Smtp-Source: ABdhPJzQeAPANbiAmUwJbdDHqgqKLmC7CQe4oeQcA4IUQ/MBdOu2b/RZsx/t4Z569lut9IJk2LZxsA==
X-Received: by 2002:a62:640b:: with SMTP id y11mr22670086pfb.195.1592878578089;
        Mon, 22 Jun 2020 19:16:18 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w77sm15909899pff.126.2020.06.22.19.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 19:16:17 -0700 (PDT)
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
 <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
 <20200622122742.GU11244@42.do-not-panic.com>
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
Message-ID: <14dc9294-fa99-cad0-871b-b69f138e8ac9@acm.org>
Date:   Mon, 22 Jun 2020 19:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622122742.GU11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-22 05:27, Luis Chamberlain wrote:
> Note: this will bring you sanity if you try to figure out *why* we still
> get:
> 
> [235530.144343] debugfs: Directory 'loop0' with parent 'block' already present!
> [235530.149477] blktrace: debugfs_dir not present for loop0 so skipping
> [235530.232328] debugfs: Directory 'loop0' with parent 'block' already present!
> [235530.238962] blktrace: debugfs_dir not present for loop0 so skipping
> 
> If you run run_0004.sh from break-blktrace [0]. Even with all my patches
> merged we still run into this. And so the bug lies within the block
> layer or on the driver. I haven't been able to find the issue yet.
> 
> [0] https://github.com/mcgrof/break-blktrace

Thanks Luis for having shared this information. If I can find the time I
will have a look into this myself.

Bart.
