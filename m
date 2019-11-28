Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4410C591
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK1JCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 04:02:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43088 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1JCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:02:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so4445203ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 01:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0ArWTMK2M2cZ2zXfxSef0laglMj50lskLz/N/COoyI=;
        b=G6glzc+N9b1z4gASSZC5AEd2jFJOL3n0eIWVnAe5AFj6b9KL8p9l0fGtPjZWwqloVc
         MbFAw7gXgY7/o9XSopUwxaWCYsOW18S4HjAnf9itzbbDFUaNMz31hPcYOSVv9JEZ7K8h
         ktQw5DrGfazKfaU1IQ6XlCNocKnC3bQUx4EY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0ArWTMK2M2cZ2zXfxSef0laglMj50lskLz/N/COoyI=;
        b=B5C9nEHMdAQ+FnT6xqUg5d71tcU4remtzRRsJ8tO8pGExQMdAnVOY+YsjkWbNYFNYq
         i53Yo8+1RaAcbsZlYTWUzB8c8EdsaMKpWELAYQXZ4acoYpuhuGgwG4XK1Mwggryc+jZo
         MtXtDKk2oQuFiQG5v3c1nliBEl69KTrsExNiXQrL1gqwGhidr2ohX6n5yXH7SF6ryZVp
         L+bnrHigRO3raqhnCsgzEL7rNXbFGEZIyiqD75nVGrynDptXaAyKcgZNwyoYXxMPImL4
         qAjxJNU/Zt37ieSc0V1pqNx2vEBLyuaQB4egd+nDcGmbjYNKbSAofesXKj113KeRmEVs
         ZHqw==
X-Gm-Message-State: APjAAAV44a4j/QPnuyJLH2kl1qOtmAGQDURbVXEOsbzYWYfLzu51uFW3
        RozJe51oGs8tl6JcNgktWuKUJeql9/vIdMz9
X-Google-Smtp-Source: APXvYqzK+0aH2OxqnNebVIbBxsAx+sVVUV5///KJSvWtCfimRUSUBpmooYcKVoc1aZPo9aQXeAPhvA==
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr33630972lji.191.1574931766022;
        Thu, 28 Nov 2019 01:02:46 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r125sm8265681lff.59.2019.11.28.01.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 01:02:45 -0800 (PST)
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
 <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
Date:   Thu, 28 Nov 2019 10:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/11/2019 00.27, Jann Horn wrote:

> One more thing, though: We'll have to figure out some way to
> invalidate the fd when the target goes through execve(), in particular
> if it's a setuid execution. Otherwise we'll be able to just steal
> signals that were intended for the other task, that's probably not
> good.
> 
> So we should:
>  a) prevent using ->wait() on an old signalfd once the task has gone
> through execve()
>  b) kick off all existing waiters
>  c) most importantly, prevent ->read() on an old signalfd once the
> task has gone through execve()
> 
> We probably want to avoid using the cred_guard_mutex here, since it is
> quite broad and has some deadlocking issues; it might make sense to
> put the update of ->self_exec_id in fs/exec.c under something like the
> siglock,

What prevents one from exec'ing a trivial helper 2^32-1 times before
exec'ing into the victim binary?

Rasmus
