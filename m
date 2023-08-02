Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0076C72B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjHBHlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjHBHk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285F4EE5
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 00:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF32F61826
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AA4C433C8;
        Wed,  2 Aug 2023 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690961907;
        bh=oCGuQ8mz8j6motb8jauwMHsm1475mUuOPqVTPXOHsXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPWKt+hnvgPw2Rammja6e+KEIh+yS3jl8zKWU/NhRvuHHHnHaJYXQ0/7QxIKUvPVD
         n3zziE5YVYkkTqXTUT0deiMno/nm80gLiE01ZsDwblGty68S0NUrLJG13aZpayoL/q
         bkcRkA9wGJE3VG28fBUFZIxA60kcGYYT1qIXRY4/sz6NiBI1ZDqv8LAUhrJjYoHnW2
         vsZlfLUmSRveRXbbWtmnafQOkMNJE8OXu9tciCRfM+Bezd91uM8QpIO0TiM2RONKap
         bMQfImHqb16eDRe9ENXS5KEVAfARI9e5rUcQ9hM3CwdeYCOh4EDw4mdzR4NmQawRjT
         H07kLHC4PaX2A==
Date:   Wed, 2 Aug 2023 09:38:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] fs: add FSCONFIG_CMD_CREATE_EXCL
Message-ID: <20230802-flaute-fotowettbewerb-7e7fedaa82cb@brauner>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
 <20230801-vfs-super-exclusive-v1-3-1a587e56c9f3@kernel.org>
 <20230801154607.GD12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801154607.GD12035@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:46:07PM +0200, Christoph Hellwig wrote:
> > +	/* require the new mount api */
> > +	if (exclusive && (fc->ops == &legacy_fs_context_ops))
> 
> No need for the inner braces.

My love for operator precendence isn't very strong and having also
studied math has left me with an obsessive relationsip with brackets...

> 
> > +		return -EOPNOTSUPP;
> > +
> >  	fc->phase = FS_CONTEXT_CREATING;
> > +	fc->exclusive = exclusive;
> >  
> >  	ret = vfs_get_tree(fc);
> > -	if (ret)
> > +	if (ret) {
> > +		fc->exclusive = false;
> 
> What's the point in clearing the flag on error?

I originally thought that when the caller did:

fsconfig(fd_fs, FSCONFIG_CMD_CREATE_EXCL)

and this failed but the caller immediately followed this up with another
call to:

fsconfig(fd_fs, FSCONFIG_CMD_CREATE)

then leaving fc->exclusive set might turn FSCONFIG_CMD_CREATE into an
exclusive create on accident leaving the caller confused. But then I
remembered that this code explicitly fails the whole fs_context forever
after a failed superblock creation because after vfs_get_tree() it is
unclear what state the fs_context is in. And I apparently forgot to
remove that after I remembered that.

> 
> > +	case FSCONFIG_CMD_CREATE_EXCL:
> > +		fallthrough;
> >  	case FSCONFIG_CMD_CREATE:
> > -		ret = vfs_cmd_create(fc);
> > +		ret = vfs_cmd_create(fc, cmd == FSCONFIG_CMD_CREATE_EXCL);
> >  		if (ret)
> >  			break;
> >  		return 0;
> 
> Nitpick, but I always find it cleaner to do something like:
> 
> 	case FSCONFIG_CMD_CREATE_EXCL:
> 		ret = vfs_cmd_create(fc, true)
> 		break;
>  	case FSCONFIG_CMD_CREATE:
> 		ret = vfs_cmd_create(fc, false);
> 
> but that might just be preference.

Fine by me.
