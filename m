Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EC1A9119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgDOCq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 22:46:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40113 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgDOCqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:46:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so709568plo.7;
        Tue, 14 Apr 2020 19:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8mRfxoN3bcfcA1TxXqki/WiTHgjCQ2LePwB5Nf3Tcgg=;
        b=ddSMr44V1NatRcjpEvz0b95ktygt7OTU2BZw0ha9+6C4DuYeICp6R3raOyf2gfLMGk
         0/oZFpliKstDHroOimSMoju/21FD3YsjtP+8mOyP3zXikfy7f6WXVt4Nnvguag9XMHGf
         05EybzPQ0Ff7/VbRZgGfFhpTEbX3evsK/Ggf4u8I8xCLCbdTn51fTL/aiykC5mp0BLBG
         dlpI5xD9eOV5lvQPc6xyo+BBivX/LZaDsEsAaukJmTXz2bhKFjsym/+RG1wgq8G+AwY2
         7Wn0YbuATXfRSeQ1FRVBPo6SfuSVV1vKdWodcSdW/vq/8nrL0/urD+bC31bhg+qMf9Ea
         j4Gw==
X-Gm-Message-State: AGi0Pua2egqZKhtOYjal5upsmQrQlB5jYWllxqv4xogKjee1CyGV17gC
        8HSnK2tWEsSkrLxWU/Iftm0=
X-Google-Smtp-Source: APiQypIWuUQhQ3vjC/8iRMxAkMbtjgb/6nKIWTCZxGVhNEk2zJlKzeWIiiIkPFYUAm26uppDkSO/wg==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr3616695pjc.0.1586918781929;
        Tue, 14 Apr 2020 19:46:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3d9e:6f43:1883:92f0? ([2601:647:4000:d7:3d9e:6f43:1883:92f0])
        by smtp.gmail.com with ESMTPSA id z12sm12827964pfj.144.2020.04.14.19.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 19:46:21 -0700 (PDT)
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
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
Message-ID: <608dc241-2f87-27df-fd51-a1b91c7e4425@acm.org>
Date:   Tue, 14 Apr 2020 19:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414041902.16769-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-13 21:18, Luis Chamberlain wrote:
> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> merged on v4.12 Omar fixed the original blktrace code for request-based
> drivers (multiqueue). This however left in place a possible crash, if you
> happen to abuse blktrace in a way it was not intended.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
