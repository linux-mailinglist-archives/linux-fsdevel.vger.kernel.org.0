Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3184E47FB58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhL0JcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0JcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:32:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D62C06173E;
        Mon, 27 Dec 2021 01:32:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mj19so12992402pjb.3;
        Mon, 27 Dec 2021 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=blLyqMGVfs0AXFge5rZvCvR55Jlo7Ci/Oo9BAO3yZv0=;
        b=LS2dAyf37rcZFYM7ikwO9zifbPnqt4N8M4ZsoQw+qaZPpHQMM/iZnE0MTLLaavjS/p
         KGphPKq6ivNOGsGnAl/AMNCBujp726HGWUFiQClxO2jxe7W1zE/mlag5ylf047HWsoTm
         T1+EJbXZpkOivcgKd9HLbXQwxmuMEQams/EPgoL9XAwdSLm4MNTMMARld1gSD2VDDhJU
         gWJFv3mSQ45D/os5sfwPjlSU7WrGenIHzl6HJ0GpZJIhFQCrZwkbeTQSx7frbiKtRbW+
         1CWU3O3fBg28/iYt5gVbqqo8xfQwVH+WeCjD5S0VJA9zxbnCrU2QTma94fktXB/QO9k+
         VIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=blLyqMGVfs0AXFge5rZvCvR55Jlo7Ci/Oo9BAO3yZv0=;
        b=5Dgq4G7htanNGnFVmma8u4opUWjBkqFqBUcu08GWeNuxk1tp4ueSymVqGqGQJ9RdML
         S3KX1jclrhYTLffDCXabNITddmuMDcUOU9/ycZ7Z1/hwTLdd5vhQyOxgXSjEFBqsITF9
         1E0igjBrmrPbTpkzqduVXYRz2OGQLQYouOLcH65e7Ehvb6sfl9sySa9eBUrYKUnEwBJP
         J8JyCp3znjsyqgmsaTvyPyHTggSChBXpOmwm6dWK4Do+wZHRHqcRo9zkaaAvA3wlFRR2
         PukaYrvgsLQCgYWUAbXEdElIZZgqpCH9KLyD6Dl/8eV2QW34bGub1yQlIWjo9zBA0xd9
         jNbg==
X-Gm-Message-State: AOAM531jAsmlVU/B3T2RI7JgJRWd9ksu8uN22xa8E3YcC5d63+RgohtP
        ccEpkUVYRkAnZTv+0WLAihh9Mo2w29Y=
X-Google-Smtp-Source: ABdhPJyCdzlaIZDM422nqqDeSBxQwuHBA5PLmDAniPnAPJtDFJS+UdHChOtIYWdDm3/fqNU/u3/fSQ==
X-Received: by 2002:a17:902:f543:b0:148:a2e8:2793 with SMTP id h3-20020a170902f54300b00148a2e82793mr16886367plf.154.1640597531253;
        Mon, 27 Dec 2021 01:32:11 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.127])
        by smtp.gmail.com with ESMTPSA id oa9sm16238648pjb.31.2021.12.27.01.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 01:32:10 -0800 (PST)
Subject: Re: [BUG] fs: super: possible ABBA deadlocks in
 do_thaw_all_callback() and freeze_bdev()
To:     Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
 <YckgOocIWOrOoRvf@casper.infradead.org> <YclDafAwrN0TkhCi@mit.edu>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <a9dde5cc-b919-9c82-a185-851c2eab5442@gmail.com>
Date:   Mon, 27 Dec 2021 17:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YclDafAwrN0TkhCi@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/12/27 12:39, Theodore Ts'o wrote:
> On Mon, Dec 27, 2021 at 02:08:58AM +0000, Matthew Wilcox wrote:
>> On Mon, Dec 27, 2021 at 10:03:35AM +0800, Jia-Ju Bai wrote:
>>> My static analysis tool reports several possible ABBA deadlocks in Linux
>>> 5.10:
>>>
>>> do_thaw_all_callback()
>>>    down_write(&sb->s_umount); --> Line 1028 (Lock A)
>>>    emergency_thaw_bdev()
>>>      thaw_bdev()
>>>        mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 602 (Lock B)
>>>
>>> freeze_bdev()
>>>    mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 556 (Lock B)
>>>    freeze_super()
>>>      down_write(&sb->s_umount); --> Line 1716 (Lock A)
>>>      down_write(&sb->s_umount); --> Line 1738 (Lock A)
>>>    deactivate_super()
>>>      down_write(&s->s_umount); --> Line 365 (Lock A)
>>>
>>> When do_thaw_all_callback() and freeze_bdev() are concurrently executed, the
>>> deadlocks can occur.
>>>
>>> I am not quite sure whether these possible deadlocks are real and how to fix
>>> them if them are real.
>>> Any feedback would be appreciated, thanks :)
>> As a rule, ABBA deadlocks that can actually occur are already found by
>> lockdep.    Tools that think they've found something are generally wrong.
>> I'm not inclined to look in detail to find out why this tool is wrong
>> because lockdep is so effective.
> Well, to be fair, lockdep will only find problems if both code paths
> are actually executed during a boot session where lockdep is active.
>
> In this particular case, "do_thaw_all_callback()" is called only from
> emergency_thaw_all(), which is executed via a magic-sysrq.  (Sysrq-j).
> In practice, this sysrq is almost never used except to work around
> userspace bugs where a particular block device is frozen via the
> FIFREEZE ioctl, and never thawed via the FITHAW ioctl.
>
> So unless we had, say, an xfstest which tried to simulate triggering
> sysrq-j (e.g., via "echo j > /proc/sysrq-trigger"), lockdep would
> never find it.  Of course, how likely is it that a user would try to
> trigger sysrq-j, because the user was trying to debug a buggy program
> that froze a block device and then, say, crashed before it had a
> chance to thaw it?  It's probably pretty darned unlikely.
>
> So as to whether or not it's real, I'm sure we could probably trigger
> the deadlock using an artificial workload if you had one process
> constantly calling FIFREEZE and FITHAW on a block device, and other
> process constantly triggering "echo j > /proc/sysrq-trigger".  So it
> *technically* could happen.  Is it *likely* to happen under any kind
> of normal workload?  Not hardly....
>
> This makes it fall in the category of, "patch to fix something that
> never happens in real life, and would require root privs to trigger,
> and root can screw over the system in enough other ways anyway so it's
> kind of pointless", versus "let's try to shut up the static checker so
> we can find real bugs".
>
> And there I'd agree with Willy; I run xfstests with lockdep enabled,
> and given that the code coverage of xfstests is pretty good, I'm
> confident that any ABBA deadlocks that are *likely* to happen in real
> life tend to be found quickly, and fixed.
>
> If someone wanted to rewrite the emergency_thaw codepath to fix the
> locking order, in my opinion it's *technically* a bug fix.  But it's
> the sort of thing which gets categorized as a P2 bug, and after a
> year, gets dropped down to P3, and a year after that, dropped down to
> P4 and ignored, since for most engineering organizations, resources
> are finite, and while this is a real bug, for most companies it's not
> worth fixing.

Thanks for your reply and suggestions.
I will try to trigger this possible deadlock by enabling lockdep and 
using the workloads that you suggested.
In my opinion, static analysis can conveniently cover some code that is 
hard to be covered at runtime, and thus it is useful to detecting some 
infrequently-triggered bugs.
However, it is true that static analysis sometimes has many false 
positives, which is unsatisfactory :(
I am trying some works to relieve this problem in kernel-code analysis.
I can understand that the related code is not frequently executed, but I 
think that finding and fixing bugs should be always useful in practice :)


Best wishes,
Jia-Ju Bai
