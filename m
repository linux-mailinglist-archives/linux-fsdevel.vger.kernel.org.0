Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885ED3570FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353874AbhDGPvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353909AbhDGPuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e55XxdhFEquyLB2Ir8ZHzShBhWe4g5kf5ai240p48C8=;
        b=EZqkyiQ8/YWM2cebSFIRsqO2R4EOdFCAp0Clp2knzxd+FTgVMwRipVgxPkz3PiCE4p+7jk
        B2L0h0fuUIjp1DZkmt9I29Kzle5ZLWa6wPFeqN2sk7bzfPfBf/uiHY/s6gOEDRC0ejdJyP
        8/JV7QMdxBC+owHCPPHhNin3FSTjxZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-5_T2zrWdOB2lBb81PkAixw-1; Wed, 07 Apr 2021 11:50:39 -0400
X-MC-Unique: 5_T2zrWdOB2lBb81PkAixw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C0E81425A;
        Wed,  7 Apr 2021 15:50:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-29.rdu2.redhat.com [10.10.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0993F1042A66;
        Wed,  7 Apr 2021 15:50:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6DF1122054F; Wed,  7 Apr 2021 11:50:31 -0400 (EDT)
Date:   Wed, 7 Apr 2021 11:50:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: Avoid potential use after free
Message-ID: <20210407155031.GA1014852@redhat.com>
References: <20210406235332.2206460-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406235332.2206460-1-pakki001@umn.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> In virtio_fs_get_tree, after fm is freed, it is again freed in case
> s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> a double free, set fm to NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4ee6f734ba83..a7484c1539bf 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	if (fsc->s_fs_info) {
>  		fuse_conn_put(fc);
>  		kfree(fm);
> +		fm = NULL;

I think both the code paths are mutually exclusive and that's why we
don't double free it.

sget_fc(), can either return existing super block which is already
initialized, or it can create a new super block which need to
initialize further.

If if get an existing super block, in that case fs->s_fs_info will
still be set and we need to free fm (as we did not use it). But in 
that case this super block is already initialized so sb->s_root
should be non-null and we will not call virtio_fs_fill_super()
on this. And hence we will not get into kfree(fm) again.

Same applies to fuse_conn_put(fc) call as well.

So I think this patch is not needed. I think sget_fc() semantics are
not obvious and that confuses the reader of the code.

Thanks
Vivek

>  	}
>  	if (IS_ERR(sb))
>  		return PTR_ERR(sb);
> -- 
> 2.25.1
> 

