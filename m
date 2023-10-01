Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186A7B4897
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjJAQSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229A91;
        Sun,  1 Oct 2023 09:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1C4C433C7;
        Sun,  1 Oct 2023 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696177130;
        bh=IJqi20NX4A+8cl63oTYPC78bMfzYE+wujX5yM3GVGE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiAIOkII+No95P1D8rRQWljSNLcoio4W+UrsWF+9SnDhIzOSgeAqQ/mhfluo1QWCW
         lUv1fcut3xe9aNakp8vw8X4Su/fvmbXJ1EmobZB7tUPLSx7ahQGKmy6KLssOgxlHzp
         c8sKk/KO4hMDaAlgFMpfHF88pb6Bq5R7ITx9zuajdOgC5iCLohgPhiGRcI/JDq12no
         DkxhdY2Yw1+a8052mmhF3WIk73l1RLKSE1Wf5+fo3hiWLZsUlu+1pyz7wuZSq55Pfs
         kGRWI+wQEn5eXXddjTago2XRycci8UCNWucv4ELr+TaKe+c2Om1Fhg/Q90bxEaDG+v
         cVtNgMaJ9xT0Q==
Date:   Sun, 1 Oct 2023 09:18:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/29] xfs: move xfs_xattr_handlers to .rodata
Message-ID: <20231001161850.GB21298@frogsfrogsfrogs>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-27-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-27-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:00:30AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> xfs_xattr_handlers at runtime.
> 
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_xattr.c | 2 +-
>  fs/xfs/xfs_xattr.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 43e5c219aaed..77418bcd6f3a 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -175,7 +175,7 @@ static const struct xattr_handler xfs_xattr_security_handler = {
>  	.set	= xfs_xattr_set,
>  };
>  
> -const struct xattr_handler *xfs_xattr_handlers[] = {
> +const struct xattr_handler * const xfs_xattr_handlers[] = {
>  	&xfs_xattr_user_handler,
>  	&xfs_xattr_trusted_handler,
>  	&xfs_xattr_security_handler,
> diff --git a/fs/xfs/xfs_xattr.h b/fs/xfs/xfs_xattr.h
> index 2b09133b1b9b..cec766cad26c 100644
> --- a/fs/xfs/xfs_xattr.h
> +++ b/fs/xfs/xfs_xattr.h
> @@ -8,6 +8,6 @@
>  
>  int xfs_attr_change(struct xfs_da_args *args);
>  
> -extern const struct xattr_handler *xfs_xattr_handlers[];
> +extern const struct xattr_handler * const xfs_xattr_handlers[];
>  
>  #endif /* __XFS_XATTR_H__ */
> -- 
> 2.34.1
> 
