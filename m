Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1496B2C38DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 06:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgKYFxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 00:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgKYFxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606283601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z9zobmRc9QZolW0FKUVYPp9xq6ljWzO5eKBmWGy+x0=;
        b=IpYJZ77JBcEZBc2kko1jd4HKEUQ40aAFrYqs5DvkmGY5LKod5sXkQGBDerrnnmjalnCE4g
        /CVsnVlCE0w5tDL48q60yVOp2XdBJMSbRnE7aowZdnua0sMfNN1leG/3UVmLdk0meuvXZj
        iqmgrbQ1CY2DwyTKP4T/y+6IFZ+bTzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Xo--wji0N9-wQGWIFIiXSw-1; Wed, 25 Nov 2020 00:53:17 -0500
X-MC-Unique: Xo--wji0N9-wQGWIFIiXSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481EE9A220;
        Wed, 25 Nov 2020 05:53:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C0665D71D;
        Wed, 25 Nov 2020 05:53:16 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id ED6E518095C9;
        Wed, 25 Nov 2020 05:53:15 +0000 (UTC)
Date:   Wed, 25 Nov 2020 00:53:15 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Xiaoli Feng <fengxiaoli0714@gmail.com>
Message-ID: <136563737.59838105.1606283595257.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201125024644.GA14534@magnolia>
References: <20201125020840.1275-1-xifeng@redhat.com> <20201125024644.GA14534@magnolia>
Subject: Re: [PATCH v2] fs/stat: set attributes_mask for STATX_ATTR_DAX
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.13.128, 10.4.195.6]
Thread-Topic: fs/stat: set attributes_mask for STATX_ATTR_DAX
Thread-Index: vH38uV0iM87GdBISkylk6PnPD1HwvA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

----- Original Message -----
> From: "Darrick J. Wong" <darrick.wong@oracle.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: linux-fsdevel@vger.kernel.org, david@fromorbit.com, "Xiaoli Feng" <fengxiaoli0714@gmail.com>
> Sent: Wednesday, November 25, 2020 10:46:44 AM
> Subject: Re: [PATCH v2] fs/stat: set attributes_mask for STATX_ATTR_DAX
> 
> On Wed, Nov 25, 2020 at 10:08:40AM +0800, XiaoLi Feng wrote:
> > From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> > 
> > keep attributes and attributes_mask are consistent for
> > STATX_ATTR_DAX.
> > ---
> > Hi,
> > Please help to review this patch. I send this patch because xfstests
> > generic/532
> > is failed for dax test.
> > 
> >  fs/stat.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index dacecdda2e79..4619b3fc9694 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -80,8 +80,10 @@ int vfs_getattr_nosec(const struct path *path, struct
> > kstat *stat,
> >  	if (IS_AUTOMOUNT(inode))
> >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> >  
> > -	if (IS_DAX(inode))
> > +	if (IS_DAX(inode)) {
> >  		stat->attributes |= STATX_ATTR_DAX;
> > +		stat->attributes_mask |= STATX_ATTR_DAX;
> 
> From the discussion of the V1 patch:
> 
> Doesn't it make more sense for /filesystems/ driver to set the attr_mask
> bit when the filesystem is capable of DAX?  Surely we should be able to
> tell applications that DAX is a possibility for the fs even if it's not
> enabled on this specific file.
> 
> IOWs the place to make this change is in the ext2/ext4/fuse/xfs code,
> not in the generic vfs.

Got it. Thanks for review.

> 
> --D
> 
> > +	}
> >  
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> > --
> > 2.18.1
> > 
> 
> 

