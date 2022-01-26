Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6170449CC9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiAZOqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 09:46:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58982 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiAZOqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF070B81CB5;
        Wed, 26 Jan 2022 14:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950A1C340E3;
        Wed, 26 Jan 2022 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208367;
        bh=cqbZeKQMWhz60xNOYMmiOJ6Ns4ueZnXODMnqhlHxm+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYvMX672yUdVX9ZYR5n6MAMAwumedvxK2sMWmhk7UuBXIkBapod4bL6tw2ks7WqMz
         ADh6/5WPgcoSeymYq9rpRSfLxUSIyScdF7A7reTKvrDGtYiyEBwHE6gKLQzmeEYPd9
         b1ZEaqzWgH4hGh6KjDdGa9rY2IfORt1MIflib5Dh0Qqu0oWGQbNC9UpOGDacM+GbSE
         58ptOdMnpGpymUKMx0wr9zja0yz0XfYIikkXMurXODQ4M96UNia7MRZOA5brAnrMPk
         sexsXzZg099IfP2/OocOSw2aDCmn83+xe9T6IxvD27fchrdoV+AP6yLeCR6nJvFbmn
         Nf1XuMw4/E+gQ==
Date:   Wed, 26 Jan 2022 15:46:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <20220126144603.vlxmlngqlpsjtmzw@wittgenstein>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
 <20220126132729.GA7942@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220126132729.GA7942@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:27:30AM -0500, Rich Felker wrote:
> On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
> > The first argument to argv when used with execv family of calls is
> > required to be the name of the program being executed, per POSIX.
> 
> That's not quite the story. The relevant text is a "should", meaning
> that to be "strictly conforming" an application has to follow the
> convention, but still can't assume its invoker did. (Note that most
> programs do not aim to be "strictly conforming"; it's not just the
> word strictly applied as an adjective to conforming, but a definition
> of its own imposing very stringent portability conditions beyond what
> the standard already imposes.) Moreover, POSIX (following ISO C, after
> this was changed from early C drafts) rejected making it a
> requirement. This is documented in the RATIONALE for execve:
> 
>     Early proposals required that the value of argc passed to main()
>     be "one or greater". This was driven by the same requirement in
>     drafts of the ISO C standard. In fact, historical implementations
>     have passed a value of zero when no arguments are supplied to the
>     caller of the exec functions. This requirement was removed from
>     the ISO C standard and subsequently removed from this volume of
>     POSIX.1-2017 as well. The wording, in particular the use of the
>     word should, requires a Strictly Conforming POSIX Application to
>     pass at least one argument to the exec function, thus guaranteeing
>     that argc be one or greater when invoked by such an application.
>     In fact, this is good practice, since many existing applications
>     reference argv[0] without first checking the value of argc.
> 
> Source: https://pubs.opengroup.org/onlinepubs/9699919799/functions/execve.html
> 
> Note that despite citing itself as POSIX.1-2017 above, this is not a
> change in the 2017 edition; it's just the way they self-cite. As far
> as I can tell, the change goes back to prior to the first publication
> of the standard.
> 
> > By validating this in do_execveat_common(), we can prevent execution
> > of shellcode which invokes execv(2) family syscalls with argc < 1,
> > a scenario which is disallowed by POSIX, thus providing a mitigation
> > against CVE-2021-4034 and similar bugs in the future.
> > 
> > The use of -EFAULT for this case is similar to other systems, such
> > as FreeBSD and OpenBSD.
> 
> I don't like this choice of error, since in principle EFAULT should
> never happen when you haven't invoked memory-safety-violating UB.
> Something like EINVAL would be more appropriate. But if the existing
> practice for systems that do this is to use EFAULT, it's probably best
> to do the same thing.
> 
> > Interestingly, Michael Kerrisk opened an issue about this in 2008,
> > but there was no consensus to support fixing this issue then.
> > Hopefully now that CVE-2021-4034 shows practical exploitative use
> > of this bug in a shellcode, we can reconsider.
> 
> I'm not really opposed to attempting to change this with consensus
> (like, actually proposing it on the Austin Group tracker), but a less
> invasive change would be just enforcing it for the case where exec is
> a privilege boundary (suid/sgid/caps). There's really no motivation
> for changing longstanding standard behavior in a
> non-privilege-boundary case.

Agreed. If we do this at all then this has way less regression potential.
