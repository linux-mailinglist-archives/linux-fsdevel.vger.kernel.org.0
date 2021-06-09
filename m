Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CD3A0DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhFIHrz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Jun 2021 03:47:55 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:42667 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233136AbhFIHry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:47:54 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-8MgHxSRfNGK8NOd496-1zQ-1; Wed, 09 Jun 2021 03:45:55 -0400
X-MC-Unique: 8MgHxSRfNGK8NOd496-1zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FCD78049C5;
        Wed,  9 Jun 2021 07:45:54 +0000 (UTC)
Received: from bahia.lan (ovpn-112-166.ams2.redhat.com [10.36.112.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51A55C1C2;
        Wed,  9 Jun 2021 07:45:48 +0000 (UTC)
Date:   Wed, 9 Jun 2021 09:45:47 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Max Reitz <mreitz@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 6/7] fuse: Switch to fc_mount() for submounts
Message-ID: <20210609094547.222fc420@bahia.lan>
In-Reply-To: <0d3b4dfb-2474-2200-80d1-39dcbf8f626e@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
        <20210604161156.408496-7-groug@kaod.org>
        <0d3b4dfb-2474-2200-80d1-39dcbf8f626e@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Jun 2021 17:51:03 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 04.06.21 18:11, Greg Kurz wrote:
> > fc_mount() already handles the vfs_get_tree(), sb->s_umount
> > unlocking and vfs_create_mount() sequence. Using it greatly
> > simplifies fuse_dentry_automount().
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   fs/fuse/dir.c | 26 +++++---------------------
> >   1 file changed, 5 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index b88e5785a3dd..fc9eddf7f9b2 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -311,38 +311,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
> >   	struct fs_context *fsc;
> >   	struct vfsmount *mnt;
> >   	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
> > -	int err;
> >   
> >   	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
> > -	if (IS_ERR(fsc)) {
> > -		err = PTR_ERR(fsc);
> > -		goto out;
> > -	}
> > +	if (IS_ERR(fsc))
> > +		return (struct vfsmount *) fsc;
> 
> I think ERR_CAST(fsc) would be nicer.
> 

Indeed. I'll fix that if I need to repost.

> Apart from that:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

