Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD33EF84F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 04:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHRC7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhHRC7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:59:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24DC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 19:58:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a5so920778plh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdmIuyF92LGiV6+vakUJJZRgq/yRSpMjmpEbsFkYVp0=;
        b=EKqkwTTEMNNBAFF+3R0Qo936G9BTekrWtCEpqQLICHJ2cQuyZp0QKf9/pF8tEYK5/1
         OtpZObMcTQyTgswjnHashw91VbnSamMwr5ATlkQcRhSHIPgiLx4+qPXLqg1zq0m3BwXh
         cbyqkmpocLct+z1g+fs9FdMEqiM3uMFgxoznEvvWOYDtt6v2BdoiGCwCRdfwfJRrHW2L
         eR6HUzYqFYOArD2wxHZexnY/2DwuSca7mij+hloGKsLijV+YW54Do35hmSjF5XKpC3zr
         wKtNRMxx902AzeDelruMYoyEaH2SQTls4zmcrsNpyf0CCr2WqIlvCnEAIk02OGuQ409B
         veSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdmIuyF92LGiV6+vakUJJZRgq/yRSpMjmpEbsFkYVp0=;
        b=YpNDyvlG1rfcqJaDwsyG00mPOD69SF/1CWQvjZm6bxiUZUJjKgfyKUcQ6yyhJSN2sR
         mxmGJmj1hMg6kjX8oynJUFJwjKdmZY9WvIu+hj3h2hLyhmW9G+ddow3Ioh2QTRjp7s75
         wmDWJnzsbcDqMZfKLw04rFIaME1vW4Ts8h6YhuXbHHN/6BvNhXTg1t/BxpokEvpug625
         37NnZn1Y/FBcNujGy4yT+eCw47JkGyOdxJl6cP7p3CuKNBpFFuCHX55+8TlVVT9vcB8L
         OAlQ+FJLF8lEZE0wziMq/iSxIxsdDzlXcfvRc76XPWAGtbRpIh0e+hcFL0VDpxjBPRr3
         qpWw==
X-Gm-Message-State: AOAM530J+/8fJZuJRTvQUjQY2gcC4KRSdc0r7hJgQNyVcc7SaoLZDh9t
        dcf0POVckzNUHxpDwB82PyCSow==
X-Google-Smtp-Source: ABdhPJyy9CJWGbwRitw2QgxNzSiCer2iVaqihxz8Cfeb1xWDFJoq7aO3SRaoVyD94PhspH28aWD6mQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr6838904pjj.165.1629255509787;
        Tue, 17 Aug 2021 19:58:29 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 10sm3806486pjc.41.2021.08.17.19.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 19:58:29 -0700 (PDT)
Subject: Re: [PATCH] coredump: Limit what can interrupt coredumps
From:   Jens Axboe <axboe@kernel.dk>
To:     Tony Battersby <tonyb@cybernetics.com>,
        Olivier Langlois <olivier@trillion01.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>
References: <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133>
 <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
 <87y2bh4jg5.fsf@disp2133>
 <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
 <87sg1p4h0g.fsf_-_@disp2133> <20210614141032.GA13677@redhat.com>
 <87pmwmn5m0.fsf@disp2133>
 <4d93d0600e4a9590a48d320c5a7dd4c54d66f095.camel@trillion01.com>
 <8af373ec-9609-35a4-f185-f9bdc63d39b7@cybernetics.com>
 <9d194813-ecb1-2fe4-70aa-75faf4e144ad@kernel.dk>
 <b36eb4a26b6aff564c6ef850a3508c5b40141d46.camel@trillion01.com>
 <0bc38b13-5a7e-8620-6dce-18731f15467e@kernel.dk>
 <24c795c6-4ec4-518e-bf9b-860207eee8c7@kernel.dk>
 <05c0cadc-029e-78af-795d-e09cf3e80087@cybernetics.com>
 <b5ab8ca0-cef5-c9b7-e47f-21c0d395f82e@kernel.dk>
 <84640f18-79ee-d8e4-5204-41a2c2330ed8@kernel.dk>
 <c4578bef-a21a-2435-e75a-d11d13d42923@kernel.dk>
Message-ID: <212724bd-9aa7-c619-711c-c156236c7d1a@kernel.dk>
Date:   Tue, 17 Aug 2021 20:58:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4578bef-a21a-2435-e75a-d11d13d42923@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Olivier, I sent a 5.10 version for Nathan, any chance you can test this
                                     ^^^^^^

Tony of course, my apologies.

-- 
Jens Axboe

