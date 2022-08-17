Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48630596FE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiHQNZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiHQNZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:25:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B289821;
        Wed, 17 Aug 2022 06:25:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 54BA234DAB;
        Wed, 17 Aug 2022 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660742734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXu6js/hFYKcYH+ji2qfz5ZfeIiTsDVvaDGSemIC5GM=;
        b=dv3IFxotciO3kFJ8CtrEHNTtdHJGLeNauF2FU9BfDWeaPPbzqqisC9E64m9OGl/96wy7mG
        3SdVTsMPDMceo+zqMe5yAnDzaMNVEXmGCsGQSqqrPqrVwoa5JmqpVRW2Zcr0HUwOVfamWS
        +P/HcHL+Fj0mVoJry3qgsaqudp68wUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660742734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXu6js/hFYKcYH+ji2qfz5ZfeIiTsDVvaDGSemIC5GM=;
        b=L3pIF0QVBDaw7o07v0bth5YC5rTrR7PCtcS/i1eKKoMQG76L9BHSD9Io8pyV51eqQfofPA
        /bxTaVfDP8LfOlAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 092862C175;
        Wed, 17 Aug 2022 13:25:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3AD6AA066B; Wed, 17 Aug 2022 15:25:33 +0200 (CEST)
Date:   Wed, 17 Aug 2022 15:25:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
Message-ID: <20220817132533.4xvvkvltmwzudybm@quack3>
References: <20220816131522.42467-1-jlayton@kernel.org>
 <20220817130441.qigqv62wj6lrvxfc@quack3>
 <e822b39e120332f88cbfe5d02d69c217bac74419.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e822b39e120332f88cbfe5d02d69c217bac74419.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-08-22 09:09:58, Jeff Layton wrote:
> On Wed, 2022-08-17 at 15:04 +0200, Jan Kara wrote:
> > On Tue 16-08-22 09:15:22, Jeff Layton wrote:
> > > ext4 currently updates the i_version counter when the atime is updated
> > > during a read. This is less than ideal as it can cause unnecessary cache
> > > invalidations with NFSv4. The increment in ext4_mark_iloc_dirty is also
> > > problematic since it can also corrupt the i_version counter for
> > > ea_inodes.
> > > 
> > > We aren't bumping the file times in ext4_mark_iloc_dirty, so changing
> > > the i_version there seems wrong, and is the cause of both problems.
> > > Remove that callsite and add increments to the setattr and setxattr
> > > codepaths (at the same time that we update the ctime). The i_version
> > > bump that already happens during timestamp updates should take care of
> > > the rest.
> > > 
> > > Cc: Lukas Czerner <lczerner@redhat.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > After some verification (which was not completely trivial e.g. for
> > directories) I agree all cases should be covered. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > 								Honza
> > 
> 
> Thanks.
> 
> I think this covers the typical cases, but there are some places I
> missed:
> 
> The setacl codepath, for one, and there are a number of places that set
> the ctime explicitly for hole punching and the like.

Hum, why is setacl() not covered by your change to ext4_xattr_set_handle()?
ext4_set_acl() ends up calling it... I have checked hole punching (whole
ext4_fallocate()) and it seems to be incrementing iversion where needed.

> I'm planning to
> send a v2 once I do a bit more testing. I'll hold off on adding your
> Reviewed-by just yet, since the final patch may be quite a bit
> different.

OK, thanks!

								Honza

> 
> 
> > > ---
> > >  fs/ext4/inode.c | 10 +++++-----
> > >  fs/ext4/xattr.c |  2 ++
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > I think this patch should probably supersede Lukas' patch entitled:
> > > 
> > >     ext4: don't increase iversion counter for ea_inodes
> > > 
> > > This will also mean that we'll need to respin the patch to turn on the
> > > i_version counter unconditionally in ext4 (though that should be
> > > trivial).
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 601214453c3a..a70921df89a5 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5342,6 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >  	int error, rc = 0;
> > >  	int orphan = 0;
> > >  	const unsigned int ia_valid = attr->ia_valid;
> > > +	bool inc_ivers = IS_IVERSION(inode);
> > >  
> > >  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> > >  		return -EIO;
> > > @@ -5425,8 +5426,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >  			return -EINVAL;
> > >  		}
> > >  
> > > -		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
> > > -			inode_inc_iversion(inode);
> > > +		if (attr->ia_size == inode->i_size)
> > > +			inc_ivers = false;
> > >  
> > >  		if (shrink) {
> > >  			if (ext4_should_order_data(inode)) {
> > > @@ -5528,6 +5529,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >  	}
> > >  
> > >  	if (!error) {
> > > +		if (inc_ivers)
> > > +			inode_inc_iversion(inode);
> > >  		setattr_copy(mnt_userns, inode, attr);
> > >  		mark_inode_dirty(inode);
> > >  	}
> > > @@ -5731,9 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> > >  	}
> > >  	ext4_fc_track_inode(handle, inode);
> > >  
> > > -	if (IS_I_VERSION(inode))
> > > -		inode_inc_iversion(inode);
> > > -
> > >  	/* the do_update_inode consumes one bh->b_count */
> > >  	get_bh(iloc->bh);
> > >  
> > > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > > index 533216e80fa2..4d84919d1c9c 100644
> > > --- a/fs/ext4/xattr.c
> > > +++ b/fs/ext4/xattr.c
> > > @@ -2412,6 +2412,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
> > >  	if (!error) {
> > >  		ext4_xattr_update_super_block(handle, inode->i_sb);
> > >  		inode->i_ctime = current_time(inode);
> > > +		if (IS_IVERSION(inode))
> > > +			inode_inc_iversion(inode);
> > >  		if (!value)
> > >  			no_expand = 0;
> > >  		error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> > > -- 
> > > 2.37.2
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
