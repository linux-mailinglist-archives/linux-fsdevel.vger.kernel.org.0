Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1716801F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgBUOYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:24:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728392AbgBUOYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582295042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8mWqxlRjMqzWv3h3wuv1G8u9oII3zP+jyI9+XnLcJA=;
        b=DSqkQl2P3UzntTwpRcqo73FFC9ujFM/0IySH6Tu36JR2XQa0gcZJ6gWiI5ClXKy5OSYQjr
        PAWG2CyL7FrzPQN6GVl6Rq5Vb4Ht8Ah506IfNQ2xc86jUPsC39P/SGVCUM91qI+l5qRLzP
        RcxcAX5Mz/NlYn/3cB2fImae53wtf6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-K3W4URiHOyKQlUHyroESXw-1; Fri, 21 Feb 2020 09:23:58 -0500
X-MC-Unique: K3W4URiHOyKQlUHyroESXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086AF8010EB;
        Fri, 21 Feb 2020 14:23:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B95A60BE0;
        Fri, 21 Feb 2020 14:23:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com>
References: <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1897787.1582295034.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 14:23:54 +0000
Message-ID: <1897788.1582295034@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > +               if (!s->s_watchers) {
> 
> READ_ONCE() ?

I'm not sure it matters.  It can only be set once, and the next time we read
it we're inside the lock.  And at this point, I don't actually dereference it,
and if it's non-NULL, it's not going to change.

> > +                       ret = add_watch_to_object(watch, s->s_watchers);
> > +                       if (ret == 0) {
> > +                               spin_lock(&sb_lock);
> > +                               s->s_count++;
> > +                               spin_unlock(&sb_lock);
> 
> Where is the corresponding decrement of s->s_count? I'm guessing that
> it should be in the ->release_watch() handler, except that there isn't
> one...

Um.  Good question.  I think this should do the job:

	static void sb_release_watch(struct watch *watch)
	{
		put_super(watch->private);
	}

And this then has to be set later:

	init_watch_list(wlist, sb_release_watch);

> > +       } else {
> > +               ret = -EBADSLT;
> > +               if (READ_ONCE(s->s_watchers)) {
> 
> (Nit: I don't get why you do a lockless check here before taking the
> lock - it'd be more straightforward to take the lock first, and it's
> not like you want to optimize for the case where someone calls
> sys_watch_sb() with invalid arguments...)

Fair enough.  I'll remove it.

> > +#ifdef CONFIG_SB_NOTIFICATIONS
> > +       if (unlikely(s->s_watchers)) {
> 
> READ_ONCE() ?

Shouldn't matter.  It's only read once and then a decision is made on it
immediately thereafter.  And if it's non-NULL, the value cannot change
thereafter.

David

