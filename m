Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC82C1AB37E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 23:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgDOVsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 17:48:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53549 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgDOVsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:48:36 -0400
Received: by mail-pj1-f65.google.com with SMTP id cl8so419365pjb.3;
        Wed, 15 Apr 2020 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3n/tFi5CGbzTrobjd2A4ZhBvLfQl0w0u7WVPVo0RKxc=;
        b=ofSc4s+toc3DJr14/HEzNk9tiffwAj5Do6Q7C+5yxQEyEuXccm63/oKPFdFs2NLAoc
         /SA0icxtD6c0Vts2Hre1WM3A4pXfmL4nr52zChncrSMPxWFzJbLRHNG0PhiXw6CDbcz5
         mMs958tN7Mnt9Ax4YGIUpFSOEkc4U373Re8DODVEd5OPxC1CGoMyrfApNLGFPvq+ip5Z
         3J78Yi91Y7t6SosbB5AF0VMKesO23yYmmOKlxEyGbhjPiHHZyGdrrlAL3ODBheHSgINB
         E41PGLg1hLI4dzMVbJk5WvP19XCQXmQ5eb3RS491ZtYPa76jTHVn9Ybho15GTgaDLDk6
         pFNA==
X-Gm-Message-State: AGi0PuYUIVba22D759jVv2z9aVBprmr6TUeP5wwexHJLFJqhVtSe77WI
        yeQr1f96qw5bJzgGghkULNg=
X-Google-Smtp-Source: APiQypKVnmZwhQdbvwifV7/L+LDyJ+sn1ettKHycXby9PIfr+6X5Gg0+xpBdXmPV1ae+9LxBKhG1Uw==
X-Received: by 2002:a17:902:dc86:: with SMTP id n6mr7076951pld.198.1586987315701;
        Wed, 15 Apr 2020 14:48:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:74a5:f25a:9320:53da? ([2601:647:4000:d7:74a5:f25a:9320:53da])
        by smtp.gmail.com with ESMTPSA id g14sm545735pjd.15.2020.04.15.14.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 14:48:34 -0700 (PDT)
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
To:     Eric Sandeen <sandeen@sandeen.net>,
        Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
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
Message-ID: <27552cfd-d903-b224-8e81-538c2714a67d@acm.org>
Date:   Wed, 15 Apr 2020 14:48:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-15 10:38, Eric Sandeen wrote:
> On 4/13/20 11:18 PM, Luis Chamberlain wrote:
>> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
>> merged on v4.12 Omar fixed the original blktrace code for request-based
>> drivers (multiqueue). This however left in place a possible crash, if you
>> happen to abuse blktrace in a way it was not intended.
>>
>> Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
>> forget to BLKTRACETEARDOWN, and then just remove the device you end up
>> with a panic:
> 
> I think this patch makes this all cleaner anyway, but - without the apparent
> loop bug mentioned by Bart which allows removal of the loop device while blktrace
> is active (if I read that right), can this still happen?

That's a great question. Even if the loop driver fix would be sufficient
to fix the blktrace debugfs use-after free I think the block layer
patches from this series are still very valuable. As explained in the
cover letter this patch series fixes more than only the blktrace debugfs
use-after-free.

Thanks,

Bart.
