Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F24EB03D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiC2P0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiC2P0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:26:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08D6A01B
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 08:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F981B8181F
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F82CC340ED;
        Tue, 29 Mar 2022 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648567482;
        bh=dF0Y16rVu0vCh3giQKq4XhhQxnMZTfuNm9Jq6adLHf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sPc7jsm5k8STWQt6krljiXvATbNcPIg0YYSXvxTIfaSdETBXWkb8t++1dB8lH/+o2
         T6x2abhA1d5swaxeq68mCrzvkdcq8iIcM32XQgM6w1mAhPSFJnOAhcClFWOxYte19f
         kgHbmT5ld1LoNpvCs7WLDX872AsYv0/9CZiA1ygtcgkRIo2MJYe+mM19dXPHxGjS7C
         SvpL/PGeELxrAZ2vl1Dk8F4DJyUWmOnt88yL4Nf5T+p+4s2QRPZYTiCrZrxIZLcQT1
         rsN8pxuQQ6HCqPUWoM8SsfwCsT9Myrs2M11uWcQCFQUZL4ploUc1952DqaSEOH2kD0
         /6OuIVhEa1TMg==
Message-ID: <7611e896d3120d5f8c2b579d32590f26080622c5.camel@kernel.org>
Subject: Re: [PATCH] fs/dcache: use lockdep assertion instead of warn
 try_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Date:   Tue, 29 Mar 2022 11:24:40 -0400
In-Reply-To: <20220325190001.1832-1-dossche.niels@gmail.com>
References: <20220325190001.1832-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-03-25 at 20:00 +0100, Niels Dossche wrote:
> Currently, there is a fallback with a WARN that uses down_read_trylock
> as a safety measure for when there is no lock taken. The current
> callsites expect a write lock to be taken. Moreover, the s_root field
> is written to, which is not allowed under a read lock.
> This code safety fallback should not be executed unless there is an
> issue somewhere else.
> Using a lockdep assertion better communicates the intent of the code,
> and gets rid of the currently slightly wrong fallback solution.
> 
> Note:
> I am currently working on a static analyser to detect missing locks
> using type-based static analysis as my master's thesis
> in order to obtain my master's degree.
> If you would like to have more details, please let me know.
> This was a reported case. I manually verified the report by looking
> at the code, so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created
> this patch. I have both compile-tested this patch and runtime-tested
> this patch on x86_64. The effect on a running system could be a
> potential race condition in exceptional cases.
> This issue was found on Linux v5.17.
> 
> Fixes: c636ebdb186bf ("VFS: Destroy the dentries contributed by a superblock on unmounting")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c84269c6e8bf..0142f15340e5 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1692,7 +1692,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
>  {
>  	struct dentry *dentry;
>  
> -	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
> +	lockdep_assert_held_write(&sb->s_umount);
>  
>  	dentry = sb->s_root;
>  	sb->s_root = NULL;

Much nicer.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
