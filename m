Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0738739416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFVAs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVAsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3271997;
        Wed, 21 Jun 2023 17:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDE76171F;
        Thu, 22 Jun 2023 00:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FD4C433C8;
        Thu, 22 Jun 2023 00:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687394903;
        bh=Bl7XRetwBpjJVy/aHPO0vt7E8lsSma1FzCd6OcpO2p8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GfmvJ/ZAcNSa9DltdNwubGT3N8f7to5gGqKVO4PmFDFhazY3fVXSiqZhlp21WKGdc
         HQFcDnN9Da7Ui70do729LK2NblrnURr6pwnKE5zmVld8afltWDtMeUofqWVK3u6Q1a
         QewJ4W0lj5CsiJ6Mw/wUc+BEuZwsrUlkSTOPAXPke7duVM5j3KGrpRUwUgYuZHkL9W
         2VdGEN9fPLWh0xgoDIt1wo0Qu+88MArmB5YAsrH7l8uI7BXwEiUe4crLsausSo9xbT
         z/+ITR28vKSlt2PN/yYbt7Rp+WaSAFhl+qDEVF9JOnRZsMPycGceoy5qZCIPymeyz8
         h6ux8BJiiStcA==
Message-ID: <52614749-cbc9-b526-4241-75d553069b61@kernel.org>
Date:   Thu, 22 Jun 2023 09:48:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 71/79] zonefs: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-70-jlayton@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230621144735.55953-70-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 23:46, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Modulo the proposed renaming for inode_ctime_peek(), looks good.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  fs/zonefs/super.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index bbe44a26a8e5..75be0e039ccf 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -658,7 +658,8 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
>  
>  	inode->i_ino = ino;
>  	inode->i_mode = z->z_mode;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
> +	inode->i_mtime = inode->i_atime = inode_ctime_peek(dir);
> +	inode_ctime_set(inode, inode->i_mtime);
>  	inode->i_uid = z->z_uid;
>  	inode->i_gid = z->z_gid;
>  	inode->i_size = z->z_wpoffset;
> @@ -694,7 +695,8 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
>  	inode->i_ino = ino;
>  	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
>  	inode->i_size = sbi->s_zgroup[ztype].g_nr_zones;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = root->i_ctime;
> +	inode->i_mtime = inode->i_atime = inode_ctime_peek(root);
> +	inode_ctime_set(inode, inode->i_mtime);
>  	inode->i_private = &sbi->s_zgroup[ztype];
>  	set_nlink(inode, 2);
>  
> @@ -1317,7 +1319,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	inode->i_ino = bdev_nr_zones(sb->s_bdev);
>  	inode->i_mode = S_IFDIR | 0555;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_op = &zonefs_dir_inode_operations;
>  	inode->i_fop = &zonefs_dir_operations;
>  	inode->i_size = 2;

-- 
Damien Le Moal
Western Digital Research

