Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE86219D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiKHQwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 11:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKHQwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:52:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469657B50
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 08:52:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 118E41F6E6;
        Tue,  8 Nov 2022 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667926368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHECEQhfUWfWHlrepvwLdG7vDeykYc+sX3jvMGokVyM=;
        b=OEHj+ZdrdAWBNJZKRZkp9OwPmNo603uQw9wuS0v0X3+pJBkUldiYpQzuIhjLBuo7LWqUZY
        P1x6berolYoz0jWop1v8leTx9HfYNdHxp4niw5kXPcTb/46upcFAkCf2DMvH8TPr5xZfgW
        DWKD0wyGkkEf3F9bYkViW5uM1RDcK7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667926368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHECEQhfUWfWHlrepvwLdG7vDeykYc+sX3jvMGokVyM=;
        b=OUdYVsD8meNR1bcNmUUdZ0Gff4b8tavUzAX3dtnaef7ITfjvjEX89b5pzzvVvH+DoQizBA
        M4hUNmFCX3C33tBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F25C813398;
        Tue,  8 Nov 2022 16:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nIoiO1+JamOKCQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 08 Nov 2022 16:52:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84689A0704; Tue,  8 Nov 2022 17:52:47 +0100 (CET)
Date:   Tue, 8 Nov 2022 17:52:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] shmem: implement user/group quota support for tmpfs
Message-ID: <20221108165247.aeqooex26wfdiitm@quack3>
References: <20221108133010.75226-1-lczerner@redhat.com>
 <20221108133010.75226-2-lczerner@redhat.com>
 <Y2qC8lcFAMyDhUs1@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qC8lcFAMyDhUs1@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-11-22 08:25:22, Darrick J. Wong wrote:
> On Tue, Nov 08, 2022 at 02:30:09PM +0100, Lukas Czerner wrote:
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
> > +          standard quota tools.
> > +usrquota  Same as quota option. Exists for compatibility reasons.
> > +grpquota  Same as quota option. Exists for compatibility reasons.
> 
> I guess this is following ext* where group and user quota cannot be
> enabled individually, nor is there a 'noenforce' mode?

Well, in ext4 enforcement of user and group quotas can be enabled
separately. usrquota enables enforcement of user quotas, grpquota enables
enforcement of group quotas. Quota usage tracking depends on the enabled
filesystem features and there you are correct ext4 either tracks both user
& group usage or none.  OTOH project quota tracking can be selected
separately.  Frankly, I don't see a great reason to not allow user/group
quotas to be tracked independently when we already have all three mount
options.

I agree the noenforce mode for tmpfs does not make a lot of sense.

> > +		shmem_quota_write_inode(inode, type, (const char *)&qinfo,
> > +					sizeof(qinfo), sizeof(qheader));
> > +		shmem_quota_write_inode(inode, type, 0,
> > +					QT_TREEOFF * QUOTABLOCK_SIZE,
> > +					QUOTABLOCK_SIZE);
> > +
> > +		shmem_set_inode_flags(inode, FS_NOATIME_FL | FS_IMMUTABLE_FL);
> > +
> > +		err = dquot_load_quota_inode(inode, type, QFMT_VFS_V1,
> 
> I wonder, what's the difference between quota v1 and v2?  Wouldn't we
> want the newer version?

So this is a naming catch I've introduced many years ago :-| QFMT_VFS_V1 is
the newest quota format we support and is implemented in
fs/quota/quota_v2.c

> > @@ -353,7 +590,6 @@ static void shmem_recalc_inode(struct inode *inode)
> >  	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
> >  	if (freed > 0) {
> >  		info->alloced -= freed;
> > -		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
> 
> I guess the quotaops helpers take care of the i_blocks updates now?

Yes, dquot_alloc_space() takes care of inode->i_blocks update.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
