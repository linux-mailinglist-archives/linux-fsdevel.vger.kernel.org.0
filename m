Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702611493C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgAYGRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 01:17:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40411 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYGRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 01:17:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id t204so3573066qke.7;
        Fri, 24 Jan 2020 22:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tsg/r/0YkW+EwvqQByRlznkOGOX8nMWqFwoWlOGNvn8=;
        b=iY+grmAPc30j6s7U+lRPizYmH7hV2PAWEKR71dLE2dmN6yU1rFMyesbZUFSMOauaVf
         AQ9cpT68ECqVY+efd5oKkLJvdlIt9sZXp1sT7hhWx7cKC3Z0kVr+qI6rJzJHuS7+OAYT
         9tP8OzS97Jt32QTS1CFNMlc2IzGOFYPry2npjIJ+lyjXTv+Qg1tlLW3anAB8VyEs0WHd
         b1Q+rh7P8cnrvzw0V6HrjKy4O80PZNQnYnI1jN1Xd2QA1VsboWQ9oZ6Bv8rfkVJAhaIK
         22EQOoPEm6OaRMU3O4rOgxpn0I1J4f5p8qRuDarvNU+gH14FZqOSSJ0iow23txsL6/SX
         NIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tsg/r/0YkW+EwvqQByRlznkOGOX8nMWqFwoWlOGNvn8=;
        b=swPbXZpzIymRlRkx8eDj9P4dz+a0CRt53QWFKhqU+ZR9BB8Es3pJQgwm/YSNoo+b9F
         v/FHJX3vY05pstG46Sxu6ktVr0GI0lAi0VZiljowP0RccWgZrsfzd+RK1NzwL6YpSr/C
         u14e/7wW8Tp3mHLvuOTWMmo7lSl5XiFZFufTYMrb8Y0H/tJELqj2Jj8iaYT5BFvUCwrk
         82ZmDtaqf+tGRq+L2QafvbdkSOlQSqhgRJm5YnFn/Am/LCC4TP3D2KNJtIvYbZ03OcuX
         OB6/hshFPmVAVEuwhPpCkIohkrsOFTjqmnLRAf3uY3bpWR3tGxk79t582zB+PEpwFps6
         ut1Q==
X-Gm-Message-State: APjAAAWgkfYDXLXLCfn+ouFySxI1v6tevNJXz45wQkzj5/V2johfhpNJ
        gBrL/SQUUntKkkRgBu6lj2ZhEC7+UPq9Ef9xAJA=
X-Google-Smtp-Source: APXvYqzXMH2ecc4WrNRTSRqMoJiY5NdwoAvLhz3IqzcpCpum0aGfk2zEnLWmJG13dZn/DF6tLcJ+3/2VAi47wkEYVVY=
X-Received: by 2002:a05:620a:15e9:: with SMTP id p9mr6924393qkm.490.1579933034407;
 Fri, 24 Jan 2020 22:17:14 -0800 (PST)
MIME-Version: 1.0
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
 <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
In-Reply-To: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Fri, 24 Jan 2020 22:17:03 -0800
Message-ID: <CA+8MBb++x2onyy0obGKc=3exTCekWRJ98xhQZuvHMQbFvV7zCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> We used to have a read/write argument to the old "verify_area()" and
> "access_ok()" model, and it was a mistake. It was due to odd i386 user
> access issues. We got rid of it. I'm not convinced this is any better
> - it looks very similar and for odd ppc access issues.

If the mode (read or write) were made visible to the trap handler, I'd
find that useful for machine check recovery.  If I'm in the middle of a
copy_from_user() and I get a machine check reading poison from a
user address ... then I could try to recover in the same way as for the
user accessing the poison (offline the page, SIGBUS the task). But if
the poison is in kernel memory and we are doing a copy_to_user(), then
we are hosed (or would need some more complex recovery plan).

[Note that we only get recoverable machine checks on loads... writes
are posted, so if something goes wrong it isn't synchronous with the store
instruction that initiated it]

-Tony
