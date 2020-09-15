Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7926726A4B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIOMIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 08:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIOMII (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:08:08 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5A2206DB;
        Tue, 15 Sep 2020 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600171688;
        bh=ArlwLnttuYqX6MO3Ch7AD5E9hngbIDd9nG4WVR9YQQs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ld2kpQafUM2SmFrcTM+wC2x4WdXjo8HUR8ASOz9GZSYNTSFITEQdoFBOD7C3vrqmB
         4VQ5/4Z+bF4X79OXy6sR5/XbynHEPqevVzGOhRlg/lUsyLAd5C5iQdhVlEhnSxjot6
         Ce3yOcPYCNVTPeH2NEH6OQd4IghDSV5rNSbYJVJ8=
Message-ID: <1687d41eff214664c2c8e3aaec519aa480df2d1d.camel@kernel.org>
Subject: Re: [RFC PATCH v3 06/16] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 15 Sep 2020 08:08:06 -0400
In-Reply-To: <20200915004522.GF899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-7-jlayton@kernel.org>
         <20200915004522.GF899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 17:45 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:16:57PM -0400, Jeff Layton wrote:
> > Boilerplate ioctls for controlling encryption.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/ioctl.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> > index 6e061bf62ad4..381e44b2d60a 100644
> > --- a/fs/ceph/ioctl.c
> > +++ b/fs/ceph/ioctl.c
> > @@ -6,6 +6,7 @@
> >  #include "mds_client.h"
> >  #include "ioctl.h"
> >  #include <linux/ceph/striper.h>
> > +#include <linux/fscrypt.h>
> >  
> >  /*
> >   * ioctls
> > @@ -289,6 +290,30 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  
> >  	case CEPH_IOC_SYNCIO:
> >  		return ceph_ioctl_syncio(file);
> > +
> > +	case FS_IOC_SET_ENCRYPTION_POLICY:
> > +		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_POLICY:
> > +		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> > +		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> > +
> > +	case FS_IOC_ADD_ENCRYPTION_KEY:
> > +		return fscrypt_ioctl_add_key(file, (void __user *)arg);
> > +
> > +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> > +		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
> > +
> > +	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
> > +		return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
> > +		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_NONCE:
> > +		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> 
> Will you be implementing an encryption feature flag for ceph, similar to what
> ext4 and f2fs have?  E.g., ext4 doesn't allow these ioctls unless the filesystem
> was formatted with '-O encrypt' (or 'tune2fs -O encrypt' was run later).  There
> would be various problems if we didn't do that; for example, old versions of
> e2fsck would consider encrypted directories to be corrupted.
> 

Yes, we'll probably have something like that once the MDS support has
settled. We'll want to disallow encryption when dealing with MDS's that
don't support it, so I suspect we'll need to add a check for that in
these ioctl calls.

That feature bit hasn't been declared yet though, and this patchset is
still _really_ rough. I'll add a comment to that effect for now though.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

