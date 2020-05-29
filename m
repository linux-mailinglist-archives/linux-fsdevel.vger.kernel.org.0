Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927301E7FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgE2OKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:10:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38591 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2OKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:10:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q8so1422109pfu.5;
        Fri, 29 May 2020 07:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tczqUTCzli6Ly2l/TcTewkkYVvVSa+lfPkgrQx9tI9o=;
        b=WgtM+8Idkt4Ebxx3Zeg5enw0HRjLmWTN0koU8mLbbPRyNkpAjlYeGl5BkBt+LCcuuk
         WEey27eZnJshtX+4PJbg6/cbHLO7EWpQsikBzsDWwfgXxTXbXTDDL9ue9BgNZg0cKnpi
         o1Tt9iKQguCH5o+Fu9TomD0ZkP5j1ViDKES3IBraYQfP+qhacr7lYpu8z4QW8gX4mZ9f
         Pf58Gdxt3gMjEny4Qht03vterxdXYbj1CnrwkbP0MiGs79ft5n6cVnHEH0hEyiYwobKD
         T+QI/HwIGe17ob6fAmdYJA625H9F3ccGoN/zLCdLEoXkPR2kbFz5GcEptsgWtcEHCWqj
         u0+Q==
X-Gm-Message-State: AOAM530023CN3qlb6DHFspca27IgFoMtS3dbhlkrWSoVvx8iv/It0f//
        Lw5MM1z/L4NhXDGrHDy5+ahLGXBzw9k=
X-Google-Smtp-Source: ABdhPJxw1UoCQH96DuR8r+bgy4+6jHYcu1eVamaetqgUWGl8L9NWlB69e8KqvuzYbmzQN1lYrYFnyg==
X-Received: by 2002:a63:1a11:: with SMTP id a17mr8541713pga.227.1590761399930;
        Fri, 29 May 2020 07:09:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d55:11e:7174:3ec6? ([2601:647:4000:d7:9d55:11e:7174:3ec6])
        by smtp.gmail.com with ESMTPSA id j2sm7749637pfb.73.2020.05.29.07.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:09:58 -0700 (PDT)
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
 <20200527031202.GT11244@42.do-not-panic.com>
 <3e5e75d4-56ad-19c6-fbc3-b8c78283ec54@acm.org>
 <20200529075657.GX11244@42.do-not-panic.com>
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
Message-ID: <9495ad7d-12be-edfb-8ac8-5f88a589b0e3@acm.org>
Date:   Fri, 29 May 2020 07:09:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529075657.GX11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-29 00:56, Luis Chamberlain wrote:
> On Wed, May 27, 2020 at 06:15:10PM -0700, Bart Van Assche wrote:
>> How about adding a lockdep_assert_held(&q->blk_trace_mutex) statement in
>> do_blk_trace_setup()?
> 
> Sure, however that doesn't seem part of the fix. How about adding that
> as a separat patch?

That sounds good to me.

Thanks,

Bart.
