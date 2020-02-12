Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96F0159DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 01:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLA3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 19:29:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43768 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgBLA3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:29:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so225965ljm.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 16:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1zwim5bENoBH/YJdV0JdFYomer3zhgdaL9VRFgFbmk=;
        b=a0mAJB8SfJ9gaZZHweS2NdfMYUd1WCE17SI7XP87C6+Ff2gIDBgABMTm1Kx1Nsg1HY
         0ruUjl8AovwmwDeG0JrMTljpLYvq2f2NsCGILLfMorIKOj/gOtfvalctlgOMWWRjQ4hp
         XXLCJke+6ceL5jkjOhRCVzu1uXDQxR66FqD6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1zwim5bENoBH/YJdV0JdFYomer3zhgdaL9VRFgFbmk=;
        b=fNmsuif/tW177EoeQuOLX09DRRtCVHaYW+k0MRx5h1Mo+/65zXC7G7gyYYj/3jxt11
         BTy5/psmbWDkLaP33nN+hY2kxIrOnBdpIzt/NEsXXuFFG/x5BwsTykAlhZfkatG158eh
         nnqqVKs2QmgZuNKfgL2UFAQOYjnzAJbA98elOog54bpMDNtNOYvrdHTbJZl+iDS+Wh+t
         kBkXbBygNW3wvYDjWPFH7Kh1QBGjkXQnj7gsA2CfGgcNl+bMDzWhEQXxFJE7Pyw34c3j
         sQWOYv0xpoDsMMMLVfN1GRIotqi0ORLk+sPBPrFtENSqrscftuhyL+/Mbv9A+DTqG/BR
         7q3w==
X-Gm-Message-State: APjAAAWabRI9DJguH083Mt07AnlMlPdinKxpMqoJ+trUECx3PIZ7DLxF
        iejnJ80NG+BpoaOgtcsB3AGy7D9jNz4=
X-Google-Smtp-Source: APXvYqzf3mJWdvWaR7mGO3RAoqM9fhaFhOy3mE32e36GbfG6DYHcWByJHQtqWs3oK9391W/j6+Yemw==
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr6073662ljj.257.1581467338426;
        Tue, 11 Feb 2020 16:28:58 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i19sm2591494lfj.17.2020.02.11.16.28.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:28:57 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id d10so228397ljl.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 16:28:57 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr6018875ljk.201.1581467335909;
 Tue, 11 Feb 2020 16:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
In-Reply-To: <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Feb 2020 16:28:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Message-ID: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Testing this will be a challenge, but the issue was real - a 7GB
> highmem machine isn't crazy and I expect the inode has become larger
> since those days.

Hmm. I would say that in the intening years a 7GB highmem machine has
indeed become crazy.

It used to be something we kind of supported.

But we really should consider HIGHMEM to be something that is on the
deprecation list. In this day and age, there is no excuse for running
a 32-bit kernel with lots of physical memory.

And if you really want to do that, and have some legacy hardware with
a legacy use case, maybe you should be using a legacy kernel.

I'd personally be perfectly happy to start removing HIGHMEM support again.

                   Linus
