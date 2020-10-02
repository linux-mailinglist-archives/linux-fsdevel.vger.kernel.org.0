Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527F12819FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgJBRot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBRot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:44:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D75C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 10:44:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so1857035ljd.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2020 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d98XeALx0jpZHa3k7E1jf9qNoDRB0A1nKFjz/K+o3Oc=;
        b=hl0PuFaoCAMYj8GG2Pfudjx+2xWIyYM9u8C0Qdhem4qPxdVN52uCOBMZr+AlpJ6RO/
         ipSBRwR2iybCGpME/uDGHDNjW1tSQeQNJ5s9JnnASrNUSYKfu65jvz9TAwA+F5Y5sLiI
         pNXkx5CP960QQ0z0dbv4LFfwNZkQIWPTE3pkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d98XeALx0jpZHa3k7E1jf9qNoDRB0A1nKFjz/K+o3Oc=;
        b=iq+MRsU5bUKM6QANO/V5fY5qbZR3X+8Y8GSxqk5GFckfGMl8uftBtuabvZlyBFCpur
         7YKvlsN34++CQ3QN0hPYvGAdQQUe9b3//hjNuPTxiPvDsj5K0U/hsczrNcRYn64/TshI
         1mndi38nH3ZYlNyoh+nrIhpWRTp6n7H/Bf3109c3d5KJ2ZAaEbWnnhgcXUp5PqckweA3
         rBZ1O+FRTKNA/+KHRanihieZPtGSa1jfJA6+msvHu4bSfFgm8do/kK1bMGwKN9s/ESd+
         BdQAKUQG5lEPMnTFxR6h07RSqD16hLbNUp7z4aMsfiQSP0cAwcQKteCpAZOmtsC4kqxE
         +kkQ==
X-Gm-Message-State: AOAM532avjkcMjX1oiR4Lsb1cnw9ckzoVRC/Cmfw3hG4b4zSbVqXo+eo
        ZKkmgUGx8tVbjNjaVZHL+DKrAh5MJv1+PA==
X-Google-Smtp-Source: ABdhPJxKR8WTGK0eroW5CCGQk6lABbmATh9WXnOCjI6HIZKRr7ahKlNpCiHROafiKOYQzw41sh4sDg==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr1097094ljh.88.1601660686853;
        Fri, 02 Oct 2020 10:44:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j20sm434787lfe.252.2020.10.02.10.44.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:44:46 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b22so2829131lfs.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2020 10:44:45 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1368289lfg.344.1601660685616;
 Fri, 02 Oct 2020 10:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Oct 2020 10:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHFbAaqS0h_D-9d1=Yc-iq96wE-hrrqOfptGNUZx-GRg@mail.gmail.com>
Message-ID: <CAHk-=wiHFbAaqS0h_D-9d1=Yc-iq96wE-hrrqOfptGNUZx-GRg@mail.gmail.com>
Subject: Re: [git pull] epoll fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:20 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Several race fixes in epoll.

Fudge. I screwed up the commit message due to a cut-and-paste error
(don't ask - sometimes google chrome and gnome-terminal seem to stop
agreeing about the normal X paste buffer)

And I extra stupidly pushed the thing out after the build succeeded,
not having noticed how I screwed up the trivial commit message.

I've force-updated the public sites, and I really hope nobody pulled
in that (very short) time when my tree had a bogus commit message.

(In case anybody cares, the commit message said "SEQCNT_MUTEX_ZERO"
instead of "Several race fixes in epoll" because that's what I had
looked at in another terminal. So it was a very WTF message)

I think this was only the second time I had a forced push to fix some
stupidity of mine. So it's not exactly _common_, but it's
embarrassing.

                    Linus
