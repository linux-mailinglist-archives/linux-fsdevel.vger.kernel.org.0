Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25F278EEC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjHaNkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjHaNkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:40:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835671A4;
        Thu, 31 Aug 2023 06:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 157E6B8228D;
        Thu, 31 Aug 2023 13:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052C4C433C7;
        Thu, 31 Aug 2023 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693489240;
        bh=4JRkZ6xeVrwNQByBL+sZtpkgHgPCANvaaxggRH7SGs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXSkUxxTZnAcUmXxZr3KjSYTztykhMF8C8VPCFIGjfyhDtoHYo/EQDXPt7DAlDALq
         gPqAHYWlB3vvOtd6YtwdmExyY2aIUwyk8zIsGPnbrLjKY1pY34+ykMeDB0EmoxiTXx
         9E6IOijIw7GeTXw8imHsU6VoynkTBV8rucIyBFayV5JiUtV9+wzuw5r1XFxVG3HcIf
         lZq4hf/2qynnvEvhVm9WU9LlGCSHhQURaVKiiTblu0ThRR+a5ipOD2+aQX0uSQL7HW
         WmIsl+mi21R6n+sgSmZEhJZ7Z1r1Y3drVzOeLYVCvkIqEtTco7H9zJraQGkWkOL+WB
         jSUFHd/qSRnPA==
Date:   Thu, 31 Aug 2023 15:40:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Message-ID: <20230831-letzlich-eruption-9187c3adaca6@brauner>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230831112431.2998368-2-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831112431.2998368-2-bschubert@ddn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:24:30PM +0200, Bernd Schubert wrote:
> File systems want to hold a shared lock for DIO writes,
> but may need to drop file priveliges - that a requires an
> exclusive lock. The new export function file_needs_remove_privs()
> is added in order to first check if that is needed.
> 
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/inode.c         | 8 ++++++++
>  include/linux/fs.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 67611a360031..9b05db602e41 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2013,6 +2013,14 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
>  	return mask;
>  }
>  
> +int file_needs_remove_privs(struct file *file)
> +{
> +	struct dentry *dentry = file_dentry(file);
> +
> +	return dentry_needs_remove_privs(file_mnt_idmap(file), dentry);

Ugh, I wanted to propose to get rid of this dentry dance but I propsed
that before and remembered it's because of __vfs_getxattr() which is
called from the capability security hook that we need it...
