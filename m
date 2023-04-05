Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6056D86EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDETeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDETeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571559F9
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AD763D0C
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 19:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7109C433EF;
        Wed,  5 Apr 2023 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680723252;
        bh=k6ZLtXvcwm4j1aK/ugwc6lEtg0H9RZAz8I7KFWHnFzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saUR3bjxd1dPaRNkRsDIjFxHRXjBz1S4O9QRgSRPkqUp/sUHEBTrogSgDSS4iBV3I
         laB+LS9fwgof+D5ZRxfowlShjbZWzFNfuKR6wAFHJ7Hd77lqr5dBbePrBIVyp2ekQW
         ApqZxfZRnPbUy0NmBXixbtwBDANVK26rS5kvDAzr9WQdp2ZK3AASGugXBRDBjDICbt
         oteTAsFi98m1B67JDyEE/aeiUTgzqTrsmb3HfEuuj0kHfs6EcwQOw8G60lycZnf4/7
         Pu7poSCjsMcQTAi+jNQ0tDaKDrZa3GaKhVPt0WnNs0TO36ey6r7b8ZxByjeJ2SpHXd
         7IEW2EWiZJyzQ==
Date:   Wed, 5 Apr 2023 14:34:10 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] fs: use a for loop when locking a mount
Message-ID: <ZC3NMhWlAy2MJFyc@do-x1extreme>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
 <20230202-fs-move-mount-replace-v2-4-f53cd31d6392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v2-4-f53cd31d6392@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:13:09PM +0200, Christian Brauner wrote:
> Currently, lock_mount() uses a goto to retry the lookup until it
> succeeded in acquiring the namespace_lock() preventing the top mount
> from being overmounted. While that's perfectly fine we want to lookup
> the mountpoint on the parent of the top mount in later patches. So adapt
> the code to make this easier to implement. Also, the for loop is
> arguably a little cleaner and makes the code easier to follow. No
> functional changes intended.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c | 50 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 42dc87f86f34..7f22fcfd8eab 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2308,31 +2308,39 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  
>  static struct mountpoint *lock_mount(struct path *path)
>  {
> -	struct vfsmount *mnt;
> -	struct dentry *dentry = path->dentry;
> -retry:
> -	inode_lock(dentry->d_inode);
> -	if (unlikely(cant_mount(dentry))) {
> -		inode_unlock(dentry->d_inode);
> -		return ERR_PTR(-ENOENT);
> -	}
> -	namespace_lock();
> -	mnt = lookup_mnt(path);
> -	if (likely(!mnt)) {
> -		struct mountpoint *mp = get_mountpoint(dentry);
> -		if (IS_ERR(mp)) {
> -			namespace_unlock();
> +	struct vfsmount *mnt = path->mnt;

One small complaint, mnt is reassigned before it is used, so this
assignment is unnecessary. Otherwise looks good.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

