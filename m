Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F34771D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjHGJel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjHGJek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19346E7F
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 02:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACB761713
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 09:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7281EC433C8;
        Mon,  7 Aug 2023 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691400878;
        bh=v8Y3H4khCX0WxHBuKfcC45Vawb/clen1V7JGX+PMtv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0VCkR6/jXHfsvifgTcTnTJFAI23sbPvMrD2xNVLYqlzCV5UUBRuaquQ093BQ3Y5c
         krIKPseWsjk/IJ/Ci9aqZRLDQYPkoAlEU97zNUBYYM5TYYBcU0q4HAySllUzMWYFSk
         flo1AHtIeTivGZKK+7AdYEP0aJf1GLhZpX6tAbu5zFUhwkWhDrwS6zAS0tk+bMNIqX
         injp+JPgbbCKH5Ixi2z4O4hiJ9U4YQHGQNKh8JmSJ6u/pWLdoKsmEejYGb69xV5IFO
         wBEUVjzPwimCtqqF118+lrDi2Ei+HzS0V0erHKPYmmTLcuswGFJQTXPiTy9dvSik42
         4Z1dY7LaWc6gA==
Date:   Mon, 7 Aug 2023 11:34:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs] shmem: move spinlock into shmem_recalc_inode()
 to fix quota support
Message-ID: <20230807-haartracht-sammeln-fbc99df8aa33@brauner>
References: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
 <L1VFk72H59Uu14n59nJGp7Qdq0EYH1CAh6idm8i49RMfsIn2etAPq2PZv5wl-IILHjZFDTQxO2sJzuSUCqxBqA==@protonmail.internalid>
 <20230804-legalisieren-neukonzeption-97314400abbd@brauner>
 <20230807093222.o46d7kexapywe5jl@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807093222.o46d7kexapywe5jl@andromeda>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:32:22AM +0200, Carlos Maiolino wrote:
> On Fri, Aug 04, 2023 at 11:31:33AM +0200, Christian Brauner wrote:
> > On Thu, 03 Aug 2023 22:46:11 -0700, Hugh Dickins wrote:
> > > Commit "shmem: fix quota lock nesting in huge hole handling" was not so
> > > good: Smatch caught shmem_recalc_inode()'s shmem_inode_unacct_blocks()
> > > descending into quota_send_warning(): where blocking GFP_NOFS is used,
> > > yet shmem_recalc_inode() is called holding the shmem inode's info->lock.
> > >
> > > Yes, both __dquot_alloc_space() and __dquot_free_space() are commented
> > > "This operation can block, but only after everything is updated" - when
> > > calling flush_warnings() at the end - both its print_warning() and its
> > > quota_send_warning() may block.
> > >
> > > [...]
> > 
> > Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
> > Patches in the vfs.tmpfs branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.tmpfs
> > 
> > [1/1] shmem: move spinlock into shmem_recalc_inode() to fix quota support
> >       https://git.kernel.org/vfs/vfs/c/f384c361c99e
> 
> Once Hugh patch fixes the issue Dan reported, I believe I don't need to resubmit
> my series?

I've applied it and it should already show up in -next so yeah, no need
to resend.
