Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10928BB80E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfIWPgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:36:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41719 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIWPgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:36:32 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so34438951ioh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giOjH0e1+Va7zF2km7iWPR2tjwuOyQDUdxfszpw7LBI=;
        b=W1akfRBTIQi/Yu602zJ+J+cmVzk+bDRreA4SeyTFjAYb08P+3gBic98jasS/hmmw9p
         XDGLdYtDJVumghJvStKdUnxMo/zVPf79ptQds8PH8aVOa6/J8yenqKipvssFUBrGT4l6
         +57S66axARoIwbAlZAeCNYIOK1q76gf3TyLNRYKFG8DV6SOEETjaJ+VkvS1Co6cxR7d1
         TP/B395inKk9JvVShp+3VswuGkcbt2qLHnTL5HxTveEjol1kXXhPq9K9hlbVnV38EeO/
         9CElfQE+CTb4kol1tQOyrgI6kh+hzokHd2P4nwDlyyLhlKGjWXtqawsbj+8xNtwRPYwG
         5BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giOjH0e1+Va7zF2km7iWPR2tjwuOyQDUdxfszpw7LBI=;
        b=ZvJX+WlbiR2tCLtWeoeSmMubgtbUF26ZKC81hQwdnmqIfew3ZfKUp48B50XHxpibkH
         6ZpCqYb+CGTPkpD46I+8K8TidLaa4IqQ7qUyUlR+E7t7ya4BcFl/7R7WTU/lGphsow85
         G+jZz0zJgzPUw7/yIVy9aEqrOUhvN3MtY7rybpgAbh8Do6gn4JqE5xolgFHYWXH5fjdP
         LJ/F1yX+771XApQvISd070mr1431DxCovuk7Ws12Wth+3qcCLarJKcH1fyxDIji0FJjG
         7Djfvyj2ICDp4GGFuTNIJkgF6hgvo/OtrC8Nd1MOiJI7Zs16yiPhtUVaPZn9yMuyOj9u
         2UNA==
X-Gm-Message-State: APjAAAXTgGaaMIZxO3kwGCj97iMUxg9/5GUqClr+28f5CY9AAgaD0LDf
        H/tJS0oWdCko4Ar4Xs/T0rHXQg==
X-Google-Smtp-Source: APXvYqyyeaV/OyAPAqNs2hYQiUiDuqJkFJdUHUadcPjHwBqQTyy/QJlYetTj8pSmsVvgbE3+nY2hWQ==
X-Received: by 2002:a6b:fe0f:: with SMTP id x15mr2644657ioh.188.1569252990417;
        Mon, 23 Sep 2019 08:36:30 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f12sm13027077iob.58.2019.09.23.08.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:36:29 -0700 (PDT)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
 <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1882a6da-a599-b820-6257-11bbac02b220@kernel.dk>
Date:   Mon, 23 Sep 2019 09:36:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/19 5:10 PM, Linus Torvalds wrote:
> On Fri, Sep 20, 2019 at 4:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>
>> Now, I hear you say "those are so small these days that it doesn't
>> matter". And maybe you're right. But particularly for slow media,
>> triggering good streaming write behavior has been a problem in the
>> past.
> 
> Which reminds me: the writebehind trigger should likely be tied to the
> estimate of the bdi write speed.
> 
> We _do_ have that avg_write_bandwidth thing in the bdi_writeback
> structure, it sounds like a potentially good idea to try to use that
> to estimate when to do writebehind.
> 
> No?

I really like the feature, and agree it should be tied to the bdi write
speed. How about just making the tunable acceptable time of write behind
dirty? Eg if write_behind_msec is 1000, allow 1s of pending dirty before
starting writbeack.

-- 
Jens Axboe

