Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44786243EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMSnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgHMSny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:43:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4451C061384
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 11:43:53 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y18so6379051ilp.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qXipwEBN2Iz4fq1yjNq98iQvWOe5oSb3TwyPypfMNUc=;
        b=bwNfn8z89yMMgws2NUQpBbcixw4kIhb1FMB5u8AC2FUvX9o+Xgl532AWbjVVlO7gik
         /w8NRLA31JDA9JOy6SQAlyaJ6awX/TuZiBBSeEu66ji3lHC01ClFtIubX7080ZZ3pARL
         bdRN2/4MRMuNZ/waHaQjO5UWWfrd51LDiDFolKA0D/3VlBA4NyCNdj9hIHplwm6UM2Qk
         a+QlNvDpmpoeaPNLDQVoDpRs7i1kO6snz44Gg0pLd/7v/v3BM9OvFFT2N6jGcTAUm113
         dpBScb1eYaI5LDf3mFn9y6RDcqlUClryYva6PHhLb1FpJHj3+XwU3Zb4WSRVF8BkQ9z9
         TTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXipwEBN2Iz4fq1yjNq98iQvWOe5oSb3TwyPypfMNUc=;
        b=pXbgryVAHso/GgQb9cfFMXVqeaHK/xM6tJQ9q/ZazQ4rv5l6Xaq8J1PZ+gcv5iIbik
         ufAMG4zuANuVEOgn9YxFUYXvZo4+SiR3ABiqq/yoqTShdaqpMcJJb0VieOSogVyM0anz
         SgdSoAw+yEqAA0OKre7H6m2XOwQCXoiC45TVlj2U9V1Tzv8V1RYH5M0ze7X96BhYQq2/
         ndktn+uiPZZZV7AVvDa1hJXiHvkkarT299lTCXVw7O3uG0vtusiZj3JYzKEynE39XPCu
         EfNWht9Ml81AYLeToaWExW4j++dX2cQUsD8aYykEK5i+7Z1yMjHA8co1iiib0+A9VPKH
         uF9w==
X-Gm-Message-State: AOAM5302fkTObCoEsBns0E5VEi1nY7cui9xMiLeOo3r3uWgreNi8clHP
        NwCEtMMwntKRowWpoOLUX7uKr2vGfho=
X-Google-Smtp-Source: ABdhPJxCVR0MCPzTXSciVQ2VgWYBklfxQCGn8azURYmwBBV2jRA//hVqc0OkDR9om36sUE4SAMl2jQ==
X-Received: by 2002:a92:1b85:: with SMTP id f5mr5753195ill.308.1597344232236;
        Thu, 13 Aug 2020 11:43:52 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n3sm3118997ilj.29.2020.08.13.11.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:43:51 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in idr_for_each
To:     syzbot <syzbot+25d82ed5cc4b474f1df8@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000093837f05acc5a11f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45954f2a-bd4a-7188-0013-a48efb2a3a50@kernel.dk>
Date:   Thu, 13 Aug 2020 12:43:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000093837f05acc5a11f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 11:28 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fb893de3 Merge tag 'tag-chrome-platform-for-v5.9' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167ed216900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fedc63022bf07e
> dashboard link: https://syzkaller.appspot.com/bug?extid=25d82ed5cc4b474f1df8
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107bc222900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a09d06900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+25d82ed5cc4b474f1df8@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in radix_tree_next_slot include/linux/radix-tree.h:421 [inline]
> BUG: KASAN: use-after-free in idr_for_each+0x206/0x220 lib/idr.c:202
> Read of size 8 at addr ffff888082058c78 by task syz-executor999/3765

Should already be fixed by:

commit 6d816e088c359866f9867057e04f244c608c42fe
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Aug 11 08:04:14 2020 -0600

    io_uring: hold 'ctx' reference around task_work queue + execute

which is going upstream soon.

#syz dup: KASAN: use-after-free Read in io_async_task_func

-- 
Jens Axboe

