Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625381BD463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD2GGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 02:06:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD2GGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588140368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/xBa/OqsaiL4lL+AQ8xqe2ItBrcnopvFJln8kxnfZA=;
        b=EPOhBRyn243WzKXs066L+Y+wA599wrPohQRk6IxXE6Bx2FnWRG4hbf6g5/KpqZ/y4UP1ub
        lW0SQfqa7eN5IXSYx70BOn7VXxkWYqQAwmTLUJ90GbmPIf+71uYTemh8xeGhKRYFQzjY3U
        k7cmRc07g9hBYPV9W3m/surbysFIqX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-3eUndRugPI--HZYTarMLDw-1; Wed, 29 Apr 2020 02:06:04 -0400
X-MC-Unique: 3eUndRugPI--HZYTarMLDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8117D800C78;
        Wed, 29 Apr 2020 06:06:02 +0000 (UTC)
Received: from work (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90802614E7;
        Wed, 29 Apr 2020 06:06:00 +0000 (UTC)
Date:   Wed, 29 Apr 2020 08:05:56 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Ian Kent <raven@themaw.net>,
        torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix use after free in get_tree_bdev()
Message-ID: <20200429060556.zeci7z7jwazly4ga@work>
References: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:27:48PM +0100, David Howells wrote:
> Commit 6fcf0c72e4b9, a fix to get_tree_bdev() put a missing blkdev_put() in
> the wrong place, before a warnf() that displays the bdev under
> consideration rather after it.
> 
> This results in a silent lockup in printk("%pg") called via warnf() from
> get_tree_bdev() under some circumstances when there's a race with the
> blockdev being frozen.  This can be caused by xfstests/tests/generic/085 in
> combination with Lukas Czerner's ext4 mount API conversion patchset.  It
> looks like it ought to occur with other users of get_tree_bdev() such as
> XFS, but apparently doesn't.
> 
> Fix this by switching the order of the lines.

This fixes the problem I was seeing. Thanks David.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Fixes: 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in get_tree_bdev()")
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Ian Kent <raven@themaw.net>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> ---
> 
>  fs/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index cd352530eca9..a288cd60d2ae 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1302,8 +1302,8 @@ int get_tree_bdev(struct fs_context *fc,
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
>  	if (bdev->bd_fsfreeze_count > 0) {
>  		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		blkdev_put(bdev, mode);
>  		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
> +		blkdev_put(bdev, mode);
>  		return -EBUSY;
>  	}
>  
> 
> 

