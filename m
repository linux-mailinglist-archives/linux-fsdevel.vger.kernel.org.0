Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9CE11BEA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLKUzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 15:55:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfLKUzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576097739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YERAg9zwlW99Y5d6Zau5OzoqnwXAmUQo/8T8E4AEHCw=;
        b=LsPpftn2wPN/Df4S6UsrGFPvdlEA3FbtdBcZABqzufvQaX+zc4TjwP8PBbGMgrqV2CD6Cy
        iIn2BPo8lHer3h16lJ7zcKq5SfGcMWqIE5xXyDxGQJpOHM2cRnJYTo0pvemccyB4nwTVKb
        jhN3RyAe0PlYoa/akq/XMKBChUZquU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-uuDI_FbZPDqgFNLXyzO4HA-1; Wed, 11 Dec 2019 15:55:36 -0500
X-MC-Unique: uuDI_FbZPDqgFNLXyzO4HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBF6800D41;
        Wed, 11 Dec 2019 20:55:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637DF5D6A3;
        Wed, 11 Dec 2019 20:55:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
References: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk> <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com> <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Sterba <dsterba@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9416.1576097731.1@warthog.procyon.org.uk>
Date:   Wed, 11 Dec 2019 20:55:31 +0000
Message-ID: <9417.1576097731@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> DavidH, give these a look:
> 
>   85190d15f4ea pipe: don't use 'pipe_wait() for basic pipe IO
>   a28c8b9db8a1 pipe: remove 'waiting_writers' merging logic
>   f467a6a66419 pipe: fix and clarify pipe read wakeup logic
>   1b6b26ae7053 pipe: fix and clarify pipe write wakeup logic
>   ad910e36da4c pipe: fix poll/select race introduced by the pipe rework
> 
> the top two of which are purely "I'm fed up looking at this code, this
> needs to go" kind of changes.

They look reasonable.

Is it worth reverting:

	commit f94df9890e98f2090c6a8d70c795134863b70201
	Add wake_up_interruptible_sync_poll_locked()

since you changed the code that was calling that new function and so it's no
longer called?

David

