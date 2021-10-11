Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0351A4298A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJKVJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 17:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhJKVJ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12E3A60F3A;
        Mon, 11 Oct 2021 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633986478;
        bh=G+QJPCDxvnQUtik8kLBFGZxfNIXdogXuS2jZAwHj6Xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x7blkkuaT8Dg3v6qU7s5DLNPzbv6PIOwN/OI0GTzYNDZNS6HPNm/2zLFI1lULk/TR
         L7x89LR4YeOzOdZSsubxF2Z5jJyBTk7kFmIUnThAolPk+b6cfIldT6qBtg+k/gvGnq
         N8uXN6UFds5/xYwzIYkxumbLQP62r5urpxEP3BIc=
Date:   Mon, 11 Oct 2021 14:07:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?UTF-8?B?VHLDqWJ1Y2hldA==?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v14 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-Id: <20211011140755.a09af989de3ca844577d1ded@linux-foundation.org>
In-Reply-To: <457941da-c4a4-262f-2981-74a85519c56f@digikod.net>
References: <20211008104840.1733385-1-mic@digikod.net>
        <20211010144814.d9fb99de6b0af65b67dc96cb@linux-foundation.org>
        <457941da-c4a4-262f-2981-74a85519c56f@digikod.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Oct 2021 10:47:04 +0200 Mickaël Salaün <mic@digikod.net> wrote:

> 
> On 10/10/2021 23:48, Andrew Morton wrote:
> > On Fri,  8 Oct 2021 12:48:37 +0200 Mickaël Salaün <mic@digikod.net> wrote:
> > 
> >> The final goal of this patch series is to enable the kernel to be a
> >> global policy manager by entrusting processes with access control at
> >> their level.  To reach this goal, two complementary parts are required:
> >> * user space needs to be able to know if it can trust some file
> >>   descriptor content for a specific usage;
> >> * and the kernel needs to make available some part of the policy
> >>   configured by the system administrator.
> > 
> > Apologies if I missed this...
> > 
> > It would be nice to see a description of the proposed syscall interface
> > in these changelogs!  Then a few questions I have will be answered...
> 
> I described this syscall and it's semantic in the first patch in
> Documentation/admin-guide/sysctl/fs.rst

Well, kinda.  It didn't explain why the `usage' and `flags' arguments
exist and what are the plans for them.

> Do you want me to copy-paste this content in the cover letter?

That would be best please.  It's basically the most important thing
when reviewing the implementation.

> > 
> > long trusted_for(const int fd,
> > 		 const enum trusted_for_usage usage,
> > 		 const u32 flags)
> > 
> > - `usage' must be equal to TRUSTED_FOR_EXECUTION, so why does it
> >   exist?  Some future modes are planned?  Please expand on this.
> 
> Indeed, the current use case is to check if the kernel would allow
> execution of a file. But as Florian pointed out, we may want to add more
> context in the future, e.g. to enforce signature verification, to check
> if this is a legitimate (system) library, to check if the file is
> allowed to be used as (trusted) configuration…
> 
> > 
> > - `flags' is unused (must be zero).  So why does it exist?  What are
> >   the plans here?
> 
> This is mostly to follow syscall good practices for extensibility. It
> could be used in combination with the usage argument (which defines the
> user space semantic), e.g. to check for extra properties such as
> cryptographic or integrity requirements, origin of the file…
> 
> > 
> > - what values does the syscall return and what do they mean?
> > 
> 
> It returns 0 on success, or -EACCES if the kernel policy denies the
> specified usage.

And please document all of this in the changelog also.

