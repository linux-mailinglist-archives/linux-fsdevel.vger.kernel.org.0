Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11058753151
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjGNFdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjGNFdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2273A82;
        Thu, 13 Jul 2023 22:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4CF61B97;
        Fri, 14 Jul 2023 05:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16291C433C7;
        Fri, 14 Jul 2023 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312697;
        bh=UQR3bir+WT35SRPvnb3D/9pM/N80WPTedvRzMIl+G4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQwKSe7ig70Gqivtm2Dbh5BExokj9htpK0aCmQ/N7tKSJh4eGtxg4oWTBxgaleQEd
         qkMTkC0uXCdaPk7VGzDEBFiPZW9U2eL0HFCu51sWWFBw5QX9G06HNoI4k6YI0zQ4sw
         QARcLLQ6T0uC3NCWi0g8GUK/15W8+0/JZ50uvHlOJVDUQO3Wz9IGWM/d6/COIc9/3K
         3YpxiAhODi3M/4LvO+gliXc6SJQb3k5lIn4LzAlwNWs6SpW5WWEAfHcrqa02W7Xh7m
         hzz+WcpLd+b0q+L2v5KyoTnBt0JUoFQQXr/ALkrJH1DVaXew0SEWn0wFRl/PbhMtMx
         aLnHJvNURpdDQ==
Date:   Thu, 13 Jul 2023 22:31:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
Message-ID: <20230714053135.GD913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-5-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-5-krisman@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:03:07PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Preserve the existing behavior for encrypted directories, by rejecting
> negative dentries of encrypted+casefolded directories.  This allows
> generic_ci_d_revalidate to be used by filesystems with both features
> enabled, as long as the directory is either casefolded or encrypted, but
> not both at the same time.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/libfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index f8881e29c5d5..0886044db593 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1478,6 +1478,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
>  		const struct inode *dir = READ_ONCE(parent->d_inode);
>  
>  		if (dir && needs_casefold(dir)) {
> +			if (IS_ENCRYPTED(dir))
> +				return 0;
> +

Why not allow negative dentries in case-insensitive encrypted directories?
I can't think any reason why it wouldn't just work.

- Eric
