Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B378EE58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjHaNQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjHaNQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:16:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB906CF3;
        Thu, 31 Aug 2023 06:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA7BB81ECB;
        Thu, 31 Aug 2023 13:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27976C433CA;
        Thu, 31 Aug 2023 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693487810;
        bh=d1fJKZlZpzlaUvqOOVaeb3XKMrIsl7c/38vb98JqSsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5CdLt7D5ED8lzhaF1H33s42a6UKLDavI+5HZBTS8BUcKzZBsi0hp3t5GAYkpV5Wu
         xoo4PZ3FbTPdVeI5tu/+Okhb2xk2iqrAVfYKBr8UJ+gqQc+vuc+8U7Mem/LPFC3852
         qOELUCRMffSl4ZMRhqwzL23WJpWGDJAPgFRHJcdwEXbX2+kb/RD2KH+3RKu7ERFzj3
         karSDlDU2s6UPXGabo48VFeuc2MtI1hW7DG4MZk2ykC2/bwBpkvCQ1aRcbPkdd1/AW
         9kuQaaOKMDQa1ttDHH+Q1VFuYzBTg8PFMNRC7pWEKqxzeK151KxktrBdLNy3yAmrmk
         j5044V9E65ubw==
Date:   Thu, 31 Aug 2023 15:16:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Message-ID: <20230831-ampel-reproduktion-db8d1951a3c5@brauner>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230831112431.2998368-2-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831112431.2998368-2-bschubert@ddn.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:24:30PM +0200, Bernd Schubert wrote:
> File systems want to hold a shared lock for DIO writes,
> but may need to drop file priveliges - that a requires an

s/priveliges/privileges/
s/that a requires/that requires/

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
> +}
> +EXPORT_SYMBOL_GPL(file_needs_remove_privs);
> +
>  static int __remove_privs(struct mnt_idmap *idmap,
>  			  struct dentry *dentry, int kill)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 562f2623c9c9..9245f0de00bc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2721,6 +2721,7 @@ extern struct inode *new_inode_pseudo(struct super_block *sb);
>  extern struct inode *new_inode(struct super_block *sb);
>  extern void free_inode_nonrcu(struct inode *inode);
>  extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
> +int file_needs_remove_privs(struct file *);
>  extern int file_remove_privs(struct file *);
>  int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>  			     const struct inode *inode);
> -- 
> 2.39.2
> 
