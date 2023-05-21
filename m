Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDA70B1D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEUWt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjEUWt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 18:49:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECCC6
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 15:49:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso2141879b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684709394; x=1687301394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfaiIW3biZ2nDYazMreEHIKSLRhntSglWJTWt2nlD0A=;
        b=IP5yZ0MMUZe32WseJQj3R2egNthpjmyvm+ciAk24LX8IEV7id8mpJCFeDWFj0Omm2f
         GfW41TZ5PxSnakzCNRnqNV5+26u2zf1il0w5TpmJjsm5guGJqcVuzI450S8ezK7xGm53
         aJ+fCiUOOMUejIoPQNcQOFm0coGehr46kezzbLLHU6Q6EjhrP/LicNOwUetRXPpSn6i5
         RPkrxmRKW1B0Yhp7ttk/tDuPOX7wOFhQJaeQTyXvqn9eQXqAZzuXWhDS+uGXNL3iUomt
         VQ6hKc0ZeYG9IesB6W0x2zNu/R+dTIeyCjtaPv6dKj8VfMkra6Sdh0kFoP2Mws2cdHgr
         mUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684709394; x=1687301394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfaiIW3biZ2nDYazMreEHIKSLRhntSglWJTWt2nlD0A=;
        b=I4VqjbT9fykgioXirk6AZGxyPzn3J/aQi+H6iaHBpvTogixYuialEYGxsjILReopu3
         cMWxu+wZHFw2cQ1fOnikqI27fOUiKTNG4AVeYrg+BLZhn8r6l3W0J5r6ycYmBRhmbjoj
         L2LEcnzkmfL1y/Bf2DgolgwD7pT872/OuaQEc+swBwKVvs8FxM/JjYm0p8+BKzwsBlTS
         0RBJTx/IbSbFAx95qpMND5OX22n212UtvEpM9P9PKnP1l5Ca46cnDK4HDrhuFQ+DUE78
         0taeCzG2XIniaaPT86XeZr82HM9ku5k1qvJSUDHkyhSdOMy9hgA4buNNLn2ieZ1i2cAb
         gLVA==
X-Gm-Message-State: AC+VfDw6KVomT0Jxa1qXUSbIPABloNWPJ1owPV8YhafKLez53RX/93Rl
        aSkiEg0F9PiQGxY4yc+TdwIAbA==
X-Google-Smtp-Source: ACHHUZ72WQJhhCaeNMhFrQWZeqaQ3D4XEC9Issa3Qxfnr9+ou9y0ZTpJBeGEsgMJX5F+VThTgg1fcw==
X-Received: by 2002:a17:902:c1c4:b0:1af:b681:5313 with SMTP id c4-20020a170902c1c400b001afb6815313mr820157plc.33.1684709394215;
        Sun, 21 May 2023 15:49:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001ac55a5e5eesm3425837plb.121.2023.05.21.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 15:49:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q0rs6-002J36-1t;
        Mon, 22 May 2023 08:49:50 +1000
Date:   Mon, 22 May 2023 08:49:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <ZGqgDjJqFSlpIkz/@dread.disaster.area>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520-angenehm-orangen-80fdce6f9012@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 11:17:35AM +0200, Christian Brauner wrote:
> On Fri, May 19, 2023 at 03:42:38PM -0400, Mimi Zohar wrote:
> > On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > > 
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > >     is in line what we do with all other inode attributes. IOW, the
> > >     overlayfs inode's i_version counter should aim to mirror the
> > >     relevant layer's i_version counter. I wouldn't know why that
> > >     shouldn't be the case. Asking the other way around there doesn't
> > >     seem to be any use for overlayfs inodes to have an i_version that
> > >     isn't just mirroring the relevant layer's i_version.
> > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > >     Currently, ima assumes that it will get the correct i_version from
> > >     an inode but that just doesn't hold for stacking filesystem.
> > > 
> > > While (1) would likely just fix the immediate bug (2) is correct and
> > > _robust_. If we change how attributes are handled vfs_*() helpers will
> > > get updated and ima with it. Poking at raw inodes without using
> > > appropriate helpers is much more likely to get ima into trouble.
> > 
> > In addition to properly setting the i_version for IMA, EVM has a
> > similar issue with i_generation and s_uuid. Adding them to
> > ovl_copyattr() seems to resolve it.   Does that make sense?
> > 
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 923d66d131c1..cd0aeb828868 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
> >  	inode->i_atime = realinode->i_atime;
> >  	inode->i_mtime = realinode->i_mtime;
> >  	inode->i_ctime = realinode->i_ctime;
> > +	inode->i_generation = realinode->i_generation;
> > +	if (inode->i_sb)
> > +		uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> 
> Overlayfs can consist of multiple lower layers and each of those lower
> layers may have a different uuid. So everytime you trigger a
> ovl_copyattr() on a different layer this patch would alter the uuid of
> the overlayfs superblock.
> 
> In addition the uuid should be set when the filesystem is mounted.
> Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> change the uuid.

IMO, that ext4 functionality is a landmine waiting to be stepped on.

We should not be changing the sb->s_uuid of filesysetms dynamically.
The VFS does not guarantee in any way that it is safe to change the
sb->s_uuid (i.e. no locking, no change notifications, no udev
events, etc). Various subsystems - both in the kernel and in
userspace - use the sb->s_uuid as a canonical and/or persistent
filesystem/device identifier and are unprepared to have it change
while the filesystem is mounted and active.

I commented on this from an XFS perspective here when it was
proposed to copy this ext4 mis-feature in XFS:

https://lore.kernel.org/linux-xfs/20230314062847.GQ360264@dread.disaster.area/

Further to this, I also suspect that changing uuids online will
cause issues with userspace caching of fs uuids (e.g. libblkid and
anything that uses it) and information that uses uuids to identify
the filesystem that are set up at mount time (/dev/disk/by-uuid/
links, etc) by kernel events sent to userspace helpers...

IMO, we shouldn't even be considering dynamic sb->s_uuid changes
without first working through the full system impacts of having
persistent userspace-visible filesystem identifiers change
dynamically...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
