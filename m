Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B674A010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjGFO4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjGFO4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:56:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A72103;
        Thu,  6 Jul 2023 07:55:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99C6E227FE;
        Thu,  6 Jul 2023 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4J9PR6P98tgMXCjgSTP+PtdPjVIJH4187wdpgfea21I=;
        b=oKxGijcz10FvOId9EpFTHwTZd1479JRd3D2A+/4MlnFctabauLGjdc3TmSU/HkMGxdkhka
        Q+vZyXjxKOAKZbEgBKY+chK9h7wRroA6BZ7QolbEuSpkaUrGtGWSXPr4R2GFQmmNHWxyZ3
        JGoKk3SaDBXix8H6LoGwNhDXHs2ksQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4J9PR6P98tgMXCjgSTP+PtdPjVIJH4187wdpgfea21I=;
        b=c9oURAUsaTHZxQi4jeRyjv47qBROIrEZ/qjUA9qsDyXF2uZt2gtUDXVBmAK/7mCBWP7Hsj
        d8zo+AOc4G1rnzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86DDC138FC;
        Thu,  6 Jul 2023 14:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b2fiINfVpmTBBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:55:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0FC5DA0707; Thu,  6 Jul 2023 16:55:19 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:55:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 86/92] bpf: convert to ctime accessor functions
Message-ID: <20230706145519.mbehr27khkunicgv@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-84-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-84-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:51, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/bpf/inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 4174f76133df..99d0625b6c82 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -118,9 +118,8 @@ static struct inode *bpf_get_inode(struct super_block *sb,
>  		return ERR_PTR(-ENOSPC);
>  
>  	inode->i_ino = get_next_ino();
> -	inode->i_atime = current_time(inode);
> +	inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_mtime = inode->i_atime;
> -	inode->i_ctime = inode->i_atime;
>  
>  	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
>  
> @@ -148,8 +147,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
>  	d_instantiate(dentry, inode);
>  	dget(dentry);
>  
> -	dir->i_mtime = current_time(dir);
> -	dir->i_ctime = dir->i_mtime;
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  }
>  
>  static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
