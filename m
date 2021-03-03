Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02D32B4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450216AbhCCFbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449691AbhCCECD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 23:02:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863BC0617A9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 20:01:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 201so15331488pfw.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 20:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=C+8aSxAix6GjFrfY/hP+1D1nUsbFIPsru7pSJjHkC8s=;
        b=XiHexSnRLXUibZdmdLCk9F45MzW4UsjYA5hRjjqbkZDE2MBNMG1zWPesqrCtaSyY1m
         IrgW06ZL1o13jgHWxlfNzlzfQQgvspQLyJFJv9tAX3xd9/BPHFsfk+OsjT9Ukh2JT1FD
         t/5shXZnN8rMw0btxj2Pr16+JwteSAdio+Wqt8YFCOoIIzsR0PRh7QCvhWvZvd+BzQZC
         eFpzklmp1mXZEIISeAo9JgWVqmYbdNWfQriHE/FzMwIKXGrPvyzi9K/vDNkgVuGdGIGL
         JnAzcDRDoSgxh2mg6eDgsSPYSxF9Kibw5sDFTRjh+qtdJt7PHNGVplhGOW4oIKngH/z9
         aC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+8aSxAix6GjFrfY/hP+1D1nUsbFIPsru7pSJjHkC8s=;
        b=hgc0UQjt4sKdzhDCTL1nHt1jTG0u4p98/5oHWjvZoDR6LwcQuEIa6Q5XVqxd4WK1kE
         D4yph5Rs4iBgTQHk622k2vaw4XnLJ6BlUn6G6RiZmCGFSo4MRrfIjtPwwG3Y3IEmxx03
         ISzO8faACOsi2M5HMx3OhbyRpIzSd32QLgJYrbBTudrRHK1X6Y/Iy2dchbsyfHtUVxFr
         yvATQjcY2lhU1KEGuwbXGIRpPdQY8pqVDIRYhvc5tZtdD8lrLwooStUNRJgvgPD7Dyrj
         wQ5sa3fDTK9FcM3Wotngw2Rw5bq/9CgOjPX9xEtA0L4phLfc17GKIy62l6u/+AV0vIzd
         1FXg==
X-Gm-Message-State: AOAM533vPFnJHiwq463LyX49xSN1iBXHXRB7asozeV5k6kRpubR9KBN+
        Cz63GQgw9peWKJB4QeSYwJ5jpg==
X-Google-Smtp-Source: ABdhPJz/lkInWkGXi5xNkZQiSZvVukmfQRl+TJb5xsQeZBc98cclT/FjzP3shu37PJUFwC3ouQ0myQ==
X-Received: by 2002:aa7:80cc:0:b029:1da:689d:2762 with SMTP id a12-20020aa780cc0000b02901da689d2762mr6400115pfn.3.1614744108375;
        Tue, 02 Mar 2021 20:01:48 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b15sm21078349pgj.84.2021.03.02.20.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 20:01:47 -0800 (PST)
Subject: Re: possible deadlock in io_poll_double_wake (2)
To:     syzbot <syzbot+28abd693db9e92c160d8@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000017349305bc9254f4@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f83bda00-251c-af17-1073-05fd4da80f59@kernel.dk>
Date:   Tue, 2 Mar 2021 21:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000017349305bc9254f4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/21 11:59 AM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> possible deadlock in io_poll_double_wake
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.12.0-rc1-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor.4/10454 is trying to acquire lock:
> ffff8880343cc130 (&runtime->sleep){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
> ffff8880343cc130 (&runtime->sleep){..-.}-{2:2}, at: io_poll_double_wake+0x25f/0x6a0 fs/io_uring.c:4925
> 
> but task is already holding lock:
> ffff888034e3b130 (&runtime->sleep){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&runtime->sleep);
>   lock(&runtime->sleep);

This still makes no sense to me - naming is the same, but address of waitqueue_head
is not (which is what matters). Unless I'm missing something obvious here.

Anyway, added some debug printks, so let's try again.

#syz test: git://git.kernel.dk/linux-block syzbot-test

-- 
Jens Axboe

