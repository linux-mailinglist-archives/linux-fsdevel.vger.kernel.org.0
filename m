Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76564D6373
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349356AbiCKO3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349357AbiCKO3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:29:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A3EBAD8;
        Fri, 11 Mar 2022 06:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8180D61D26;
        Fri, 11 Mar 2022 14:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943FEC340ED;
        Fri, 11 Mar 2022 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647008921;
        bh=cO1eBzH5OeqNR85TvokiRryL4AesQYFxlNxwm0QbXjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esKsBn4gL8quPEA6a9YOTXcr0Tf5kokuai9tIPhxZjsFoVzb4gTy+gOfqHZVKR+0+
         52pEC7qPU9ghPQnP5J9zDrH9IxVgoARqZ5vHq5C8OOym+KCz4NYAYmVOhl0fXiaOga
         023SVcQPEUpOboHHbmtw0xwK7BL3Mlu5VzE/+3mAdWSXtpgv8+vV3AKF3dCdkpGdxJ
         zUymhC6hfftsPwLLKy34cF+rO0Eg/Rd82TWTBe5+l0GidEpA/oiFssOIBCB+2O1Di6
         CHIGSPkynFq45jNE17tcG8oevTxcvb2xG2h58meIPO8766GGyR9IttnIIRIiQWxJiI
         VnWxQ4LnDJ4DQ==
Date:   Fri, 11 Mar 2022 14:28:38 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH 3/4] fs: add check functions for
 sb_start_{write,pagefault,intwrite}
Message-ID: <YitclpgTvXZ6lkf7@debian9.Home>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <407d74293ca164d44eb419d34c2365795e27c02f.1646983176.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407d74293ca164d44eb419d34c2365795e27c02f.1646983176.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:38:04PM +0900, Naohiro Aota wrote:
> Add a function sb_write_started() to return if sb_start_write() is
> properly called. It is used in the next commit.
> 
> Also, add the similar functions for sb_start_pagefault() and
> sb_start_intwrite().
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  include/linux/fs.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 27746a3da8fd..0c8714d64169 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>  #define __sb_writers_release(sb, lev)	\
>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>  
> +static inline bool __sb_write_started(struct super_block *sb, int level)
> +{
> +	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> +}
> +
>  /**
>   * sb_end_write - drop write access to a superblock
>   * @sb: the super we wrote to
> @@ -1797,6 +1802,11 @@ static inline bool sb_start_write_trylock(struct super_block *sb)
>  	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
>  }
>  
> +static inline bool sb_write_started(struct super_block *sb)
> +{
> +	return __sb_write_started(sb, SB_FREEZE_WRITE);
> +}
> +
>  /**
>   * sb_start_pagefault - get write access to a superblock from a page fault
>   * @sb: the super we write to
> @@ -1821,6 +1831,11 @@ static inline void sb_start_pagefault(struct super_block *sb)
>  	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
>  }
>  
> +static inline bool sb_pagefault_started(struct super_block *sb)
> +{
> +	return __sb_write_started(sb, SB_FREEZE_PAGEFAULT);
> +}
> +
>  /**
>   * sb_start_intwrite - get write access to a superblock for internal fs purposes
>   * @sb: the super we write to
> @@ -1844,6 +1859,11 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
>  	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
>  }
>  
> +static inline bool sb_intwrite_started(struct super_block *sb)
> +{
> +	return __sb_write_started(sb, SB_FREEZE_FS);
> +}
> +
>  bool inode_owner_or_capable(struct user_namespace *mnt_userns,
>  			    const struct inode *inode);
>  
> -- 
> 2.35.1
> 
