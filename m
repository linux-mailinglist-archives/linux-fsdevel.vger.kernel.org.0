Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048FA1F0387
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgFEXd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgFEXd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:33:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7CC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 16:33:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a25so13747508ljp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=HenIB/3KEnX6g7OVHqu+kSDDosed1DGCBW9BlMitBhtXu1qUftlTh0ByQYgIxxzPaJ
         v1BjKRoudpt4MRAW4isZGAyfXDO8MooDq35/5ak4ac6HzntoEvXpzd5SVBQKA2dAjkgz
         VEzncixfstBUoWrWg53pxL1hUYFIG0E2zxjFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=OPv5MbYmuXcA3BuxFsjZPMkyU9Y++Brp0wyhV46PailZj0LmXN7VnQ2Uewk5rp86oY
         L1yIwKOo/ifS7kvGDkp+1Z03K0uZBApCeXXUzilmHWlURBYgyhZbEqrBmBSY28p5H3kZ
         0WAdRGPbCNKylQUtg/OcPz5R48CR7E49NS3oP2Vv1g83ZzGMxnM9b3pAGk4ImoDMOdSY
         arbakfHmffXQiM9LyYuZYx4fqkzJEfrDi6HRc6x6EXSGerYcKka+Q7J+u8pMSQYsiyWY
         sLpMYG/gqe4HU2Eg9bbYcppwnW0RQHH0BRM1WQ/fNrTGd/U5VGj2EauHCe6IIYQKcMGL
         X4fQ==
X-Gm-Message-State: AOAM532p/pD/Ua2S0EWbR7Izf7e4vm7KCPkOc5oM0H8QzSERdwTXYElV
        LQJi137cMfY7qP0EKzO1Sb4rKdfrXLc=
X-Google-Smtp-Source: ABdhPJxoJ7botWvKDNPSGfiey2/x6e/VbPTo6mZbGfqZ52iq3wl05DIN4EE/lYr9jYqXBGZ/B8OU9g==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr5734261ljg.431.1591400034004;
        Fri, 05 Jun 2020 16:33:54 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id i8sm1813011lfl.72.2020.06.05.16.33.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n24so13703346lji.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5449089ljn.70.1591400031826;
 Fri, 05 Jun 2020 16:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <2240660.1591289899@warthog.procyon.org.uk>
In-Reply-To: <2240660.1591289899@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 16:33:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Improvements for v5.8
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 4, 2020 at 9:58 AM David Howells <dhowells@redhat.com> wrote:
>
>  (4) Improve Ext4's time updating.  Konstantin Khlebnikov said "For now,
>      I've plugged this issue with try-lock in ext4 lazy time update.  This
>      solution is much better."

It would have been good to get acks on this from the ext4 people, but
I've merged this as-is (but it's still going through my sanity tests,
so if that triggers something it might get unpulled again).

                  Linus
