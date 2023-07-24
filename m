Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8675EDBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGXIfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 04:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGXIfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA7E74;
        Mon, 24 Jul 2023 01:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759B360FA1;
        Mon, 24 Jul 2023 08:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21924C433C8;
        Mon, 24 Jul 2023 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690187702;
        bh=ne7tk1khFVWf1DrNJLr/0lBfX1iyufLPJA4BWhCI0Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQ6+HgKz+Old8TWsdMEPMfR46/Pfclw6QcF5QLXXrtgFJ1n9Qe55q4GGtvL7jdlDY
         yjdvSTMxe/B11PYvPI+xWRpvtBWR/PKFHcnJxvHI/TSGa/4rOvcfNXfSBSN4uf0nEh
         qERnHsqM9r9XYcGqpvSlmquJrTg7wHWakxQqz7XsVhw1MgE2kAimibWFzipi8wMFn/
         k0OSqInoXfdLxAboPkVx17ELO5GSZ+KotpQ95lbXxnbfCjJGaPepgv79zoGxnkQYdS
         K1wbtml35ihiuXINizioUS0h9raob1VYdu5ZirUsry9SiGvYK7mXCkXwNbHCi2Lb1/
         68p+JmQP+vdmw==
Date:   Mon, 24 Jul 2023 10:34:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] ext4: fix the time handling macros when ext4 is using
 small inodes
Message-ID: <20230724-waldlauf-hermelin-58df07b2e2dd@brauner>
References: <20230719-ctime-v2-1-869825696d6d@kernel.org>
 <20230720144807.GC5764@mit.edu>
 <f541027cca189c42550136aab27b89889cd2fdd3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f541027cca189c42550136aab27b89889cd2fdd3.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:54:16AM -0400, Jeff Layton wrote:
> On Thu, 2023-07-20 at 10:48 -0400, Theodore Ts'o wrote:
> > On Wed, Jul 19, 2023 at 06:32:19AM -0400, Jeff Layton wrote:
> > > If ext4 is using small on-disk inodes, then it may not be able to store
> > > fine grained timestamps. It also can't store the i_crtime at all in that
> > > case since that fully lives in the extended part of the inode.
> > > 
> > > 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
> > > still store the tv_sec field of the i_crtime into the raw_inode, even
> > > when they were small, corrupting adjacent memory.
> > > 
> > > This fixes those macros to skip setting anything in the raw_inode if the
> > > tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
> > > the raw_inode doesn't support it.
> > > 
> > > Also, fix a bug in ctime handling during rename. It was updating the
> > > renamed inode's ctime twice rather than the old directory.
> > > 
> > > Cc: Jan Kara <jack@suse.cz>
> > > Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
> > > Reported-by: Hugh Dickins <hughd@google.com>
> > > Tested-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Acked-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > I assume this is will be applied to the vfs.ctime branch, yes?
> > 
> >   	      	      	 	    	- Ted
> 
> Yes. Ideally it'll be folded into the ext4 patch there.

Done now, thanks!
