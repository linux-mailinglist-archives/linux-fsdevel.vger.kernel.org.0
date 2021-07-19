Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1F3CEF19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhGSV2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383654AbhGSSBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626720099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p204Ua/8UMVEDK/XuK5qa9JXwwuGxX3Scr0fvegt0Q8=;
        b=NU4B4IIYND7BQGflnhCsU1nYeg1AJ+c9LkcHabMcQUX+2wmaa4lzEOQHrHj36R/LHebBdM
        QHlYtaw7qE+Lfol1DBBnV9F8BesY9d1UnYhr95dvYyyMXqb/qw05r8/WhrW8Y8sYkzo7Za
        nLpM6zHCr5EbEIjG2nEqzzIox3n3sgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-iNZ3s_tHMRaavc_J-FzkGg-1; Mon, 19 Jul 2021 14:41:37 -0400
X-MC-Unique: iNZ3s_tHMRaavc_J-FzkGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04456101F7A5;
        Mon, 19 Jul 2021 18:41:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F16055D6A1;
        Mon, 19 Jul 2021 18:41:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 79845223E4F; Mon, 19 Jul 2021 14:41:30 -0400 (EDT)
Date:   Mon, 19 Jul 2021 14:41:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPXHWmiYXMNxxhf7@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-4-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> this file.
> 
> When the per-file DAX flag changes for an *opened* file, the state of
> the file won't be updated until this file is closed and reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

[..]
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..90c9df10d37a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -184,6 +184,9 @@
>   *
>   *  7.34
>   *  - add FUSE_SYNCFS
> + *
> + *  7.35
> + *  - add FUSE_ATTR_DAX
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -449,8 +452,10 @@ struct fuse_file_lock {
>   * fuse_attr flags
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> +#define FUSE_ATTR_DAX		(1 << 1)

Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
a separate patch. 

I am not clear on one thing. If we are planning to rely on persistent
inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
why fuse server needs to communicate the state of that attr using a 
flag? Can client directly query it?  I am not sure where at these
attrs stored and if fuse protocol currently supports it.

What about flag STATX_ATTR_DAX. We probably should report that too
in stat if we are using dax on the inode?

Vivek

