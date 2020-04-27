Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB411BAF78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD0U2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbgD0U2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:28:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945ACC03C1A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 13:28:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so19041839ljl.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ai+rmEpn02qg4BdEO/ZE6kOX/94j7td8pRB+ptKEnVM=;
        b=O1lgqypRxFfC+vFZsk3/9/KPI2PcZLA1mM/B20gc8yvnWS47pxSazg3digWF06v8IL
         RKAAvSH2pMe/bStrBhAr1F9weq0Mr/w01Euy1dRvf3JlL/YV1rIWnHbyzEnsfoJAv5qf
         C2xIbuvQvx9oklaGI3hdIGJx3zSFp3Uf5kvuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ai+rmEpn02qg4BdEO/ZE6kOX/94j7td8pRB+ptKEnVM=;
        b=uKS4+N+npIKwJylsJAdeqJ7yApVYq9lRGKqom4krQtCcfsJPQr1l8ntRvbAJCwN7/L
         21t/ljC/cVrFmmXyaq82WG/AgxdqVCp/v22O4jLIj/yNFufjypLh4eof2rZyZGCmmM84
         sYstoPYkfowiXgqENIPHGlISak2QsG39kmwT7VRPNiiqwgnU0z6I2kdVddCxoZVyzWHN
         72k/BdH49gV9B1dqR0K+s2Jt5TkFFiN66lID+N0HufMmcA57j/OeMAN+NJTemf1UFtKW
         apNUMwmLAgjG0DXufPS0/tAslVenUJ3SCR1JYhVoDD5w4LvRRJsi9JEOrZ/LMFMAtEI3
         MA1g==
X-Gm-Message-State: AGi0PubQ00BjxJ1XTvPLV2Ibw4ZcUC7xwUmsod580PFHoz34Yvd3N3yn
        t0jdNQ7G3sg/Ood9PNpponCEjWrPjXc=
X-Google-Smtp-Source: APiQypIb6RgPrSyaDk/qUdXg5tGi8caYciL+PEMv4y77PEjVaTfxbyKkOhFzJesY5o7GIf6t4FddKg==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr15592925ljj.92.1588019278071;
        Mon, 27 Apr 2020 13:27:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 23sm10717487lju.106.2020.04.27.13.27.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:27:57 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id y4so19084719ljn.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 13:27:56 -0700 (PDT)
X-Received: by 2002:a2e:3017:: with SMTP id w23mr15585804ljw.150.1588019276500;
 Mon, 27 Apr 2020 13:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sihgfzh.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 13:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Message-ID: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] rculist: Add hlist_swap_before_rcu
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 7:32 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Would hlists_swap_heads_rcu be noticably better?

Edited out most of the rest because I think we're in agreement and
it's not a huge deal.

And yes, I think it might be nice to just call it "swap_heads()" and
make the naming match what the user wants, so that people who don't
care about the implementation can just guess from the function name.

But I also think that by now it's mostly bikeshedding, and I'm
probably also now biased by the fact that I have looked at that code
and read your explanations so it's all fresh in my mind.

A year from now, when I've forgotten the details, who knows which part
I'd find confusing? ;)

               Linus
