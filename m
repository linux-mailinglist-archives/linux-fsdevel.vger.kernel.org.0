Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3A25B44C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIBTOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 15:14:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgIBTOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599074062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvBxqy1tla4NoYESXGOPuAMo0LZFgayYGw3Czxc1AXA=;
        b=ACX+TFGfuuVxj2GBQs8uY8cFl9qxCVJ7PKV7jD4tTF24tMiIfNbOk7772iO9mY+NATYqSP
        45Y1fk1mNJe/8cG2ssYBXa2NEmd30BwM/q6PuR0b3MBVzOJF6zMA1T9v7blt+AFP2HB5vn
        07bRzrnXb5cB2CCvV2JKiXyszXyB70Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-q5tKy3JJPaasoDsDubUi5g-1; Wed, 02 Sep 2020 15:14:20 -0400
X-MC-Unique: q5tKy3JJPaasoDsDubUi5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96CC1801AC2;
        Wed,  2 Sep 2020 19:14:18 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-152.rdu2.redhat.com [10.10.114.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74A7E5D6C4;
        Wed,  2 Sep 2020 19:14:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EF275223642; Wed,  2 Sep 2020 15:14:17 -0400 (EDT)
Date:   Wed, 2 Sep 2020 15:14:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     stefanha@redhat.com, dgilbert@redhat.com, eric.ernst@intel.com
Subject: Re: [RFC PATCH 0/2] fuse: Enable SB_NOSEC if filesystem is not shared
Message-ID: <20200902191417.GC1263242@redhat.com>
References: <20200901204045.1250822-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901204045.1250822-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 04:40:43PM -0400, Vivek Goyal wrote:
> Hi,
> 
> I want to enable SB_NOSEC in fuse in some form so that performance of
> small random writes can be improved. As of now, we call file_remove_privs(),
> which results in fuse always sending getxattr(security.capability) to
> server to figure out if security.capability has been set on file or not.
> If it has been set, it needs to be cleared. This slows down small
> random writes tremendously.
> 
> I posted couple of proposals in the past here.
> 
> Proposal 1:
> 
> https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/
> 
> Proposal 2:
> 
> https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/
> 
> This is 3rd proposal now. One of the roadblocks in enabling SB_NOSEC
> is shared filesystem. It is possible that another client modified the
> file data and this client does not know about it. So we might regress
> if we don't fetch security.capability always.
> 
> So looks like this needs to be handled different for shared filesystems
> and non-shared filesystems. non-shared filesystems will be more like
> local filesystems where fuse does not expect file data/metadata to
> change outside the fuse. And we should be able to enable SB_NOSEC
> optimization. This is what this proposal does.
> 
> It does not handle the case of shared filesystems. I believe solution
> to that will depend on filesystem based on what's the cache coherency
> guarantees filesystem provides and what's the cache invalidation 
> mechanism it uses.
> 
> For now, all filesystems which are not shared can benefit from this
> optimization. I am interested in virtiofs which is not shared in
> many of the cases. In fact we don't even support shared mode yet. 

Well, I was hoping that virtiofs and kata containers can directly
benefit from this mode for root filesystem image. But Eric Ernst
says that kata containers keep bunch of things in a single directory
being exported to guest. And while rootfs image is not expected to
be updated later, it is possile kubernetes updates other parts
later.

And that most likely means kata will not use virtiofs non-shared
mode. 

I guess I need to keep this idea on hold for now because I will not
have any immediate users. And go back to drawing board and figure out
how to not query security.capability on every WRITE.

Thanks
Vivek

> 
> Any comments or feedback is welcome.
> 
> Thanks
> Vivek
> 
> Vivek Goyal (2):
>   fuse: Add a flag FUSE_NONSHARED_FS
>   fuse: Enable SB_NOSEC if filesystem is not shared
> 
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           | 12 +++++++++++-
>  include/uapi/linux/fuse.h |  4 ++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.4
> 

