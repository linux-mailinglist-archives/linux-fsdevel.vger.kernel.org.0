Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAB439AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhJYP63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233425AbhJYP62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635177365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ECqSaHQ0pbEcATw6/3SW1rQoKUfxPdGHecB780Nee0=;
        b=ZZ70dQ5dy+1jeFLwTMw1CsMcPTyP3aZL+tsavKCGlyTQYv6MpPi4XL6xwheTdSh8R7ioYs
        XWQ0h5yZJfzFkJtuhXSlo3ORBSxJj8LsDM1XLENiSzS+C3yPBC30zb+dDmd0sFpSLihN4P
        CF8aposejBRaeoFDoNMLvzH+seMn3jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-8tYJVqH9NhyOo-Qz_oeJfA-1; Mon, 25 Oct 2021 11:56:02 -0400
X-MC-Unique: 8tYJVqH9NhyOo-Qz_oeJfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08827CC628;
        Mon, 25 Oct 2021 15:56:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5455C5C1A1;
        Mon, 25 Oct 2021 15:55:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E04E222377B; Mon, 25 Oct 2021 11:55:37 -0400 (EDT)
Date:   Mon, 25 Oct 2021 11:55:37 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, chirantan@chromium.org,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        casey@schaufler-ca.com, omosnace@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fuse: Send file/inode security context during
 creation
Message-ID: <YXbTeb3G810yo216@redhat.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012180624.447474-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:06:22PM -0400, Vivek Goyal wrote:
> Hi,
> 
> This is V2 of patches. Posted V1 here.

Hi Miklos,

Wondering how do these patches look to you. Can you please consider these
for inclusion.

These patches are dependent on following patch which Paul Moore is now
carrying in this tree.

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=next&id=15bf32398ad488c0df1cbaf16431422c87e4feea

Thanks
Vivek
> 
> https://lore.kernel.org/linux-fsdevel/20210924192442.916927-1-vgoyal@redhat.com/
> 
> Changes since v1:
> 
> - Added capability to send multiple security contexts in fuse protocol.
>   Miklos suggestd this. So now protocol can easily carry multiple
>   security labels. Just that right now we only send one. When a security
>   hook becomes available which can handle multiple security labels,
>   it should be easy to send those.
> 
> This patch series is dependent on following patch I have posted to
> change signature of security_dentry_init_security().
> 
> https://lore.kernel.org/linux-fsdevel/YWWMO%2FZDrvDZ5X4c@redhat.com/
> 
> Description
> -----------
> When a file is created (create, mknod, mkdir, symlink), typically file
> systems call  security_inode_init_security() to initialize security
> context of an inode. But this does not very well with remote filesystems
> as inode is not there yet. Client will send a creation request to
> server and once server has created the file, client will instantiate
> the inode.
> 
> So filesystems like nfs and ceph use security_dentry_init_security()
> instead. This takes in a dentry and returns the security context of
> file if any.
> 
> These patches call security_dentry_init_security() and send security
> label of file along with creation request (FUSE_CREATE, FUSE_MKDIR,
> FUSE_MKNOD, FUSE_SYMLINK). This will give server an opportunity
> to create new file and also set security label (possibly atomically
> where possible).
> 
> These patches are based on the work Chirantan Ekbote did some time
> back but it never got upstreamed. So I have taken his patches,
> and made modifications on top.
> 
> https://listman.redhat.com/archives/virtio-fs/2020-July/msg00014.html
> https://listman.redhat.com/archives/virtio-fs/2020-July/msg00015.html
> 
> These patches will allow us to support SELinux on virtiofs.
> 
> Vivek Goyal (2):
>   fuse: Add a flag FUSE_SECURITY_CTX
>   fuse: Send security context of inode on file creation
> 
>  fs/fuse/dir.c             | 115 ++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h          |   3 +
>  fs/fuse/inode.c           |   4 +-
>  include/uapi/linux/fuse.h |  29 +++++++++-
>  4 files changed, 144 insertions(+), 7 deletions(-)
> 
> -- 
> 2.31.1
> 

