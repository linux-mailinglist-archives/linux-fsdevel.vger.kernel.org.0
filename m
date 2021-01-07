Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B2C2ED444
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAGQ1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 11:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbhAGQ1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610036769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQV/x5GtXZ0B2hPRvGG0KO7F8c4S3HMWgh/cKMsSZQg=;
        b=T++2GgJqqOZmzHqvWuqXTn0tNlyGwmQ/o5Uwx+Ch8lpIWGNyuj+5y0ytlboSAph+aSDV3X
        6NlxQGb91PaFGscHhXrvehmJSLQtA/FiMuHBg81p71V9zl5fdGHLhebh/CHXlw9RpsX3NP
        jtuZw/9IwGMwqVhySdF9MAOvduNj7qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-0oCKIdzxMBy12Zv7lVr-Rg-1; Thu, 07 Jan 2021 11:26:07 -0500
X-MC-Unique: 0oCKIdzxMBy12Zv7lVr-Rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10F4800D55;
        Thu,  7 Jan 2021 16:26:04 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B77ED3A47;
        Thu,  7 Jan 2021 16:26:04 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AAF684BB7B;
        Thu,  7 Jan 2021 16:26:04 +0000 (UTC)
Date:   Thu, 7 Jan 2021 11:26:02 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Satya Tangirala <satyat@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <1880595671.42956897.1610036762534.JavaMail.zimbra@redhat.com>
In-Reply-To: <20210107162000.GA2693@lst.de>
References: <20201224044954.1349459-1-satyat@google.com> <20210107162000.GA2693@lst.de>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.201, 10.4.195.23]
Thread-Topic: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb
Thread-Index: wReIBcuiVcLsNfvvUAISHBXneDQ8yg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> Can someone pick this up?  Maybe through Jens' block tree as that is
> where my commit this is fixing up came from.
> 
> For reference:
> 
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On Thu, Dec 24, 2020 at 04:49:54AM +0000, Satya Tangirala wrote:
> > freeze/thaw_bdev() currently use bdev->bd_fsfreeze_count to infer
> > whether or not bdev->bd_fsfreeze_sb is valid (it's valid iff
> > bd_fsfreeze_count is non-zero). thaw_bdev() doesn't nullify
> > bd_fsfreeze_sb.
> > 
> > But this means a freeze_bdev() call followed by a thaw_bdev() call can
> > leave bd_fsfreeze_sb with a non-null value, while bd_fsfreeze_count is
> > zero. If freeze_bdev() is called again, and this time
> > get_active_super() returns NULL (e.g. because the FS is unmounted),
> > we'll end up with bd_fsfreeze_count > 0, but bd_fsfreeze_sb is
> > *untouched* - it stays the same (now garbage) value. A subsequent
> > thaw_bdev() will decide that the bd_fsfreeze_sb value is legitimate
> > (since bd_fsfreeze_count > 0), and attempt to use it.
> > 
> > Fix this by always setting bd_fsfreeze_sb to NULL when
> > bd_fsfreeze_count is successfully decremented to 0 in thaw_sb().
> > Alternatively, we could set bd_fsfreeze_sb to whatever
> > get_active_super() returns in freeze_bdev() whenever bd_fsfreeze_count
> > is successfully incremented to 1 from 0 (which can be achieved cleanly
> > by moving the line currently setting bd_fsfreeze_sb to immediately
> > after the "sync:" label, but it might be a little too subtle/easily
> > overlooked in future).
> > 
> > This fixes the currently panicking xfstests generic/085.
> > 
> > Fixes: 040f04bd2e82 ("fs: simplify freeze_bdev/thaw_bdev")
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  fs/block_dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 9e56ee1f2652..12a811a9ae4b 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -606,6 +606,8 @@ int thaw_bdev(struct block_device *bdev)
> >  		error = thaw_super(sb);
> >  	if (error)
> >  		bdev->bd_fsfreeze_count++;
> > +	else
> > +		bdev->bd_fsfreeze_sb = NULL;
> >  out:
> >  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
> >  	return error;
> > --
> > 2.29.2.729.g45daf8777d-goog
> ---end quoted text---
> 
> 
Funny you should ask. I came across this bug in my testing of gfs2
and my patch is slightly different. I was wondering who to send it to.
Perhaps Viro?

Regards,

Bob Peterson

