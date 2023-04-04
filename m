Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221596D5E81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjDDLCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjDDLCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:02:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED52D61
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 04:00:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7544821CFB;
        Tue,  4 Apr 2023 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680605961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ThcWicpsGQ2RnXyb8yTGtCo3F4UO6chUrSx4AOuifuM=;
        b=oCGwxlo6rB4Xd011auZfMe9W2ldBs52wNCVR46MLknoHYu6yK6PVBZmHSFdE7b9ULneTFz
        tbLfuWhkX/lZGuXHY96oRMYPHLpqrABdygoT7u3IC5WMEaiNX7f2TdWHoNb8d9nyvyOiZO
        173fUz8x4y2/bXakgYsDB5f414qbWPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680605961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ThcWicpsGQ2RnXyb8yTGtCo3F4UO6chUrSx4AOuifuM=;
        b=/+iRrkz4cXi8dzS8sX/2tjFr/isUILBLFqy0Ma5UGi/4A3FKwxBDWmiQl81g6q1g2F++G8
        8fhsPS3cjH52TuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67D8913920;
        Tue,  4 Apr 2023 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9DRXGQkDLGSobQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Apr 2023 10:59:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3CD9A0732; Tue,  4 Apr 2023 12:59:20 +0200 (CEST)
Date:   Tue, 4 Apr 2023 12:59:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/6] shmem: make shmem_inode_acct_block() return error
Message-ID: <20230404105920.nlrxopw3zdwoa5su@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-2-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-2-cem@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 10:47:54, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Make shmem_inode_acct_block() return proper error code instead of bool.
> This will be useful later when we introduce quota support.
> 
> There should be no functional change.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks good to me, except one minor nit.

> @@ -1589,7 +1590,8 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
>  		huge = false;
>  	nr = huge ? HPAGE_PMD_NR : 1;
>  
> -	if (!shmem_inode_acct_block(inode, nr))
> +	err = shmem_inode_acct_block(inode, nr);
> +	if (err)
>  		goto failed;
>  
>  	if (huge)

The initialization of 'err' in this function is unused now so it can be
dropped.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
