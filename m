Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9B4DC161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiCQIfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiCQIfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:35:39 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F48A147AFA;
        Thu, 17 Mar 2022 01:34:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C29F310E4B5B;
        Thu, 17 Mar 2022 19:34:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nUlaO-006Tqn-0l; Thu, 17 Mar 2022 19:34:20 +1100
Date:   Thu, 17 Mar 2022 19:34:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 3/4] fs: add check functions for
 sb_start_{write,pagefault,intwrite}
Message-ID: <20220317083420.GA1544202@dread.disaster.area>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <0737603ecc6baf785843d6e91992e6ef202c308c.1647436353.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0737603ecc6baf785843d6e91992e6ef202c308c.1647436353.git.naohiro.aota@wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6232f28d
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=iox4zFpeAAAA:8 a=JF9118EUAAAA:8
        a=7-415B0cAAAA:8 a=zkEiViQQ1w_MH5clXOgA:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=xVlTc564ipvMDusKsbsT:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:22:39PM +0900, Naohiro Aota wrote:
> Add a function sb_write_started() to return if sb_start_write() is
> properly called. It is used in the next commit.
> 
> Also, add the similar functions for sb_start_pagefault() and
> sb_start_intwrite().
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
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

We should not be adding completely unused code to the VFS APIs.

Just rename __sb_write_started() to sb_write_started() and pass
SB_FREEZE_WRITE directly from the single debug assert that you've
added that needs this check.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
