Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76027E9DC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJ3Olu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 10:41:50 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38613 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3Olu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:41:50 -0400
Received: by mail-il1-f193.google.com with SMTP id y5so2354210ilb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8M4Q/hulOLKq5QBH7SseZicRn46BDfUKYYJB1woZ9F8=;
        b=O0gGjKRrxHys6Q2aujV+4MT2j/ZjsSYkDi9GKfTadrp+3OsaEj9MpPZeaVUYjh3jga
         Lt/pb1YjDeKkLIc9X0ysapeDeMirJQ5DAoWssEDfb1y9SMHca7Cpner/0PwQkojLHkpx
         N4TSDBzSztYw8kJfiT9Daj01/md5WfML34mttZWozPOAn5dmoM5foBsQXL+jEaHnmEzW
         RhhGAMAO5fVn+TzVSsErUinwOJRVAltcO+jIVr/z2lFeIAA+i5gdvsrvJVYsoFn6iVDd
         5t2q0XNohZr2NnrrDWO1Q8lxvwtpuTZKxxUQL9BKAIZqMKdtPXdqb1BwFUAK4RSsm2wv
         ZkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8M4Q/hulOLKq5QBH7SseZicRn46BDfUKYYJB1woZ9F8=;
        b=maDVS7d2A2LxdrGEI8T6aMLlCutYmIgPrZNqoP5FVjSQ6fwnyW1k6zDdbgHPSAPMsm
         Lyl1e2z/DHFrCIQSo9XM0f5a9QIN2LpzfxO745bhbagoJfwNogSPrmJS4RJKlHRlyY+8
         dwvU11Txe/vXAlH3dbyJ34+m0QLZECa4AAeIj2xYvIUwvs/ZozW/Nqxx8N4a8shITfNP
         6DPqEJIzyhpV7RfVENFtETY/wXRwteQIWWm0NCzSJGbvJi3olyr1zeDXyZV8l64KLh1A
         XdBazNeqYsYEaaDaZR59eEQKLxhik2ctB3bLvhQQttpIWRGymk7+PS973N4Wj3pIGKJG
         xFoA==
X-Gm-Message-State: APjAAAWOTG5eBL538BT23QokmM5QDfXmNX1EObS5u6Mh8eYReNAuWVWc
        tFHjCqxXiPe5PlvXAMKJbXZVDTpwKK5m2g==
X-Google-Smtp-Source: APXvYqyqrROuX3U0xP+PNenNQOMYso72VKgcxfO/6ysc4+hXLZApIoNa/HRe7jHr0SUpJ9LQw4UwlQ==
X-Received: by 2002:a92:580c:: with SMTP id m12mr389533ilb.225.1572446509207;
        Wed, 30 Oct 2019 07:41:49 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i79sm55737ild.6.2019.10.30.07.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:41:48 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        dhowells@redhat.com, gregkh@linuxfoundation.org,
        hannes@cmpxchg.org, joel@joelfernandes.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        mingo@redhat.com, patrick.bellasi@arm.com, rgb@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yamada.masahiro@socionext.com
References: <00000000000069801e05961be5fb@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
Date:   Wed, 30 Oct 2019 08:41:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <00000000000069801e05961be5fb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/19 1:44 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ef0524d3654628ead811f328af0a4a2953a8310f
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 24 13:25:42 2019 +0000
> 
>       io_uring: replace workqueue usage with io-wq
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
> start commit:   c57cf383 Add linux-next specific files for 20191029
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
> dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
> 
> Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
> Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")

Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
the below fix.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index af1937d66aee..76d653085987 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3534,8 +3534,9 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	/* Do QD, or 4 * CPUS, whatever is smallest */
 	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
 	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
-	if (!ctx->io_wq) {
-		ret = -ENOMEM;
+	if (IS_ERR(ctx->io_wq)) {
+		ret = PTR_ERR(ctx->io_wq);
+		ctx->io_wq = NULL;
 		goto err;
 	}
 

-- 
Jens Axboe

