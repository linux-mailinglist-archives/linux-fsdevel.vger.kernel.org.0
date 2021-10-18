Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5B431F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhJROXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232132AbhJROXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634566864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cq4DqOrjNjJUzCsiMoOeTeURqXSFSIHOXptSN1M9jPE=;
        b=GQsK7ezoIpF3OZta5YBSV1yu3eX9H23Y8l++8Dq0HrIi7ExbP/V0pFOJpn/pKPEgHmebwp
        KzdvEjJZl2IUtOu+/6cZHduAI3CVvZxRaQaoCRzHSKg4xFkncYBh2YQtGbG0Zh1Ca5P3UD
        yOX9bX7mEzOG0zmA1alD16oXBu7HyjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-9-PO3ha9N8KzzAqVyyBxrA-1; Mon, 18 Oct 2021 10:21:01 -0400
X-MC-Unique: 9-PO3ha9N8KzzAqVyyBxrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316F8800685;
        Mon, 18 Oct 2021 14:21:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE921100E809;
        Mon, 18 Oct 2021 14:20:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 71CB12254EE; Mon, 18 Oct 2021 10:20:59 -0400 (EDT)
Date:   Mon, 18 Oct 2021 10:20:59 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 3/7] fuse: support per-file DAX in fuse protocol
Message-ID: <YW2Cyxtijcq5UqYA@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-4-jefflexu@linux.alibaba.com>
 <YW2BLCtThkdrEs3K@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2BLCtThkdrEs3K@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:14:04AM -0400, Vivek Goyal wrote:
> On Mon, Oct 11, 2021 at 11:00:48AM +0800, Jeffle Xu wrote:
> > Expand the fuse protocol to support per-file DAX.
> > 
> > FUSE_PERFILE_DAX flag is added indicating if fuse server/client
> 
> Should we call this flag FUSE_INODE_DAX instead? It is per inode property?
> 

I realized that you are using FUSE_DAX_INODE to represent dax mode. So it
will be confusing to use FUSE_INODE_DAX as protocol flag. How about
FUSE_INODE_DAX_STATE instead?

Vivek

> Vivek
> 
> > supporting per-file DAX. It can be conveyed in both FUSE_INIT request
> > and reply.
> > 
> > FUSE_ATTR_DAX flag is added indicating if DAX shall be enabled for
> > corresponding file. It is conveyed in FUSE_LOOKUP reply.
> > 
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> >  include/uapi/linux/fuse.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 36ed092227fa..15a1f5fc0797 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -184,6 +184,9 @@
> >   *
> >   *  7.34
> >   *  - add FUSE_SYNCFS
> > + *
> > + *  7.35
> > + *  - add FUSE_PERFILE_DAX, FUSE_ATTR_DAX
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -219,7 +222,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >  
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 34
> > +#define FUSE_KERNEL_MINOR_VERSION 35
> >  
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -336,6 +339,7 @@ struct fuse_file_lock {
> >   *			write/truncate sgid is killed only if file has group
> >   *			execute permission. (Same as Linux VFS behavior).
> >   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> > + * FUSE_PERFILE_DAX:	kernel supports per-file DAX
> >   */
> >  #define FUSE_ASYNC_READ		(1 << 0)
> >  #define FUSE_POSIX_LOCKS	(1 << 1)
> > @@ -367,6 +371,7 @@ struct fuse_file_lock {
> >  #define FUSE_SUBMOUNTS		(1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
> >  #define FUSE_SETXATTR_EXT	(1 << 29)
> > +#define FUSE_PERFILE_DAX	(1 << 30)
> >  
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -449,8 +454,10 @@ struct fuse_file_lock {
> >   * fuse_attr flags
> >   *
> >   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> > + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
> >   */
> >  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> > +#define FUSE_ATTR_DAX		(1 << 1)
> >  
> >  /**
> >   * Open flags
> > -- 
> > 2.27.0
> > 

