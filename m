Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445942DC2E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 16:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLPPPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 10:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgLPPPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608131654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfDj4DJaoB++2KIjkmOLDB1ZfXvWoRXRp8J5NFncySc=;
        b=RDZiiyHCYIF1sB+nn5MQPeM3/CeElXoBvRhbspBij/iUsgFwwRaZUrdUuomuYjBdRfUPaW
        EuQrTATjgltx6SWGK/vsWyy729JIDCpFxPhb8NAJBs/NwNTjXf6WcSIgKZEciqkmxGsxRu
        v/g1cmSEj95ydw6pZY4q7mFLt7Dq3Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-r1I8TnV4MYmAaZJGsd23gQ-1; Wed, 16 Dec 2020 10:14:12 -0500
X-MC-Unique: r1I8TnV4MYmAaZJGsd23gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0CD800D53;
        Wed, 16 Dec 2020 15:14:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C4AB19CAC;
        Wed, 16 Dec 2020 15:14:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C3283220BCF; Wed, 16 Dec 2020 10:14:09 -0500 (EST)
Date:   Wed, 16 Dec 2020 10:14:09 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, amir73il@gmail.com,
        willy@infradead.org, jack@suse.cz, sargun@sargun.me
Subject: Re: [PATCH] vfs, syncfs: Do not ignore return code from ->sync_fs()
Message-ID: <20201216151409.GA3177@redhat.com>
References: <20201216143802.GA10550@redhat.com>
 <132c8c1e1ab82f5a640ff1ede6bb844885d46e68.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <132c8c1e1ab82f5a640ff1ede6bb844885d46e68.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:57:49AM -0500, Jeff Layton wrote:
> On Wed, 2020-12-16 at 09:38 -0500, Vivek Goyal wrote:
> > I see that current implementation of __sync_filesystem() ignores the
> > return code from ->sync_fs(). I am not sure why that's the case.
> > 
> > Ignoring ->sync_fs() return code is problematic for overlayfs where
> > it can return error if sync_filesystem() on upper super block failed.
> > That error will simply be lost and sycnfs(overlay_fd), will get
> > success (despite the fact it failed).
> > 
> > I am assuming that we want to continue to call __sync_blockdev()
> > despite the fact that there have been errors reported from
> > ->sync_fs(). So I wrote this simple patch which captures the
> > error from ->sync_fs() but continues to call __sync_blockdev()
> > and returns error from sync_fs() if there is one.
> > 
> > There might be some very good reasons to not capture ->sync_fs()
> > return code, I don't know. Hence thought of proposing this patch.
> > Atleast I will get to know the reason. I still need to figure
> > a way out how to propagate overlay sync_fs() errors to user
> > space.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/sync.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > Index: redhat-linux/fs/sync.c
> > ===================================================================
> > --- redhat-linux.orig/fs/sync.c	2020-12-16 09:15:49.831565653 -0500
> > +++ redhat-linux/fs/sync.c	2020-12-16 09:23:42.499853207 -0500
> > @@ -30,14 +30,18 @@
> >   */
> >  static int __sync_filesystem(struct super_block *sb, int wait)
> >  {
> > +	int ret, ret2;
> > +
> >  	if (wait)
> >  		sync_inodes_sb(sb);
> >  	else
> >  		writeback_inodes_sb(sb, WB_REASON_SYNC);
> >  
> > 
> >  	if (sb->s_op->sync_fs)
> > -		sb->s_op->sync_fs(sb, wait);
> > -	return __sync_blockdev(sb->s_bdev, wait);
> > +		ret = sb->s_op->sync_fs(sb, wait);
> > +	ret2 = __sync_blockdev(sb->s_bdev, wait);
> > +
> > +	return ret ? ret : ret2;
> >  }
> >  
> > 
> >  /*
> > 
> 
> I posted a patchset that took a similar approach a couple of years ago,
> and we decided not to go with it [1].
> 
> While it's not ideal to ignore the error here, I think this is likely to
> break stuff.

So one side affect I see is that syncfs() might start returning errors
in some cases which were not reported at all. I am wondering will that
count as breakage.

> What may be better is to just make sync_fs void return, so
> people don't think that returned errors there mean anything.

May be. 

But then question remains that how do we return error to user space
in syncfs(fd) for overlayfs. I will not be surprised if other
filesystems want to return errors as well.

Shall I create new helpers and call these in case of syncfs(). But
that too will start returning new errors on syncfs(). So it does
not solve that problem (if it is a problem).

Or we can define a new super block op say ->sync_fs2() and call that
first and in that case capture return code. That way it will not
impact existing cases and overlayfs can possibly make use of
->sync_fs2() and return error. IOW, impact will be limited to
only file systems which chose to implement ->sync_fs2().

Thanks
Vivek

> 
> [1]: https://lore.kernel.org/linux-fsdevel/20180518123415.28181-1-jlayton@kernel.org/
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

