Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF42D4AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbgLITvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgLITva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:51:30 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21CC0613CF;
        Wed,  9 Dec 2020 11:50:49 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn5Tt-0008d1-3N; Wed, 09 Dec 2020 19:50:33 +0000
Date:   Wed, 9 Dec 2020 19:50:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201209195033.GP3579531@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:13:38AM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > -                               struct file * file = xchg(&fdt->fd[i], NULL);
> > +                               struct file * file = fdt->fd[i];
> >                                 if (file) {
> > +                                       rcu_assign_pointer(fdt->fd[i], NULL);
> 
> This makes me nervous. Why did we use to do that xchg() there? That
> has atomicity guarantees that now are gone.
> 
> Now, this whole thing should be called for just the last ref of the fd
> table, so presumably that atomicity was never needed in the first
> place. But the fact that we did that very expensive xchg() then makes
> me go "there's some reason for it".
> 
> Is this xchg() just bogus historical leftover? It kind of looks that
> way. But maybe that change should be done separately?

I'm still not convinced that exposing close_files() to parallel
3rd-party accesses is safe in all cases, so this patch still needs
more analysis.  And I'm none too happy about "we'll fix the things
up at the tail of the series" - the changes are subtle enough and
the area affected is rather fundamental.  So if we end up returning
to that several years from now while debugging something, I would
very much prefer to have the transformation series as clean and
understandable as possible.  It's not just about bisect hazard -
asking yourself "WTF had it been done that way, is there anything
subtle I'm missing here?" can cost many hours of head-scratching,
IME.

Eric, I understand that you want to avoid reordering/folding, but
in this case it _is_ needed.  It's not as if there had been any
serious objections to the overall direction of changes; it's
just that we need to get that as understandable as possible.
