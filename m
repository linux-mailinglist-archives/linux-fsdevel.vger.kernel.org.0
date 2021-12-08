Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A146DAD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhLHSRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 13:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhLHSRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:17:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECCC061746;
        Wed,  8 Dec 2021 10:14:02 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so11427370edd.0;
        Wed, 08 Dec 2021 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mcPtzo6Mc48uKJRt67ru8n5CsPPRYIExPhncNpI7X2U=;
        b=goXuzERkzrBi7PF/ABRAY1JlIs3T/p3DGwgarHIhPWMngpKnVtN9muwoQuIhthQ1NN
         zu0CBT1/MlwJRmmtEDNGxf/ZHeEC2rBDjr4kFQgoJrfo8Na+hSQaiCi5PGwBaEOV/mH6
         vAHhFmrqiM5gTqW6X7u2X/qt1ZjzNHcjkH9KjJK1pVeIAfvZ6MCBnRAwRQHjMigg6yA5
         H1zZ76N2M9rUbzVSvbxpPNI8ePx7NKLGarBs4ocit/b4hUz0P26Gamqe2cC/ttpmgTfU
         bkLgZDkKDpmQkDUn66gsWxvnUl4dg2G0gP8lNiefnKFHwPWoAofoN/uspG8Fz4d3YO+Q
         0Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mcPtzo6Mc48uKJRt67ru8n5CsPPRYIExPhncNpI7X2U=;
        b=OU0/mbSvuDGZijCpQE95b5rvONPMY9t1PWvMlrFWcQ0bDgniZr6XqVpa3ougUbmfdC
         6xWBzw4XI7mOxSVjC6d7iMxNQjehpgWFdHJGwSfxTDqmVvPOqgGLuVkrFl92joPLVseE
         0KOV5+YzouMZjS8guZ4CAhctc+FkxOGpYw+71hn3LEudFQBtZ7WsWWpH+vN9zgXFjCRt
         mfq1Ix4DDxCZdUK4V2jNBDTwYosJDx9nxkgStUF5rf1R/pR7gnWEUEjX4f50rrTolq1h
         r2hI6xPD/Mv5VoqeGksGE5MLV7sByorpace2e1CWnkj+HqniO2f15pVClAoHloQfpBBB
         KpmQ==
X-Gm-Message-State: AOAM530kkHPxr02HRzstc2L1OvrVdAMWsQdbWbI5dzlRvcfLwN4iFq0d
        GuFmLXZ3J2uSXvrHwptQqdg=
X-Google-Smtp-Source: ABdhPJwKPHdX+gzCJKNjuLehVfaV7WepeVwMXkhb/qivYPPrqm60yAGGQkEMaewHZREDIhU8WsEcSQ==
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr9065810ejc.387.1638987241581;
        Wed, 08 Dec 2021 10:14:01 -0800 (PST)
Received: from [192.168.8.198] ([148.252.128.29])
        by smtp.gmail.com with ESMTPSA id o8sm2616767edc.25.2021.12.08.10.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:14:00 -0800 (PST)
Message-ID: <02bcc03a-f5e1-bc7d-b4f1-323dd4495080@gmail.com>
Date:   Wed, 8 Dec 2021 18:14:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] KASAN: use-after-free Write in io_submit_one
Content-Language: en-US
To:     syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>,
        axboe@kernel.dk, bcrl@kvack.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000ad0e4105d29b6b0f@google.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <000000000000ad0e4105d29b6b0f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/8/21 05:04, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 54a88eb838d37af930c9f19e1930a4fba6789cb5
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Sat Oct 23 16:21:32 2021 +0000
> 
>      block: add single bio async direct IO helper

Looks that's the same George reported yesterday, a fix is queued:
https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=75feae73a28020e492fbad2323245455ef69d687

#syz fix: block: fix single bio async DIO error handling


> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1615e2b9b00000
> start commit:   04fe99a8d936 Add linux-next specific files for 20211207
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1515e2b9b00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1115e2b9b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
> dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db884db00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e9eabdb00000
> 
> Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com
> Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

-- 
Pavel Begunkov
