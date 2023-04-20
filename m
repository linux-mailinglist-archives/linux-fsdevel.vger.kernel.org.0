Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A046E95FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDTNkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDTNku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A824EEC
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 06:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D78964592
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CDC433EF;
        Thu, 20 Apr 2023 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681998047;
        bh=MRxKldcFY1ijDw5IIxD43bDbNia8QfxPMVwcnt0mZE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPNsC5mpAU9aE2iVewuFg3mhrJ03+acrucvtsKYnCZ3IhroTpHi5MnXqyums554kh
         cTxH+B8m/cOVxnU5+thFqPoPdylJOCCNkVdVPISXrXQL+kJ17oxzTiEAt4otLxpWIL
         KEwWLmvbinTuKUwfvgaKJRTXEEjAV8wL9/av13n2Hm2YGu55tgbAItMu7qpcmCapXt
         Zk9fyXmCPWHAexpCeabMNHyQIDY70nbk2pyqTSN2d2jBlHc4tRlnsZm/i8lG8/k8oJ
         9F5QZowQDK53czLgYqN7nLul6iiht3NyAThCm1VFIi+z1bgDV/nfWx/jwEKrlxA8Bh
         T9zqDUg+kHFIg==
Date:   Thu, 20 Apr 2023 15:40:43 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V2 2/6] shmem: make shmem_get_inode() return ERR_PTR
 instead of  NULL
Message-ID: <20230420134043.25rxcb4du4wm6h2f@andromeda>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-3-cem@kernel.org>
 <eatHY580dDdZyhTX6D7239i-1UISBkQ4lo201zzsUtKiwMIkUmqVmCmWReJ3D0ywmeaoovolq1R_og-5Kw9g0A==@protonmail.internalid>
 <20230420132516.qbrwe4cuvhckde7b@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420132516.qbrwe4cuvhckde7b@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 03:25:16PM +0200, Jan Kara wrote:
> On Thu 20-04-23 10:03:55, cem@kernel.org wrote:
> > From: Lukas Czerner <lczerner@redhat.com>
> >
> > Make shmem_get_inode() return ERR_PTR instead of NULL on error. This will be
> > useful later when we introduce quota support.
> >
> > There should be no functional change.
> >
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Looks good to me except for one problem with ramfs fallback:
> 
> > @@ -4209,10 +4228,16 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
> >  #define shmem_vm_ops				generic_file_vm_ops
> >  #define shmem_anon_vm_ops			generic_file_vm_ops
> >  #define shmem_file_operations			ramfs_file_operations
> > -#define shmem_get_inode(idmap, sb, dir, mode, dev, flags) ramfs_get_inode(sb, dir, mode, dev)
> >  #define shmem_acct_size(flags, size)		0
> >  #define shmem_unacct_size(flags, size)		do {} while (0)
> >
> > +static inline struct inode *shmem_get_inode(struct mnt_idmap, struct super_block *sb, struct inode *dir,
> > +					    umode_t mode, dev_t dev, unsigned long flags)
> 
> IMO this won't even compile - "struct mnt_idmap," does not look like valid
> C.

True, I totally overlooked at it as I've been testing with/without TMPFS_QUOTA
and QUOTA, I totally forgot to disable CONFIG_SHMEM for testing.
I'll update it on a next version once we get a few eyes on it.

Thanks for spotting it Honza!

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
