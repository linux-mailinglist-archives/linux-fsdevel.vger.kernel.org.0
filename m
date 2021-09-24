Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7231F417E4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbhIXXeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 19:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237813AbhIXXea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 19:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632526377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAURutp2HKBpGkWfffuX1cN49bIs6B414rgIINtepRc=;
        b=jQW3mDJ7XVk7Misqq/hbvwtUy33B1ZDs+qvXtkXtaJp4sSDT8VsDy6P8yHJP/5GggcdwQE
        nugY6Bv9fY15g0JN2W0xD785rn5K/JSZLkX+bgarZDWiK2rkGVfzfV4AtZuM1Y6mwOnOPm
        G9itu4sPPlrW2+fvTJCIddYrVFSijBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-kA2Me3tZMLOdiIjy9dnA6g-1; Fri, 24 Sep 2021 19:32:53 -0400
X-MC-Unique: kA2Me3tZMLOdiIjy9dnA6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15D7E8145E5;
        Fri, 24 Sep 2021 23:32:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB98660BF4;
        Fri, 24 Sep 2021 23:32:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 444E8222E4F; Fri, 24 Sep 2021 19:32:39 -0400 (EDT)
Date:   Fri, 24 Sep 2021 19:32:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Colin Walters <walters@verbum.org>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
Message-ID: <YU5gF9xDhj4g+0Oe@redhat.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
> 
> 
> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
> > When a new inode is created, send its security context to server along
> > with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> > This gives server an opportunity to create new file and set security
> > context (possibly atomically). In all the configurations it might not
> > be possible to set context atomically.
> >
> > Like nfs and ceph, use security_dentry_init_security() to dermine security
> > context of inode and send it with create, mkdir, mknod, and symlink requests.
> >
> > Following is the information sent to server.
> >
> > - struct fuse_secctx.
> >   This contains total size of security context which follows this structure.
> >
> > - xattr name string.
> >   This string represents name of xattr which should be used while setting
> >   security context. As of now it is hardcoded to "security.selinux".
> 
> Any reason not to just send all `security.*` xattrs found on the inode? 
> 
> (I'm not super familiar with this code, it looks like we're going from the LSM-cached version attached to the inode, but presumably since we're sending bytes we can just ask the filesytem for the raw data instead)

So this inode is about to be created. There are no xattrs yet. And
filesystem is asking LSMs, what security labels should be set on this
inode before it is published. 

For local filesystems it is somewhat easy. They are the one creating
inode and can set all xattrs/labels before inode is added to inode
cache.

But for remote like filesystems, it is more tricky. Actual inode
creation first will happen on server and then client will instantiate
an inode based on information returned by server (Atleast that's
what fuse does).

So security_dentry_init_security() was created (I think by NFS folks)
so that they can query the label and send it along with create
request and server can take care of setting label (along with file
creation).

One limitation of security_dentry_init_security() is that it practically
supports only one label. And only SELinux has implemented. So for
all practical purposes this is a hook to obtain selinux label. NFS
and ceph already use it in that way.

Now there is a desire to be able to return more than one security
labels and support smack and possibly other LSMs. Sure, that great.
But I think for that we will have to implement a new hook which
can return multiple labels and filesystems like nfs, ceph and fuse
will have to be modified to cope with this new hook to support
multiple lables. 

And I am arguing that we can modify fuse when that hook has been
implemented. There is no point in adding that complexity in fuse
code as well all fuse-server implementations when there is nobody
generating multiple labels. We can't even test it.

Thanks
Vivek

