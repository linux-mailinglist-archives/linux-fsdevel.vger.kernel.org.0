Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD3431FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhJROdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230344AbhJROdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634567449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWLlU++HFlR60Dji6+JiSChwyoeu1/BiL2UnhLTA9vM=;
        b=Sgoj/tIcwXvjPd/n0SUgOhHkDESNAwwQVRfXViONYgK3kwx67Bkr1x5xGIeV89ievsYvLk
        zFxc3LSVQsOplTGJDXRg0GUn6CaOF61gSRQZm/xguQZoAWAQRm9f2FVKZC6RDjeHzxlFxe
        nvTMLWxrpFvKpK/q/7M/Nst/6HHX998=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-yx6F7kvyPSycFTuv-AgCmg-1; Mon, 18 Oct 2021 10:30:48 -0400
X-MC-Unique: yx6F7kvyPSycFTuv-AgCmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D494D19251A0;
        Mon, 18 Oct 2021 14:30:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD41C69C83;
        Mon, 18 Oct 2021 14:30:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 63D4922553C; Mon, 18 Oct 2021 10:30:02 -0400 (EDT)
Date:   Mon, 18 Oct 2021 10:30:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 4/7] fuse: negotiate per-file DAX in FUSE_INIT
Message-ID: <YW2E6jaTbv1FcFnu@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-5-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:49AM +0800, Jeffle Xu wrote:
> Among the FUSE_INIT phase, client shall advertise per-file DAX if it's
> mounted with "-o dax=inode". Then server is aware that client is in
> per-file DAX mode, and will construct per-inode DAX attribute
> accordingly.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b4b41683e97e..f4ad99e2415b 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1203,6 +1203,8 @@ void fuse_send_init(struct fuse_mount *fm)
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> +	if (fm->fc->dax_mode == FUSE_DAX_INODE)
> +		ia->in.flags |= FUSE_PERFILE_DAX;

Are you not keeping track of server's response whether server supports
per inode dax or not. Client might be new and server might be old and
server might not support per inode dax. In that case, we probably 
should error out if user mounted with "-o dax=inode".

Vivek

>  #endif
>  	if (fm->fc->auto_submounts)
>  		ia->in.flags |= FUSE_SUBMOUNTS;
> -- 
> 2.27.0
> 

