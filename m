Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F231AA9C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634182AbgDOOSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:18:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37723 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506385AbgDOOS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:18:26 -0400
Received: by mail-pj1-f67.google.com with SMTP id z9so6747593pjd.2;
        Wed, 15 Apr 2020 07:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5IopSX9GJ2vX2KVXHELrCUGod5MEFkycVBu4B7TnveU=;
        b=tFjVFLqcIhyffnInMoNhqhiP4mtZRmXpeu3m2JaODlrrvH3wNYAnrJxDnM1cAXAUHq
         LAhQ0aHDOZM9e1PpvEjL6kRC+/3doQj39PjUkvtFf6+Q2M19rACyzXnZTNw9YUK8naTs
         yL8MzhGGZADVQOfT1ybe3vS2LIQAwQhyPOvg7DjUEAUw8WfrWOSk9/D2zSTCmy9p6zfj
         oob8cm2lVnIipX5YtbgeDhNnwweQ1cVZKvZ4z7YtmoR6fLSdFDA3X+c3hx4hpBfHw2on
         xM6pJwJo+PX8qAsOy+kLsst7pBdn6qmDeGc287iL69mZbsNbpTE3AAW0ZVT4rYadV8EU
         LLgw==
X-Gm-Message-State: AGi0PubdvMtpE+8yoh6KX+I8cnPIleKoVEeBrKED5Wbbzz4wUfYGqoTo
        F+h30Ljz1nyEAZWnYMDEG9I=
X-Google-Smtp-Source: APiQypL+tq09UzLXwWYyxeyg0GFdB+W9oWy5Q4yXEHLV4C+RumEaBRUnw34+Pq3OPSvABtX30ZnGlw==
X-Received: by 2002:a17:90a:9747:: with SMTP id i7mr6727270pjw.192.1586960305422;
        Wed, 15 Apr 2020 07:18:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:74a5:f25a:9320:53da? ([2601:647:4000:d7:74a5:f25a:9320:53da])
        by smtp.gmail.com with ESMTPSA id 140sm9427833pge.49.2020.04.15.07.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:18:24 -0700 (PDT)
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
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
Message-ID: <73332d32-b095-507f-fb2a-68460533eeb7@acm.org>
Date:   Wed, 15 Apr 2020 07:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415123434.GU11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-15 05:34, Luis Chamberlain wrote:
> On Wed, Apr 15, 2020 at 12:14:25AM -0700, Christoph Hellwig wrote:
>> Btw, Isn't blk_get_queue racy as well?  Shouldn't we check
>> blk_queue_dying after getting the reference and undo it if the queue is
>> indeeed dying?
> 
> Yes that race should be possible:
> 
> bool blk_get_queue(struct request_queue *q)                                     
> {                                                                               
> 	if (likely(!blk_queue_dying(q))) {
>        ----------> we can get the queue to go dying here <---------
> 		__blk_get_queue(q);
> 		return true;
> 	}                                                                       
> 
> 	return false;
> }                                                                               
> EXPORT_SYMBOL(blk_get_queue);
> 
> I'll pile up a fix. I've also considered doing a full review of callers
> outside of the core block layer using it, and maybe just unexporting
> this. It was originally exported due to commit d86e0e83b ("block: export
> blk_{get,put}_queue()") to fix a scsi bug, but I can't find such
> respective fix. I suspec that using bdgrab()/bdput() seems more likely
> what drivers should be using. That would allow us to keep this
> functionality internal.

blk_get_queue() prevents concurrent freeing of struct request_queue but
does not prevent concurrent blk_cleanup_queue() calls. Callers of
blk_get_queue() may encounter a change of the queue state from normal
into dying any time during the blk_get_queue() call or after
blk_get_queue() has finished. Maybe I'm overlooking something but I
doubt that modifying blk_get_queue() will help.

Bart.
