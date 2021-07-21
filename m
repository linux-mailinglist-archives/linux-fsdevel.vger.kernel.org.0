Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696BF3D1192
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbhGUOCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233069AbhGUOCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626878579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKs3+Xdc2Yu+lcTu46rzXDZNt56m1hbeO49s4AhSxWY=;
        b=b5AhOuFdD00mAzbUu8FtMiwbabWhYSquAVqRZ8p3qEwI2Tf/vVmTKkNvZqh7FUsBQduBiT
        a5EFU/N6YdBYJ5yf/HOmXS9dpumcMM8IHETAp4k3VvFhL95wM7JMfvaXx3LlkccuwyNWw0
        Hvn98gpB1U6fQaT9IYcjtVlrxVFDldw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-s-RFpwf6O2aYXw05b7YYdg-1; Wed, 21 Jul 2021 10:42:58 -0400
X-MC-Unique: s-RFpwf6O2aYXw05b7YYdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0B17760C0;
        Wed, 21 Jul 2021 14:42:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7E0E61F21;
        Wed, 21 Jul 2021 14:42:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 568DB223E70; Wed, 21 Jul 2021 10:42:50 -0400 (EDT)
Date:   Wed, 21 Jul 2021 10:42:50 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Message-ID: <YPgyalU0avl9KI/U@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
 <YPchgf665bwUMKWU@redhat.com>
 <38e9da34-cc2b-f496-7ebb-18db8da1aa01@linux.alibaba.com>
 <YPgXuacFfJ/JVRjo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgXuacFfJ/JVRjo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 08:48:57AM -0400, Vivek Goyal wrote:
[..]
> > > So is "dax=inode" enough for your needs? What's your requirement,
> > > can you give little bit of more details.
> > 
> > In our use case, the backend fs is something like SquashFS on host. The
> > content of the file on host is downloaded *as needed*. When the file is
> > not completely ready (completely downloaded), the guest will follow the
> > normal IO routine, i.e., by FUSE_READ/FUSE_WRITE request. While the file
> > is completely ready, per-file DAX is enabled for this file. IOW the FUSE
> > server need to dynamically decide if per-file DAX shall be enabled,
> > depending on if the file is completely downloaded.
> 
> So you don't want to enable DAX yet because guest might fault on
> a section of file which has not been downloaded yet?
> 
> I am wondering if somehow user fault handling can help with this.
> If we could handle faults for this file in user space, then you
> should be able to download that particular page[s] and resolve
> the fault?

Stefan mentioned that can't we block when fuse mmap request comes
in and download corresponding section of file. Or do whatever you
are doing in FUSE_READ. 

IOW, even if you enable dax in your use case on all files,
FUSE_SETUPMAPPING request will give you control to make sure 
file section being mmaped has been downloaded.

Vivek

