Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C558400C7A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhIDSKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhIDSKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:10:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15222C061757
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Sep 2021 11:09:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q21so3952808ljj.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9cCKBvhWQzJ1D49VIyTebPGrZpxmsDI6MMA6+ICjqw=;
        b=HJK+uwndSZDYMHUzAH2y1VYzz3qQkff8CaYRr5jvVhT2+rmi0k+i0J+wr5bTW0pCiz
         sPI+5NNf1wFJW96mj0g6PLOostmhaZo4meoyhQw7fIIveBocpxXBQU4fJ1dr69eLoWac
         XydqvnVnJB2yWg7x8Gy8VphD1A+JJ5CU0SoZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9cCKBvhWQzJ1D49VIyTebPGrZpxmsDI6MMA6+ICjqw=;
        b=FolE7ZAVk2Nj+y9VLeyfXMGkhG1yEBYHZCYRRl8yelEsfDncFnRlfpBjejNWbzs1vb
         wEHXsNRL2WQwkXXI4bhgLXyR0YAtLcsu+JO0LiniBfq5WMRlc/NVqMACMp0EKqTkHy/R
         gj18x0K2KIRTRPDwoKMxB3Tts7ZBZUMcoOtakp9IWVBY4j9PvtPFkXhmfD9DCdRQtf18
         rwiwLhaYrl/kUi6pcKo9iZwTc91Cs+5yffS1xLOuq8WaQIuLVeCZ41Kat59mVrdRSqWM
         2+Bi6ENd3CcGfBCOjnOUc+1ZBEtfriq5eYfYDKP9E8hg9eVZpavsIMRzyjWftQPsbt+d
         t6ag==
X-Gm-Message-State: AOAM531VaeppanOoTRXVD8nLxleTcLWDHI1bNRLhJlpdEdq/R6ooj2fg
        7LhQwpdhOD1wLGQF9gdAoJofJrPaTxfdDF+h
X-Google-Smtp-Source: ABdhPJwk6WTDPU9y2MinPwMvXPRjqfTS3eNVCC62n5EV+EBhB66VO/NZYIh9uNFC+x/vIElPGyzmCw==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr3684656lje.386.1630778956674;
        Sat, 04 Sep 2021 11:09:16 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c10sm345508ljn.54.2021.09.04.11.09.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 11:09:16 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id c8so4956597lfi.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 11:09:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr3726453lfu.280.1630778954535;
 Sat, 04 Sep 2021 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com> <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
In-Reply-To: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 11:08:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com>
Message-ID: <CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: new NTFS driver for 5.15
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 4, 2021 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For github accounts (or really, anything but kernel.org where I can
> just trust the account management), I really want the pull request to
> be a signed tag, not just a plain branch.

Ok, to expedite this all and not cause any further pointless churn and
jumping through hoops, I'll let it slide this time, but I'll ask that
you sort out your pgp key for the future and use signed tags.

Also, I notice that you have a github merge commit in there.

That's another of those things that I *really* don't want to see -
github creates absolutely useless garbage merges, and you should never
ever use the github interfaces to merge anything.

This is the complete commit message of that merge:

    Merge branch 'torvalds:master' into master

Yeah, that's not an acceptable message. Not to mention that it has a
bogus "github.com" committer etc.

github is a perfectly fine hosting site, and it does a number of other
things well too, but merges is not one of those things.

Linux kernel merges need to be done *properly*. That means proper
commit messages with information about what is being merged and *why*
you merge something. But it also means proper authorship and committer
information etc. All of which github entirely screws up.

We had this same issue with the ksmbd pull request, and my response is
the same: the initial pull often has a few oddities and I'll accept
them now, but for continued development you need to do things
properly. That means doing merges from the command line, not using the
entirely broken github web interface.

(Sadly, it looks like that ksmbd discussion was not on any mailing
lists, so I can't link to it).

                    Linus
