Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07791D2F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 14:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgENMWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 08:22:12 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA2C061A0C;
        Thu, 14 May 2020 05:22:12 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 19so24335479oiy.8;
        Thu, 14 May 2020 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nF6vAAaP1cfceYeXNm1y8xNSuJkqKIzjNDIfaM3hC6U=;
        b=i5amiZT4SYTxnRSl42OFApQUVQWMEMCzpzva6IzJpZUA8ComrOQCQAsHjrgthqm5Ti
         GtsNDdoRqE46Qt9PLanUT5TY2Bl0VFqUiHu5M0QIg6duIlNkLuQe8qJr+kir6XgqdVfD
         5/SOQWjTz2Km5dz+pfxkh7zPj9KPJ94r2/Ag3If3AMmreLm/vSOzM8UVd2wlUJy4XxrC
         Y3Y61W6yaKPCDHY9edStqeGLglJrTL68OjZ0vcd54XZi+j9Fq2kDYMrFFSRcy9rIFy7A
         nX7z+uQKUg5PTswBiYuT5Cmq5JDIibyvxwL2OfL1jJvso9rIPZInZKoazLpB6dSHSd6h
         W5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nF6vAAaP1cfceYeXNm1y8xNSuJkqKIzjNDIfaM3hC6U=;
        b=MQ39zqs14DLM3VQ7p9t3vbeDNtDHsjP6cG6wPaQU5ko4EVj8OPCrHURZVqvqJZQEjR
         xYFgZ2IHvhWma5FQqpAnV/Auyzgc7ILvAQ2nYevjUrnzWr/cDAFGtbYUolo+E2j01GUF
         e2lEpZ1KrfPvlD2e8f+bP65sGvaKS8+UQXWTLK84mbeOFHgRVE85XxbCHGCGzw30CWQh
         yem5UVEt62yF1arUIeUNjmwpGPXKLro6CufBLwA7cdv6uv9WHGj+12gpUkNgD4nFIfRI
         tvMv5eZYLJjVeYeA9Ju67ZOnuNEUz6W8Y2//VKgFgMoCUex96nprviL315pGovXOm5lq
         XTYg==
X-Gm-Message-State: AGi0PuaX/OaN7e36MsaFOlucejx2OLsJjDL54UsicGOfEsLCxRv7i0Jl
        Lm++Po43m1hTJZZDxaSx5Ys41VLkHD7tOIKyJK4=
X-Google-Smtp-Source: APiQypKvnbVkSBLslf8tuVKDqGZ9R3qBIciw1yU8Il1eGXOPA175sNtg+n/Z5A2Hq8fDCIabdLt9q9wcWPA/Ns3WUPQ=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr28839792oib.160.1589458931895;
 Thu, 14 May 2020 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200505153156.925111-1-mic@digikod.net> <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook> <202005132002.91B8B63@keescook>
In-Reply-To: <202005132002.91B8B63@keescook>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 08:22:01 -0400
Message-ID: <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 13, 2020 at 04:27:39PM -0700, Kees Cook wrote:
> > Like, couldn't just the entire thing just be:
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index a320371899cf..0ab18e19f5da 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2849,6 +2849,13 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >               break;
> >       }
> >
> > +     if (unlikely(mask & MAY_OPENEXEC)) {
> > +             if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT &&
> > +                 path_noexec(path))
> > +                     return -EACCES;
> > +             if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
> > +                     acc_mode |= MAY_EXEC;
> > +     }
> >       error = inode_permission(inode, MAY_OPEN | acc_mode);
> >       if (error)
> >               return error;
> >
>
> FYI, I've confirmed this now. Effectively with patch 2 dropped, patch 3
> reduced to this plus the Kconfig and sysctl changes, the self tests
> pass.
>
> I think this makes things much cleaner and correct.

I think that covers inode-based security modules but not path-based
ones (they don't implement the inode_permission hook).  For those, I
would tentatively guess that we need to make sure FMODE_EXEC is set on
the open file and then they need to check for that in their file_open
hooks.
