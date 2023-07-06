Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87BC749A1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGFLAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGFLAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:00:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE169173F;
        Thu,  6 Jul 2023 04:00:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE8AF21C07;
        Thu,  6 Jul 2023 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688641207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tPUniIVIu0FAYmaWLGUdde+evUlDMjdaTm3qSZ/wTE=;
        b=fA38CEOBUbD7/EdBE57owBP6hc4uRNojoyc3zJKyF1n8EUi4Tgju0UNXdMD86z6yqwRP8T
        g4TpGuiXJGbYbKeUdhhuIYDfrqIaZI5HXmLXQugQuh6i8KZsinKy5xDvxAYz40fYT6/b26
        92Oq3AEnKF4Xr2UlauUObS19p+HTxXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688641207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tPUniIVIu0FAYmaWLGUdde+evUlDMjdaTm3qSZ/wTE=;
        b=eF9nF5ZtYckwI5G4yta0AyMW6sbL4N3hAL/HCE5CO3HFu9PVHczKS7CYWQQi+tBDboivGL
        jrdcoAenO/kf4TCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95014138EE;
        Thu,  6 Jul 2023 11:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SkNVJLeepmQcCAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 11:00:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 11265A0707; Thu,  6 Jul 2023 13:00:07 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:00:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
Message-ID: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-37-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-37-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:04, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Just one nit below:

> @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		vi->chunkbits = sb->s_blocksize_bits +
>  			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>  	}
> -	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
> -	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
> -	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
> -	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
> +	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
> +	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
> +	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
> +	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;

Isn't this just longer way to write:

	inode->i_atime = inode->i_mtime = inode_get_ctime(inode);

?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
