Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2106DD5CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDKIln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKIlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA00E6A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39C5161CCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 08:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D5C433D2;
        Tue, 11 Apr 2023 08:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681202500;
        bh=7u7/nI6VJjJ+81GqcnTk2qduufTY1lvAgSL3PrqyYQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqKOe68NFCmJcYcruvxCJEtd6Oav4j/ZX4tDi97gSAW2vF96nS0SeSY2CATBM4fMr
         VII0pB1lGhBjtvjhBHjdeO+CAGBESonJ2HnVRJOO9clgEAvUF2njMYMOikTLFSiYkT
         KiP7X6kJShj70TzzifQCY45GbnBhkUN98J2CKjj66qSOqZKNrjtR3m3osXPMB3WqBL
         GlXOVcevvlyS46dCHZ9mD8fqUeWxemYEv+O37f0QCLUhN3mDSQtqyKFoZsK9y/EzVz
         s5i3bt+TwWR1e8oOWYy6dAD+eVfwLiA99wKa1E5phjgptcVrznEFBCjTXK/AnhyfR0
         G4UM1rw5ksiOg==
Date:   Tue, 11 Apr 2023 10:41:35 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead
 of NULL
Message-ID: <20230411084135.vwxuyl2c23hf2kjj@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-3-cem@kernel.org>
 <tLzd9z0prOKXpbWA3SHcS9KsIWPXVcwdgdxn4HuqDRoy9o8BgCNaKDNsNvW6C_m3Wo1pCXScjS6j14EaxszP6g==@protonmail.internalid>
 <20230403102354.jnwrqdbhpysttkxm@quack3>
 <20230411074708.gb7hkp6knxag3qjs@andromeda>
 <wTYYPY3jaos1BBZAhgDf_jyTQMjR8rY2GJ8f97Hiamsrgx5dyA6lTG_eC1Zrv6FSO8GHwvtFR3wrI0BZtNS9EQ==@protonmail.internalid>
 <20230411081445.i57nloespetckatg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411081445.i57nloespetckatg@quack3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:14:45AM +0200, Jan Kara wrote:
> 
> Hi!
> 
> On Tue 11-04-23 09:47:08, Carlos Maiolino wrote:
> > My apologies it took a while to get back to you on this one, I was
> > accumulating reviews before running through all of them.
> 
> Sure, that is fine.
> 
> > > >  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> > > > -	if (inode) {
> > > > -		error = security_inode_init_security(inode, dir,
> > > > -						     NULL,
> > > > -						     shmem_initxattrs, NULL);
> > > > -		if (error && error != -EOPNOTSUPP)
> > > > -			goto out_iput;
> > > > -		error = simple_acl_create(dir, inode);
> > > > -		if (error)
> > > > -			goto out_iput;
> > > > -		d_tmpfile(file, inode);
> > > > -	}
> > > > +
> > > > +	if (IS_ERR(inode))
> > > > +		return PTR_ERR(inode);
> > >
> > > This doesn't look correct. Previously, we've called
> > > finish_open_simple(file, error), now you just return error... Otherwise the
> > > patch looks good to me.
> >
> > I see what you mean. But, finish_open_simple() simply does:
> >
> > 	if (error)
> > 		return error;
> >
> > So, calling it with a non-zero value for error at most will just add another
> > function call into the stack.
> 
> I see, I didn't look inside finish_open_simple() :). Well, it is at least
> inline function so actually no function call.

Great, I didn't notice it's an inline function :D

.
.
.
> Yeah, I'd prefer we keep calling finish_open_simple(). Adding a label for
> it is fine by me.

Ok, I'm updating the series today, hopefully I'll send the new version today or
tomorrow.

Thanks for the reviews!

-- 
Carlos Maiolino
