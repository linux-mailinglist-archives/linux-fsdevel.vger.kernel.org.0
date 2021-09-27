Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD44195ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhI0OH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 10:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234691AbhI0OH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632751578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Njho4Z4V5IX6IqXLiubSzD1xQsvCLZJLI7bOJydcHoY=;
        b=D5rvBJWR+WiQAbJYjL45iXu6ZrV3xBv871tF2QA3kwFYzgGPnd8cfJV996YvlGMDN1VRIW
        daKQ9aum0v3jVVzs9CWWFTNYalxSAn1gTHQLsoCnB9XsYzzZIEh5HQ3DDejmwPlHoDY70B
        u6FDtsU8NBY6OVq7uXkeknW0UDnVKwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-gV7HNcYQMLCDryw8qDYK9g-1; Mon, 27 Sep 2021 10:06:16 -0400
X-MC-Unique: gV7HNcYQMLCDryw8qDYK9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E913626F;
        Mon, 27 Sep 2021 14:06:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5F586A900;
        Mon, 27 Sep 2021 14:05:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 342E3222E4F; Mon, 27 Sep 2021 10:05:57 -0400 (EDT)
Date:   Mon, 27 Sep 2021 10:05:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
Message-ID: <YVHPxYRnZvs/dH7N@redhat.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
 <YU5gF9xDhj4g+0Oe@redhat.com>
 <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 26, 2021 at 05:53:11PM -0700, Casey Schaufler wrote:
> On 9/24/2021 4:32 PM, Vivek Goyal wrote:
> > On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
> >>
> >> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
> >>> When a new inode is created, send its security context to server along
> >>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> >>> This gives server an opportunity to create new file and set security
> >>> context (possibly atomically). In all the configurations it might not
> >>> be possible to set context atomically.
> >>>
> >>> Like nfs and ceph, use security_dentry_init_security() to dermine security
> >>> context of inode and send it with create, mkdir, mknod, and symlink requests.
> >>>
> >>> Following is the information sent to server.
> >>>
> >>> - struct fuse_secctx.
> >>>   This contains total size of security context which follows this structure.
> >>>
> >>> - xattr name string.
> >>>   This string represents name of xattr which should be used while setting
> >>>   security context. As of now it is hardcoded to "security.selinux".
> >> Any reason not to just send all `security.*` xattrs found on the inode? 
> >>
> >> (I'm not super familiar with this code, it looks like we're going from the LSM-cached version attached to the inode, but presumably since we're sending bytes we can just ask the filesytem for the raw data instead)
> > So this inode is about to be created. There are no xattrs yet. And
> > filesystem is asking LSMs, what security labels should be set on this
> > inode before it is published. 
> 
> No. That's imprecise. It's what SELinux does. An LSM can add any
> number of attributes on inode creation, or none. These attributes
> may or may not be "security labels". Assuming that they are is the
> kind of thinking that leads people like Linus to conclude that the
> LSM community is clueless.
> 
> 
> >
> > For local filesystems it is somewhat easy. They are the one creating
> > inode and can set all xattrs/labels before inode is added to inode
> > cache.
> >
> > But for remote like filesystems, it is more tricky. Actual inode
> > creation first will happen on server and then client will instantiate
> > an inode based on information returned by server (Atleast that's
> > what fuse does).
> >
> > So security_dentry_init_security() was created (I think by NFS folks)
> > so that they can query the label and send it along with create
> > request and server can take care of setting label (along with file
> > creation).
> >
> > One limitation of security_dentry_init_security() is that it practically
> > supports only one label. And only SELinux has implemented. So for
> > all practical purposes this is a hook to obtain selinux label. NFS
> > and ceph already use it in that way.
> >
> > Now there is a desire to be able to return more than one security
> > labels and support smack and possibly other LSMs. Sure, that great.
> > But I think for that we will have to implement a new hook which
> > can return multiple labels and filesystems like nfs, ceph and fuse
> > will have to be modified to cope with this new hook to support
> > multiple lables. 
> >
> > And I am arguing that we can modify fuse when that hook has been
> > implemented. There is no point in adding that complexity in fuse
> > code as well all fuse-server implementations when there is nobody
> > generating multiple labels. We can't even test it.
> 
> There's a little bit of chicken-and-egg going on here.
> There's no point in accommodating multiple labels in
> this code because you can't have multiple labels. There's
> no point in trying to support multiple labels because
> you can't use them in virtiofs and a bunch of other
> places.

Once security subsystem provides a hook to support multiple lables, then
atleast one filesystem will have to be converted to make use of this new
hook at the same time and rest of the filesystems can catch up later.

Vivek

