Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E105782D92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjHUPwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjHUPwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF624A1;
        Mon, 21 Aug 2023 08:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8550B63C9A;
        Mon, 21 Aug 2023 15:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F0BC433C7;
        Mon, 21 Aug 2023 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633161;
        bh=/vUBGyYP6VPO4JH3SmEIBCefV7FnpLZ3SJcwW8GIf5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6V0CaqMpxTdaO+LJv26M2zy4Tz566Z18dEQrMZ6FPcYyqiNZmvzPfasyNf0FID6B
         FoKWyGF8R+5ykhtbAaGhCfbioayjQht+ErRCbM7gBDDpuKpIMWpTfLkgQGgEh2+Wva
         nOt4CDfmxJf3VK3ZpfnNIHeXYhxDDdm6B3brvPQ18zyHrbAfOgOrlze7YBQLqA2eka
         u71Ryd9q6SHFQnUDkfSkrIOxrPnvrHBlarNfjNKuu/Jj3t/B3F7lw3nivGEDoy1sC6
         /Mkq9jxm+qwono3i/ffFQfhUnJgl0DODxSzeRk1xw2lIbKJ4BsVPB9HZyaLyZ6Whmr
         MvSmZ3ylZBGEw==
Date:   Mon, 21 Aug 2023 17:52:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230821-derart-serienweise-3506611e576d@brauner>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230817170658.GD1483@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817170658.GD1483@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:06:58AM -0700, Eric Biggers wrote:
> On Wed, Aug 16, 2023 at 01:07:54AM -0400, Gabriel Krisman Bertazi wrote:
> > Hi,
> > 
> > This is v6 of the negative dentry on case-insensitive directories.
> > Thanks Eric for the review of the last iteration.  This version
> > drops the patch to expose the helper to check casefolding directories,
> > since it is not necessary in ecryptfs and it might be going away.  It
> > also addresses some documentation details, fix a build bot error and
> > simplifies the commit messages.  See the changelog in each patch for
> > more details.
> > 
> > Thanks,
> > 
> > ---
> > 
> > Gabriel Krisman Bertazi (9):
> >   ecryptfs: Reject casefold directory inodes
> >   9p: Split ->weak_revalidate from ->revalidate
> >   fs: Expose name under lookup to d_revalidate hooks
> >   fs: Add DCACHE_CASEFOLDED_NAME flag
> >   libfs: Validate negative dentries in case-insensitive directories
> >   libfs: Chain encryption checks after case-insensitive revalidation
> >   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
> >   ext4: Enable negative dentries on case-insensitive lookup
> >   f2fs: Enable negative dentries on case-insensitive lookup
> > 
> 
> Looks good,
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Thanks! We're a bit too late for v6.6 with this given that this hasn't
even been in -next. So this will be up for v6.7.
