Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B94401D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhIFOk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 10:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243274AbhIFOkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630939157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+z2oy7uRo+rUCluRBsFNUqB8lI2Md370z/AcYxkK4jA=;
        b=dzn6PFHNUFHWYUP46l4Gh4mmFTiQCxPy3le4ZDQg3hKmXRPv76oHCWXPE0jcdmss9KB5EH
        NJBd/9L1wL79MneU9YWnHy9HSWMp/mZIHDBFPKt/dWYqlz/pc+BDskkAtkjJ1KKPleR9rn
        n18SdT2EyozbmiflQqF5owa6qK00UWs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-RXffr2g0N9mo9Mp9zcbYBg-1; Mon, 06 Sep 2021 10:39:16 -0400
X-MC-Unique: RXffr2g0N9mo9Mp9zcbYBg-1
Received: by mail-wr1-f69.google.com with SMTP id 102-20020adf82ef000000b001576e345169so1258995wrc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 07:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+z2oy7uRo+rUCluRBsFNUqB8lI2Md370z/AcYxkK4jA=;
        b=lZk9b1fHbJj4oBfcerQq7pO1e0nwVvMoeKP48qK4Z5KRcKXldap5VVQPUThUhmSmBQ
         Ozgkh46XG+6HTAearmdxbO8+DHHkrGZKrHNjLkOQDuoZB9tWD591pu/dTwy0M9eScCNN
         kZzHlVYUSKTACcqYA/dtUl5w/wsEHFxCdxaWMbr3zERxLV2YUquRLK46XrA1ASdCXTco
         GSYd53nDm/NbdGV0UFnOg46dp7scnqwIeeZFV8T857G54Zxo1oD5ZGglwnrApBfQ7Oyx
         s7ya0Kw+Dnyt3l1Z4vVf1dB4tZHOq3Umv8DxnUUdvO7Sd2mlNHvA8WhrVYNnHiC2Th6Y
         OfQw==
X-Gm-Message-State: AOAM530tso6F9i5SOOmN5gwk0Px96cDige97F6gqZYk2lcQLrQ0abRWa
        fPoQ3ECv4iiXzlMgd9ZMQsArgv6sgaOaZ1LB6OmsPmqwpWGZkI6xjrAhydExt8dV2bZy/ejZltY
        JP0Rqo34CpzSIEZ8irUYrJbgHdw==
X-Received: by 2002:adf:d231:: with SMTP id k17mr13829224wrh.389.1630939155278;
        Mon, 06 Sep 2021 07:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeRatgQ0xCt0UI+SY5SQtyOXtLxDfFiIuJsWPUTO5VpZ73PMk33KS8HQ6FV/teH8sV8VDRwQ==
X-Received: by 2002:adf:d231:: with SMTP id k17mr13829186wrh.389.1630939154987;
        Mon, 06 Sep 2021 07:39:14 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id u9sm8160923wrm.70.2021.09.06.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 07:39:14 -0700 (PDT)
Date:   Mon, 6 Sep 2021 15:39:12 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YTYoEDT+YOtCHXW0@work-vm>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Andreas Gruenbacher (agruenba@redhat.com) wrote:
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
> 
> You may be able to get away with using trusted.* xattrs which support
> roughly the kind of daemon use I think you're talking about here, but
> I'm not sure selinux will be happy with labels that aren't fully under
> its own control. I really wonder why this wasn't obvious enough.

It was; however in our use case it wasn't an issue in general, because
the selinux instance that was setting the labels was inside an untrusted
guest, as such it's labels on the host are themselves untrusted, and
hence user. made some sense to the host - until we found out the
restrictons on user. the hard way.

The mapping code we have doesn't explicitly set user. - it's an
arbitrary remapper that can map to anything you like, trusted. whatever,
but user. feels (to us) like it's right for an untrusted guest.

IMHO the real problem here is that the user/trusted/system/security
'namespaces' are arbitrary hacks rather than a proper namespacing
mechanism that allows you to create new (nested) namespaces and associate
permissions with each one.

Each one carries with it some arbitrary baggage (trusted not working on
NFS, user. having the special rules on symlinks etc).

Then every fs or application that trips over these arbitrary limits adds
some hack to work around them in a different way to every other fs or
app that's doing the same thing; (see 9p, overlayfs, fuse-overlayfs,
crosvm etc etc all that do some level of renaming)

What we really need is a namespace where you can do anything you like,
but it's then limited by the security modules, so that I could allow
user.virtiofsd.guest1 to be able to set labels on symlinks for example.

Dave

> Thanks,
> Andreas
> 
> > Thanks
> > Vivek
> >
> > Vivek Goyal (1):
> >   xattr: Allow user.* xattr on symlink and special files
> >
> >  fs/xattr.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > --
> > 2.31.1
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

