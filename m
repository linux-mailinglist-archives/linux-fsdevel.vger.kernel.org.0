Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049181A5737
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgDKXVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 19:21:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40013 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgDKXVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:21:20 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so2257819pjb.5;
        Sat, 11 Apr 2020 16:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OnEdTEw0ywKO3uB4jy60eHyGZ2CxASOjH3gei6SJ2NA=;
        b=CLW4WlEqBrfZv5Svthez2gKoMv7rr2oU91bLRK+SFKK+PvJ4f+a8sB5XvTvZRk4v4W
         HdqChL8Qg9UcHZJdy0C9zEQB7xAtzPtev97WkZM5f5yqhrf3y4YEa9Hvvw4g4c58gHDK
         MQzx2/GzjGogdL6HNXAlu3qBL8rjcoPK5exFUZc/KCH91kgrKFKjIgGNIFSyxFcT9OQ5
         NSX1pbN0jZXaCcNnUr7Y3IqsNOfuzvPX6ZUN5I9jCpSuK3JJNIHD8df4SprwzJrFy1cM
         NGyKHK3aLwwu2r4iS2swRPmlOgmSooY6cCvuXw596REi2pU1mZR3lGH1aZVy7ibrWDg1
         PGZw==
X-Gm-Message-State: AGi0PuYeEbcplONJeWF7FWttgub8C+sO7IgBH5QnjScMhHDjyhMxnpgB
        aa9GLRDWEqBxawo7Eqd2E6s=
X-Google-Smtp-Source: APiQypLHqz4km5FIo2c058vEcQtuJ+/nXQ2X5Otv+2Z17DtjYXioxzZtjN80ODAcjm06XLNBW3C4EQ==
X-Received: by 2002:a17:902:ba14:: with SMTP id j20mr10464925pls.69.1586647279530;
        Sat, 11 Apr 2020 16:21:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c9fa:49a8:1701:9c75? ([2601:647:4000:d7:c9fa:49a8:1701:9c75])
        by smtp.gmail.com with ESMTPSA id e7sm5117580pfj.97.2020.04.11.16.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 16:21:18 -0700 (PDT)
Subject: Re: [RFC v2 5/5] block: revert back to synchronous request_queue
 removal
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-6-mcgrof@kernel.org>
 <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org>
 <20200410143412.GK11244@42.do-not-panic.com>
 <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
 <CAB=NE6XfdgB82ncZUkLpdYvDDdyVvVUd8nUmRCb8LbOQ213QoA@mail.gmail.com>
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
Message-ID: <64c9212d-aaa3-d172-0ab9-0fc0e25a019a@acm.org>
Date:   Sat, 11 Apr 2020 16:21:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XfdgB82ncZUkLpdYvDDdyVvVUd8nUmRCb8LbOQ213QoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-10 14:27, Luis Chamberlain wrote:
> On Fri, Apr 10, 2020 at 2:50 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Fri, Apr 10, 2020 at 8:34 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> On Thu, Apr 09, 2020 at 08:12:21PM -0700, Bart Van Assche wrote:
>>>> Please add a might_sleep() call in blk_put_queue() since with this patch
>>>> applied it is no longer allowed to call blk_put_queue() from atomic context.
>>>
>>> Sure thing.
>>
>> On second though, I don't think blk_put_queue() would be the right
>> place for might_sleep(), given we really only care about the *last*
>> refcount decrement to 0. So I'll move it to blk_release_queue().
>> Granted, at that point we are too late, and we'd get a splat about
>> this issue *iff* we really sleep. So yeah, I do suppose that forcing
>> this check there still makes sense.
> 
> I'll add might_sleep() to both blk_release_queue() *and* blk_cleanup_queue().

Since there is already an unconditional mutex_lock() call in
blk_cleanup_queue(), do we really need to add a might_sleep() call in
blk_cleanup_queue()?

Thanks,

Bart.
