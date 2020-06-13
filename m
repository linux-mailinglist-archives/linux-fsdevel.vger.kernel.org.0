Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F81F836B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFMNYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 09:24:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgFMNYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592054649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njgs1r9galiF3MoU+Zrmic02k4Poj3Y0WKSsIgqKRd0=;
        b=NnITedHc+l5kM/MvglHmWI1IZ52Z1XmiAW9SNDm58eVS7RbTuQcQc8KSIbesSmnYl0bAqc
        CRvT+SuY+uyCNW/vqS+xqQ3eaPAqYIkV+27RuHEu9lN1KRcDdT+T65fZPncW0Gl1RBYZMW
        yjUPlTJgFFWZ983wXK+rQg+knXlEhmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-6lltXHwEPeyB9Co1zx3NPA-1; Sat, 13 Jun 2020 09:24:06 -0400
X-MC-Unique: 6lltXHwEPeyB9Co1zx3NPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 690CA835B44;
        Sat, 13 Jun 2020 13:24:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06FBB60F88;
        Sat, 13 Jun 2020 13:24:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
References: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Karel Zak <kzak@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3986608.1592054641.1@warthog.procyon.org.uk>
Date:   Sat, 13 Jun 2020 14:24:01 +0100
Message-ID: <3986609.1592054641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > All the next operations are done with "fd". It's nowhere used as a
> > pipe, and nothing uses pipefd[1].
> 
> As an aside, that isn't necessarily true.
> 
> In some of the examples, pipefd[1] is used for configuration (sizing
> and adding filters), although I think right now that's not really
> enforced, and other examples seem to have pipefd[0] do that too.

The configuration can happen on either end of the pipe.  I just need to be
able to find the pipe object.

> DavidH: should that perhaps be a hard rule, so that you can pass a
> pipefd[0] to readers, while knowing that they can't then change the
> kinds of notifications they see.

You can argue that the other way: that it should be a hard rule that you can
pass pipefd[1] to writers, whilst knowing that they can't then change the kind
of notifications that the kernel can insert into the pipe.  My feeling is that
it's more likely that you would keep the read end yourself and give the write
end away - if at all.  Most likely, IMO, would be that you attach notification
sources and never use the write end directly.

There is some argument for making it so that the notification sources belong
to the read end only and that they keep the write side alive internally -
meaning that you can just close the write end.  All the notification sources
just then disappear when the read end is closed - but dup() might make this
kind of tricky as there is only one pipe object and its shared between both
ends.  The existence of O_RDWR FIFOs might also make this tricky.

> In the "pipe: Add general notification queue support" commit message,
> the code example uses pipefd[0] for IOC_WATCH_QUEUE_SET_SIZE, but then
> in the commit message for "watch_queue: Add a key/keyring notification
> facility" it uses pipefd[1].
>
> And that latter example does make sense: using the write-side
> pipefd[1] for configuration, while the read-side pipefd[0] is the side
> that sees the results. That is also how it would work if you have a
> user-mode pipe with the notification source controlling the writing
> side - the reading side can obviously not add filters or change the
> semantics of the watches.
> 
> So that allows a trusted side to add and create filters, while some
> untrusted entity can then see the results.

As stated above, I think you should be looking at this the other way round -
you're more likely to keep the read end for yourself.  If you attach multiple
sources to a pipe, everything they produce comes out mixed together from the
read end of the pipe.

You might even pass the write end to multiple userspace-side event generators,
but I'm not sure it would make sense to pass the read end around unless you
have sufficient flow that you need multiple consumers to keep up with it.

David

