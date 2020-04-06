Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A87919EFD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDFEZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 00:25:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35844 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgDFEZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:25:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id n10so6949767pff.3;
        Sun, 05 Apr 2020 21:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c8wPbad/8W9/8b6vePf+GYvbUSqgcxrAZ3yGLbYkRIg=;
        b=nNy1VitUHs4ZrHyV0qTotIiwPFPn26bHsJz/tDwyEl78xPQZv7H9P05l5s5+IIKo7/
         9HKLR5ocx1coV44gUU9SZQ/S/LEp5p1DrKfc1T8bVsVntf0uC55kpOTSOYGd7uB0P/On
         LAST/j2IzNsQsHj/ISazT4GOK7vlkjQqA1AIHN6KU2OvCoE61FUN9sqJc8fxc2bzHaLW
         F0JKW2GEJ14ODUwRFfzKeQdx89JX2hL9PjnJ6YRvKykU2uhKW5xX7LxkzcAqoDzI+a1N
         VSkZmQOxvuUh5jqvXUUF3J9Ym7pFRmuSIbBrOxC5oQ86Uwx+qL2qJvnyUxDQDWESWHNe
         n1hA==
X-Gm-Message-State: AGi0Pub8urHfmDuTS2LK9o/fiu2wz3LsZJA/OfjjeFPlLmSAQFa71XyD
        5D3HxUuLOFiZ/Dix/SB9rEUpkXDJJ2o=
X-Google-Smtp-Source: APiQypKEoPMxKPEw1lvcr+pVTnkijH/ndCn7BCmmULSLJlYTk+1hOrYPoUZBL8ZSN5GPm4bYSgO3WA==
X-Received: by 2002:a63:8dc7:: with SMTP id z190mr19591971pgd.39.1586147144839;
        Sun, 05 Apr 2020 21:25:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7d7b:4f16:40c2:d1f9? ([2601:647:4000:d7:7d7b:4f16:40c2:d1f9])
        by smtp.gmail.com with ESMTPSA id e184sm10462077pfh.219.2020.04.05.21.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 21:25:43 -0700 (PDT)
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
To:     Eric Sandeen <sandeen@sandeen.net>,
        Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
 <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
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
Message-ID: <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org>
Date:   Sun, 5 Apr 2020 21:25:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-05 18:27, Eric Sandeen wrote:
> The thing I can't figure out from reading the change log is
> 
> 1) what the root cause of the problem is, and
> 2) how this patch fixes it?

I think that the root cause is that do_blk_trace_setup() uses
debugfs_lookup() and that debugfs_lookup() may return a pointer
associated with a previous incarnation of the block device.
Additionally, I think the following changes fix that problem by using
q->debugfs_dir in the blktrace code instead of debugfs_lookup():

[ ... ]
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,7 +311,6 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
-	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
[ ... ]
@@ -509,21 +510,19 @@ static int do_blk_trace_setup(struct request_queue
*q, char *name, dev_t dev,

 	ret = -ENOENT;

-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);

 	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
+	bt->dropped_file = debugfs_create_file("dropped", 0444,
+					       q->debugfs_dir, bt,
 					       &blk_dropped_fops);
[ ... ]

Bart.
