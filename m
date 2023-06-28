Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78C374169B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjF1Qm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231563AbjF1Qm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687970496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnVyCujzdEZQCQhWIXvD4KgctZ350N170aw6MNVL7b8=;
        b=GiR/9wtipzbCl8tYaJASrdhPiO90audcOKa749VCmQViGmDUJB+XtHycQuZ2mhjgVm3uDp
        CWwPm7OsOFboX6U/bq1k6C78ncZsvXDzt7Yeh3YtPksA5b3OpfA6laEkekITNfYcM0WGGy
        uGCDMcKuk3o1lqZINCB+l4vIQYbKxek=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-mvbvvUpqO5KW0JldaqOrMA-1; Wed, 28 Jun 2023 12:41:31 -0400
X-MC-Unique: mvbvvUpqO5KW0JldaqOrMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC46E3C108CB;
        Wed, 28 Jun 2023 16:41:29 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02AF1F5CD9;
        Wed, 28 Jun 2023 16:41:28 +0000 (UTC)
Date:   Wed, 28 Jun 2023 11:41:27 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: Convert to bdev_logical_block_mask()
Message-ID: <ZJxit/naWMq3v6OU@redhat.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
 <20230628093500.68779-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-6-frank.li@vivo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:34:59PM +0800, Yangtao Li wrote:
> Use bdev_logical_block_mask() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  fs/xfs/xfs_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15d1e5a7c2d3..f784daa21219 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1968,7 +1968,7 @@ xfs_setsize_buftarg(
>  
>  	/* Set up device logical sector size mask */
>  	btp->bt_logical_sectorsize = bdev_logical_block_size(btp->bt_bdev);
> -	btp->bt_logical_sectormask = bdev_logical_block_size(btp->bt_bdev) - 1;
> +	btp->bt_logical_sectormask = bdev_logical_block_mask(btp->bt_bdev);
>  
>  	return 0;
>  }
> -- 
> 2.39.0
> 

