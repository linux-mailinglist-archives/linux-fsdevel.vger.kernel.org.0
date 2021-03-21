Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A162E343457
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCUTUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCUTUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:20:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5EC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 12:20:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r20so18442337ljk.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFncp4+O1KZPv7CnqX2/Ghau8TfBtJkHUxqwd06JKQI=;
        b=R4S7/z7YxJ8eV2nZse4wEhVq4dS/Oq5i6b3WnNHB7ih5Jv+h7B8J0HaX1z1/hA3jH5
         Yrg6VjA8EgGGeBhcmz1csHzWaRynYwOsG+bSqOK1R0KZtV7UV+UdwjqD6/5XVwFFDbsc
         XzpFmiy4CPGwLPUzu91wTzA441vV06wT7RWRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFncp4+O1KZPv7CnqX2/Ghau8TfBtJkHUxqwd06JKQI=;
        b=ecnIYMRbdgZ+2+MUimjdIWPL8FxoWu0VnnkugB7VwLJRNIkI4Vqw9x7ZII33hwBA51
         eCNzvMLOETbRBIrxaI0Sok49sdoc8GnqRoIVnp8pD1woIOXF9p1jqlSTmCZjghFUEfyq
         HSWE178f40GWgLPiLldZKaCNVxYml5iP+6fZcdempqa3wgbn+SubhCYDzM7IhzTBJtzA
         VP3pyRxXX2iROn94JtoJF3lLb9MKPBbs/UEC42U1ur0vXnBY7Gev9euPJhicmtV/NqfK
         H0LGrZE1oowg6JSph6rr4mhRg2TSlj5CVM7+Cqq1jTeV9VyeJVVh3474hS3p0LASPHmo
         /4nQ==
X-Gm-Message-State: AOAM532aOf0rhyY7fmJAf+cep4lXV/2wUbkb8z2wLQwJJjwii/NPhqRN
        plIohJZdxULrxOpZFQ7lN8z3Xc+TFyq6ug==
X-Google-Smtp-Source: ABdhPJxw6FDePOAuFcIspW8S/pcvRt/Hw7j+YqRBK4ebhkSoVVNKTjC/3RBNvqAs8rc4K7lKFSa8hw==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr7524600ljj.78.1616354438077;
        Sun, 21 Mar 2021 12:20:38 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w8sm1630437ljh.131.2021.03.21.12.20.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 12:20:37 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 16so18383647ljc.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 12:20:37 -0700 (PDT)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr7258281ljj.48.1616354437158;
 Sun, 21 Mar 2021 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp> <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
In-Reply-To: <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Mar 2021 12:20:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
Message-ID: <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 21, 2021 at 7:37 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting NULL pointer dereference at reiserfs_security_init()

Whee. Both of the mentioned commits go back over a decade.

I guess I could just take this directly, but let's add Jeff Mahoney
and Jan Kara to the participants in case they didn't see it on the
fsdevel list. I think they might want to be kept in the loop.

I'll forward the original in a separate email to them.

Jeff/Jan - just let me know if I should just apply this as-is.
Otherwise I'd expect it to (eventually) come in through Jan's random
fs tree, which is how I think most of these things have come in ..

           Linus
