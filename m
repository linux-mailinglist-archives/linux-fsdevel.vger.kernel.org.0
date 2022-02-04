Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE464A9891
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 12:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358472AbiBDLtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 06:49:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBDLtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:49:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 92F431F382;
        Fri,  4 Feb 2022 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643975370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4ojmeLqWFus4pyldtpcM+iSQ4e1E+7sbEN57iH9+2k=;
        b=EYKvUbcWj9DxXe6vLq9jBIiAA+hJhfBa4lQS/j8SFw9yWF7p7HK6P13tK1P+tFBn8AeRUt
        VJzV1Mdj/2zReTfWiXUzE43DSwsA+mMHGmHfim8dEDmoGW1X4diPtMisnEp/trmGk5HKPN
        Z02P71qWIPhMiOj7zxhHBsRwhj8XmcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643975370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4ojmeLqWFus4pyldtpcM+iSQ4e1E+7sbEN57iH9+2k=;
        b=7puleTRMufaAzQb+GdAsj+IEp+kFjyFca55XWwtRAc4tvmvQx4+UOBSObexQOd1CaySDCv
        1AU0qyXUsgm4cICA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82E02A3B83;
        Fri,  4 Feb 2022 11:49:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DACCA05B6; Fri,  4 Feb 2022 12:49:30 +0100 (CET)
Date:   Fri, 4 Feb 2022 12:49:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 2/6] ext4: Implement ext4_group_block_valid() as common
 function
Message-ID: <20220204114930.7n7z2zqhtkzmco3p@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
 <20220201113453.exaikdfsc3vubqel@quack3.lan>
 <20220204100844.ty23mdc5mfjbgiwj@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204100844.ty23mdc5mfjbgiwj@riteshh-domain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 04-02-22 15:38:44, Ritesh Harjani wrote:
> On 22/02/01 12:34PM, Jan Kara wrote:
> > On Mon 31-01-22 20:46:51, Ritesh Harjani wrote:
> > > This patch implements ext4_group_block_valid() check functionality,
> > > and refactors all the callers to use this common function instead.
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ...
> >
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 8d23108cf9d7..60d32d3d8dc4 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -6001,13 +6001,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
> > >  		goto error_return;
> > >  	}
> > >
> > > -	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
> > > -	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
> > > -	    in_range(block, ext4_inode_table(sb, gdp),
> > > -		     sbi->s_itb_per_group) ||
> > > -	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
> > > -		     sbi->s_itb_per_group)) {
> > > -
> > > +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
> > >  		ext4_error(sb, "Freeing blocks in system zone - "
> > >  			   "Block = %llu, count = %lu", block, count);
> > >  		/* err = 0. ext4_std_error should be a no op */
> >
> > When doing this, why not rather directly use ext4_inode_block_valid() here?
> 
> This is because while freeing these blocks we have their's corresponding block
> group too. So there is little point in checking FS Metadata of all block groups
> v/s FS Metadata of just this block group, no?
> 
> Also, I am not sure if we changing this to check against system-zone's blocks
> (which has FS Metadata blocks from all block groups), can add any additional
> penalty?

I agree the check will be somewhat more costly (rbtree lookup). OTOH with
more complex fs structure (like flexbg which is default for quite some
time), this is by far not checking the only metadata blocks, that can
overlap the freed range. Also this is not checking for freeing journal
blocks. So I'd either got for no check (if we really want performance) or
full check (if we care more about detecting fs errors early). Because these
half-baked checks do not bring much value these days...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
