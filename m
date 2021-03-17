Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9E33F47B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhCQPtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 11:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232495AbhCQPtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615996156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojM9g5bXUmb7n3KgDuQWnhqjZ24DPefjMRpNBzV+8t4=;
        b=W4+G3i0oAafLiaWb9OSLXCd8l0XNcubO3n2pU4rniCZNwDVPmvCpes2xVQHbakndZMgb6e
        s22gKXMQIyH7PtMPWK70q2SzlIq+mK6jqtHPWXLs4aY8J/6UD/TvVfxWoZQY3LiJkM/2c/
        7oppovShzNs/7M5psXbEBmlYomiCL2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-x5NourVEOhGzr9N7HRFZ1A-1; Wed, 17 Mar 2021 11:19:02 -0400
X-MC-Unique: x5NourVEOhGzr9N7HRFZ1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA8E100945F;
        Wed, 17 Mar 2021 15:19:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-32.rdu2.redhat.com [10.10.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FEF10074FC;
        Wed, 17 Mar 2021 15:18:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AC0FD220BCF; Wed, 17 Mar 2021 11:18:57 -0400 (EDT)
Date:   Wed, 17 Mar 2021 11:18:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, dgilbert@redhat.com, seth.forshee@canonical.com
Subject: Re: [PATCH 0/1] fuse: acl: Send file mode updates using SETATTR
Message-ID: <20210317151857.GC324911@redhat.com>
References: <20210316160147.289193-1-vgoyal@redhat.com>
 <YFISL+dvR/qy6P+1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFISL+dvR/qy6P+1@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:29:03PM +0000, Luis Henriques wrote:
> On Tue, Mar 16, 2021 at 12:01:46PM -0400, Vivek Goyal wrote:
> > Hi Miklos,
> > 
> > Please find attached a patch to fix the SGID clearing issue upon 
> > ACL change. 
> > 
> > Luis reported that currently fstests generic/375 fails on virtiofs. And
> > reason being that we don't clear SGID when it should be.
> > 
> > Setting ACL can lead to file mode change. And this in-turn also can
> > lead to clearing SGID bit if.
> > 
> > - None of caller's groups match file owner group.
> > AND
> > - Caller does not have CAP_FSETID.
> > 
> > Current implementation relies on server updating the mode. But file
> > server does not have enough information to do so. 
> > 
> > Initially I thought of sending CAP_FSETID information to server but
> > then I realized, it is just one of the pieces. What about all the
> > groups caller is a member of. If this has to work correctly, then
> > all the information will have to be sent to virtiofsd somehow. Just
> > sending CAP_FSETID information required adding V2 of fuse_setxattr_in
> > because we don't have any space for sending extra information.
> > 
> > https://github.com/rhvgoyal/linux/commit/681cf5bdbba9c965c3dbd4337c16e9b17f27debe
> > 
> > Also this approach will not work with idmapped mounts because server
> > does not have information about idmapped mappings.
> > 
> > So I started to look at the approach of sending file mode updates
> > using SETATTR. As filesystems like 9pfs and ceph are doing. This
> > seems simpler approach. Though it has its issues too.
> > 
> > - File mode update and setxattr(system.posix_acl_access) are not atomic.
> 
> After reviewing (and testing) the patch, the only comment I have is that
> we should at least pr_warn() an eventual failure in setxattr().  But f
> that operation fails at that point, probably something went wrong on the
> other side

Hi Luis,

If setxattr failed, user will get the error. 

I guess pr_warn() could help with figuring out that there was a side affect
of failed failed setxattr operation. (mode changed). I will add something.

> and the kernel is unlikely to be able to revert the mode
> changes anyway.

Interestingly ceph code seems to revert mode changes if setxattr fails.
I think for now I am happy with just a pr_warn().
> 
> (And a nit: your patch seems to require some whitespaces clean-up.)

Will check it and fix it and post V2.

Thanks
Vivek

> 
> Cheers,
> --
> Luís
> 
> 
> > None of the approaches seem very clean to me. But sending SETATTR
> > explicitly seems to be lesser of two evils to me at this point of time.
> > Hence I am proposing this patch. 
> > 
> > I have run fstests acl tests and they pass. (./check -g acl).
> > 
> > Corresponding virtiofsd patches are here.
> > 
> > https://github.com/rhvgoyal/qemu/commits/acl-sgid-setattr
> > 
> > What do you think.
> > 
> > Vivek Goyal (1):
> >   fuse: Add a mode where fuse client sends mode changes on ACL change
> > 
> >  fs/fuse/acl.c             | 54 ++++++++++++++++++++++++++++++++++++---
> >  fs/fuse/dir.c             | 11 ++++----
> >  fs/fuse/fuse_i.h          |  9 ++++++-
> >  fs/fuse/inode.c           |  4 ++-
> >  include/uapi/linux/fuse.h |  5 ++++
> >  5 files changed, 71 insertions(+), 12 deletions(-)
> > 
> > -- 
> > 2.25.4
> > 
> 

