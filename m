Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5DA3FF36E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbhIBStO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 14:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347129AbhIBStJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630608490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTapUMM73s83e0K7qxbWMEgZd2lb/t4V7pWuvJh+DU4=;
        b=V8FFOeWPtPMSo/Ohzc2eS6R2SJ7lsmSI2X5hRTrT16QIp+XzyPzM7Elt9fIumrUy+fgRTm
        kjHfZI22lrjOq0Z7WiAE0OFMUwyZqv16M3OqKcj9VNSi5U4fZU5pruL7a0KrOS+wMXJgFp
        2WOjUCN9kk26SQv+jM8s8mPTrSkgEuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-MWX27cAvPEeAe7tjG1PD_A-1; Thu, 02 Sep 2021 14:48:09 -0400
X-MC-Unique: MWX27cAvPEeAe7tjG1PD_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F59D100945E;
        Thu,  2 Sep 2021 18:48:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CE4677716;
        Thu,  2 Sep 2021 18:48:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1BF5A220257; Thu,  2 Sep 2021 14:48:02 -0400 (EDT)
Date:   Thu, 2 Sep 2021 14:48:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YTEcYkAA2F1FhOvF@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
> Hi,
> 
> On Thu, Sep 2, 2021 at 5:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > This is V3 of the patch. Previous versions were posted here.
> >
> > v2: https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> > v1: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
> >
> > Changes since v2
> > ----------------
> > - Do not call inode_permission() for special files as file mode bits
> >   on these files represent permissions to read/write from/to device
> >   and not necessarily permission to read/write xattrs. In this case
> >   now user.* extended xattrs can be read/written on special files
> >   as long as caller is owner of file or has CAP_FOWNER.
> >
> > - Fixed "man xattr". Will post a patch in same thread little later. (J.
> >   Bruce Fields)
> >
> > - Fixed xfstest 062. Changed it to run only on older kernels where
> >   user extended xattrs are not allowed on symlinks/special files. Added
> >   a new replacement test 648 which does exactly what 062. Just that
> >   it is supposed to run on newer kernels where user extended xattrs
> >   are allowed on symlinks and special files. Will post patch in
> >   same thread (Ted Ts'o).
> >
> > Testing
> > -------
> > - Ran xfstest "./check -g auto" with and without patches and did not
> >   notice any new failures.
> >
> > - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
> >   filesystems and it works.
> >
> > Description
> > ===========
> >
> > Right now we don't allow setting user.* xattrs on symlinks and special
> > files at all. Initially I thought that real reason behind this
> > restriction is quota limitations but from last conversation it seemed
> > that real reason is that permission bits on symlink and special files
> > are special and different from regular files and directories, hence
> > this restriction is in place. (I tested with xfs user quota enabled and
> > quota restrictions kicked in on symlink).
> >
> > This version of patch allows reading/writing user.* xattr on symlink and
> > special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.
> 
> the idea behind user.* xattrs is that they behave similar to file
> contents as far as permissions go. It follows from that that symlinks
> and special files cannot have user.* xattrs. This has been the model
> for many years now and applications may be expecting these semantics,
> so we cannot simply change the behavior. So NACK from me.

Directories with sticky bit break this general rule and don't follow
permission bit model.

man xattr says.

*****************************************************************
and access to user extended  attributes  is  re‐
       stricted  to  the  owner and to users with appropriate capabilities for
       directories with the sticky bit set
******************************************************************

So why not allow similar exceptions for symlinks and device files.

I can understand the concern about behavior change suddenly and
applications being surprised. If that's the only concern we could
think of making user opt-in for this new behavior based on a kernel
CONFIG, kernel command line or something else.


> 
> > Who wants to set user.* xattr on symlink/special files
> > -----------------------------------------------------
> > I have primarily two users at this point of time.
> >
> > - virtiofs daemon.
> >
> > - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
> >   fuse-overlay as well and he ran into similar issue. So fuse-overlay
> >   should benefit from this change as well.
> >
> > Why virtiofsd wants to set user.* xattr on symlink/special files
> > ----------------------------------------------------------------
> > In virtiofs, actual file server is virtiosd daemon running on host.
> > There we have a mode where xattrs can be remapped to something else.
> > For example security.selinux can be remapped to
> > user.virtiofsd.securit.selinux on the host.
> >
> > This remapping is useful when SELinux is enabled in guest and virtiofs
> > as being used as rootfs. Guest and host SELinux policy might not match
> > and host policy might deny security.selinux xattr setting by guest
> > onto host. Or host might have SELinux disabled and in that case to
> > be able to set security.selinux xattr, virtiofsd will need to have
> > CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> > guest security.selinux (or other xattrs) on host to something else
> > is also better from security point of view.
> >
> > But when we try this, we noticed that SELinux relabeling in guest
> > is failing on some symlinks. When I debugged a little more, I
> > came to know that "user.*" xattrs are not allowed on symlinks
> > or special files.
> >
> > So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> > allow virtiofs to arbitrarily remap guests's xattrs to something
> > else on host and that solves this SELinux issue nicely and provides
> > two SELinux policies (host and guest) to co-exist nicely without
> > interfering with each other.
> 
> The fact that user.* xattrs don't work in this remapping scenario
> should have told you that you're doing things wrong; the user.*
> namespace seriously was never meant to be abused in this way.

Guest's security label is not be parsed by host kernel. Host kernel
will have its own security label and will take decisions based on
that. In that aspect making use of "user.*" xattr seemed to make
lot of sense and we were wondering why user.* xattr is limited to
regualr files and directories only and can we change that behavior.

> 
> You may be able to get away with using trusted.* xattrs which support
> roughly the kind of daemon use I think you're talking about here, but
> I'm not sure selinux will be happy with labels that aren't fully under
> its own control. I really wonder why this wasn't obvious enough.

I guess trusted.* will do same thing. But it requires CAP_SYS_ADMIN
in init_user_ns. And that rules out running virtiofsd unpriviliged
or inside a user namespace. Also it reduces the risk posted by
virtiofsd on host filesystem due to CAP_SYS_ADMIN. That's why we
were trying to steer clear of trusted.* xattr space.

Also, trusted.* xattr space does not work with NFS.

$ setfattr -n "trusted.virtiofs" -v "foo" test.txt
setfattr: test.txt: Operation not supported

We want to be able run virtiofsd over NFS mounted dir too.

So its not that we did not consider trusted.* xattrs. We ran
into above issues.

Thanks
Vivek

