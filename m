Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475376D93EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjDFK0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjDFK0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC21713;
        Thu,  6 Apr 2023 03:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5DB3642B5;
        Thu,  6 Apr 2023 10:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB72C433D2;
        Thu,  6 Apr 2023 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680776779;
        bh=yVOn8o+5hTtwRbr8XWL47ZWTuN1kQFTfBsh5tqfXXsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWYNS0Io9NTLz6QIIXU25HZjd2/sgvoDoIrhLx/Yz50kimlZLKl7PXdLTeRCF0E+F
         TTLD39rqPrNIE5+pZd8q1vXeULBayb9zSJbktxLOl/65+bAcfLNlTCkGBqHMrJaMwc
         KUc7zYbWYouSEJKxP5Sh2yWpPuLjnyRRJ30d4suhCC/CiMiHFAynVIIVf/UUWWPQ4i
         XYBdhcocsdcpgZGnu2YYh3FhbABlkQX3a/UxiH+1AAtce8afGlPO/ekJSSfOYld9Ml
         S8giSIw0VqfkGjV9gnpZf0KtdAdBVHyXkut8KomvYWM1D2yX/s9riOcAWU7ALSjpkP
         lg0/Q0/5zKwQw==
Date:   Thu, 6 Apr 2023 12:26:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230406-diffamieren-langhaarig-87511897e77d@brauner>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405171449.4064321-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
> Overlayfs fails to notify IMA / EVM about file content modifications
> and therefore IMA-appraised files may execute even though their file
> signature does not validate against the changed hash of the file
> anymore. To resolve this issue, add a call to integrity_notify_change()
> to the ovl_release() function to notify the integrity subsystem about
> file changes. The set flag triggers the re-evaluation of the file by
> IMA / EVM once the file is accessed again.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/file.c       |  4 ++++
>  include/linux/integrity.h |  6 ++++++
>  security/integrity/iint.c | 13 +++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 6011f955436b..19b8f4bcc18c 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -13,6 +13,7 @@
>  #include <linux/security.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/integrity.h>
>  #include "overlayfs.h"
>  
>  struct ovl_aio_req {
> @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>  
>  static int ovl_release(struct inode *inode, struct file *file)
>  {
> +	if (file->f_flags & O_ACCMODE)
> +		integrity_notify_change(inode);
> +
>  	fput(file->private_data);
>  
>  	return 0;
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2ea0f2f65ab6..cefdeccc1619 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -23,6 +23,7 @@ enum integrity_status {
>  #ifdef CONFIG_INTEGRITY
>  extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
>  extern void integrity_inode_free(struct inode *inode);
> +extern void integrity_notify_change(struct inode *inode);

I thought we concluded that ima is going to move into the security hook
infrastructure so it seems this should be a proper LSM hook?
