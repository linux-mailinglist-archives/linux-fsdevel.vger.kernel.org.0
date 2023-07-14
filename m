Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E087530A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 06:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjGNEke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 00:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjGNEkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDE2690;
        Thu, 13 Jul 2023 21:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6906161BED;
        Fri, 14 Jul 2023 04:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8288EC433C7;
        Fri, 14 Jul 2023 04:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689309629;
        bh=xPM2ynhDBbedudlIudtUkYVzF4pbvK2Vdl+QBkQbJiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoBL2G7UhnHKAv1rD45zLbyHhpNg7D4LGBCVNLEZ5/JIJt5nrpIIN/CriLkQ7fZFj
         1fQ0daHISxxSWsWcVStSHSp2qIQOr/cr2dYE32Qc4Y/0OqzYQMOUbe2QHr0Fr0pQgp
         XxT4UYkD8rM6CCYcVx0PHQCZ9/TjPnruWNKJAsAFiFUR4xZ3VdSNFOhlk/eNo9ivvm
         sBv+5zsTqOIU7hexEhkH2K0JWgYTSfB/labqich3y1wCB9V7isf9xg+R5+GjNxLihc
         +0AeVN0rzSYqOMUpBwDCpdO64veY54ckb/6t9D3N55G0n3Zo5GvFriODy0muY3vMl2
         HXcj9nMVMdkjQ==
Date:   Thu, 13 Jul 2023 21:40:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/7] fs: Expose name under lookup to d_revalidate hook
Message-ID: <20230714044027.GB913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-2-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-2-krisman@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

On Fri, Apr 21, 2023 at 08:03:04PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Negative dentries support on case-insensitive ext4/f2fs will require
> access to the name under lookup to ensure it matches the dentry.  This
> adds an optional new flavor of cached dentry revalidation hook to expose
> this extra parameter.
> 
> I'm fine with extending d_revalidate instead of adding a new hook, if
> it is considered cleaner and the approach is accepted.  I wrote a new
> hook to simplify reviewing.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/dcache.c            |  2 +-
>  fs/namei.c             | 23 ++++++++++++++---------
>  include/linux/dcache.h |  1 +
>  3 files changed, 16 insertions(+), 10 deletions(-)

Documentation/filesystems/vfs.rst and Documentation/filesystems/locking.rst need
to be updated to document d_revalidate_name.

- Eric
