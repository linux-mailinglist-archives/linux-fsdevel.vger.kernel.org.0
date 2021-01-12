Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF872F3681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbhALRDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 12:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391729AbhALRDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610470904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjaGgyoD1V0w8BbYfKfUI/xGXNJMo05sCpMFlD8IBUA=;
        b=g48v2kY0KI3PuZCVZlSMA/ljF2HapWHKxGLGQ5/v/wiTbVkfhBGgRGfniP6EBNcSFfLI+w
        bilEfa84fBroZMJtoWWFu5B6doDUoyjF4mDiXqbaB8b4qsOdniWNfsmfIN0IyAe+8ja006
        xg2RmxuZLZLyqM95w7jSi+fuDUqAL3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-mm2Dyvb3PUiFlme-fzpnvA-1; Tue, 12 Jan 2021 12:01:40 -0500
X-MC-Unique: mm2Dyvb3PUiFlme-fzpnvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DABDA15732;
        Tue, 12 Jan 2021 17:01:35 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F3EA5D9CD;
        Tue, 12 Jan 2021 17:01:34 +0000 (UTC)
Date:   Tue, 12 Jan 2021 12:01:33 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 6/6] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210112170133.GD1137163@bfoster>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-7-david@fromorbit.com>
 <X/19MZHQtcnj9NDc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/19MZHQtcnj9NDc@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:42:57AM +0100, Christoph Hellwig wrote:
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index bba33be17eff..f5c75404b8a5 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -408,7 +408,7 @@ xfs_file_aio_write_checks(
> >  			drained_dio = true;
> >  			goto restart;
> >  		}
> > -	
> > +
> 
> Spurious unrelated whitespace change.
> 
> >  	struct iomap_dio_rw_args args = {
> >  		.iocb			= iocb,
> >  		.iter			= from,
> >  		.ops			= &xfs_direct_write_iomap_ops,
> >  		.dops			= &xfs_dio_write_ops,
> >  		.wait_for_completion	= is_sync_kiocb(iocb),
> > -		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
> > +		.nonblocking		= true,
> 
> I think this is in many ways wrong.  As far as I can tell you want this
> so that we get the imap_spans_range in xfs_direct_write_iomap_begin. But
> we should not trigger any of the other checks, so we'd really need
> another flag instead of reusing this one.
> 

It's really the br_state != XFS_EXT_NORM check that we want for the
unaligned case, isn't it?

> imap_spans_range is a bit pessimistic for avoiding the exclusive lock,
> but I guess we could live that if it is clearly documented as helping
> with the implementation, but we really should not automatically trigger
> all the other effects of nowait I/O.
> 

Regardless, I agree on this point. I don't have a strong opinion in
general on this approach vs. the other, but it does seem odd to me to
overload the broader nowait semantics with the unaligned I/O checks. I
see that it works for the primary case we care about, but this also
means things like the _has_page() check now trigger exclusivity for the
unaligned case where that doesn't seem to be necessary. I do like the
previous cleanups so I suspect if we worked this into a new
'subblock_io' flag that indicates to the lower layer whether the
filesystem can allow zeroing, that might clean much of this up.

Brian

