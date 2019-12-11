Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0411BDC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLKUTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 15:19:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39340 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKUTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:19:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so25528081ljj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UjwHXfl+wSpdIy6pFsKx1jWMPt+sQscIiO9W8R2W1Y=;
        b=XtMIe7iuAOWqyQoOMNK32ZxWsoe5+aC9clZlbvlSHNeQnBL3iYqXG5cOgaShAhZu8l
         KBr+OSu1TBtcjjKLP/Z3bTH9YZpJTmNG6piE4dk0EuVKUQlYs0QuS8A3v4YnDRaXgUGn
         axHRPhHleLO8S+aMNKnrf/AwhGUa0j2Qagvqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UjwHXfl+wSpdIy6pFsKx1jWMPt+sQscIiO9W8R2W1Y=;
        b=chuCFCaCdARAW1V5lrzD5WxPvxNJilRE37An0qxxY3gVkyxyf6BmOety4hvRbpXxiz
         DzLakA85DyyFEvbTjLiC8Wp1+jIIcqV+C563WEhA+82vD6Vf5uFkq+5LoK/Myjce1SW4
         OXt89dl6SFZzL8a+Nv9DbKBEQ02pzIAGEMDGiKz3QhOftGuUnL7ZIKS+5H1o5o1+uLP1
         fuJBQOAoc+3vio8JBriQ+uNcoeR+Ex1mPFweCfYqv1fBg4sU+4GYqCZVKcBJK8gyXEoq
         J8IUc172vc+wO5bhaPdEsYGNb0nPjekdYGZJ3Ln9erSBiYBhni23H1dXpQacphTeAN6Z
         uTeQ==
X-Gm-Message-State: APjAAAVPNliPZmSK4ZMy+O74+4shqnyOeFJAzpKamgiz1Bl4vIdNIM00
        rEyjsQpqq2svCn2Ln5QkzFKDALl6cbw=
X-Google-Smtp-Source: APXvYqxi7WNtbBza3cwLF5tMZExXH/61TBEOIsXCLv4+tU+WQhOSz7LagLoCWODLiXrkm8faUpykiQ==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr3483450ljg.213.1576095537024;
        Wed, 11 Dec 2019 12:18:57 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n3sm1698835lfk.61.2019.12.11.12.18.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:18:56 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a13so25534535ljm.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 12:18:55 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3384426ljj.97.1576095535581;
 Wed, 11 Dec 2019 12:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com> <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
In-Reply-To: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 12:18:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Message-ID: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> $ cat /proc/meminfo | grep -i active
> Active:           134136 kB
> Inactive:       28683916 kB
> Active(anon):      97064 kB
> Inactive(anon):        4 kB
> Active(file):      37072 kB
> Inactive(file): 28683912 kB

Yeah, that should not put pressure on some swap activity. We have 28
GB of basically free inactive file data, and the VM is doing something
very very bad if it then doesn't just quickly free it with no real
drama.

In fact, I don't think it should even trigger kswapd at all, it should
all be direct reclaim. Of course, some of the mm people hate that with
a passion, but this does look like a prime example of why it should
just be done.

MM people - mind giving this a look?  Jens, if you have that NOACCESS
flag in a git tree too and a trivial way to recreate your load, that
would be good for people to be able to just try things out.

                     Linus
