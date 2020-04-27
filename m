Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A022D1BABCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgD0R61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 13:58:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48676 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgD0R61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588010305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5szEPVymC4ndC8RJO9oa6y1UYRoV+3+bMcnppRK97Q=;
        b=KEjACS/en4JJ53ed21SGXAoqLqKDzIHEDEp2u25x9OfkIHv/Nrtc5oJA3cwWccQeO4/W/z
        dxBcB6B/18zqIJ8gtqbPzhp3+SCeEIj0mHyVKgictLdCpUgyTbTrZ1fE4a/CYhp1PFJ4Ae
        ombvsWlTeQtHBXV0USpsZ7Ig0Z+v+NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ibtlmwTwM9OYMwimsNBSrg-1; Mon, 27 Apr 2020 13:58:21 -0400
X-MC-Unique: ibtlmwTwM9OYMwimsNBSrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9892B1895A28;
        Mon, 27 Apr 2020 17:58:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 548BF5D9DA;
        Mon, 27 Apr 2020 17:58:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9844722036A; Mon, 27 Apr 2020 13:58:14 -0400 (EDT)
Date:   Mon, 27 Apr 2020 13:58:14 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Subject: Re: [PATCH 1/2] fuse: virtiofs: Fix nullptr dereference
Message-ID: <20200427175814.GC146096@redhat.com>
References: <20200424062540.23679-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424062540.23679-1-chirantan@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:25:39PM +0900, Chirantan Ekbote wrote:
> virtiofs device implementations are allowed to provide more than one
> request queue.  In this case `fsvq->fud` would not be initialized,
> leading to a nullptr dereference later during driver initialization.
> 
> Make sure that `fsvq->fud` is initialized for all request queues even if
> the driver doesn't use them.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  fs/fuse/virtio_fs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bade747689033..d3c38222a7e4e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1066,10 +1066,13 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  	}
>  
>  	err = -ENOMEM;
> -	/* Allocate fuse_dev for hiprio and notification queues */
> -	for (i = 0; i < VQ_REQUEST; i++) {
> +	/* Allocate fuse_dev for all queues except the first request queue. */
> +	for (i = 0; i < fs->nvqs; i++) {
>  		struct virtio_fs_vq *fsvq = &fs->vqs[i];
>  
> +		if (i == VQ_REQUEST)
> +			continue;
> +

These special conditions of initializing fuse device for one queue
fusing fill_super_common() and rest of the queues outside of it, are
bothering me. I am proposing a separate patch where all fuse device
initialization/cleanup is done by the caller. It makes code look
cleaner and easier to understand.

Vivek

>  		fsvq->fud = fuse_dev_alloc();
>  		if (!fsvq->fud)
>  			goto err_free_fuse_devs;
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

