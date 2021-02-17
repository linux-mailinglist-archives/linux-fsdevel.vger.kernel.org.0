Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF531E0DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBQUyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 15:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbhBQUyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613595166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFiDBPwntblDzO2abdyHiSeoIY+aP35IN/oS0CjNvck=;
        b=YYdy8eRpir7x4vtlSIVvo2OoX72Q6ZtVmkrdx58zMT3A9ONmWspZVauJPYXs+qO2UIgMf3
        HG+L/0/rE42Rpk7BjNcrROSZrvs9UYezMkSapo55akw/Cqd2aaDhTo54dw8RU/KJgx5Cj+
        kLsINWPPA7wFI7ckX9qiE/6D8QvodyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-o97sgGFZOFCZdTlFKLOssw-1; Wed, 17 Feb 2021 15:52:44 -0500
X-MC-Unique: o97sgGFZOFCZdTlFKLOssw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FC7801979;
        Wed, 17 Feb 2021 20:52:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-123.rdu2.redhat.com [10.10.114.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 681E12DACE;
        Wed, 17 Feb 2021 20:52:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EF567220BCF; Wed, 17 Feb 2021 15:52:38 -0500 (EST)
Date:   Wed, 17 Feb 2021 15:52:38 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>
Subject: Re: [Virtio-fs] Question on ACLs support in virtiofs
Message-ID: <20210217205238.GD31184@redhat.com>
References: <87r1llk28a.fsf@suse.de>
 <20210215205221.GB3331@redhat.com>
 <CAJfpegsEa6ZCXBFUpER6Fiagp3TEpxa82qBo0a4NydjC3ucnTw@mail.gmail.com>
 <20210216155416.GA10195@redhat.com>
 <YC13rHlrabQTp8y9@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC13rHlrabQTp8y9@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 08:08:12PM +0000, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > On Tue, Feb 16, 2021 at 04:11:20PM +0100, Miklos Szeredi wrote:
> > > On Mon, Feb 15, 2021 at 9:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Fri, Feb 12, 2021 at 10:30:13AM +0000, Luis Henriques wrote:
> > > > > Hi!
> > > > >
> > > > > I've recently executed the generic fstests on virtiofs and decided to have
> > > > > a closer look at generic/099 failure.  In a nutshell, here's the sequence
> > > > > of commands that reproduce that failure:
> > > > >
> > > > > # umask 0
> > > > > # mkdir acldir
> > > > > # chacl -b "u::rwx,g::rwx,o::rwx" "u::r-x,g::r--,o::---" acldir
> > > > > # touch acldir/file1
> > > > > # umask 722
> > > > > # touch acldir/file2
> > > > > # ls -l acldir
> > > > > total 0
> > > > > -r--r----- 1 root root 0 Feb 12 10:04 file1
> > > > > ----r----- 1 root root 0 Feb 12 10:05 file2
> > > > >
> > > > > The failure is that setting umask to 722 shouldn't affect the new file2
> > > > > because acldir has a default ACL (from umask(2): "... if the parent
> > > > > directory has a default ACL (see acl(5)), the umask is ignored...").
> > > > >
> > > > > So... I tried to have look at the code, and initially I thought that the
> > > > > problem was in (kernel) function fuse_create_open(), where we have this:
> > > > >
> > > > >       if (!fm->fc->dont_mask)
> > > > >               mode &= ~current_umask();
> > > > >
> > > > > but then I went down the rabbit hole, into the user-space code, and
> > > > > couldn't reach a conclusion.  Maybe the issue is that there's in fact no
> > > > > support for this POSIX ACLs in virtiofs/FUSE?  Any ideas?
> > > >
> > > > Hi,
> > > >
> > > > [ CC Miklos and linux-fsdevel ]
> > > >
> > > > I debugged into this a little. There are many knobs and it is little
> > > > confusing that what are right set of fixes.
> > > >
> > > > So what's happening in this case is that fc->dont_mask is not set. That
> > > > means fuse client is modifying mode using umask. First time you
> > > > touch file, umask is 0, so there is no modification. But next time,
> > > > you set umask to 722, and fuse modifies mode before sending file
> > > > create request to server. virtiofs server is already running with
> > > > umask 0, so it does not touch the mode.
> > > >
> > > > So that means, that in case of default acl, fuse client should not
> > > > be modifying mode using umask. But question is when should fuse
> > > > skip applying umask.
> > > >
> > > > I see that fuse always sets SB_POSIXACL. That means VFS is not
> > > > going to apply umask and all the umask handling is with-in fuse.
> > > >
> > > > sb->s_flags |= SB_POSIXACL;
> > > >
> > > > Currently fuse sets fc->dont_mask in two conditions.
> > > >
> > > > - If the caller mounted with flag MS_POSIXACL, then fc->dont_mask is set.
> > > > - If fuse server opted in for option FUSE_DONT_MASK, then fc->dont_mask
> > > >   is set.
> > > >
> > > > I see that for virtiofs, both the conditions are not true out of the
> > > > box. In fact looks like ACL support is not fully enabled, because
> > > > I don't see fuse server opting in for FUSE_POSIX_ACL.
> > > >
> > > > I suspect that we probably should provide an option in virtiofsd to
> > > > enable/disable acl support.
> > > 
> > > Sounds good.
> > > 
> > > > Setting FUSE_DONT_MASK is tricky. If we leave it to fuse, that means
> > > > fuse will have to query acl to figure out if default acl is set or
> > > > not on parent dir. And that data could be stale and there could be
> > > > races w.r.t setting acls from other client.
> > > >
> > > > If we do set FUSE_DONT_MASK, that means in file creation path virtiofsd
> > > > server will have to switch its umask to one provided in request. Given
> > > > its a per process property, we will have to have some locks to make
> > > > sure other create requests are not progressing in parallel. And that
> > > > hope host does the right thing. That is apply umask if parent dir does
> > > > not have default acl otherwise apply umask (as set by virtiofsd process).
> > > >
> > > > Miklos, does above sound reasonable. You might have more thoughts on
> > > > how to handle this best in fuse/virtiofs.
> > > 
> > > fv_queue_worker() does unshare(CLONE_FS) for the fchdir() call in
> > > xattr ops, which means that umask is now a per-thread propery in
> > > virtiofsd.
> > 
> > Aha.. I forgot about that. Thanks. 
> 
> Isn't that actually variable; in that we cna't do that unshare in some
> cases when we don't have the capability?

fv_queue_worker() always calls unshare(CLONE_FS). fchdir() is the
optional part. We care about unshare(CLONE_FS) so that umask is
not shared between threads.

Vivek

> 
> Dave
> > > 
> > > So setting umask before create ops sounds like a good solution.
> > 
> > I will give it a try along with an option to enable/disable acl
> > support in virtiofsd. 
> > 
> > Vivek
> > 
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

