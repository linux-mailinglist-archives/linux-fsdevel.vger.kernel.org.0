Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970211AB652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbgDPDnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 23:43:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44332 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgDPDni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:43:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so1039791pfb.11;
        Wed, 15 Apr 2020 20:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MF+GTcAP/Qi1eGTnMDQ31INQwaQqeTxesD5C90whNm4=;
        b=OSNHTeLgm7mfq2H+4Mbf2xG+wk1C2t/IBwmavxqO0EBEuN2WGqif1n9DhZ/czrNHEI
         B9SiNSXXQOViU1Gs04jpYjPKAO0y3yH2Jko8ctQpph++ShfDhl9f3SHrlMFkDD+sx8t/
         laj9b/tbS7mRA7WsXbt2HRmj50GT7A0aGk5UiDftQQSyNMQVx7jS2MO1w8UFxb6DcCRo
         FiCUJAE8tj0ppNkTzyPw8iy31TpJxeobxw7hhCMMyJzOXOXltUJF/h8Ld5K0Uyt/6Beu
         SLZmzbF2XmMkYtHq1x98SolAcPEx43uGmg1E0iDYpO+oxLg61jKxnbgBHfoqThLhOK1n
         2D1w==
X-Gm-Message-State: AGi0PuaLrv2lnb4+V0aw9SObEk8bkOfe3c3RIsxaJsof4Ih6GPY7+jio
        MULKmfLOCtx2vpzOez9qwVo=
X-Google-Smtp-Source: APiQypJW/DVeigCfIx/tEMJ1u8JJIZm5hJJ9dvGJdqr8k9BoFgyywcE0DNRRh5Kfl5ObHf8rRTRZ/A==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr28638998pgf.245.1587008615446;
        Wed, 15 Apr 2020 20:43:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:91ba:7380:46ae:a781? ([2601:647:4000:d7:91ba:7380:46ae:a781])
        by smtp.gmail.com with ESMTPSA id u24sm12045079pgo.65.2020.04.15.20.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 20:43:34 -0700 (PDT)
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
 <73332d32-b095-507f-fb2a-68460533eeb7@acm.org>
 <20200416011247.GB11244@42.do-not-panic.com>
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
Message-ID: <a71d9c9b-72c8-8905-aeba-08e5382f5a81@acm.org>
Date:   Wed, 15 Apr 2020 20:43:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416011247.GB11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-15 18:12, Luis Chamberlain wrote:
> On Wed, Apr 15, 2020 at 07:18:22AM -0700, Bart Van Assche wrote:
>> blk_get_queue() prevents concurrent freeing of struct request_queue but
>> does not prevent concurrent blk_cleanup_queue() calls.
> 
> Wouldn't concurrent blk_cleanup_queue() calls be a bug? If so should
> I make it clear that it would be or simply prevent it?

I think calling blk_cleanup_queue() while the queue refcount > 0 is well
established behavior. At least the SCSI core triggers that behavior
since a very long time. I prefer not to change that behavior.

Regarding patch 3/5: how about dropping that patch? If the queue
refcount can drop to zero while blk_trace_ioctl() is in progress I think
that should be fixed in the block_device_operations.open callback
instead of in blk_trace_ioctl().

Thanks,

Bart.
