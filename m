Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D255149C7CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiAZKpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 05:45:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54484 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbiAZKpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:45:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F166A1F393;
        Wed, 26 Jan 2022 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643193936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMhbvnqBAiv8Isyn96DuMZIgEOOAlDbvw+pj2/LPwZQ=;
        b=LdEOKpFECGlmIrcDUZmOgcwMaekPeA8UDO3q5mXGD/ejL7xr+CQkWQvzPEj2+zbHolpdu/
        RBV8ZiymlanPDMJ/VtPfl+3PPO9cKKfsdnM5zHpUMzUuNzYFEcIXAhCaDnjEEjg3LItcNq
        Frdfl063c8ChaPvXLBlR5eH5pGNb3UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643193936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMhbvnqBAiv8Isyn96DuMZIgEOOAlDbvw+pj2/LPwZQ=;
        b=wBANlHQJ+u9JwxI709i2z3YLKURLiTH/1uG1aUyp9+iTI44EitKm723/2BXMOa2Qh46FXQ
        Zxb7P/toJxGWEyBA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5D3BA3B89;
        Wed, 26 Jan 2022 10:45:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AE379A05E6; Wed, 26 Jan 2022 11:45:36 +0100 (CET)
Date:   Wed, 26 Jan 2022 11:45:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 4/4] xfs: return errors in xfs_fs_sync_fs
Message-ID: <20220126104536.p4fwxhuhfpaj7dyo@quack3.lan>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316351155.2600168.3007243245021307622.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316351155.2600168.3007243245021307622.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-01-22 18:18:31, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that the VFS will do something with the return values from
> ->sync_fs, make ours pass on error codes.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_super.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Makes sence. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> 
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e8f37bdc8354..4c0dee78b2f8 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -735,6 +735,7 @@ xfs_fs_sync_fs(
>  	int			wait)
>  {
>  	struct xfs_mount	*mp = XFS_M(sb);
> +	int			error;
>  
>  	trace_xfs_fs_sync_fs(mp, __return_address);
>  
> @@ -744,7 +745,10 @@ xfs_fs_sync_fs(
>  	if (!wait)
>  		return 0;
>  
> -	xfs_log_force(mp, XFS_LOG_SYNC);
> +	error = xfs_log_force(mp, XFS_LOG_SYNC);
> +	if (error)
> +		return error;
> +
>  	if (laptop_mode) {
>  		/*
>  		 * The disk must be active because we're syncing.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
