Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BD485BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 23:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiAEWuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 17:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiAEWuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:50:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04786C061245;
        Wed,  5 Jan 2022 14:50:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e5so652932wmq.1;
        Wed, 05 Jan 2022 14:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xYoFNqMSvj9LOjKGYsSwaSyvDg/m5HuyIVAO3qaK6pI=;
        b=UQKRjS0j6OtGq9O+Bbu24ZShb3cSZVcgBQWCgGFqjXahW1vO4fhfK3Gpq20yy58uHb
         /5CLDckat1ihjTDx9M+f04m62CCcnien4Kri465q06WrMdkCD4BLg169vlqZDAa7t10s
         9Qtx4uFJvDXql5fApyk9GC0pXQOm2hrnbk/L/zhk3EfJiFP45LUCy5j439aUY4WW1Qid
         S4jfKLb4TOIAKT+Y0rHiB/JbfsYt7ml/qAaVtnS+Jxyj2hpsluYbwcOtH+o7t/XcL6nB
         npI2kAhLOwPDcRwBiw4xrCY7exnZVOJeJvle+ZC8bPYXEQi8tdLRvOk0SO+r5rpL3U6/
         WZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xYoFNqMSvj9LOjKGYsSwaSyvDg/m5HuyIVAO3qaK6pI=;
        b=hrFCyqGGAR6YSxBJlCa+C5ceAIbCh74so/9hGBqJ3qcGo7xVgyBrFt8rNwHbfJTSgh
         T+AnHDHEDrZMg0vKdwrkQBSd7AHTpsH59QG3i4kiE25YTmEPhhYyKCHApOImEXFTvC0I
         wAonh3ODf6kRlYiKtn34MjoxxNmZVT4oxVgHs7LvtJTVH21INWccmuMyvoYmgRZnNVMA
         UINA9iSmsZPgNg8yq/ZrI+LEZxyOjN1sb+dq0uTcvxFLAblhCvyLYpQJaGYuahzKHTho
         AcEEHgRgMJ54o7lfvYdUezBI+ynEN4AWC9d3baeyk6G7emHqQjBZlKUT86jIXUdJVHF4
         018w==
X-Gm-Message-State: AOAM530YBv/3X0Ll9xdpPYLrwHoyWig7RLaRq073wksVD+ldPz7FxBwL
        FS/N+I+PPZA18mKRM2rofD8=
X-Google-Smtp-Source: ABdhPJyc4Wk+B8IPyL5lo1k7+x6pnWhFwBcYefM5EqlnLufdLDNfG0QeuqSvzu/OlvT9FSWl1BhBAA==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr4201773wmf.56.1641423007667;
        Wed, 05 Jan 2022 14:50:07 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id g5sm289300wru.48.2022.01.05.14.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:50:07 -0800 (PST)
Message-ID: <51fee051-cacc-14bf-0095-b301380bd1ad@gmail.com>
Date:   Wed, 5 Jan 2022 22:50:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220104171058.22580-1-avagin@gmail.com>
 <77862a7a-3fd2-ff2b-8136-93482f98ed3c@gmail.com>
 <CANaxB-zM1EhPR1f4tubCQTMEMAuRAtAWYZsWFTVhfeqYMHhKdg@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <CANaxB-zM1EhPR1f4tubCQTMEMAuRAtAWYZsWFTVhfeqYMHhKdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/5/22 21:47, Andrei Vagin wrote:
> On Tue, Jan 4, 2022 at 10:54 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
[..]
>> Otherwise this loop in free_pipe_info() may become lockup on some ugly
>> platforms with INTMAX allocation reachable, I think. I may be wrong :-)
> 
> This change looks reasonable, it makes types of local variables consistent
> with proper fields of pipe_inode_info. But right now, the maximum pipe size
> is limited by (1<<31) (look at round_pipe_size) and so we don't have a real
> issue here.

Right you are, I haven't noticed it.

Hmm,
:	if (size > (1U << 31))
:		return 0;

Isn't size == (1U << 31) a negative integer on 32-bit?

[probably, the question is not very related to your patch, though]

Thanks,
          Dmitry
