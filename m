Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16DE1A3E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 04:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDJCsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 22:48:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDJCsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:48:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so461344pfl.12;
        Thu, 09 Apr 2020 19:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9Q5Xyyihwp2JnRtlC2ONHxzXn26cTV+LmTcM1TReBcA=;
        b=CF+NuMXqgJsLv/O6PsJfnSh5pOcnPPbauK8yuapuz8xazNOFuoL+6tIHoMOuCxXPz/
         Ju3eSGIsGnCrO8aQYsfEL/9pHdBASeuBRAGydim42qDuxNsoJOVx8f7cxL7p92pFDkUV
         g/04VeRyhlpwqdvioAMtaU6FLut3Km2+0mT4UjQe6T3Rpcb3w8WqIS2uSZrdFwyV/8WC
         a6mu4vWgCGsCaZxHBQvscnjVrMGEXBXrDKkZvTWPlSa3Xo9fmGHosBx/s0cbd//qNli2
         jTK5jFd3lEKlqeu4WbGImN55a68CQ69xT+Gu/TfkZhxJ6oYMCkiaT7g2xhYc//IZ5G2A
         kz5g==
X-Gm-Message-State: AGi0Pub7DjDLBcSxVKyMPSAnMUG2vqrhbyABv/YkE+oL8aEGSxRvtaxB
        3iAucaEnwVZcm3B1jXfbPQ0=
X-Google-Smtp-Source: APiQypI/p2Z57KSNXzcZBPYB7BISO44gnnzEmhSqJ1z00w/d7/guzoVM4cVlS3s5fjOPfOIU1njvCw==
X-Received: by 2002:a63:e1e:: with SMTP id d30mr2364954pgl.369.1586486922243;
        Thu, 09 Apr 2020 19:48:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ed4e:1b14:7fc4:cd73? ([2601:647:4000:d7:ed4e:1b14:7fc4:cd73])
        by smtp.gmail.com with ESMTPSA id 6sm411368pgm.51.2020.04.09.19.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 19:48:41 -0700 (PDT)
Subject: Re: [RFC v2 1/5] block: move main block debugfs initialization to its
 own file
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-2-mcgrof@kernel.org>
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
Message-ID: <ff5bfeb5-fb4d-931a-b34f-843596fad340@acm.org>
Date:   Thu, 9 Apr 2020 19:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409214530.2413-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-09 14:45, Luis Chamberlain wrote:
> Single and multiqeueue block devices share some debugfs code. By
> moving this into its own file it makes it easier to expand and audit
> this shared code.

Christoph doesn't like the name "single queue block devices".
Additionally, the legacy (single queue) block layer is gone. Should the
description of this patch perhaps refer to make_request-based drivers
and request-based drivers?

> +/*
> + * Shared debugfs mq / non-mq functionality
> + */

Shared request-based / make_request-based functionality?

Otherwise this patch looks good to me.

Thanks,

Bart.
