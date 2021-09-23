Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8141658F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhIWTAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 15:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231830AbhIWTAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632423541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTs5uavSb7CXDRgzwwCAXMMOT01lkovGyaxjP72U1kI=;
        b=foyX8mia1mhlqtQaJ4Txv56JfuTxaBefzHvm7jnXQJyuXE3NkxQwTO1xADghgOqwIO9uPH
        thrd/pK9PoLbBwsws3rZqFHXiSHdc0KzsxLE+yEmZEEBs5RyoR+k2Rv4IClxLqZ+KM0wbS
        aipZd15bCl9+YA/cITaTc0DgkDThKIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-etQEhPFeN_CYWdFE4V439Q-1; Thu, 23 Sep 2021 14:58:59 -0400
X-MC-Unique: etQEhPFeN_CYWdFE4V439Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82BFD56AA7;
        Thu, 23 Sep 2021 18:58:58 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C0EA5BAF8;
        Thu, 23 Sep 2021 18:58:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D6613222E4F; Thu, 23 Sep 2021 14:58:52 -0400 (EDT)
Date:   Thu, 23 Sep 2021 14:58:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 1/5] fuse: add fuse_should_enable_dax() helper
Message-ID: <YUzObLV8SB4EqaTD@redhat.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923092526.72341-2-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:25:22PM +0800, Jeffle Xu wrote:
> This is in prep for following per-file DAX checking.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 281d79f8b3d3..28db96ea23e2 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1330,11 +1330,19 @@ static const struct address_space_operations fuse_dax_file_aops  = {
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

It probably is easier to read if we flip the logic.

{
	if (fc->dax)
		return true;
	return false;
}

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

