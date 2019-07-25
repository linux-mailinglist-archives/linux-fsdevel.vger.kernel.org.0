Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CC7510A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfGYO0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 10:26:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfGYO0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:26:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so50971717wrt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2019 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4yNVultYze7PPpy5cvYCGPl+Bxml2Gu2G9EV6OVJFI=;
        b=aZFlfwYl11ZfalVK9HQXiK6psS8etYrq9MwdgKIeCJ3kUwwzXuJGup6sST8vFdvBKQ
         rkCcwECT04sJ7YhwAYxBq5jy2/UpsoS5q5OXFn8Ok8EH6a6wWiUESNyzJIs0r2rnNini
         RX9AZbR1bJNbiqsydTo0QFCdo45Ml3jX2A9h03zVGZ+LxvCTOYzFpq2ls8Ngtu1BX49r
         nsz/wBb4QJ6Y5MZ2ETI4GCfJuw76lG1feSBfo2lb+mpXmxfmQXsXEm536srR+dvDubLo
         /w/peoDdqwFNa85L1h2g5AMrXUdpIFtsNgZYkqVRcW+LTelShFbzpDXHPBotrl1euBKw
         YPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4yNVultYze7PPpy5cvYCGPl+Bxml2Gu2G9EV6OVJFI=;
        b=qJRv40siZp0DgjfJ9crXl3BiuC2fKcaRARZuhf1jORTEnECwJOefrjUgta0+jZeMK7
         sWUAONDlXRVivy7BSS2Fmy4uvm1DPNqkwOhGrBCe7Jv/akSkOd9ABkkn8NHGmJ6MtauI
         8/szgjaEfbi16HegH3vwSqTs3z1oEcz/EdJyG0eNIc8p+SHahWLaqLO5ygTZ66NzeESO
         peyHOfPjxCXlZOIYeGb4iVjqFJh5UfDes92zP6L2P3ui4GS50WHZlo/hZ6nr7QxJnEOc
         81mJJqTv71osihgtLgUfYS/NRJ0DhfkMvvVwXkFIX67vwv2YSq4ugeHLX2uH7yVIt29S
         zwvA==
X-Gm-Message-State: APjAAAX42sNZ+Qss76cX551RaZ88ys/UJQpKNnj9OJvFd1wDhdqLdRbi
        Nju/GtgUaVpl3UeIDi1aH267jFH7Gi4cMFNOLh2aoVJ8Ztq8YbY7uoHla6UnMYuFKp9xBmjJG86
        0pykMjT7Poz29u/U4VeaAAbMctarcFnFax3gjHMZCuXM6NH9mVQbd0OOCjepj+6krA2zrvVtm6A
        +xQdO0v4jWX+grHxnDEYPldtCQRcP1vSRvT+Km
X-Google-Smtp-Source: APXvYqxabH00r2hqqNGEp5to49iVTGmcAndrlBJ4BpORlLoVXwrBhNSWz9rDUPc4MdkiwTekqVtyvw==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr95315821wrn.168.1564064758809;
        Thu, 25 Jul 2019 07:25:58 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 4sm115262930wro.78.2019.07.25.07.25.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:25:58 -0700 (PDT)
Subject: Re: [PATCH] hung_task: Allow printing warnings every check interval
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190724170249.9644-1-dima@arista.com>
 <2964b430-63d6-e172-84e2-cb269cf43443@i-love.sakura.ne.jp>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <aa151251-d271-1e65-1cae-0d9da9764d56@arista.com>
Date:   Thu, 25 Jul 2019 15:25:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2964b430-63d6-e172-84e2-cb269cf43443@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/25/19 11:38 AM, Tetsuo Handa wrote:
> On 2019/07/25 2:02, Dmitry Safonov wrote:
>> Hung task detector has one timeout and has two associated actions on it:
>> - issuing warnings with names and stacks of blocked tasks
>> - panic()
>>
>> We want switches to panic (and reboot) if there's a task
>> in uninterruptible sleep for some minutes - at that moment something
>> ugly has happened and the box needs a reboot.
>> But we also want to detect conditions that are "out of range"
>> or approaching the point of failure. Under such conditions we want
>> to issue an "early warning" of an impending failure, minutes before
>> the switch is going to panic.
> 
> Can't we do it by extending sysctl_hung_task_panic to accept values larger
> than 1, and decrease by one when at least one thread was reported by each
> check_hung_uninterruptible_tasks() check, and call panic() when
> sysctl_hung_task_panic reached to 0 (or maybe 1 is simpler) ?
> 
> Hmm, might have the same problem regarding how/when to reset the counter.
> If some userspace process can reset the counter, such process can trigger
> SysRq-c when some period expired...

Yes, also current distributions already using the counter to print
warnings number of times and then silently ignore. I.e., on my Arch
Linux setup:
hung_task_warnings:10

>> It seems rather easy to add printing tasks and their stacks for
>> notification and debugging purposes into hung task detector without
>> complicating the code or major cost (prints are with KERN_INFO loglevel
>> and so don't go on console, only into dmesg log).
> 
> Well, I don't think so. Might be noisy for systems without "quiet" kernel
> command line option, and we can't pass KERN_DEBUG to e.g. sched_show_task()...

Yes, that's why it's disabled by default (=0).
I tend to agree that printing with KERN_DEBUG may be better, but in my
point of view the patch isn't enough justification for patching
sched_show_task() and show_stack().

Thanks,
          Dmitry
