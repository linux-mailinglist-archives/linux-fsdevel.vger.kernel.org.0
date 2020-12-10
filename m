Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62712D4F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 01:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgLJAkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 19:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgLJAkD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:40:03 -0500
Date:   Wed, 9 Dec 2020 16:39:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607560762;
        bh=9jkTkzNR5+yFLFpq3bVXs1VvccVU58KWQYAEI2PHgCU=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QoOYmzZtFENS3dMnNiUr3cGsMcN8mmM9kCAuibYtxtQ7PKHck+m59wCEwRxKkVrrv
         QDX2QUSvqbF0fFzyQ6BrfERjslvxXfetI7UjydaKB6HzKGLRAiJxcBNhspbsxQqATj
         UQ4T2lRydrRmGQwNRu1uRBFK+/t+9fTyssvlkzDzrocScn6yquzQzXPBI1vQrxxV+8
         bwtAYG98uAWEy/kkjBwx0HD3MfzlfzJt2SnRxqKO07DVgMzPaDaL+BxS5J9SDAigW6
         /PTgr8DrHfpcbD+J7foIxQ8gV9NYVrsxUQdtRgx8ZvAo+qkvvTGDvRp7ZKDHcMGDeV
         ycusWKG2rNDVw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210003922.GL2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
 <20201209230755.GV7338@casper.infradead.org>
 <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:29:09PM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 3:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >  #. It is not necessary to use rcu_assign_pointer() when creating
> >     linked structures that are to be published via a single external
> > -   pointer. The RCU_INIT_POINTER() macro is provided for this task
> > -   and also for assigning ``NULL`` pointers at runtime.
> > +   pointer. The RCU_INIT_POINTER() macro is provided for this task.
> > +   It used to be more efficient to use RCU_INIT_POINTER() to store a
> > +   ``NULL`` pointer, but rcu_assign_pointer() now optimises for a constant
> > +   ``NULL`` pointer itself.
> 
> I would just remove the historical note about "It used to be more
> efficient ..". It's not really helpful.
> 
> If somebody wants to dig into the history, it's there in git.
> 
> Maybe the note could be part of the commit message for the comment
> update, explaining that it used to be more efficient but no longer is.
> Because commit messages are about the explanation for the change.
> 
> But I don't feel it makes any sense in the source code.

Like this, then?

							Thanx, Paul

 #. It is not necessary to use rcu_assign_pointer() when creating
    linked structures that are to be published via a single external
-   pointer. The RCU_INIT_POINTER() macro is provided for this task
-   and also for assigning ``NULL`` pointers at runtime.
+   pointer. The RCU_INIT_POINTER() macro is provided for this task.
