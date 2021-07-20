Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB03D021A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 21:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhGTSin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 14:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230173AbhGTSh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626808714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVavRmBCFQMgCfTGMbqTCEVwgb4wxSR94J/cuWyrTdU=;
        b=WgH/9w+Ty0hpVrpTAn7koM18u5ckCRftOeMr1z2bS8sSEwB7Q69J3+d4jpgeTCVDjqvSED
        jvLrM87S5y5ga/1eNB+6AhGRfh3jSTQobdxxlECWhBamTysZ+3EePmsHD0+XSqTrT/8Vaw
        k9kmrB7vrlXAZmyVp1kIzMxBwJSwK4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-OTi243zAMb2FbI2bX7HUMg-1; Tue, 20 Jul 2021 15:18:31 -0400
X-MC-Unique: OTi243zAMb2FbI2bX7HUMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D62ED100C609;
        Tue, 20 Jul 2021 19:18:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-228.rdu2.redhat.com [10.10.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC64C5D6A1;
        Tue, 20 Jul 2021 19:18:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4142B223E70; Tue, 20 Jul 2021 15:18:25 -0400 (EDT)
Date:   Tue, 20 Jul 2021 15:18:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Message-ID: <YPchgf665bwUMKWU@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:25:11PM +0800, JeffleXu wrote:
> 
> 
> On 7/20/21 5:30 AM, Vivek Goyal wrote:
> > On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
> >> This patchset adds support of per-file DAX for virtiofs, which is
> >> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>
> >> There are three related scenarios:
> >> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
> >> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
> >> In this case, the dentry and inode are all marked as DONT_CACHE, and
> >> the DAX state won't be updated until the file is closed and reopened
> >> later.
> >> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
> >> (patch 4)
> >> 4. Create new files under directories with DAX enabled. When creating
> >> new files in ext4/xfs on host, the new created files will inherit the
> >> per-file DAX flag from the directory, and thus the new created files in
> >> virtiofs will also inherit the per-file DAX flag if the fuse server
> >> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
> >> DAX flag.
> > 
> > Thinking little bit more about this from requirement perspective. I think
> > we are trying to address two use cases here.
> > 
> > A. Client does not know which files DAX should be used on. Only server
> >    knows it and server passes this information to client. I suspect
> >    that's your primary use case.
> 
> Yes, this is the starting point of this patch set.
> 
> > 
> > B. Client is driving which files are supposed to be using DAX. This is
> >    exactly same as the model ext4/xfs are using by storing a persistent
> >    flag on inode. 
> > 
> > Current patches seem to be a hybrid of both approach A and B. 
> > 
> > If we were to implement B, then fuse client probably needs to have the
> > capability to query FS_XFLAG_DAX on inode and decide whether to
> > enable DAX or not. (Without extra round trip). Or know it indirectly
> > by extending GETATTR and requesting this explicitly.
> 
> If guest queries if the file is DAX capable or not by an extra GETATTR,
> I'm afraid this will add extra round trip.
> 
> Or if we add the DAX flag (ATTR_DAX) by extending LOOKUP, as done by
> this patch set, then the FUSE server needs to set ATTR_DAX according to
> the FS_XFLAG_DAX of the backend files, *to make the FS_XFLAG_DAX flag
> previously set by FUSE client work*. Then it becomes a *mandatory*
> requirement when implementing FUSE server. i.e., it becomes part of the
> FUSE protocol rather than implementation specific. FUSE server can still
> implement some other algorithm deciding whether to set ATTR_DAX or not,
> though it must set ATTR_DAX once the backend file is flagged with
> FS_XFLAG_DAX.
> 
> Besides, as you said, FUSE server needs to add one extra
> GETFLAGS/FSGETXATTR ioctl per LOOKUP in this case. To eliminate this
> cost, we could negotiate the per-file DAX capability during FUSE_INIT.
> Only when the per-file DAX capability is negotiated, will the FUSE
> server do extra GETFLAGS/FSGETXATTR ioctl and set ATTR_DAX flag when
> doing LOOKUP.
> 
> 
> Personally, I prefer the second way, i.e., by extending LOOKUP (adding
> ATTR_DAX), to eliminate the extra round trip.

Negotiating a fuse feature say FUSE_FS_XFLAG_DAX makes sense. If
client is mounted with "-o dax=inode", then client will negotitate
this feature and if server does not support it, mount can fail.

But this probably will be binding on server that it needs to return
the state of FS_XFLAG_DAX attr on inode upon lookup/getattr. I don't
this will allow server to implement its own separate policy which
does not follow FS_XFLAG_DAX xattr. 

IOW, I don't think server can choose to implement its own policy
for enabling dax for "-o dax=inode".

If there is really a need to for something new where server needs
to dynamically decide which inodes should use dax (and not use
FS_XFLAG_FS), I guess that probably should be a separate mount
option say "-o dax=server" and it negotiates a separate feature
say FUSE_DAX_SERVER. Once that's negotiated, now both client
and server know that DAX will be used on files as determined
by server and not necessarily by using file attr FS_XFLAG_DAX.

So is "dax=inode" enough for your needs? What's your requirement,
can you give little bit of more details.

Thanks
Vivek

> 
> > 
> > If we were only implementing A, then server does not have a way to 
> > tell client to enable DAX. Server can either look at FS_XFLAG_DAX
> > and decide to enable DAX or use some other property. Given querying
> > FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
> > it probably will be a server option. But enabling on server does not
> > mean client will enable it.
> 
> As I said previously, it can be negotiated whether this per-file DAX
> capability is needed. Guest can advertise this capability when '-o
> dax=inode' is configured.
> 
> > 
> > I think my primary concern with this patch right now is trying to
> > figure out which requirement we are trying to cater to first and how
> > to connect server and client well so they both understand what mode
> > they are operating in and interact well.
> > 
> 
> 
> -- 
> Thanks,
> Jeffle
> 

