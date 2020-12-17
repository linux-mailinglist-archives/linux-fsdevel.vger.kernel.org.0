Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A782DD945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLQTXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 14:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQTXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:23:52 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C185C061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 11:23:12 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r17so26811380ilo.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QrwC6GPjarKOSesNU/nFpqVImO7JnoCNayskjtahWs=;
        b=vMcj2+x04rTqDH5+w9XUka0PNQrNUvNtRXjgbQnT/B7cId8qsAMq3HpwHuVHNb4sfo
         3B++5boZ3oiNv4SQ/eyuJQQWmwuEjVmpvDp7on8ka/GqK50QXG/NYYEzQ9Qj0XYpwwQ9
         sPz+aPZKw3N/w2WnWOlAKLmErbB7yS70PxYnteZZswc7R4JgJLaANuwsxDtJaqc8bO+E
         Ja0QjMcnzO/mUJBi+GS4yQlqzNo7MziZLtazmcNlsRkNMcjfL43Srposwz3eD4pFAOak
         9MUakiNsvQsAG+DPKFY5foNsVdlmATqRMTr/GO9Oy+rpChXUYltzF8E+JCEvb53GFyeE
         UbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QrwC6GPjarKOSesNU/nFpqVImO7JnoCNayskjtahWs=;
        b=PYB50EsiibbNoYgqAbqelGBqnI8h/nqXCiHkaMSn3XTPD+T6HRkuIuiPtyd0OgZQWm
         j+oCDQXJaDB/7ylr8sibJm2nolV6Z0a5Ms3X94hrBHNhTldchkthHSAEVdkyu36NYJB4
         xIXTPMMvQCwHTjTo80Zg2+L4KHB5xgVyl8n8Ep3+BrKfsyihccK37/BfImG5CV4tvCL9
         4N/tJEvuqFVZMW0kW1WJ9zaR9erMc7KepSf+xgRqI98ICUGRTsksPdlgpKUaA/Q81msY
         JlKtJwWiDpDKrxHYmtiKDrl53Zv1RYU6sIk4rtx6KZ2IuTHzKd0sZhge74xTAK0esLgh
         v4qg==
X-Gm-Message-State: AOAM532UTJND+w2hO/fPjT1HruEt+h3b+Q6mkWeapZVJ+588X7d7m0lM
        fl20ehxsRDrCuA1M/RUb7EBrFizd7CED0w==
X-Google-Smtp-Source: ABdhPJy4UsGPYepbuG7HgDZ6NkTIed0TVfmKPboxbGuN8uGeWesuA4HfMQ1/Q4BRWbUzFAW5vABh7g==
X-Received: by 2002:a05:6e02:4ae:: with SMTP id e14mr359900ils.132.1608232991132;
        Thu, 17 Dec 2020 11:23:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n77sm14947959iod.48.2020.12.17.11.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 11:23:10 -0800 (PST)
Subject: Re: [PATCHSET 0/4] fs: Support for LOOKUP_CACHED / RESOLVE_CACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201217161911.743222-1-axboe@kernel.dk>
 <CAHk-=wjxQOBVZiX-OD9YC1ZkA-N4tG7sjtkWApY8Rtz4gb_k6Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ccf2292-01da-4ae5-c7e4-db34f824a5c9@kernel.dk>
Date:   Thu, 17 Dec 2020 12:23:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjxQOBVZiX-OD9YC1ZkA-N4tG7sjtkWApY8Rtz4gb_k6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/20 11:09 AM, Linus Torvalds wrote:
> On Thu, Dec 17, 2020 at 8:19 AM Jens Axboe <axboe@kernel.dk> wrote:
>> [..]
>> which shows a failed nonblock lookup, then punt to worker, and then we
>> complete with fd == 4. This takes 65 usec in total. Re-running the same
>> test case again:
>> [..]
>> shows the same request completing inline, also returning fd == 4. This
>> takes 6 usec.
> 
> I think this example needs to be part of the git history - either move
> it into the individual commits, or we just need to make sure it
> doesn't get lost as a cover letter and ends up part of the merge
> message.

I agree, and I think the best approach will depend a bit on whether
Al takes the core bits, and then I'm left with just the io_uring part,
or if the series goes in as a whole. In any case, I'll make sure it
gets in as either the merge message, or (at the least) in the io_uring
enablement of it.

> Despite having seen the patch series so many times now, I'm still just
> really impressed by how small and neat it is, considering the above
> numbers, and considering just how problematic this case was
> historically (ie I remember all the discussions we had about
> nonblocking opens back in the days).
> 
> So I continue to go "this is the RightWay(tm)" just from that.

Well, that's largely thanks to your and Al's feedback. I did attempt
this one time earlier, and the break through just wasn't there in
terms of condensing it properly. I'm very happy with it now.

-- 
Jens Axboe

