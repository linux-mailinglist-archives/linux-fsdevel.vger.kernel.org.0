Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3E1FE3ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 04:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgFRCOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 22:14:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46946 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgFRCO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:14:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id n2so1774404pld.13;
        Wed, 17 Jun 2020 19:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Le1+A9v4jFjRt4VG3Xq//Jk2RuRTl7qEG22rEXGxqc=;
        b=IkZnAJvy4AnFsQ2fSv5CeHRspXDmKf8olCYjFKzZC5YosTz5TlMQFhkUzct6Oix6Rg
         5fC/1Cr4xSbpPIyMnjrd2vKydzbQ6vv+rb65ZFgIn6gEWewTWja4/R2+5eevJfe4MIIF
         Yczxg8471GcXxgFmE5km6jTtR/p4rsnvLR9zs5BdB58rt41dVu9MYhnAzGZ6LVQKQvec
         j+f6iX4lkMh/SULah7rFrtd5wtxEsMN8CjFc7vmdY5cWyHXhtIId9AwRbMKIZ+PSeWQS
         cPLo+PWfxUfZvQjH+WX8am4rf3LdnDA9eaxQ/KHGHc24p8GTZE9+mNBlkES6HufEwuhY
         8LyA==
X-Gm-Message-State: AOAM533dbVYxaN5q9NS3NKcQDdeQswldzroTSg7LkRhw+CAmdnfFpOoF
        RQgptkHxcNyEKRgBt1ca0x4=
X-Google-Smtp-Source: ABdhPJwl1mkg/jrvMc/UXQw/tv7F5UxkmlI9Bmx1IsFCwraX6RSBJKMpSeYe0TrYLrbpkDxMK8kVMA==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr1971712pjq.225.1592446466771;
        Wed, 17 Jun 2020 19:14:26 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q24sm959825pgg.3.2020.06.17.19.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 19:14:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] loop: replace kill_bdev with invalidate_bdev
To:     Zheng Bin <zhengbin13@huawei.com>, hch@infradead.org,
        axboe@kernel.dk, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20200530114032.125678-1-zhengbin13@huawei.com>
 <20200530114032.125678-2-zhengbin13@huawei.com>
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
Message-ID: <bf6c99e3-bf17-1d45-1ef8-d3431bd0d09e@acm.org>
Date:   Wed, 17 Jun 2020 19:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200530114032.125678-2-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-30 04:40, Zheng Bin wrote:
> When a filesystem is mounted on a loop device and on a loop ioctl
> LOOP_SET_STATUS64, because of kill_bdev, buffer_head mappings are getting
> destroyed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
