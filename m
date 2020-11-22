Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE722BC69B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKVP5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 10:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgKVP5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606060651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hBVsDBRvKdqTpz6pw325TDjwoGFHbZ/Qsf+L6Re3P4=;
        b=ZS/szxnmOE1ABoSzdSlVMMy7sOGGQHO4aYrf4Fd/aLfWWPPLcPhdR88E4U+zyxxGEAkuQi
        SI3NH69NrKiXUQiXhKgP8+I5udr+5Qnybf5bghcScXBtEBHJ6iVl4Mpio0tEIQfXPCNQVy
        VibwDBHWDgk23H9Cahotj73gz2gq8b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-OOqf_9IPPcubHJYNsA-MPg-1; Sun, 22 Nov 2020 10:57:27 -0500
X-MC-Unique: OOqf_9IPPcubHJYNsA-MPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC0F81005D73;
        Sun, 22 Nov 2020 15:57:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C344012D7E;
        Sun, 22 Nov 2020 15:57:25 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AE78C18095C9;
        Sun, 22 Nov 2020 15:57:25 +0000 (UTC)
Date:   Sun, 22 Nov 2020 10:57:25 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <esandeen@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        ira weiny <ira.weiny@intel.com>,
        Xiaoli Feng <fengxiaoli0714@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1450940377.59255884.1606060645520.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201121011516.GD3837269@magnolia>
References: <20201121003331.21342-1-xifeng@redhat.com> <21890103-fce2-bb50-7fc2-6c6d509b982f@infradead.org> <20201121011516.GD3837269@magnolia>
Subject: Re: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.20, 10.4.195.4]
Thread-Topic: fs/stat: set attributes_mask for STATX_ATTR_DAX
Thread-Index: UpJOH+7qV0HTw1EJ2RkbvKNCw/Hb9A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thanks for review.

----- Original Message -----
> From: "Darrick J. Wong" <darrick.wong@oracle.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: "Randy Dunlap" <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "ira weiny" <ira.weiny@intel.com>, "Xiaoli
> Feng" <fengxiaoli0714@gmail.com>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
> Sent: Saturday, November 21, 2020 10:03:18 AM
> Subject: Re: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
> 
> [Adding fsdevel to cc since this is a filesystems question]
> 
> On Fri, Nov 20, 2020 at 04:58:09PM -0800, Randy Dunlap wrote:
> > Hi,
> > 
> > I don't know this code, but:
> > 
> > On 11/20/20 4:33 PM, XiaoLi Feng wrote:
> > > From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> > > 
> > > keep attributes and attributes_mask are consistent for
> > > STATX_ATTR_DAX.
> > > ---
> > >  fs/stat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index dacecdda2e79..914a61d256b0 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -82,7 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct
> > > kstat *stat,
> > >  
> > >  	if (IS_DAX(inode))
> > >  		stat->attributes |= STATX_ATTR_DAX;
> > > -
> > > +	stat->attributes_mask |= STATX_ATTR_DAX;
> > 
> > Why shouldn't that be:
> > 
> > 	if (IS_DAX(inode))
> > 		stat->attributes_mask |= STATX_ATTR_DAX;
> > 
> > or combine them, like this:
> > 
> > 	if (IS_DAX(inode)) {
> > 		stat->attributes |= STATX_ATTR_DAX;
> > 		stat->attributes_mask |= STATX_ATTR_DAX;
> > 	}
> > 
> > 
> > and no need to delete that blank line.
> 
> Some filesystems could support DAX but not have it enabled for this
> particular file, so this won't work.
> 
> General question: should filesystems that are /capable/ of DAX signal
> this by setting the DAX bit in the attributes mask?  Or is this a VFS
> feature and hence here is the appropriate place to be setting the mask?

Actually I just see here set the attributes. Then set the attributes mask 
after it.

> 
> Extra question: should we only set this in the attributes mask if
> CONFIG_FS_DAX=y ?

No, my origin patch always set this attributes mask. It's out of if condition.

        if (IS_DAX(inode))
                stat->attributes |= STATX_ATTR_DAX;
-
+       stat->attributes_mask |= STATX_ATTR_DAX;


> 
> --D
> 
> > >  	if (inode->i_op->getattr)
> > >  		return inode->i_op->getattr(path, stat, request_mask,
> > >  					    query_flags);
> > > 
> > 
> > thanks.
> > --
> > ~Randy
> > 
> 
> 

