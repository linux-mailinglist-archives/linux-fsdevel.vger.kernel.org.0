Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2882DD97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE2M6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 08:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfE2M6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 08:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D63E9C07188B;
        Wed, 29 May 2019 12:58:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CA8C5D9D6;
        Wed, 29 May 2019 12:58:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2o1egR13FDd3=CgdXP_MbBsZM4SX=+aqvR6eheWddhFg@mail.gmail.com>
References: <CAG48ez2o1egR13FDd3=CgdXP_MbBsZM4SX=+aqvR6eheWddhFg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905934373.7587.10824503964531598726.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] vfs: Add superblock notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24576.1559134719.1@warthog.procyon.org.uk>
Date:   Wed, 29 May 2019 13:58:39 +0100
Message-ID: <24577.1559134719@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 29 May 2019 12:58:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> It might make sense to require that the path points to the root inode
> of the superblock? That way you wouldn't be able to do this on a bind
> mount that exposes part of a shared filesystem to a container.

Why prevent that?  It doesn't prevent the container denizen from watching a
bind mount that exposes the root of a shared filesystem into a container.

It probably makes sense to permit the LSM to rule on whether a watch may be
emplaced, however.

> > +                       ret = add_watch_to_object(watch, s->s_watchers);
> > +                       if (ret == 0) {
> > +                               spin_lock(&sb_lock);
> > +                               s->s_count++;
> > +                               spin_unlock(&sb_lock);
> 
> Why do watches hold references on the superblock they're watching?

Fair point.  It was necessary at one point, but I don't think it is now.  I'll
see if I can remove it.  Note that it doesn't stop a superblock from being
unmounted and destroyed.

> > +                       }
> > +               }
> > +               up_write(&s->s_umount);
> > +               if (ret < 0)
> > +                       kfree(watch);
> > +       } else if (s->s_watchers) {
> 
> This should probably have something like a READ_ONCE() for clarity?

Note that I think I'll rearrange this to:

	} else {
		ret = -EBADSLT;
		if (s->s_watchers) {
			down_write(&s->s_umount);
			ret = remove_watch_from_object(s->s_watchers, wqueue,
						       s->s_unique_id, false);
			up_write(&s->s_umount);
		}
	}

I'm not sure READ_ONCE() is necessary, since s_watchers can only be
instantiated once and the watch list then persists until the superblock is
deactivated.  Furthermore, by the time deactivate_locked_super() is called, we
can't be calling sb_notify() on it as it's become inaccessible.

So if we see s->s_watchers as non-NULL, we should not see anything different
inside the lock.  In fact, I should be able to rewrite the above to:

	} else {
		ret = -EBADSLT;
		wlist = s->s_watchers;
		if (wlist) {
			down_write(&s->s_umount);
			ret = remove_watch_from_object(wlist, wqueue,
						       s->s_unique_id, false);
			up_write(&s->s_umount);
		}
	}

David
