Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBC44DC88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhKKUh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 15:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKUh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636662877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SGyKeYhgcGOPMEZvf3dSjeVeoTSfCDYQlQSNfqt26l8=;
        b=LpSxld5FxqunDmC0+5Si5jI+TZiY1MRvqOHI2aV7NyA1q55u4g06Ao75/J9hMBR85seBmK
        idHlGal1XC6owCZLgzbBuF2GRKtBLHELh5LIKZut2yMX4WFmBt6x9GlLm9IFrO6lNTThbi
        2aUZ+YGLPP+WUH0P+p2bX31zCe4YgW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-ZTo48KdRNFShErtK5CBZkA-1; Thu, 11 Nov 2021 15:34:31 -0500
X-MC-Unique: ZTo48KdRNFShErtK5CBZkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B90110168DA;
        Thu, 11 Nov 2021 20:34:25 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 489E367871;
        Thu, 11 Nov 2021 20:33:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AE61B220EED; Thu, 11 Nov 2021 15:33:21 -0500 (EST)
Date:   Thu, 11 Nov 2021 15:33:21 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v7 6/7] fuse: mark inode DONT_CACHE when per inode DAX
 hint changes
Message-ID: <YY1+EYQOXNn0HgVu@redhat.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
 <20211102052604.59462-7-jefflexu@linux.alibaba.com>
 <CAJfpegvfQbA32HjqWv9-Ds04W7Qs2idTOP7w5_NvKS_n=0Td7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvfQbA32HjqWv9-Ds04W7Qs2idTOP7w5_NvKS_n=0Td7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:50:25PM +0100, Miklos Szeredi wrote:
> On Tue, 2 Nov 2021 at 06:26, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > When the per inode DAX hint changes while the file is still *opened*, it
> > is quite complicated and maybe fragile to dynamically change the DAX
> > state.
> >
> > Hence mark the inode and corresponding dentries as DONE_CACHE once the
> > per inode DAX hint changes, so that the inode instance will be evicted
> > and freed as soon as possible once the file is closed and the last
> > reference to the inode is put. And then when the file gets reopened next
> > time, the new instantiated inode will reflect the new DAX state.
> >
> > In summary, when the per inode DAX hint changes for an *opened* file, the
> > DAX state of the file won't be updated until this file is closed and
> > reopened later.
> 
> This patch does nothing, since fuse already uses .drop_inode =
> generic_delete_inode, which is has the same effect as setting
> I_DONTCACHE, at least in the fuse case (inode should never be dirty at
> eviction).   In fact it may be cleaner to set I_DONTCACHE
> unconditionally and remove the .drop_inode callback setting.

I thought idea was to drop dentry and not cache it which in turn
will drop dentry's reference on inode and lead to cleanup of inode.

Otherwise dentry might remain cached and which in-turn will keep
inode in cache. Am I missing something.

Thanks
Vivek

