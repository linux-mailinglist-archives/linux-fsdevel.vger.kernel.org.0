Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0997913CBF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 19:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAOSTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 13:19:24 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44806 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728904AbgAOSTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:19:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9ABDE8EE191;
        Wed, 15 Jan 2020 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579112363;
        bh=pAkgSM4XCYD08LoXMWLR6CnpdLgNyvNulobz8SsQjH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZYXf+jTipAKnRUKfAbQNFo/tQgw3IZ7emGiHZFZZxyqt5L9XHas7o+UYe+BefKEbU
         jgSAOcd7NwBKsgd4YI1wD7qSZtj5z4wAHES5YEu4RlBhuajUJLxm1GAsyl60SnkzEd
         VucvKTqkyZXGTgq8mW8xSXRj32tIcMHfZNOS7lCg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NjZXcexcsQRZ; Wed, 15 Jan 2020 10:19:23 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 542148EE0D4;
        Wed, 15 Jan 2020 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579112363;
        bh=pAkgSM4XCYD08LoXMWLR6CnpdLgNyvNulobz8SsQjH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZYXf+jTipAKnRUKfAbQNFo/tQgw3IZ7emGiHZFZZxyqt5L9XHas7o+UYe+BefKEbU
         jgSAOcd7NwBKsgd4YI1wD7qSZtj5z4wAHES5YEu4RlBhuajUJLxm1GAsyl60SnkzEd
         VucvKTqkyZXGTgq8mW8xSXRj32tIcMHfZNOS7lCg=
Message-ID: <1579112360.3249.17.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>
Date:   Wed, 15 Jan 2020 10:19:20 -0800
In-Reply-To: <20200113034149.GA27228@mail.hallyn.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
         <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
         <20200113034149.GA27228@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-01-12 at 21:41 -0600, Serge E. Hallyn wrote:
> On Sat, Jan 04, 2020 at 12:39:45PM -0800, James Bottomley wrote:
> > This implementation reverse shifts according to the user_ns
> > belonging to the mnt_ns.  So if the vfsmount has the newly
> > introduced flag MNT_SHIFT and the current user_ns is the same as
> > the mount_ns->user_ns then we shift back using the user_ns before
> > committing to the underlying filesystem.
> > 
> > For example, if a user_ns is created where interior (fake root, uid
> > 0) is mapped to kernel uid 100000 then writes from interior root
> > normally go to the filesystem at the kernel uid.  However, if
> > MNT_SHIFT is set, they will be shifted back to write at uid 0,
> > meaning we can bind mount real image filesystems to user_ns
> > protected faker root.
> 
> Thanks, James, I definately would like to see shifting in the VFS
> api.
> 
> I have a few practical concerns about this implementation, but my
> biggest concern is more fundemental:  this again by design leaves
> littered about the filesystem uid-0 owned files which were written by
> an untrusted user.

Well, I think that's a consequence of my use case: using unmodified
container images with the user namespace.  We're starting to do IMA/EVM
signatures in our images, so shifted UID images aren't an option for us
.  Therefore I have to figure out a way of allowing an untrusted user
to write safely at UID zero.  For me that safety comes from strictly
corralling where they can write and making sure the container
orchestration system sets it up correctly.

> I would feel much better if you institutionalized having the origin
> shifted.  For instance, take a squashfs for a container fs, shift it
> so that fsuid 0 == hostuid 100000.  Mount that, with a marker saying
> how it is shifted, then set 'shiftable'.  Now use that as a base for
> allowing an unpriv user to shift.  If that user has subuid 200000 as
> container uid 0, then its root will write files as uid 100000 in the
> fs.  This isn't perfect, but I think something along these lines
> would be far safer.

OK, so I fully agree that if you're not doing integrity in the
container, then this is an option for you and whatever API gets
upstreamed should cope with that case.

So to push on the API a bit, what do you want?  The reverse along the
user_ns one I implemented is easy: a single flag tells you to map back
or not.  However, the implementation is phrased in terms of shifted
credentials, so as long as we know how to map, it can work for both our
use cases.  I think in plumbers you expressed interest in simply
passing the map to the mount rather than doing it via a user_ns; is
that still the case?

> Two namespaces with different uid maps can share the filesystem as
> though they both had the same uidmap.  (This currently is to me the
> most interesting use case for shifing bind mounts)
> 
> If the user wants to tar up the result, they can do do in their own
> namespace, resulting in uid 0 shown as uid 0.  If host root wants to
> do so, they can umount it everywhere and use something like
> fuidshift. Or, they can also create a namespace to do the shifting to
> uid 0 in tar.
> 
> My more practical concerns include: (1) once a userns has set a
> shiftable bind mount to shift, if it then creates a new child userns,
> that ns will not see (iiuc) see the fs as shifted.

Actually, it will.  The shift is a property of the vfsmount (or
underlying struct mount), so if you create a new user_ns then a
mount_ns, the new mount_ns inherits the shift flag and you go back
along your new user_ns.  If you don't create a new mount_ns, you still
get the shift flag, but you're still being shifted along the parent
user_ns, not your new one.

>   (2) there seems to be no good reason to stick to caching the cred
> for only one mnt, versus having a per-userns hashtable of creds for
> shifted mnts.  Was that just a temporary shortcut or did you intend
> it to stay that way?

Well, it was a demo of mechanism, but remember this cache is per thread
of execution.  Is there really going to be a use case where one thread
of execution traverses multiple user_ns's and so would need multiple
shifted credentials?  The current implementation could be backed by a
hashtable, but I really think it would only make sense if the creds
could be global, but they're not they're strictly thread specific
entities.

James


