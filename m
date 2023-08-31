Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36D78EB25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbjHaKy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHaKy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:54:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F73CDD;
        Thu, 31 Aug 2023 03:54:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0353211CE;
        Thu, 31 Aug 2023 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693479290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zL35cb2cbV/aZEdQfn5WUt1+RtMwa4sJY7cweJYRIBQ=;
        b=edp5Bjn8Z/6zG+gYXBdCnRvbC4HD5N/O0EKP02n7t3b9RcPVKGOl1OFGVEna53xLsxmoji
        vVCWALCyuerTDA5pvRjsb+NIVVycF1r7cGN8oKE2NQvWeN1wf2Bcn3ghno43tPaO57qk5o
        QyGgmY+yUyEU6zYZzBAXthHSUPZWUvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693479290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zL35cb2cbV/aZEdQfn5WUt1+RtMwa4sJY7cweJYRIBQ=;
        b=jbh3cgZbamSfqw/PIFNRYiceCvoDRdbiH5jaNR7REh3SJ48G5gz1nrx9ltgsrJuaIOmteQ
        z2v7wmOylMLnwWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E135A13583;
        Thu, 31 Aug 2023 10:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tmb7Nnpx8GQaSQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 31 Aug 2023 10:54:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 561C0A0767; Thu, 31 Aug 2023 12:54:50 +0200 (CEST)
Date:   Thu, 31 Aug 2023 12:54:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     brauner@kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, jack@suse.cz, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: switch back to using kill_anon_super
Message-ID: <20230831105450.sdwtqnxp5vwmq5ej@quack3>
References: <20230831052940.256193-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831052940.256193-1-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-08-23 07:29:40, Christoph Hellwig wrote:
> NFS switch to open coding kill_anon_super in 7b14a213890a
> ("nfs: don't call bdi_unregister") to avoid the extra bdi_unregister
> call.  At that point bdi_destroy was called in nfs_free_server and
> thus it required a later freeing of the anon dev_t.  But since
> 0db10944a76b ("nfs: Convert to separately allocated bdi") the bdi has
> been free implicitly by the sb destruction, so this isn't needed
> anymore.
> 
> By not open coding kill_anon_super, nfs now inherits the fix in
> dc3216b14160 ("super: ensure valid info"), and we remove the only
> open coded version of kill_anon_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfs/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 2284f749d89246..0d6473cb00cb3e 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1339,15 +1339,13 @@ int nfs_get_tree_common(struct fs_context *fc)
>  void nfs_kill_super(struct super_block *s)
>  {
>  	struct nfs_server *server = NFS_SB(s);
> -	dev_t dev = s->s_dev;
>  
>  	nfs_sysfs_move_sb_to_server(server);
> -	generic_shutdown_super(s);
> +	kill_anon_super(s);
>  
>  	nfs_fscache_release_super_cookie(s);
>  
>  	nfs_free_server(server);
> -	free_anon_bdev(dev);
>  }
>  EXPORT_SYMBOL_GPL(nfs_kill_super);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
