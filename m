Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D703C473392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbhLMSIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241559AbhLMSIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639418909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykESYpv/5u+O8vn68tOYD0QwBQmexsCFWdt6W0E3KR8=;
        b=dAsqvxfh8qO/wb1GL6tJQThJzGnD4dc3xDlO9/8nYF4rqVO686pbp6/OP9MvEY1wnqKVGL
        5Z0cuQQY1SnPs1XWk0Ihdr+vKIlODK/abs+x3ZAnq3uHJ0iuYlq3j1EIAroeLdsEAFB6z3
        QHjE6mfBikLouMbtqzz4lwZ/OkznUbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-r19kVBu4P3uaBOejU99rnQ-1; Mon, 13 Dec 2021 13:08:28 -0500
X-MC-Unique: r19kVBu4P3uaBOejU99rnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FD0100C662;
        Mon, 13 Dec 2021 18:08:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC57919EF9;
        Mon, 13 Dec 2021 18:08:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 79EBD2233DF; Mon, 13 Dec 2021 13:08:26 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:08:26 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 1/7] fuse: add fuse_should_enable_dax() helper
Message-ID: <YbeMGlULQP53bSlq@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-2-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:24PM +0800, Jeffle Xu wrote:
> This is in prep for following per inode DAX checking.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> ---
>  fs/fuse/dax.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 5778ebfbce5e..4c48a57632bd 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1329,11 +1329,19 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  	.invalidatepage	= noop_invalidatepage,
>  };
>  
> -void fuse_dax_inode_init(struct inode *inode)
> +static bool fuse_should_enable_dax(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  
>  	if (!fc->dax)
> +		return false;
> +
> +	return true;
> +}
> +
> +void fuse_dax_inode_init(struct inode *inode)
> +{
> +	if (!fuse_should_enable_dax(inode))
>  		return;
>  
>  	inode->i_flags |= S_DAX;
> -- 
> 2.27.0
> 

