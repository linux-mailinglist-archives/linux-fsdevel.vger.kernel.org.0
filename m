Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2D6DD497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDKHrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDKHrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E188EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 00:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC09D61D52
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 07:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF0BC433EF;
        Tue, 11 Apr 2023 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681199234;
        bh=HJ5FYYgDpUem41NoQ8cGQIFYkPRPD9zOKz57ZG3YCA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMAUuUOQ2CxJ3N+Jx/jd/0vjk/hUA2uHcRpknqYNlbEJi4OJT1qk67d1xdhg3e5sD
         ChZRNqu8dgNunix5CRQ/2BtGggLcjnf1IP0Gq9rCNLu1yz7OqEqhpLrkVD86RbAIRG
         I4bpwUfz6Qsd6OulvgKURo8HyS41O2/hm8WYbNS/AdaVzbGoOUHBmpaupp+O5/ADJn
         Yldx2OxpOkzO4Z3vR/uGxA2t3LTIQe3jzHLeR4Mfb1hiKgcMD/bHaKED5aQIyIo60u
         K42BJm2hwTRHnm0o0BHa7Xk1zkLj6U8ICBRKnyKWPmpu3+N66B8+YGg9aDPLf+eQZF
         T1VK16hxmQfsA==
Date:   Tue, 11 Apr 2023 09:47:08 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead
 of NULL
Message-ID: <20230411074708.gb7hkp6knxag3qjs@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-3-cem@kernel.org>
 <tLzd9z0prOKXpbWA3SHcS9KsIWPXVcwdgdxn4HuqDRoy9o8BgCNaKDNsNvW6C_m3Wo1pCXScjS6j14EaxszP6g==@protonmail.internalid>
 <20230403102354.jnwrqdbhpysttkxm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403102354.jnwrqdbhpysttkxm@quack3>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Honza.

My apologies it took a while to get back to you on this one, I was accumulating
reviews before running through all of them.


> >  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> > -	if (inode) {
> > -		error = security_inode_init_security(inode, dir,
> > -						     NULL,
> > -						     shmem_initxattrs, NULL);
> > -		if (error && error != -EOPNOTSUPP)
> > -			goto out_iput;
> > -		error = simple_acl_create(dir, inode);
> > -		if (error)
> > -			goto out_iput;
> > -		d_tmpfile(file, inode);
> > -	}
> > +
> > +	if (IS_ERR(inode))
> > +		return PTR_ERR(inode);
> 
> This doesn't look correct. Previously, we've called
> finish_open_simple(file, error), now you just return error... Otherwise the
> patch looks good to me.

I see what you mean. But, finish_open_simple() simply does:

	if (error)
		return error;

So, calling it with a non-zero value for error at most will just add another
function call into the stack.
I'm not opposed to still call finish_open_simple() but I don't think it adds
anything.

If you prefer it being called. I thought about adding a new label, something
like:

	if (IS_ERR(inode))
		goto err_out;
	.
	.
	.
	d_tmpfile(file, inode)
err_out:
	return finish_open_simple(file, error)
.
.
.

Would it work for you?

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
