Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB346E95D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDTNZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDTNZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:25:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297359D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 06:25:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3EAE21B1D;
        Thu, 20 Apr 2023 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681997116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjZJGFYF7RHYIbl0f70AINTNCHrtYqqAEsuq8oLRtSg=;
        b=m952Z1iYkyGa1z5ldO/1O7lE0fRpL2wJ0gF1OlZphN22mbS1kvUu6hOLZz4WCxV2XKVkBV
        TRMhrFbzOqLGAJ9YsFwNFU5UYej7qXoQjYxwpw2QQQuqWkWBFKxcFziln9PhcTJs9dywKd
        U4YdtO3TYGsgLrLqW6venEuwti8JTeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681997116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjZJGFYF7RHYIbl0f70AINTNCHrtYqqAEsuq8oLRtSg=;
        b=5V72OE03NeSp7fR/CAEo2WNo+EZMNcAAV1VE4lw7dinjvKGOktb46pnGEEX8jpI/XU+4Ow
        GPa7NiK+p8kiHBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADADD13584;
        Thu, 20 Apr 2023 13:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hspOKjw9QWT+GAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 13:25:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21051A0744; Thu, 20 Apr 2023 15:25:16 +0200 (CEST)
Date:   Thu, 20 Apr 2023 15:25:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V2 2/6] shmem: make shmem_get_inode() return ERR_PTR
 instead of  NULL
Message-ID: <20230420132516.qbrwe4cuvhckde7b@quack3>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-3-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080359.2551150-3-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-04-23 10:03:55, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Make shmem_get_inode() return ERR_PTR instead of NULL on error. This will be
> useful later when we introduce quota support.
> 
> There should be no functional change.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks good to me except for one problem with ramfs fallback:

> @@ -4209,10 +4228,16 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
>  #define shmem_vm_ops				generic_file_vm_ops
>  #define shmem_anon_vm_ops			generic_file_vm_ops
>  #define shmem_file_operations			ramfs_file_operations
> -#define shmem_get_inode(idmap, sb, dir, mode, dev, flags) ramfs_get_inode(sb, dir, mode, dev)
>  #define shmem_acct_size(flags, size)		0
>  #define shmem_unacct_size(flags, size)		do {} while (0)
>  
> +static inline struct inode *shmem_get_inode(struct mnt_idmap, struct super_block *sb, struct inode *dir,
> +					    umode_t mode, dev_t dev, unsigned long flags)

IMO this won't even compile - "struct mnt_idmap," does not look like valid
C.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
