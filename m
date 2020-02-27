Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389EB17167F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgB0L5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:57:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44025 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgB0L5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:57:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id c13so2942379wrq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh05Cj8vtIuH5qpsLMyYEWFCipQ2HuOc3XYtKhBW6hA=;
        b=lPMYR8/2BG8nuN9H0R1Cq+e5+kdzaxauQ8ws/ZcJMjpdlz6Tpw+hvapLx3CBe9ZQWy
         BlGyuk3F2T0KinjIJmB8BTj7WY4Fbjx4Uhh/S1HdSPyM4jBgqrIYzw2XE+zEONhAHNRd
         pNMoruUeOPN85/E91SBQftlqdx+5v97RaBLR6FgoFc7ZJzX4fEkmbWOUCiTmIuDrdA8X
         VJOnPem9ckGuOYYer7jKPwRwL9G/3Oi34Dv4JtAa5QaEEi4oNFtUeDpdtqpq+ZJpKdv1
         fh+BPc1iNqaTPcv9+wGiN8mr2QnvpI/nycwbSZ4NxQZEMKhRB+XeabupV1ilnFb2TYJM
         rrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh05Cj8vtIuH5qpsLMyYEWFCipQ2HuOc3XYtKhBW6hA=;
        b=JU+lQj4irDBzgEE8FKLG9wB8lvxUIK+53ts7WPzyaUWgFIF2h63eF2lfHJ5vDTVXSA
         vRsZd3stLp2WX3yQF0Z9iCo7pT3mlucpxk3keiCN1D4SNF3CA0EZCoOEcLXGVcmivO6R
         EIHtHd4olPcNjHxiIq+0e73lV8M36B2MXtflSKjydaywvJlbdTfOjZp9JTw0QW1evkwh
         UFjQl0WGtVW4YaUSC13j0BFaYXnUzoPVWOywBXBVh88UF2AhfS2Y8IonFHidFZNauMNj
         tZ1aAXsfqkqvO+4yBTcwKeY0bF2BP4PU1ywf0Z5fU3XD635R/3dZ5vjniDjeigKtoXdu
         zEAw==
X-Gm-Message-State: APjAAAXQZrowpeOt7qgThwLolxoVazxBUv4Oe4lrfoZn6jrBmky3gPl+
        tVl4jJX3Ika4RIdCP0x0aUEz95Pm1pQoAdq2MQ92Kw==
X-Google-Smtp-Source: APXvYqzZG8/nRFzUUy7t28psZ9jaVKoc5iI0sCJb50rEPQJATHPmHl2vMiijVIImTjjmkDU3rGMLIzb4Rqydz2C+AKo=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4412776wru.382.1582804648383;
 Thu, 27 Feb 2020 03:57:28 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b25c1059f8b5a4f@google.com>
In-Reply-To: <0000000000007b25c1059f8b5a4f@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Feb 2020 12:57:17 +0100
Message-ID: <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in simple_attr_read
To:     syzbot <syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:29 AM syzbot
<syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8bbbc5cf kmsan: don't compile memmove
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14394265e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
> dashboard link: https://syzkaller.appspot.com/bug?extid=fcab69d1ada3e8d6f06b
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338127ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161403ede00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com

This report says it's uninit in strlen, but there's actually an
information leak later on that lets the user read arbitrary data past
the non-terminated attr->get_buf.
