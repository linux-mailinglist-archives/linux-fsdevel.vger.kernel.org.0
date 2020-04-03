Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD14919D8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbgDCONv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 10:13:51 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35022 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbgDCONv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:13:51 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so3001484pjp.0;
        Fri, 03 Apr 2020 07:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/uC4dyI6g/PVHzu7KkxcRUmHDDWKaue2mVENJy78MPk=;
        b=rIXk+74Iz+ezuq2HvUKD43aBukAJIZnVN1fE5/4zet+ARD1/l+sK1rsQkWi3j1j9S/
         jR1kKJP/evHpiRDZoEfbfszr85N2rJSdQ3YaG2354WWhQQcm1HiYvv2wrZeSTV6WyD84
         wLIb0ArGpQmbhMLpZnOCtjr5YMNnmC66bULJthzL0cSAmle6+A0xBRoN9yBuh6mIxL2R
         O0m6odUxcVgiVUTVmXz2PRkitpcv23KEBudfU+f2wgEqtwFeZkNxzri2a8Asc90RuC4A
         K+wR9QrWizIy562c5chef0MJ3h10ma2+DuIe9aUjLbbTtGDg1UfCUDDcGXZOgiii0lxP
         jK0g==
X-Gm-Message-State: AGi0PuZSrfNMNHfJxHjtYoonVKXYl9n3m3TdL/y9qztsTrwD4lMOczFe
        wcq4G6BF6mnQbtuRIyKwDo0=
X-Google-Smtp-Source: APiQypLbv2R9UWMbSdlA1dpLMUeuXSgOYK2XnOLxMBZ8iw7cFdIA3aQX+mLaKiUU6jZJDti9X2xa4Q==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr8313202plr.84.1585923229856;
        Fri, 03 Apr 2020 07:13:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f1be:827e:b9e9:8d94? ([2601:647:4000:d7:f1be:827e:b9e9:8d94])
        by smtp.gmail.com with ESMTPSA id 184sm5432095pge.71.2020.04.03.07.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 07:13:49 -0700 (PDT)
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
To:     Ming Lei <ming.lei@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200403081929.GC6887@ming.t460p>
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
Message-ID: <15236c59-6b48-2fcf-1a84-f98cb8b339ab@acm.org>
Date:   Fri, 3 Apr 2020 07:13:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403081929.GC6887@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-03 01:19, Ming Lei wrote:
> BTW, Yu Kuai posted one patch for this issue, looks that approach
> is simpler:
> 
> https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/

That approach is indeed simpler but at the expense of performing dynamic
memory allocation in a cleanup path, something I'm not enthusiast about.

Bart.
