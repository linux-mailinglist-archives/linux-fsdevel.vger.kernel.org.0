Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60C73510C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjFSJ46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFSJ4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:56:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CA12F;
        Mon, 19 Jun 2023 02:56:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8DE51F45A;
        Mon, 19 Jun 2023 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687168589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQVAvWxLe8ddOnT0x92jyszEXcQ2Ez0WGCSpMTarvf8=;
        b=O7ivCX7C1pmL0yBAJe7Ne+Y+kth455ZJUYF10UMTbSbKG39ENlmViLSrEC1BGNn2VxTtMc
        3CRtP2k1YSIlYIVybmbfACDfVqq4ifeSNuarWY2bERzoWseJBGvX4b/BH4FHxoL7kcshex
        vMQP+ioZCg5BLuPhPVBDJESP+ixptYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687168589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQVAvWxLe8ddOnT0x92jyszEXcQ2Ez0WGCSpMTarvf8=;
        b=yVCXTvzoVEmetaKWn5zm+QI1WM708Q/50rB5VjHCe1WHoS6NF1tvR9p7MyqanZqNB4z/dn
        GVYPWKjBPL19cvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D3FE138E8;
        Mon, 19 Jun 2023 09:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Q9gJk0mkGT2NgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Jun 2023 09:56:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 45982A0755; Mon, 19 Jun 2023 11:56:29 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:56:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v1 4/5] fs/ocfs2: No need to check return value of
 block_commit_write()
Message-ID: <20230619095629.qicy2guryvryc7el@quack3>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
 <20230618213250.694110-5-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618213250.694110-5-beanhuo@iokpp.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 18-06-23 23:32:49, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Remove unnecessary check on the return value of block_commit_write().
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/file.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..39d8dbb26bb3 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -808,12 +808,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
>  
>  
>  		/* must not update i_size! */
> -		ret = block_commit_write(page, block_start + 1,
> -					 block_start + 1);
> -		if (ret < 0)
> -			mlog_errno(ret);
> -		else
> -			ret = 0;
> +		block_commit_write(page, block_start + 1, block_start + 1);
>  	}
>  
>  	/*
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
