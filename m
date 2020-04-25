Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7181B8326
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDYB62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 21:58:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37592 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYB61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:58:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id c21so3609457plz.4;
        Fri, 24 Apr 2020 18:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n9CN/oQvEAYLNaAYRFLVAwCJwVMav9x9AK7qDWbYaXA=;
        b=iqB+f2YirDKZx7JcEr7IjIIH+C5eQpl2T5V5V4fy5RNnDxUvoO5a8nOZl7T8e8ckmT
         3/jvcQwQIkynV5hLQwIi7rO8V15ApU24sN0+sHiectHfpp/uuM9hV8N2YBVqCjVaAXw+
         xlH6ajX/OT2lcvTd6TAdhZ5z+k88meE8asoHtKfOJhjvBOVOfCiyjQtKDMO+PiOhSmEI
         5g/4JTReLBV6qlTlDIxC2bIBwDuSdsIaZs2wB1J1ay6hG7PBgUSNWhbFPZe7ToCseJcJ
         rGvgT86D4btmhGLS1MWPNXsOtUgaVdV7HmXVJbEhVyQB1GdStVXQN6rJyaCdqLUYhle4
         H6xg==
X-Gm-Message-State: AGi0PubGf/OjTvml9rSJfm22KepYG3035Dv8ctEMa7tsxvQP5gM39iNf
        ZV5DmIrDfsjEoHtsmcE5o9bFUT/F6H0=
X-Google-Smtp-Source: APiQypL8gLi6c7jUPihStIJrQ6nZ/Vz/d+AKX48+0AeVfsVUKmTftjeoB8yFxiLdhLSLv4kA4VL5hw==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr12049211plt.177.1587779906365;
        Fri, 24 Apr 2020 18:58:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d7d:6dae:7169:7912? ([2601:647:4000:d7:9d7d:6dae:7169:7912])
        by smtp.gmail.com with ESMTPSA id 1sm7183266pff.180.2020.04.24.18.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 18:58:25 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] block: put_device() if device_add() fails
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-11-mcgrof@kernel.org>
 <85a18bcf-4bd0-a529-6c3c-46fcd23a350e@acm.org>
 <20200424223210.GD11244@42.do-not-panic.com>
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
Message-ID: <d8e01420-5a0a-3c60-0b8c-46465437e255@acm.org>
Date:   Fri, 24 Apr 2020 18:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424223210.GD11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-24 15:32, Luis Chamberlain wrote:
> On Sun, Apr 19, 2020 at 04:40:45PM -0700, Bart Van Assche wrote:
>> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
>>> Through code inspection I've found that we don't put_device() if
>>> device_add() fails, and this must be done to decrement its refcount.
>>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> Turns out this is wrong, as bdi needs it still, we have can only remove
> it once all users are done, which should be at the disk_release() path.
> 
> I've found this while adding the errors paths missing.

Hi Luis,

I had a look at the comments above device_add() before I added my
Reviewed-by. Now that I've had another look at these comments and also
at the device_add() implementation I agree that we don't need this patch.

Bart.
