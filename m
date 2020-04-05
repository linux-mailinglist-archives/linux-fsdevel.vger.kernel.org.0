Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88419E8D2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEDM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 23:12:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36660 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDEDM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:12:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id n10so5773291pff.3;
        Sat, 04 Apr 2020 20:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CcrM78Ee5sJ7nNP72U0wM1cu31MrzFzOVzTC6xSrZ0U=;
        b=oR6wJiaUrfU3miabYBQns0ThkVqBBnzEWm1UbO4LCCSWA3nbWosx4RjgSDfhjPY+k1
         Bhpkyn2NRjp8axMKNB+ny7AnqtgMcEwDfWwQPOKwWUCoCRcbX5LoU4IemH4YilRuPCNu
         adS/PU+/No4wviXivVGSZLaWzY3ghgAGUJtvnVtrtKfrBtCPGI2YZ6Eua/s4k1t9eV8/
         4bQ2/50KUaHDfYjdoZgA8HeIlBIWaE2z9DthZBQJz1sGjXXRVYEhN+TphzExDc3TBaIU
         XHx8lFOP0OcRpz2Jb+0dhRFj/d2QPGamDAjU98/Phg9yi5O89sydOYpIRI2o7lrHchZs
         MR4g==
X-Gm-Message-State: AGi0PuaKN0HMzV/8tuR2ErvsihMpce/6ZtmjbUzFjQmccQh3+C2aYFAj
        McOZPl8SA7Ek5tu5HoEy1G0=
X-Google-Smtp-Source: APiQypKEwX4L8/TOzddPUJ8IWcjtV6TmCEBEGEEZX5/TWkJI7xTfrX7PHuobqvMGyZlKuG3uYLQZuQ==
X-Received: by 2002:a65:5a4f:: with SMTP id z15mr15611596pgs.103.1586056375548;
        Sat, 04 Apr 2020 20:12:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id s3sm6534495pjd.21.2020.04.04.20.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 20:12:54 -0700 (PDT)
Subject: Re: [RFC 1/3] block: move main block debugfs initialization to its
 own file
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-2-mcgrof@kernel.org>
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
Message-ID: <cef15625-3814-aec2-d10c-1344a6f063a9@acm.org>
Date:   Sat, 4 Apr 2020 20:12:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402000002.7442-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-01 17:00, Luis Chamberlain wrote:
> Single and multiqeueue block devices share some debugfs code. By
             ^^^^^^^^^^^
             multiqueue?
> moving this into its own file it makes it easier to expand and audit
> this shared code.

[ ... ]

> diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> new file mode 100644
> index 000000000000..634dea4b1507
> --- /dev/null
> +++ b/block/blk-debugfs.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Shared debugfs mq / non-mq functionality
> + */

The legacy block layer is gone, so not sure why the above comment refers
to non-mq?

> diff --git a/block/blk.h b/block/blk.h
> index 0a94ec68af32..86a66b614f08 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -487,5 +487,12 @@ struct request_queue *__blk_alloc_queue(int node_id);
>  int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		bool *same_page);
> +#ifdef CONFIG_DEBUG_FS
> +void blk_debugfs_register(void);
> +#else
> +static inline void blk_debugfs_register(void)
> +{
> +}
> +#endif /* CONFIG_DEBUG_FS */

Do we really need a new header file that only declares a single
function? How about adding the above into block/blk-mq-debugfs.h?

Thanks,

Bart.
