Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4535826CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiG0Mhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiG0MhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707402F39D;
        Wed, 27 Jul 2022 05:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FEA5B82113;
        Wed, 27 Jul 2022 12:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F88AC433D6;
        Wed, 27 Jul 2022 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658925440;
        bh=5uGFhwnAjPwbu39ewjhIkjpjr3mcKfTg6VBfx5qToTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mviPG5j2yGfxbO3cDv4PsEKq7XZgdp61xJZr+3Mn6eH7OQyG4kurXDabnRSG/foyN
         Rbjy3mAUAnBcyWu7sdSeW99p2QhwQEa43TSmOVRkiK6Fv5NqvfPcELvdGv7/G86av0
         MO59kb3sz8iSCfsCqhNHBjO5Pk/ZHwTGEvvkNs6bl2gMeoqMxBbCyetT9IAlFF1Caj
         29KjWDzZHD+8OFcwiblifdF3dCr4zE6yWDzyd/UJ5wuj++I0bDr+r6CqP//deeaTH3
         sbbappHNAEzKS1SkZdWGV3X0LTcgDWSSqp4oNQdbnJnvceX8FJMVU2Oq3DdLUcXLoa
         aFWATQPPADFFA==
Date:   Wed, 27 Jul 2022 14:37:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Subject: Re: [PATCH] vfs: bypass may_create_in_sticky check if task has
 CAP_FOWNER
Message-ID: <20220727123710.tzg44xojlc3pmsiw@wittgenstein>
References: <20220727123048.46389-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220727123048.46389-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:30:48AM -0400, Jeff Layton wrote:
> NFS server is exporting a sticky directory (mode 01777) with root
> squashing enabled. Client has protect_regular enabled and then tries to
> open a file as root in that directory. File is created (with ownership
> set to nobody:nobody) but the open syscall returns an error.
> 
> The problem is may_create_in_sticky, which rejects the open even though
> the file has already been created/opened. Bypass the checks in
> may_create_in_sticky if the task has CAP_FOWNER in the given namespace.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
> Reported-by: Yongchen Yang <yoyang@redhat.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f28d3f463c3..170c2396ba29 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1230,7 +1230,8 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
>  	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
>  	    likely(!(dir_mode & S_ISVTX)) ||
>  	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
> -	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
> +	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
> +	    ns_capable(mnt_userns, CAP_FOWNER))
>  		return 0;

Hm, no. You really want inode_owner_or_capable() here..
You need to verify that you have a mapping for the inode->i_{g,u}id in
question and that you're having CAP_FOWNER in the caller's userns.

I'm pretty sure we should also restrict this to the case were the caller
actually created the file otherwise we introduce a potential issue where
the caller is susceptible to data spoofing. For example, the file was
created by another user racing the caller's O_CREAT.
