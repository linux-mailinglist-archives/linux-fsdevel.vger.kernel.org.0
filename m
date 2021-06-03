Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3D399BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFCHgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 3 Jun 2021 03:36:14 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56147 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhFCHgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:36:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-J2cflW4UN0yhwxpUH8_qPg-1; Thu, 03 Jun 2021 03:34:25 -0400
X-MC-Unique: J2cflW4UN0yhwxpUH8_qPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7794B180FD7A;
        Thu,  3 Jun 2021 07:34:24 +0000 (UTC)
Received: from bahia.lan (ovpn-114-128.ams2.redhat.com [10.36.114.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E80620DE;
        Thu,  3 Jun 2021 07:34:19 +0000 (UTC)
Date:   Thu, 3 Jun 2021 09:34:17 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Max Reitz <mreitz@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 3/4] fuse: Call vfs_get_tree() for submounts
Message-ID: <20210603093333.154c23ac@bahia.lan>
In-Reply-To: <7b4a3379-3004-98f2-841c-386ce62c888a@redhat.com>
References: <20210525150230.157586-1-groug@kaod.org>
        <20210525150230.157586-4-groug@kaod.org>
        <7b4a3379-3004-98f2-841c-386ce62c888a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 May 2021 15:24:40 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 25.05.21 17:02, Greg Kurz wrote:
> > We recently fixed an infinite loop by setting the SB_BORN flag on
> > submounts along with the write barrier needed by super_cache_count().
> > This is the job of vfs_get_tree() and FUSE shouldn't have to care
> > about the barrier at all.
> > 
> > Split out some code from fuse_dentry_automount() to a new dedicated
> > fuse_get_tree_submount() handler for submounts and call vfs_get_tree().
> > 
> > The fs_private field of the filesystem context isn't used with
> > submounts : hijack it to pass the FUSE inode of the mount point
> > down to fuse_get_tree_submount().
> 
> What exactly do you mean by “isn’t used”?  virtio_fs_init_fs_context() 
> still sets it (it is non-NULL in fuse_dentry_automount() after 
> fs_context_for_submount()).  It does appear like it is never read, but 
> one thing that definitely would need to be done is for it to be freed 
> before putting mp_fi there.
> 

Oops... yes it should. Thanks for the catch !

> So I think it may technically be fine to use this field, but then 
> virtio_fs_init_fs_context() shouldn’t set it for submounts (should be 
> discernible with fsc->purpose), and perhaps that should be a separate patch.
> 

Yes, I'll do just that.

> (Apart from that, this patch looks good to me, though.)
> 
> Max
> 
> > Finally, adapt virtiofs to use this.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   fs/fuse/dir.c       | 58 +++++++--------------------------------------
> >   fs/fuse/fuse_i.h    |  6 +++++
> >   fs/fuse/inode.c     | 44 ++++++++++++++++++++++++++++++++++
> >   fs/fuse/virtio_fs.c |  3 +++
> >   4 files changed, 62 insertions(+), 49 deletions(-)
> 

