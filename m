Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB66EA83E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDUKWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDUKWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C71FD0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 03:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FFC60FA4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11C1C433D2;
        Fri, 21 Apr 2023 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682072447;
        bh=U+b/+dv0OYfR922a/EMYngteFkuh3GpuR3Zv9Q3ESek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmCICkkLosJy72kWhOppDzth2MJIEstExrYLrBBHcCaEgIF/n4ahjneFu1HSi3vUY
         7R5utZNCdp3igQoscobbD2Ed1mqJwW0DKco+HIat+khI9Ua7S8iB5+fvNPfI831JYG
         fpzrtfjXnh9MqHW0rYmOCWoSG1+RyS6RbIbGKgrwGtmfY1KtvPSW9gMgrqYCUXiOQ8
         eYMBYVlfI65bQdgC1faM830cmGuUWKBqBL1XMb1UooKhW1AhppMnZExzPHaCPnKoq4
         zkGyewghBpmny80Puyf2rDTWqEw++BRWqHpQFxuGv07sOXwMyevvpFs+q8HcFSk8g5
         BbEQduAkBs5qQ==
Date:   Fri, 21 Apr 2023 12:20:42 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 6/6] Add default quota limit mount options
Message-ID: <20230421102042.re3mij2avpvyilek@andromeda>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-7-cem@kernel.org>
 <Zjm4wD22Q8NU2h4KOvWzcfoANWK18DShrsWE6MIUq-AMEA0cOzxvzyFZNiFM-rePmqKt1loq92zJaZBw1YJFwA==@protonmail.internalid>
 <20230420143954.asmpkta4tknyzcda@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420143954.asmpkta4tknyzcda@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 04:39:54PM +0200, Jan Kara wrote:
> On Thu 20-04-23 10:03:59, cem@kernel.org wrote:
> > From: Lukas Czerner <lczerner@redhat.com>
> >
> > Allow system administrator to set default global quota limits at tmpfs
> > mount time.
> >
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >  Documentation/filesystems/tmpfs.rst | 34 ++++++++++----
> >  include/linux/shmem_fs.h            |  8 ++++
> >  mm/shmem.c                          | 69 +++++++++++++++++++++++++++++
> >  mm/shmem_quota.c                    |  9 ++++
> >  4 files changed, 111 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > index 1d4ef4f7cca7e..241c11f86cd73 100644
> > --- a/Documentation/filesystems/tmpfs.rst
> > +++ b/Documentation/filesystems/tmpfs.rst
> > @@ -88,15 +88,31 @@ that instance in a system with many CPUs making intensive use of it.
> >
> >  tmpfs also supports quota with the following mount options
> >
> > -========  =============================================================
> > -quota     User and group quota accounting and enforcement is enabled on
> > -          the mount. Tmpfs is using hidden system quota files that are
> > -          initialized on mount.
> > -usrquota  User quota accounting and enforcement is enabled on the
> > -          mount.
> > -grpquota  Group quota accounting and enforcement is enabled on the
> > -          mount.
> > -========  =============================================================
> > +======================== =================================================
> > +quota                    User and group quota accounting and enforcement
> > +                         is enabled on the mount. Tmpfs is using hidden
> > +                         system quota files that are initialized on mount.
> > +usrquota                 User quota accounting and enforcement is enabled
> > +                         on the mount.
> > +grpquota                 Group quota accounting and enforcement is enabled
> > +                         on the mount.
> > +usrquota_block_hardlimit Set global user quota block hard limit.
> > +usrquota_inode_hardlimit Set global user quota inode hard limit.
> > +grpquota_block_hardlimit Set global group quota block hard limit.
> > +grpquota_inode_hardlimit Set global group quota inode hard limit.
> > +======================== =================================================
> > +
> > +None of the quota related mount options can be set or changed on remount.
> > +
> > +Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
> > +and can't be changed on remount. Default global quota limits are taking
> > +effect for any and all user/group/project except root the first time the
> > +quota entry for user/group/project id is being accessed - typically the
> > +first time an inode with a particular id ownership is being created after
> > +the mount. In other words, instead of the limits being initialized to zero,
> > +they are initialized with the particular value provided with these mount
> > +options. The limits can be changed for any user/group id at any time as it
> 									   ^^ they
> > +normally can.
> 	    ^^^ can be
> 
Thanks!

> > @@ -3714,6 +3723,50 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> >  		ctx->seen |= SHMEM_SEEN_QUOTA;
> >  		ctx->quota_types |= QTYPE_MASK_GRP;
> >  		break;
> > +	case Opt_usrquota_block_hardlimit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
> > +			return invalfc(fc,
> > +				       "User quota block hardlimit too large.");
> > +		ctx->qlimits.usrquota_bhardlimit = size;
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		ctx->quota_types |= QTYPE_MASK_USR;
> 
> So if I get it right, the intention here is that if
> usrquota_block_hardlimit=value option is used, it automatically enables
> user quota accounting and enforcement. I guess it is logical but it is not
> documented and I'd prefer to require explicit usrquota mount option to
> enable accounting & enforcement - it is then e.g. easier to parse mount
> options (in userspace) for finding out whether enforcement is enabled or
> not.

Hmmm, I think I see what you mean. I can make usrquota_block_hardlimit options
to not actually set the quota flag on quota_types, so this should be explicitly
set by usrquota/grpquota options. Does that work for you?

> Also I can imagine we would allow changing the default limits on
> remount but it isn't easy to enable quota accounting on remount etc.
> 

hmm, yes, maybe enabling default limits to be changed on remount isn't a big
deal, once the quota is already enabled, so everything is already in place.

> > diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> > index c0b531e2ef688..3cc53f2c35e2c 100644
> > --- a/mm/shmem_quota.c
> > +++ b/mm/shmem_quota.c
> > @@ -166,6 +166,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> >  {
> >  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> >  	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> > +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> >  	struct rb_node *parent = NULL, *new_node = NULL;
> >  	struct quota_id *new_entry, *entry;
> >  	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > @@ -195,6 +196,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> >  	}
> >
> >  	new_entry->id = id;
> > +	if (dquot->dq_id.type == USRQUOTA) {
> > +		new_entry->bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > +		new_entry->ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > +	} else if (dquot->dq_id.type == GRPQUOTA) {
> > +		new_entry->bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
> > +		new_entry->ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
> > +	}
> > +
> >  	new_node = &new_entry->node;
> >  	rb_link_node(new_node, parent, n);
> >  	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> 
> Maybe in shmem_dquot_release() when usage is 0 and limits are at default
> limits, we can free the structure?

hmmm, which struct are you talking about? quota_id? As we do for DQ_FAKE?


> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
