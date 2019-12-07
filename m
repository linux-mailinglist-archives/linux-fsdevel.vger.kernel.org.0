Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E678115E12
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 19:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLGS4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 13:56:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGS4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:56:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so11179347ljs.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUXh/vHN4dqMclBZKIZwccZppvH5dwFkBq5Smb/jrgY=;
        b=Nc8nLEaa21HMhDezUfC5lwyjSyFBJ42cIMjyfxscr5tJULO4xWqy7VX3NTn0yd7MPw
         AxL9SBfD+nf5uAWF8oNP4r637mLmZVHo5Kvw9kCQuNoP3Y1qMV4sk2WoySQIvJIJtEOP
         b7tn0U1BFu5ErXk60MXKMLaTf5LMPt6v1kug4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUXh/vHN4dqMclBZKIZwccZppvH5dwFkBq5Smb/jrgY=;
        b=RPXp7xy709KxL/QUf+vTuS8Ej4McUxgvqJFRy+2r3jKEQeexLbvgRtZPEXMmxtUbjl
         rQAD5LFmBSq4M25EvI97iX2Q6vLKQYielAmh+SHj/GjkwPIG9kRvl87ooDwbckV/IOYk
         ZvHRHSH6vWLbXCI4MTcErHatTXrn/Nd3sQn/spZ0Md/QT+RFEcJqkt7nHxgiVFOVa4HN
         dDct5XH/1A412Ute3FEkQDI1cMOtH+0DJHzSFDa+hGTsbV7TBAT512bipTrTyY56mz3c
         ovTLiLmxOtlkHUm8cMtrozs6/qgIOFoJhb6weJhfB5vYQ999UQmOeTcce/d6W927T+D3
         a43g==
X-Gm-Message-State: APjAAAXPgbtUAMYMnVF0+kfNjmKb1Y7vGkTE24HDFpPqUimVmU3YjoGs
        Y/i6utJebjtbvL3gQO3NQtyucOjvpOA=
X-Google-Smtp-Source: APXvYqyjFv9vBUAcWZDi7DzSp6D97hX7kwJgYyIUHphk2AKXylPn+4voWpifP+K2jto3igmnCwgC7A==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr9542795ljg.113.1575744975091;
        Sat, 07 Dec 2019 10:56:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g6sm8506660lja.10.2019.12.07.10.56.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 10:56:14 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 21so11230842ljr.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 10:56:13 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr7607919ljj.97.1575744973488;
 Sat, 07 Dec 2019 10:56:13 -0800 (PST)
MIME-Version: 1.0
References: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
 <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com>
In-Reply-To: <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 10:55:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
Message-ID: <CAHk-=wiamjvQAw1y2ymstHbato_XtrkBeWYf1xbi1=94Zft2NA@mail.gmail.com>
Subject: Re: [PATCH] pipe: Fix iteration end check in fuse_dev_splice_write()
To:     mceier@gmail.com
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 7, 2019 at 10:30 AM Mariusz Ceier <mceier@gmail.com> wrote:
>
> I believe it's still not complete fix for 8cefc107ca54. Loading videos
> (or streams) on youtube, twitch in firefox (71 or nightly) on kernel
> eea2d5da29e396b6cc1fb35e36bcbf5f57731015 still results in page
> rendering getting stuck (switching between tabs shows spinner instead
> of page content).

Ok, so youtube (unlike facebook), I can test in firefox. Although it's
70, not 71 or nightly. And it doesn't seem to fail for me.

Of course, maybe the reason it doesn't fail for me is that I have a
patch in my tree that may be the fix. It's a very small race in
select()/poll(), and it's small enough that I wonder if it's really
the fix for this, but hey, it might be.

It also might be that your version of firefox is different, or just
that you're hitting something else that I'm just not hitting.

But I committed my patch and pushed it out, so that you could see if
that fixes it for you.

                Linus
