Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B811434B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhJTMdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 08:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230200AbhJTMdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634733096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBksMSRlzVzIRqYRz7FTRO//MQHxY7XrIS8vzdTdH/0=;
        b=IkReGZAXHw9VG5Qp6Oearv7lY1SLjxqNSA0Y6ms4kbnFeL/yGVMEdFLN+YQWPuUKgfhHO+
        rPj2wXCs6qFGWl3Ph8VeUh9rhnWVKTFce5RepMa73pyrdrN/qmj6vljmgAFaS72HENPBCe
        CxUXAxTVfLlYZepR4EchlTZouwK5hwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-H756tWO_PiG8kexqIt7lSA-1; Wed, 20 Oct 2021 08:31:35 -0400
X-MC-Unique: H756tWO_PiG8kexqIt7lSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC578042EF;
        Wed, 20 Oct 2021 12:31:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8177D62A44;
        Wed, 20 Oct 2021 12:31:28 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id ED5F02256F7; Wed, 20 Oct 2021 08:31:27 -0400 (EDT)
Date:   Wed, 20 Oct 2021 08:31:27 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Dan Walsh <dwalsh@redhat.com>, jlayton@kernel.org,
        idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2] security: Return xattr name from
 security_dentry_init_security()
Message-ID: <YXAMH1nyfM+IA4Ce@redhat.com>
References: <YWWMO/ZDrvDZ5X4c@redhat.com>
 <CAHC9VhRv8xOoPtfpSYSvUrcHUjhqQWw5LiDSfwR2f4VJ=9Qr8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRv8xOoPtfpSYSvUrcHUjhqQWw5LiDSfwR2f4VJ=9Qr8Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:24:44AM -0400, Paul Moore wrote:
> On Tue, Oct 12, 2021 at 9:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Right now security_dentry_init_security() only supports single security
> > label and is used by SELinux only. There are two users of of this hook,
> > namely ceph and nfs.
> >
> > NFS does not care about xattr name. Ceph hardcodes the xattr name to
> > security.selinux (XATTR_NAME_SELINUX).
> >
> > I am making changes to fuse/virtiofs to send security label to virtiofsd
> > and I need to send xattr name as well. I also hardcoded the name of
> > xattr to security.selinux.
> >
> > Stephen Smalley suggested that it probably is a good idea to modify
> > security_dentry_init_security() to also return name of xattr so that
> > we can avoid this hardcoding in the callers.
> >
> > This patch adds a new parameter "const char **xattr_name" to
> > security_dentry_init_security() and LSM puts the name of xattr
> > too if caller asked for it (xattr_name != NULL).
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >
> > Changes since v1:
> > - Updated comment to make it clear caller does not have to free the
> >   xattr_name. (Jeff Layton).
> > - Captured Jeff's Reviewed-by ack.
> >
> > I have tested this patch with virtiofs and compile tested for ceph and nfs.
> >
> > NFS changes are trivial. Looking for an ack from NFS maintainers.
> >
> > ---
> >  fs/ceph/xattr.c               |    3 +--
> >  fs/nfs/nfs4proc.c             |    3 ++-
> >  include/linux/lsm_hook_defs.h |    3 ++-
> >  include/linux/lsm_hooks.h     |    3 +++
> >  include/linux/security.h      |    6 ++++--
> >  security/security.c           |    7 ++++---
> >  security/selinux/hooks.c      |    6 +++++-
> >  7 files changed, 21 insertions(+), 10 deletions(-)
> 
> This looks fine to me and considering the trivial nature of the NFS
> changes I'm okay with merging this without an explicit ACK from the
> NFS folks.  Similarly, I generally dislike merging new functionality
> once we hit -rc6, but this is trivial enough that I think it's okay;
> I'm merging this into selinux/next now, thanks everyone.

Thanks Paul. I agree that this a trivial fix with no functionality
change and probability of this breaking something is very very low.

Vivek

