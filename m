Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2964643B477
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJZOmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhJZOmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:42:21 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DC9C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 07:39:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q124so2189038oig.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjAuML0FYsK0Wj6Qb64twjoUiWDf+ojAMRFuxZhieKU=;
        b=YZjWc10pAkmfzibp8ipztzExsLuxLcpy6FLbWuMPU0RLFfTtgTwY1bdTHTm3O6Gx9+
         aiy5Cq/Y93fdYOOnIHR/0v0vJteVMAqcCtqcJaaA0O7vIshPGU5jkz4IzBh7F2goo4y2
         8lCNbFKeYE2JGApBi8snuqe5tfNOHDRZJTdXhdimq7IPw98lQN6uQYuLOB1YhrZqM3ge
         rhttOqdgS5U6N+joSuiJ2fQ6RWkWyeZ03bzP4ojoK1+0ycFf0u+S6nwl2bnrBeC2/Ihx
         YIynIL9GvCwc1yQKJ7gsV5h4SGX6amFPp15/nITbTv54Fk3PARYpAU+wtKXYU9JfwbV7
         9Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjAuML0FYsK0Wj6Qb64twjoUiWDf+ojAMRFuxZhieKU=;
        b=krSmPFjxmuHdJ+XKXaSsJndwYxG3nP7q7ApJOEX9G9L5K5IzPiexv7LFuJtN3psSTx
         7AwS++m5KEAJSeCLfSgG7CLmx6tFAzXkxe/NxHEH84ZDqwsoi0CDj2LhmwSqmeThQgbg
         VLAkOzgZYPJXjp8Fn33yc9/aaQdWSfKNZVMSw+GIuICJBRWSUqPKXAVWfeO0oAzUV/VF
         PGBxN/39MpIVysyr+oB/L8bMhkBBEvIHFlNW2DhZFH9YVXQwFeU2tGu6f57u/0REcfAE
         RzQdAJ1ehhePtkGSEdUne7iticafR+jCF0qcmXtTlOH5AAcumzo98tb8w7BP5OVp6niU
         OUqA==
X-Gm-Message-State: AOAM531kZmol7RQPqqUlPKTF6FPSWrGc86KwHU9SUI286egxu0CRXwSK
        Fe+C2XH04xFe+rj43omluf8ykivdaAysPEMcC6RoEA==
X-Google-Smtp-Source: ABdhPJwZlV+eF1/b+gpsZ+xiCAcr9RKR6tA5lH1mhqPKofXvsilv0RQu4ZtYZImDVf5G0719OzeKeBC/9uuDTJliTew=
X-Received: by 2002:a05:6808:191c:: with SMTP id bf28mr27992915oib.7.1635259196625;
 Tue, 26 Oct 2021 07:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ddb95c05cf2ad54a@google.com> <CANpmjNPC6Oqq3+8ENDfM=jXUtY+_zWHAkAE5Wq87ZMYZMV6uLg@mail.gmail.com>
 <20211026140729.GW880162@paulmck-ThinkPad-P17-Gen-1> <20211026143337.GA1861432@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211026143337.GA1861432@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Oct 2021 16:39:44 +0200
Message-ID: <CANpmjNPu876ApAQzODM3OCY0uitkw9SuucNcpW9gRq19rrjuGQ@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com>,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021 at 16:33, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, Oct 26, 2021 at 07:07:30AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 25, 2021 at 12:31:53PM +0200, Marco Elver wrote:
> > > +Cc Paul
> > >
> > > data race is in rcu code, presumably not yet discovered by rcutorture?
> >
> > Quite possibly, and I will take a look.  Thank you for sending this
> > along.
>
> And this is (allegedly) fixed by commit 2431774f04d10 ("rcu: Mark accesses
> to rcu_state.n_force_qs"), which is in -rcu and slated for the upcoming
> merge window.  But yes, still a bug in mainline.

Thanks for confirming, then the latest incarnation of it must then be
a dup, and I'll mark it fixed:

#syz fix: rcu: Mark accesses to rcu_state.n_force_qs

Apologies I missed there was a previous report and your fix.

Thanks,
-- Marco
