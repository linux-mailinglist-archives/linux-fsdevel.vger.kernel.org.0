Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1034D6D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2SRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 14:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhC2SRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617041857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgFeyPkzmPObOkTR5EkP4yemPrUTiyxU/lmEG6g4BQs=;
        b=BsYPJCryDYzLV04YRZQIlJB+hZihp65Np0zH/mc7ilhliPpSVyx1mLwDwm5e1es9PtO5ij
        bOHcBqxzZLkWB52JbbkHX5O8LPpdGxY1vTmJTSGzRZwDpd3wxcnt5VsHhywC61wFCkec4x
        rlzuyScXxdMtNLaO6tRp+TryZKJ5Cjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-igv5i0B5MrmOps8rHtPNUw-1; Mon, 29 Mar 2021 14:16:57 -0400
X-MC-Unique: igv5i0B5MrmOps8rHtPNUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76EEC8030C4;
        Mon, 29 Mar 2021 18:16:55 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-64.rdu2.redhat.com [10.10.116.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 508E539A60;
        Mon, 29 Mar 2021 18:16:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DB50F220BCF; Mon, 29 Mar 2021 14:16:51 -0400 (EDT)
Date:   Mon, 29 Mar 2021 14:16:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: Re: [PATCH v2 1/2] fuse: Add support for FUSE_SETXATTR_V2
Message-ID: <20210329181651.GD676525@redhat.com>
References: <20210325151823.572089-1-vgoyal@redhat.com>
 <20210325151823.572089-2-vgoyal@redhat.com>
 <YGHpPWcZYQQWMvAi@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGHpPWcZYQQWMvAi@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:50:37PM +0100, Luis Henriques wrote:
> On Thu, Mar 25, 2021 at 11:18:22AM -0400, Vivek Goyal wrote:
> > Fuse client needs to send additional information to file server when
> > it calls SETXATTR(system.posix_acl_access). Right now there is no extra
> > space in fuse_setxattr_in. So introduce a v2 of the structure which has
> > more space in it and can be used to send extra flags.
> > 
> > "struct fuse_setxattr_in_v2" is only used if file server opts-in for it using
> > flag FUSE_SETXATTR_V2 during feature negotiations.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/acl.c             |  2 +-
> >  fs/fuse/fuse_i.h          |  5 ++++-
> >  fs/fuse/inode.c           |  4 +++-
> >  fs/fuse/xattr.c           | 21 +++++++++++++++------
> >  include/uapi/linux/fuse.h | 10 ++++++++++
> >  5 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index e9c0f916349d..d31260a139d4 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> > @@ -94,7 +94,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >  			return ret;
> >  		}
> >  
> > -		ret = fuse_setxattr(inode, name, value, size, 0);
> > +		ret = fuse_setxattr(inode, name, value, size, 0, 0);
> >  		kfree(value);
> >  	} else {
> >  		ret = fuse_removexattr(inode, name);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 63d97a15ffde..d00bf0b9a38c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -668,6 +668,9 @@ struct fuse_conn {
> >  	/** Is setxattr not implemented by fs? */
> >  	unsigned no_setxattr:1;
> >  
> > +	/** Does file server support setxattr_v2 */
> > +	unsigned setxattr_v2:1;
> > +
> 
> Minor (pedantic!) comment: most of the fields here start with 'no_*', so
> maybe it's worth setting the logic to use 'no_setxattr_v2' instead?

Hi Luis,

"setxattr_v2" kind of makes more sense to me because it is disabled
by default untile and unless client opts in. If I use no_setxattr_v2,
then it means by default I will have to initialize it to 1. Right
now, following automatically takes care of it.

fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);

Also, there are other examples which don't use "no_" prefix.

auto_inval_data, explicit_inval_data, do_readdirplus, readdirplus_auto, 
async_dio..... and list goes on.

Vivek

