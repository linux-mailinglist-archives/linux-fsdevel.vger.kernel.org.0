Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBED749E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGFOEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGFOEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:04:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FD1BF1;
        Thu,  6 Jul 2023 07:04:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73C251F747;
        Thu,  6 Jul 2023 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qF3r7ZCXvyEQaIO2Sg31RgIhGOHRT4CqczrYU/gCN0=;
        b=VVOpC/qHhhfNTu4ZaI5F/TjyNn0jwWNmSbhTe36hRHwaYZxJMFghvA/0phe5gmB7wP28W6
        0ojbfzB/GOECQSTYKTxd7QY5UaG10ZBg+k35Wq9wj1ZMO6fFjlVKXrFVMIhEwK+D3QA7Vd
        QxecqghoLE/0G75qSZpVog2jVIFhCgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qF3r7ZCXvyEQaIO2Sg31RgIhGOHRT4CqczrYU/gCN0=;
        b=zNU7NEP5DRAqmW7gE4hWdzs7WGlIQN3wpDueOhVXoAuzgLTjGDuSdA7cdK2u1dWTP03Ebh
        ozKzdsrGP/l+fwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67333138EE;
        Thu,  6 Jul 2023 14:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXsuGenJpmShaQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:04:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0561BA0707; Thu,  6 Jul 2023 16:04:25 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:04:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 73/92] romfs: convert to ctime accessor functions
Message-ID: <20230706140424.k54br7bc3ylyxgt7@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-71-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-71-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:38, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index c59b230d55b4..961b9d342e0e 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -322,8 +322,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
>  
>  	set_nlink(i, 1);		/* Hard to decide.. */
>  	i->i_size = be32_to_cpu(ri.size);
> -	i->i_mtime.tv_sec = i->i_atime.tv_sec = i->i_ctime.tv_sec = 0;
> -	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = i->i_ctime.tv_nsec = 0;
> +	i->i_mtime.tv_sec = i->i_atime.tv_sec = inode_set_ctime(i, 0, 0).tv_sec;
> +	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = 0;

The usual simplification:

	i->i_mtime = i->i_atime = inode_set_ctime(i, 0, 0);

								Honza
  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
