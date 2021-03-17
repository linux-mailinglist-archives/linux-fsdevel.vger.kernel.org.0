Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7833FB8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 23:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQW6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 18:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhCQW5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616021870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZaK6gIsCAM0oxROYY9ggmqnBS3+yKAGQL9O/N4rfPw=;
        b=G6w0yDPWm1V5IA73YaAIta0hBRIpsQVBKYBba+oeCc/lN3PsTWyTq/NoqiF/zQoeOPr5Sc
        MEvv6DEhqQ6rHp7cw5/XWVVW+lJ1Qve/O2N3nizBvQojNz4aJjMZbLRxo1DdmH6JkcW3bh
        /CEBZf5mmYEz5PHhQJHnlScEDO1+3Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-lzq7ykgKM6-wzD3kLQ3JfQ-1; Wed, 17 Mar 2021 18:57:46 -0400
X-MC-Unique: lzq7ykgKM6-wzD3kLQ3JfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0FF8108BD06;
        Wed, 17 Mar 2021 22:57:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-32.rdu2.redhat.com [10.10.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF887610F0;
        Wed, 17 Mar 2021 22:57:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 501E9220BCF; Wed, 17 Mar 2021 18:57:41 -0400 (EDT)
Date:   Wed, 17 Mar 2021 18:57:41 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 1/1] fuse: send file mode updates using SETATTR
Message-ID: <20210317225741.GG324911@redhat.com>
References: <20210316160147.289193-1-vgoyal@redhat.com>
 <20210316160147.289193-2-vgoyal@redhat.com>
 <CAJfpegtD-6Xt3JDtoOtqJLXeDzVgjfaVJhHU8OQ8Lpw9tu2FzA@mail.gmail.com>
 <20210317170119.GE324911@redhat.com>
 <CAJfpegvtYtfwsMCi38VjMGanarTStQNEnqveRUFhU1xCJ5EbUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvtYtfwsMCi38VjMGanarTStQNEnqveRUFhU1xCJ5EbUQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 08:25:51PM +0100, Miklos Szeredi wrote:
> On Wed, Mar 17, 2021 at 6:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 04:43:35PM +0100, Miklos Szeredi wrote:
> > > On Tue, Mar 16, 2021 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > If ACL changes, it is possible that file mode permission bits change. As of
> > > > now fuse client relies on file server to make those changes. But it does
> > > > not send enough information to server so that it can decide where SGID
> > > > bit should be cleared or not. Server does not know if caller has CAP_FSETID
> > > > or not. It also does not know what are caller's group memberships and if any
> > > > of the groups match file owner group.
> > >
> > > Right.  So what about performing the capability and group membership
> > > check in the client and sending the result of this check to the
> > > server?
> >
> > Hi Miklos,
> >
> > But that will still be non-atomic, right? I mean server probably will
> > do setxattr first, then check if SGID was cleared or not, and if it
> > has not been cleared, then it needs to set the mode.
> >
> > IOW, we still have two operations (setxattr followed by mode setting).
> >
> > I had thought about that option. But could not understand what does
> > it buy us as opposed to guest sending a SETATTR.
> 
> If the non-atomic SETXATTR + SETATTR is done in the client, then the
> server has no chance of ever operating correctly.
> 
> If the responsibility for clearing sgid is in the server, then it's up
> to the server to decide how to best deal with this.  That may be the
> racy way, but at least it's not the only possibility.
> 
> Not sure if virtiofsd can do this atomically or not.
> setgid()/setgroups() require CAP_SETGID, but that's relative to the
> user namespace of the daemon, so this might be possible to do, I
> haven't put a lot of thought into this.

I guess you are right. virtiofsd can do it atomically. If client says to
clear SGID, then virtiofsd can do following.

A. Query who is file owner group.
B. setgid(non-file-owner-group)
C. drop CAP_FSETID
D. setxattr(system.posix_acl_access).

If file owner group is not root, then we don't have to do any setgid at all.
If file owner group is root, then we have to find a gid which is valid
in mount namespace of virtiofsd and switch to it. I guess at virtiofsd
start time we can look at /proc/$$/gid_map and store on  non-root gid
which is valid.

Only race here will be if another client changes file owner group
between A and D and sets to same non-file-onwer-group we changed to. In
that case it will not be cleared. 

Hmm.., may be post setxattr we can do another stat() and make sure SGID
got cleared. If not, do a chmod. IOW, if atomic approach races, fall back
to non-atomic approach.

Litle twisted but should probably work. Will try.

Thanks
Vivek

