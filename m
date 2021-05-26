Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE11391231
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhEZIY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhEZIY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 04:24:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17FC061574;
        Wed, 26 May 2021 01:23:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r5so1268774lfr.5;
        Wed, 26 May 2021 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSqjrsXezTbDFWd100KELYDvThlsd4fIGxzsgNGx9R8=;
        b=q5pLzgjnYzl3rQMzEuaQagUz+19noKkkzD9vD42K/ABo2EwqCW7+ClqhVKixePFZu0
         1ZWu69FB+xa/t3jBWUrbzjxVFGHxWC/OG4AmbLuROJkLWNIcIGEVQgu5pMcoL10E4z7b
         IuvXb48ob+Ipeu5hzFatZP7gRNMx5oAXJ+NrD8tiuLu7XCzogVKUquGPirJLtPv6ZBq0
         zrTwNrpO8qCLhz8PwIm9RKIK9NX5LWDipZp+6g8eO8tCYpotiVYyr2Fpy4l3HKkVMmzi
         zLP5oeicelrDdb7g0pt4/mPMAQlXcCsEq19vddwmT+CPbLapcVUmnfXrkgJZGX3LdFvU
         8NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSqjrsXezTbDFWd100KELYDvThlsd4fIGxzsgNGx9R8=;
        b=L44Xop6DKVwxT/qAsIe/Krpl8FmQD1yHXcKUC7qgi5dfFIw4pleF9tZHsqUTfB+Ngl
         tTe0siS1YGu7vQ6kpdLnfcza4nkDeBcM8o6PwHuW6iKPXXcRLpid0cUBv/+vQYoFoWO8
         VH7ZMBUac4wfwgka/AgfZBaZOQu0+EqylHzluT3Hf0rVsevIaEWCqtn5XJ8vGxDG/g++
         /g8DPvgb82a3vKcLmqWjkoXr+3yxaUdP7ajmbsYoMS+SlJz8z6Rp8L0xOhPFDnXktVwi
         KUplApTAA3axt92ociSLUNxDkIp6ehrCCfGY7xP7gOQev6mFXn8mo+omthPYbldJHYJH
         T9XA==
X-Gm-Message-State: AOAM530BA4hQmuWXJdEuYt5H6GJbNjbcvHO+2R9mzKQ8yiYwmlfhB8gK
        p2qCZJTmHaUt7Pz1OTzYT4DVGIrB2ynvUQw6oCo=
X-Google-Smtp-Source: ABdhPJwpa61yD+QYWHzs+rtjuVwGtAem8Wc3UfQPJuJzFgR5hGlDs78zOzOaZBjUy+SAP1JR0p1muv7JG5ZSFxf7R+I=
X-Received: by 2002:a19:ad44:: with SMTP id s4mr1334728lfd.563.1622017403078;
 Wed, 26 May 2021 01:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn> <m18s42odgz.fsf@fess.ebiederm.org>
 <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com> <m11r9umb4y.fsf@fess.ebiederm.org>
In-Reply-To: <m11r9umb4y.fsf@fess.ebiederm.org>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 26 May 2021 16:23:10 +0800
Message-ID: <CADxym3bwK3c+E7nKpogT21jMPOZEZeLa8zauxSu0VHg5AAz-Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, Chris Down <chris@chrisdown.name>,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        mingo@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 11:23 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Menglong Dong <menglong8.dong@gmail.com> writes:
>
[...]
>
> If we are going to do this something that is so small and clean it can
> be done unconditionally always.
>
> I will see if I can dig in and look at little more.  I think there is
> a reason Al Viro and H. Peter Anvin implemeted initramfs this way.
> Perhaps it was just a desire to make pivot_root unnecessary.

I don't think they are meant to make it this way. Unpack cpio to the
rootfs directly seems to be a normal operation. Maybe initramfs is just
ignored by pivot_root(), as it seems not a common scene to run the
whole system in RAM that time, I guess~

Thanks!
Menglong Dong
