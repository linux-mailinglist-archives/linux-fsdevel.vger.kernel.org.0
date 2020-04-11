Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5351A5918
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 01:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgDKXej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 19:34:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgDKXJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so758498pgk.1;
        Sat, 11 Apr 2020 16:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bNOnt21gdCdQqFujqIQgsVXINX2TimtwaZJBJWFvobE=;
        b=oCYiPdkZ4fSH8S5oZyZ/Yfu0CbzGRouI7xBUkZ7934Q1MxPjzDQ8NMcquVDXOmetDW
         mgWwQoY6QtoIgQ541CboVVZzxnnUb2/x3feEsjF+aqMm441EeuLI1w3adidIRt2BgVx/
         o1ZFz2xEWmxLv1JJegCWcm+0Ee6PKskQiHFEv0bErn1SDzU7fCJHDQV8LSZhYkImrWyZ
         YnKgN3KW8BN+4BcxWnX8JrfZo6AlnUkg1i8RSvdqAn9TGF8GDif63GMzxnEwCbd8qXok
         7ddRvQNoly4pKYcEOTWPXfvyVBO+vWcfbKtS9T63CC0M6r5lJDhwhY0xr8+cN/R0k/bP
         T5gQ==
X-Gm-Message-State: AGi0PuYu7veqKVjlCtD9rGIs98N+YZNcmxzYZUz3dVhJamQbyx/b3L7V
        iMHL93FBescK9+/n4XGEQU4=
X-Google-Smtp-Source: APiQypIz9tuo6Y03zFp20Egc2qgoiCJuV8aoNvO22l1h4rt+ybn5/wyg/QTeabc+t/nfuHkqdHyW7Q==
X-Received: by 2002:aa7:83c5:: with SMTP id j5mr11676782pfn.100.1586646555117;
        Sat, 11 Apr 2020 16:09:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c9fa:49a8:1701:9c75? ([2601:647:4000:d7:c9fa:49a8:1701:9c75])
        by smtp.gmail.com with ESMTPSA id u44sm4679954pgn.81.2020.04.11.16.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 16:09:14 -0700 (PDT)
Subject: Re: [RFC v2 2/5] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>
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
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-3-mcgrof@kernel.org>
 <88f94070-cd34-7435-9175-e0518a7d7db8@acm.org>
 <20200410195805.GM11244@42.do-not-panic.com>
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
Message-ID: <0837b27e-e07b-b61c-5842-00cdf78873ca@acm.org>
Date:   Sat, 11 Apr 2020 16:09:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410195805.GM11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-10 12:58, Luis Chamberlain wrote:
> On Thu, Apr 09, 2020 at 07:52:59PM -0700, Bart Van Assche wrote:
>> On 2020-04-09 14:45, Luis Chamberlain wrote:
>>> +void blk_q_debugfs_register(struct request_queue *q)
>>> +{
>>> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
>>> +					    blk_debugfs_root);
>>> +}
>>> +
>>> +void blk_q_debugfs_unregister(struct request_queue *q)
>>> +{
>>> +	debugfs_remove_recursive(q->debugfs_dir);
>>> +	q->debugfs_dir = NULL;
>>> +}
>>
>> There are no other functions in the block layer that start with the
>> prefix blk_q_. How about changing that prefix into blk_?
> 
> I the first patch already introduced blk_debugfs_register(), so I have
> now changed the above to:
> 
> blk_debugfs_common_register()
> blk_debugfs_common_unregister()
> 
> Let me know if something else is preferred.

I just realized that the "q" in "blk_q_" probably refers to the word
"queue"? How about renaming these funtions into
blk_queue_debugfs_register/unregister()?

Thanks,

Bart.
