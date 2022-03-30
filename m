Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E34EBC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiC3IQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbiC3IP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:15:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72606D98;
        Wed, 30 Mar 2022 01:14:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 053471F7AB;
        Wed, 30 Mar 2022 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648628050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsTxg5YKPlAg6VXpLB31OEo9MwL2KGmC4FzYa308hZk=;
        b=hzwvvkDki5KwoetwuQRi0rywJyiFhyM18kSRZMzCZBKyUz2K456VNhk+yBnO78pFslW7/P
        WC6/n08+qIDET4hEPsOWvDmyriE+TaLQQHMjat+j4u6JHFq/UWTdx8o2W1hQ4zl/hjnAnK
        abeN9n5DO47U07XmEKcja7JX7O7UplU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648628050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsTxg5YKPlAg6VXpLB31OEo9MwL2KGmC4FzYa308hZk=;
        b=aPuNyrr41TxJwLJ0dr9V88MYccDJLhjKBtaKEaP4yVFW3rBHf9e5zQqkfTYf8Xh67QLg6E
        lLqmS9Jja61xmiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEA2213AF3;
        Wed, 30 Mar 2022 08:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QfzsMFERRGLCOQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 30 Mar 2022 08:14:09 +0000
Date:   Wed, 30 Mar 2022 10:14:08 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "NeilBrown" <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS: filename_create(): fix incorrect intent.
Message-ID: <20220330101408.2bbb47ee@suse.de>
In-Reply-To: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
References: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Neil,

I gave this a spin and was wondering why xfstests wouldn't start with
this change...

On Mon, 28 Mar 2022 11:56:48 +1100, NeilBrown wrote:
...
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..3ffb42e56a8e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3676,7 +3676,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	int type;
>  	int err2;
>  	int error;
> -	bool is_dir = (lookup_flags & LOOKUP_DIRECTORY);
>  
>  	/*
>  	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
> @@ -3698,9 +3697,11 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	/* don't fail immediately if it's r/o, at least try to report other errors */
>  	err2 = mnt_want_write(path->mnt);
>  	/*
> -	 * Do the final lookup.
> +	 * Do the final lookup.  Request 'create' only if there is no trailing
> +	 * '/', or if directory is requested.
>  	 */
> -	lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
> +	if (!last.name[last.len] || (lookup_flags & LOOKUP_DIRECTORY))
> +		lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;

This doesn't look right, as any LOOKUP_DIRECTORY flag gets dropped via
the prior "lookup_flags &= LOOKUP_REVAL;".

Cheers, David
