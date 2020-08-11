Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B740B241C3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgHKOVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgHKOVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:21:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89210C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:21:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so6891149pls.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kpp0GdsRYi0omTcELeAUu1IMsTjPcKqE7Mbm6MS6NsM=;
        b=nIVENNECr3scMV3Vs0Pk19gB4ND0y15sXhPBCf6HIrSOLZcwArP5jkRsMgiiQTGGTT
         K0gMxPkFjppSFqMHHcUessGfQrn6yLDwJVujYkXTbgWxsrBk81BWCRbILztlDnoLnIeC
         BpyLr590T6RGyyAtJD9fxl1IUWlqdwNvb5Ln8ftjU4NOEtRmEp3zQx5JmssgcR4DzXi8
         Mp19H0InTGtz41UCno+m+z6cPqH/ruxaU9dY8w9qr1hSyROsHdH5a71TiiykxPR+G4pq
         9HkTKlqfovpph0d9YnJbb1rMkgNhlWiWtUDEkRgHqMjRBFvZoWMi20V++sq6rE6Jkni8
         pRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpp0GdsRYi0omTcELeAUu1IMsTjPcKqE7Mbm6MS6NsM=;
        b=SrKXRgSemzYwz4woZU/BEDo4xuAH1aeCsJXSMXBje0+m+2aoN0wSdQ7V+Ukm78zav/
         Laexir+UT8HbUlinBGIlvfIuDFR5n2czpX3D4+ZZ/vuNsaQWWRX57O8KvV4ymrDnCoQq
         KH5j91ichttgPBLYYJSNVs7wy4w92rIjvQy700p5dB13hkyXF+4npu0CwzQK0IjGivPf
         8FM5wWJQjcewPKOJkm4+e4DX0CkuVT59ruE9n6O7ANelw0uJVfvwvGIl5QrNskLFRFJu
         NBehKmAJF0eeVuSPpAuf2vikXokjDRWwvH5eiuoWV6y+iQpJk1dAP8eyUeP/uqkhcbjk
         v3iA==
X-Gm-Message-State: AOAM531rycXg2LZe3pxaQ99b1UDKfigWUw6KnAc4wr/UxbdUbEWyem6b
        m8GlnTDKKw+jCNk67HSL8/C4Kw==
X-Google-Smtp-Source: ABdhPJxfOVBzlRW7S7Ar5cYVRxLsJ7EGz70ufrLcvD+osyMmeYUOi6NLWrhlSTcaWP9RyHAaH9gABA==
X-Received: by 2002:a17:902:b941:: with SMTP id h1mr1142974pls.200.1597155674883;
        Tue, 11 Aug 2020 07:21:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j13sm26263358pfa.149.2020.08.11.07.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:21:14 -0700 (PDT)
Subject: Re: possible deadlock in __io_queue_deferred
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     syzbot <syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000035fdf505ac87b7f9@google.com>
 <76cc7c43-2ebb-180d-c2c8-912972a3f258@kernel.dk>
 <20200811140010.gigc2amchytqmrkk@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <504b4b08-30c1-4ca8-ab3b-c9f0b58f0cfa@kernel.dk>
Date:   Tue, 11 Aug 2020 08:21:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811140010.gigc2amchytqmrkk@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/20 8:00 AM, Stefano Garzarella wrote:
> On Mon, Aug 10, 2020 at 09:55:17AM -0600, Jens Axboe wrote:
>> On 8/10/20 9:36 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    449dc8c9 Merge tag 'for-v5.9' of git://git.kernel.org/pub/..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d41e02900000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d25235bf0162fbc
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=996f91b6ec3812c48042
>>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c9006900000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1191cb1a900000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com
>>
>> Thanks, the below should fix this one.
> 
> Yeah, it seems right to me, since only __io_queue_deferred() (invoked by
> io_commit_cqring()) can be called with 'completion_lock' held.

Right

> Just out of curiosity, while exploring the code I noticed that we call
> io_commit_cqring() always with the 'completion_lock' held, except in the
> io_poll_* functions.
> 
> That's because then there can't be any concurrency?

Do you mean the iopoll functions? Because we're definitely holding it
for the io_poll_* functions.

-- 
Jens Axboe

