Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A96B7419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCMKcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCMKcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:32:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902F1CF66;
        Mon, 13 Mar 2023 03:32:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DEB722A3B;
        Mon, 13 Mar 2023 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678703564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHdNtQjCqb3Vt8pNGTQr7HY3gsesOM01FBMwNyxFwks=;
        b=TDFAXWoNCSFC+7ZyGnFGVUf1HEAm0TqX7utOhqoMZuBLF8xETy6TYVXmM9OAkVQLZRkJvv
        2eYx9wD8XXHFZGR2Wmb9Yxq+hvCe/rOItxSiwffPFRFgFBJrdxSbs9qQ2fMrQ42EUPKdBF
        JUU+aEaDYZGsbh7yZV5PqMzmdegikBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678703564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHdNtQjCqb3Vt8pNGTQr7HY3gsesOM01FBMwNyxFwks=;
        b=xvBXW1Sl3GB6cxLigExGWfi9IS4Ne2TE0awxiYTCT8ts8wRxqpCVMwC2debR/zfU56zVEY
        joEUdy0756SHz1BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D1FB139F9;
        Mon, 13 Mar 2023 10:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U2j0Hcz7DmQsQgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 10:32:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 018BCA06FD; Mon, 13 Mar 2023 11:32:43 +0100 (CET)
Date:   Mon, 13 Mar 2023 11:32:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] quota: simplify two-level sysctl registration for
 fs_dqstats_table
Message-ID: <20230313103243.ubn3mw3nkkcdyi5c@quack3>
References: <20230310231206.3952808-1-mcgrof@kernel.org>
 <20230310231206.3952808-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310231206.3952808-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-03-23 15:12:04, Luis Chamberlain wrote:
> There is no need to declare two tables to just create directories,
> this can be easily be done with a prefix path with register_sysctl().
> 
> Simplify this registration.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks. I've taken the patch into my tree.

								Honza

> ---
>  fs/quota/dquot.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index a6357f728034..90cb70c82012 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2948,24 +2948,6 @@ static struct ctl_table fs_dqstats_table[] = {
>  	{ },
>  };
>  
> -static struct ctl_table fs_table[] = {
> -	{
> -		.procname	= "quota",
> -		.mode		= 0555,
> -		.child		= fs_dqstats_table,
> -	},
> -	{ },
> -};
> -
> -static struct ctl_table sys_table[] = {
> -	{
> -		.procname	= "fs",
> -		.mode		= 0555,
> -		.child		= fs_table,
> -	},
> -	{ },
> -};
> -
>  static int __init dquot_init(void)
>  {
>  	int i, ret;
> @@ -2973,7 +2955,7 @@ static int __init dquot_init(void)
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
>  
> -	register_sysctl_table(sys_table);
> +	register_sysctl("fs/quota", fs_dqstats_table);
>  
>  	dquot_cachep = kmem_cache_create("dquot",
>  			sizeof(struct dquot), sizeof(unsigned long) * 4,
> -- 
> 2.39.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
