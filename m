Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B271BE4CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504934AbfJYNur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 09:50:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44036 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502198AbfJYNur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:50:47 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so2448343iol.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHXHkRZYMYriBwnGx1XM0y5ekEDpj7Yqy5vMy8KNTfI=;
        b=0cQoRyAcYNQaeNht9WUlKmJ4thYDBCv0oGZ90WqeIlTJc/i2dvhTHtH9lLGX+i9xMJ
         JNUEzJItBVmQ/pue/RpcicBZXfmgvVyCD8ta53VyAsFNMWZnIX5Hq2d5dhnxFf0DinkA
         b61XpECUWEWOztP77nH4HlIkiQTTuLjYxQ3AxvK5A/3VSPv5faRfmsint3I440JUecgz
         VzrV+RQbGZTBDQzjq9/g6PGatAMbhG+fOWV26uaBrDiAtHwbI3WV+jzo0ZoFkL9zjS/h
         4qlhySnaCAJkPLVAjF8sVbNc3Voxzx9dYl5rXOho+EJRi6a8Mxx2LDtpFri1YyapPvdm
         slBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHXHkRZYMYriBwnGx1XM0y5ekEDpj7Yqy5vMy8KNTfI=;
        b=mYgjB+g2LzkGKWzY8Sgn4ToMmqih16BVkiCN+EUPK8bqA5UmdUuYB/WSKGyrbxVAfn
         MQYovaRwMFWFgefkyZCh1Ty6HNfEhzY6uw0WFvjoVHDcOU6HdXqxi9j7cXNGu4NVgEL0
         5A1zmf/RL36xua9HT2S/mxeAsPQaE7Q5K64NYr50oUcOxqB6Op2tnf9rwaSpsJK7Kxg0
         0+clZ4SK2xbFMPH5kOIsz7vvuSWPMDjTWZvq2MAWUjM5vOULAGsnxgUJFJMDwlj2GW1i
         gDPCkDaYCxAegNehVn6VjR6SpPGRebVfVbuqu7cHwyMOou1bdD5vgYP9XNG+5quhZpcN
         wtbw==
X-Gm-Message-State: APjAAAV1zyCZPkTeCQSEr6stCrOXEBiOisTqmRftviYtrBTYi47m+Isp
        nmHEcRIM2UfVXI3OkWcEo3TCXQ==
X-Google-Smtp-Source: APXvYqxsot+KuzrRp/bZ42yX1xRSsmzeoxhjDbcJwWvURaSHFnyWN/tmsc5x4vnk1y4l48NbZvEEzw==
X-Received: by 2002:a5e:d607:: with SMTP id w7mr3921189iom.237.1572011444742;
        Fri, 25 Oct 2019 06:50:44 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm266655iok.87.2019.10.25.06.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:50:43 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000fbbe1e0595bac322@google.com>
 <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e1b3410-95b0-f9d9-6838-486eae0bf5d7@kernel.dk>
Date:   Fri, 25 Oct 2019 07:50:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/19 5:58 AM, Dmitry Vyukov wrote:
> On Fri, Oct 25, 2019 at 1:51 PM syzbot
> <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    139c2d13 Add linux-next specific files for 20191025
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ab5a70e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com
> 
> +Jens

Let me know if/when you have a reproducer for this one. I initially thought
this was a basic NULL pointer check, but it doesn't look like it. I wonder
if the thread handling the request got a signal, and since it had the
task file_table with the io_uring fd attached, it's triggering an exit.

I'll poke at it, but don't immediately see the issue.

-- 
Jens Axboe

