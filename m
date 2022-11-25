Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D746385C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKYJAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYJAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A031FAA
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669366798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DidzKOwS8JrDlrz1iO5c51tVdfPbTjHkj/ei6XrAg7c=;
        b=ctwRyhz56sxDY3hSoNWLjLKe5O26bT0uMaemuBtiQ3dz483C56rgPRkVce7WK8juel+jQh
        ASlmo5NAmd20vCak0Xe4ruueSHiZBxFwk1bQk9aTtSXZonR1ZHilAlCarbNXRc89OBrDn2
        kiw6NHn2Ms+PPSCqEDqC9j3WqDVDLeU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-mVKx6S5NPj-u-TySkU3DPg-1; Fri, 25 Nov 2022 03:59:53 -0500
X-MC-Unique: mVKx6S5NPj-u-TySkU3DPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 930FE299E76A;
        Fri, 25 Nov 2022 08:59:52 +0000 (UTC)
Received: from fedora (ovpn-193-67.brq.redhat.com [10.40.193.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 386C540C2064;
        Fri, 25 Nov 2022 08:59:51 +0000 (UTC)
Date:   Fri, 25 Nov 2022 09:59:48 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 2/3] shmem: implement user/group quota support for
 tmpfs
Message-ID: <20221125085948.wbzzbimqeehcfqnh@fedora>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-3-lczerner@redhat.com>
 <20221123163745.nnunvbl3s6th6kjx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123163745.nnunvbl3s6th6kjx@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 05:37:45PM +0100, Jan Kara wrote:
> On Mon 21-11-22 15:28:53, Lukas Czerner wrote:
> > Implement user and group quota support for tmpfs using system quota file
> > in vfsv0 quota format. Because everything in tmpfs is temporary and as a
> > result is lost on umount, the quota files are initialized on every
> > mount. This also goes for quota limits, that needs to be set up after
> > every mount.
> > 
> > The quota support in tmpfs is well separated from the rest of the
> > filesystem and is only enabled using mount option -o quota (and
> > usrquota and grpquota for compatibility reasons). Only quota accounting
> > is enabled this way, enforcement needs to be enable by regular quota
> > tools (using Q_QUOTAON ioctl).
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> ...
> 
> > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > index 0408c245785e..9c4f228ef4f3 100644
> > --- a/Documentation/filesystems/tmpfs.rst
> > +++ b/Documentation/filesystems/tmpfs.rst
> > @@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
> >  that instance in a system with many CPUs making intensive use of it.
> >  
> >  
> > +tmpfs also supports quota with the following mount options
> > +
> > +========  =============================================================
> > +quota     Quota accounting is enabled on the mount. Tmpfs is using
> > +          hidden system quota files that are initialized on mount.
> > +          Quota limits can quota enforcement can be enabled using
>                           ^^^ and?
> 
> > +          standard quota tools.
> > +usrquota  Same as quota option. Exists for compatibility reasons.
> > +grpquota  Same as quota option. Exists for compatibility reasons.
> 
> As we discussed with V1, I'd prefer if user & group quotas could be enabled
> / disabled independently. Mostly to not differ from other filesystems
> unnecessarily.

Ok, but other file systems (at least xfs and ext) differs. Mounting ext4
file system with quota feature with default quota option settings will
always enable accounting for both user and group. Mount options quota,
usrquota and grpquota enables enforcement; selectively with the last
two.

On xfs with no mount options quota is disabled. With quota, usrquota and
grpquota enforcement is enabled, again selectively with the last two.

And yes, with this implementation tmpfs is again different. The idea was
to allow enabling accounting and enforcement (with default limits)
selectively.

So how would you like the tmpfs to do it? I think having accounting only
can be useful and I'd like to keep it. Maybe adding qnoenforce,
uqnoenforce and qgnoenforce mount options, but that seems cumbersome to
me and enabling accounting by default seems a bit much. What do you think?

> 
> > +========  =============================================================
> > +
> > +
> >  tmpfs has a mount option to set the NUMA memory allocation policy for
> >  all files in that instance (if CONFIG_NUMA is enabled) - which can be
> >  adjusted on the fly via 'mount -o remount ...'
> > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > index f1a7a03632a2..007604e7eb09 100644
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -716,11 +716,11 @@ int dquot_quota_sync(struct super_block *sb, int type)
> >  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> >  		if (type != -1 && cnt != type)
> >  			continue;
> > -		if (!sb_has_quota_active(sb, cnt))
> > -			continue;
> > -		inode_lock(dqopt->files[cnt]);
> > -		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
> > -		inode_unlock(dqopt->files[cnt]);
> > +		if (sb_has_quota_active(sb, cnt) && dqopt->files[cnt]) {
> > +			inode_lock(dqopt->files[cnt]);
> > +			truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
> > +			inode_unlock(dqopt->files[cnt]);
> > +		}
> >  	}
> 
> No need to mess with this when you have DQUOT_QUOTA_SYS_FILE set.

Ah right, there is this condition earlier in the function. I'll drop it.

	if (dqopt->flags & DQUOT_QUOTA_SYS_FILE)
		return 0;

> 
> > +/*
> > + * We don't have any quota files to read, or write to/from, but quota code
> > + * requires .quota_read and .quota_write to exist.
> > + */
> > +static ssize_t shmem_quota_write(struct super_block *sb, int type,
> > +				const char *data, size_t len, loff_t off)
> > +{
> > +	return len;
> > +}
> > +
> > +static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
> > +			       size_t len, loff_t off)
> > +{
> > +	return len;
> > +}
> 
> Instead of these functions I'd go for attached patch.

Ok, I'll take a look.

> 
> > @@ -363,7 +438,7 @@ bool shmem_charge(struct inode *inode, long pages)
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> >  	unsigned long flags;
> >  
> > -	if (!shmem_inode_acct_block(inode, pages))
> > +	if (shmem_inode_acct_block(inode, pages))
> >  		return false;
> 
> As Brian asked, I'd prefer to have the calling convention change as a
> separate patch.

Alright I'll split it up.

> 
> > +static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
> > +				     umode_t mode, dev_t dev, unsigned long flags)
> > +{
> > +	int err;
> > +	struct inode *inode;
> > +
> > +	inode = shmem_get_inode_noquota(sb, dir, mode, dev, flags);
> > +	if (inode) {
> > +		err = dquot_initialize(inode);
> > +		if (err)
> > +			goto errout;
> > +
> > +		err = dquot_alloc_inode(inode);
> > +		if (err) {
> > +			dquot_drop(inode);
> > +			goto errout;
> > +		}
> > +	}
> > +	return inode;
> 
> I'd rather make shmem_get_inode() always return ERR_PTR or inode pointer.
> It's more natural convention. Also this calling convention change should
> go into a separate patch.

ok.

Thanks!
-Lukas

> 
> > +
> > +errout:
> > +	inode->i_flags |= S_NOQUOTA;
> > +	iput(inode);
> > +	shmem_free_inode(sb);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +	return NULL;
> > +}
> > +
> ...
> 
> > @@ -4196,8 +4348,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
> >  
> >  	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
> >  				flags);
> > -	if (unlikely(!inode)) {
> > +	if (IS_ERR_OR_NULL(inode)) {
> >  		shmem_unacct_size(flags, size);
> > +		if (IS_ERR(inode))
> > +			return (struct file *)inode;
> 				^^ Uhuh. ERR_CAST()?
> 
> >  		return ERR_PTR(-ENOSPC);
> >  	}
> >  	inode->i_flags |= i_flags;
> 
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


