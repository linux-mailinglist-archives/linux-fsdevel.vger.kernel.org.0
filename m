Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F028826239F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 01:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIHXee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIHXea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:34:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66063C061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 16:34:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so467355pfc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4HrkVBDdSztaoOjJqy3mdmyRFgVANQWzA+9waayHCYA=;
        b=u11P+PRulRREYp/VsWb5uscxyszxeRv3edudPvEJ16z5O0KJ+DqMft5CjoH4uAUCOp
         TJc6T4MV7I4tgySi9haP/Vv1D0k7rnZRV8fXRLYytt34NIAC4FImrcJ8/nYuUq1sU1hA
         emWB2khEQwWZl6niP9PUJWCYR0KxKtkqsfW/n+2iWGduPjSQvU+VPi0tDXRSGdyGojO2
         CVlT9pWzMOjhxEMYHE7zcZIMDB/CrJFMj5FvcxiGJAuW9Jq5TrZNsT0b8mGoWkbrGoKx
         18tyICJ/AxXiGLv/JV/d0jI7L+wVX3e8nKWItWY4aw7F9Bwp/YkTMgQXHFLO4ht3wg94
         Idew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HrkVBDdSztaoOjJqy3mdmyRFgVANQWzA+9waayHCYA=;
        b=RkoMzgPSQ2114A5gM5uu0pEsXyYhRLBPDqEk6VdZejzHdwkfQNBBz4ebYOT3CJOXcg
         zb3cRpP2tmU6jnYJbWLlAUDx2dpNiXuZqPVzoPQGQXW7Sf81/zmOmH+Va3YR2dGRnXFj
         YYHvIXmj5oHDzZ+GpZDJb9lOcR17/cStQdv3B3257BXlxC5jpNxNA1Q0myMmy2xDWWtZ
         9v0QnRb/ARB0eM7devi88P8Udkt70lHH2DNBozEcurJrAoDRTw7+Bhxd8lYrq31/GoyM
         kKIDy1VnyLaJMNrCvB364tsey/tIDq6AnZ2auKUy9pbBgPch6/0hTN9MYuzrgsUgmEcd
         +1Bg==
X-Gm-Message-State: AOAM530KMGYbgboT/HD8P8Hn63KTy8JTtNffFcjaaXMlVDlcACBo/Oe9
        Mw1C+DVdsh8hmPBiGhol/0xIDw==
X-Google-Smtp-Source: ABdhPJwaXBjoCop88KqOTK4/ZX75q6XE+iMB1mJmEx1t0iV2J3qqVqngBHzQB1rtrKx/odO06oQP2w==
X-Received: by 2002:a63:ff5d:: with SMTP id s29mr892130pgk.442.1599608069307;
        Tue, 08 Sep 2020 16:34:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::1926? ([2620:10d:c090:400::5:4e45])
        by smtp.gmail.com with ESMTPSA id c127sm458986pfa.165.2020.09.08.16.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 16:34:28 -0700 (PDT)
Subject: Re: [PATCH next] io_uring: fix task hung in io_uring_setup
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot+107dd59d1efcaf3ffca4@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Kees Cook <keescook@chromium.org>
References: <20200903132119.14564-1-hdanton@sina.com>
 <9bef23b1-6791-6601-4368-93de53212b22@kernel.dk>
 <8031fbe7-9e69-4a79-3b42-55b2a1a690e3@gmail.com>
 <20200908000339.2260-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7a4b985-6f22-96b7-d84c-cf3c91ddf79c@kernel.dk>
Date:   Tue, 8 Sep 2020 17:34:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908000339.2260-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/20 6:03 PM, Hillf Danton wrote:
> 
> On Mon, 7 Sep 2020 06:55:04 Jens Axboe wrote:
>> On 9/7/20 2:50 AM, Pavel Begunkov wrote:
>>>
>>> BTW, I don't see the patch itself, and it's neither in io_uring, block
>>> nor fs mailing lists. Hillf, could you please CC proper lists next time?
> 
> Yes, I can. So will I send io_uring patches with Pavel Cced.

While that is nice, it should not be necessary. We need to ensure that your
emails reach the list, that's more important than needing to CC a specific
person, because it still means that everyone else doesn't see it.

Do you get an error from vger, or does it simply not show up?

-- 
Jens Axboe

