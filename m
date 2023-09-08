Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5087986D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjIHMKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHMKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:10:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17D1BC5;
        Fri,  8 Sep 2023 05:10:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A5621FE19;
        Fri,  8 Sep 2023 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694175016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyAJOe4IIc4u4PsIgJoECbVObRSruBJdgdnnkoMkWpc=;
        b=ffcypC1C+MqUG8/Hn5L3CMDJzLEBNb9hCp2fG6HfXPJ4yJmXUmT08ZYq0yBtf+N43GV8ph
        /c8aD84SlH7XveWi5DVNXy71HqnrBZThe+iunyHnwnNF+8rqPXSfrVu9ezRq5Y1SaLL8bK
        0Kk44lT3LlCNk/ufrQip3EF2y4zXW+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694175016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyAJOe4IIc4u4PsIgJoECbVObRSruBJdgdnnkoMkWpc=;
        b=kBww0jG4zHOMXYIuFz6j4ucOkxulX/N1eGfJWY4Kij3JJQXPOKxOt1my+3UekQpk2gUmBF
        sR1dRImfMA5TjSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18E65132F2;
        Fri,  8 Sep 2023 12:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H/MNBigP+2SDMAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 12:10:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 806FBA0774; Fri,  8 Sep 2023 14:10:15 +0200 (CEST)
Date:   Fri, 8 Sep 2023 14:10:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] fs: initialize inode->__i_ctime to the epoch
Message-ID: <20230908121015.k2xmkbiw7dljj24g@quack3>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
 <20230907-ctime-fixes-v1-1-3b74c970d934@kernel.org>
 <20230908104229.5tsr2sn7oyfy53ih@quack3>
 <0716e97eadc834ac4be97af5d6bbab82c5dc4ac9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0716e97eadc834ac4be97af5d6bbab82c5dc4ac9.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-09-23 07:41:45, Jeff Layton wrote:
> On Fri, 2023-09-08 at 12:42 +0200, Jan Kara wrote:
> > On Thu 07-09-23 12:33:47, Jeff Layton wrote:
> > > With the advent of multigrain timestamps, we use inode_set_ctime_current
> > > to set the ctime, which can skip updating if the existing ctime appears
> > > to be in the future. Because we don't initialize this field at
> > > allocation time, that could prevent the ctime from being initialized
> > > properly when the inode is instantiated.
> > > 
> > > Always initialize the ctime field to the epoch so that the filesystem
> > > can set the timestamps properly later.
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Looks good but don't you need the same treatment to atime after your patch
> > 2/2?
> > 
> > 
> 
> I don't think so. Most filesystems are doing something along the lines
> of this when allocating a new inode:
> 
>     inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> 
> ...and I think they pretty much all have to initialize i_atime properly,
> since someone could stat the inode before an atime update occurs.

Ah, right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > > ---
> > >  fs/inode.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 35fd688168c5..54237f4242ff 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -168,6 +168,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> > >  	inode->i_fop = &no_open_fops;
> > >  	inode->i_ino = 0;
> > >  	inode->__i_nlink = 1;
> > > +	inode->__i_ctime.tv_sec = 0;
> > > +	inode->__i_ctime.tv_nsec = 0;
> > >  	inode->i_opflags = 0;
> > >  	if (sb->s_xattr)
> > >  		inode->i_opflags |= IOP_XATTR;
> > > 
> > > -- 
> > > 2.41.0
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
