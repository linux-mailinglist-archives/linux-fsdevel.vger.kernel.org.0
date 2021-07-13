Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08303C7562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGMRAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMRAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:00:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE9C0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 09:58:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 141so14468993ljj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yhm8DTXMwGH3edDwo8fP2AUueUVOXSOluzUis4TeCEM=;
        b=IouJxuG5ed7uAGJwLWz05WTIl3EyMHKLbOeZ/figWyyseOX1vqRylnWkg9X/sDBjjh
         6pRMGIxq99s6Lcm7Cc6a1DP+lO+eTYQP1SmjxNrY9YgOxxVm/OGSkQg5LBNWmcbLY/9e
         lqi5l7xqvWJEepIBLkDtBnHKIIRMeYnt4R2Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yhm8DTXMwGH3edDwo8fP2AUueUVOXSOluzUis4TeCEM=;
        b=OThoRdW3TJz7nQjEdzH03RKIaJSDIELEyybF+7tQBYjc5fJB4KoSu4IJfONaoqMDvA
         PXShou4cld0xrtmiHmQvf4NxQQMU/WaY22AQqReC6pEUVZuxwJbcNgsIjWOfvZFEo1aP
         DAfOaBzJ7UIbYv7DJNh0KD2ICHdo/gId9CHNW0hlUnhyGqMSn7Kv7VH0odCHSUn11n5J
         YtwfXc7ZlYoxsLcgqtZ83huwXEQSPaohYmBiw3sv5XBWW2BCVKJ8nrZlUu51485MiNqm
         kFM8giZTZm0V+hAL+BdS4qQlvYTBVYyoct4f4p4YqcmqiYaJo0THzvachUc/ygto2vj4
         7Hdg==
X-Gm-Message-State: AOAM532iGyrXr64QYJimE5FJihMIWHwyIUqjYHp+/rq4Fl412HMpcW3h
        4OsAQbu4C56gxekRhKPryUGOdA4UeAeoygJ3FCc=
X-Google-Smtp-Source: ABdhPJxaZ6Y7MHDH+Gi/4ViBffBqMk2pNTJdE1wrQblh/9crADs24UyzGYzjdxbPR46HufGEshGgOw==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr5137379ljk.75.1626195479280;
        Tue, 13 Jul 2021 09:57:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id k8sm285640ljn.18.2021.07.13.09.57.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 09:57:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x25so38722273lfu.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 09:57:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr3985242lfa.421.1626195478340;
 Tue, 13 Jul 2021 09:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210712123649.1102392-1-dkadashev@gmail.com> <20210712123649.1102392-2-dkadashev@gmail.com>
 <20210713145341.lngtd5g3p6zf5eoo@wittgenstein>
In-Reply-To: <20210713145341.lngtd5g3p6zf5eoo@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jul 2021 09:57:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJeGY0FAs+WLaz-cxjhYcYvF1UXtZVmqoLbZH0jqn0Qg@mail.gmail.com>
Message-ID: <CAHk-=wjJeGY0FAs+WLaz-cxjhYcYvF1UXtZVmqoLbZH0jqn0Qg@mail.gmail.com>
Subject: Re: [PATCH 1/7] namei: clean up do_rmdir retry logic
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Kadashev <dkadashev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 7:53 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Instead of naming all these $something_helper I would follow the
> underscore naming pattern we usually do, i.e. instead of e.g.
> rmdir_helper do __rmdir() or __do_rmdir().

That's certainly a pattern we have, but I don't necessarily love it.

It would be even better if we'd have names that actually explain
what/why the abstraction exists. In this case, it's the "possibly
retry due to ESTALE", but I have no idea how to sanely name that.
Making it "try_rmdir()" or something like that is the best I can come
up with right now.

On  a similar note, the existing "do_rmdir()" and friends aren't
wonderful names either, but we expose that name out so changing it is
probably not worth it. But right now we have "vfs_rmdir()" and
"do_rmdir()", and they are just different levels of the "rmdir stack",
without the name really describing where in the stack they are.

Naming is hard, and I don't think the double underscores have been
wonderful either.

            Linus
