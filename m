Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6F74999A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGFKlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:41:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF3171A;
        Thu,  6 Jul 2023 03:41:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 809E92039C;
        Thu,  6 Jul 2023 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFDOykfedKgFhlqR22HMMVD2pfNBZ1bhgYlbvr0wgR4=;
        b=OLQ+joYitJw2RRY4o5s236BotMqjCy2oj0QQ9Fv7GXLBmDXy12926yP+WQi2wX+VtdbwuK
        f+/jBjzhx/W9l6HqhDHMukZHW57kPXeB7nUimdltyXo7QvafTY5TAL5Y6ld01GON42TkZv
        hdKTqITJjgKN3l8nzwIQH33PNGU+mBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFDOykfedKgFhlqR22HMMVD2pfNBZ1bhgYlbvr0wgR4=;
        b=TJWH/UFh/gg7KbolCtBkuy9nF2QwoTkXbwZdKm09R9vnFMB5OT2XJIRLNmF6dYhmGrLB2z
        2TO3XhehGVDLwQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7448C138EE;
        Thu,  6 Jul 2023 10:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5V/HGyapmSQfAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:41:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 049ABA0707; Thu,  6 Jul 2023 12:41:48 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:41:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/92] ibm: convert to ctime accessor functions
Message-ID: <20230706104147.xtaqzmdvcxz7bg43@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-17-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-17-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:44, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  drivers/misc/ibmasm/ibmasmfs.c | 2 +-
>  drivers/misc/ibmvmc.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
> index 35fec1bf1b3d..5867af9f592c 100644
> --- a/drivers/misc/ibmasm/ibmasmfs.c
> +++ b/drivers/misc/ibmasm/ibmasmfs.c
> @@ -139,7 +139,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
>  	if (ret) {
>  		ret->i_ino = get_next_ino();
>  		ret->i_mode = mode;
> -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
>  	}
>  	return ret;
>  }
> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index d7c7f0305257..2101eb12bcba 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -1124,7 +1124,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
>  		goto out;
>  
>  	inode = file_inode(file);
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
