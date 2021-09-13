Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68040A12A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbhIMXC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbhIMXCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:02:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC5C061768
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 15:43:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j18so14308508ioj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUES55HK0iw4tz8fQ36vOwJ7kua+ZhjQXn4Oi1aQUoc=;
        b=HsyHrjsyxtk/pRLOhK0KaGbOsRal2ndwYEZzshaLwEtZjFWQqjaXMdutfw/BRsJBDJ
         3g8VSpQG4+DRYFyAJ8EdVFe8WumyirIss6SmrNjOwl0DoxxNPZkzgpG+jARQBeVn7keI
         fYLsfFW29dzyn+uwLz2vfzBKlPf9DcHVGvpRjHIgbTH2L2HjxtWS+t+julMro0lmNt/5
         a9aRjtvBkFqnXVtmvg5kzh7nkPtNPz3Tjgp4YWn2TKjivuJGGLl2gcUIfDk2fNPFCTg9
         nDmcYCg3Vgs50yPDsTvnO3BwWPjG+cXDkTUhC+E2hec0192znXnQwCaNOzeXQlWpqRH4
         j5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUES55HK0iw4tz8fQ36vOwJ7kua+ZhjQXn4Oi1aQUoc=;
        b=gLUw+HQpeAABipYFZk0XqipZ5KrZ1wYCkDjv5yL0nQl4VS+UoJnWa7Pb7Shtdv7k2V
         uDHG6yeyk2dn9pcA2mAxIgDa9FR1Ok3mcbiKl4mdeJXN1Pg9/oX1gI1HvLs4SWggINoY
         VSAm7yaM9dzsXcpHzdHGxTaNDwEQ7I8OXISzl7mpm0lc6ZpAorF+lhTGBMR4/2KCL0sN
         rL2oHs4A9fQGHjg7o3G3363G6k6/IAGB87RsisvfXGqGgUNa/SzJ1mhmMlFdPKitrCZS
         z81gFDdslgUUoDH7JBMjoNgwgmaCfCdaBXUjq3+3Af8fXzKN+6ngUUVOLOOLadbnthLt
         nRRg==
X-Gm-Message-State: AOAM531mzNotGvk9IOcB1hPoYal4FbY2v1+MiKEhpWwEWcjMXG+Az8Nd
        23NeENG2xW1YGaBD8P8Jzuq3lA==
X-Google-Smtp-Source: ABdhPJxuZ0DHBjEg/acw5j4hkav4vXWUG7N5redfvP+aaNuIQp5rr5KdGLiNOYG9k1YqnGvgNh64FA==
X-Received: by 2002:a5d:9145:: with SMTP id y5mr10897737ioq.200.1631573026247;
        Mon, 13 Sep 2021 15:43:46 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t25sm5334169ioh.51.2021.09.13.15.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 15:43:45 -0700 (PDT)
Subject: Re: [PATCHSET 0/3] Add ability to save/restore iov_iter state
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
References: <20210910182536.685100-1-axboe@kernel.dk>
Message-ID: <8a278aa1-81ed-72e0-dec7-b83997e5d801@kernel.dk>
Date:   Mon, 13 Sep 2021 16:43:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210910182536.685100-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 12:25 PM, Jens Axboe wrote:
> Hi,
> 
> Linus didn't particularly love the iov_iter->truncated addition and how
> it was used, and it was hard to disagree with that. Instead of relying
> on tracking ->truncated, add a few pieces of state so we can safely
> handle partial or errored read/write attempts (that we want to retry).
> 
> Then we can get rid of the iov_iter addition, and at the same time
> handle cases that weren't handled correctly before.
> 
> I've run this through vectored read/write with io_uring on the commonly
> problematic cases (dm and low depth SCSI device) which trigger these
> conditions often, and it seems to pass muster.
> 
> For a discussion on this topic, see the thread here:
> 
> https://lore.kernel.org/linux-fsdevel/CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com/
> 
> You can find these patches here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter

Al, Linus, are you OK with this? I think we should get this in for 5.15.
I didn't resend the whole series, just a v2 of patch 1/3 to fix that bvec
vs iovec issue. Let me know if you want the while thing resent.

-- 
Jens Axboe

