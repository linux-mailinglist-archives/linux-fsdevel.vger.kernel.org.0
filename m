Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E20544730
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiFIJSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiFIJSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:18:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F91AF0E;
        Thu,  9 Jun 2022 02:18:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 897FE21DD8;
        Thu,  9 Jun 2022 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654766319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HayFit8bzwaDzpMDwYah/6SiOyQ4+BuRvDiuto6PjDE=;
        b=J3GHj6NgeZC2l6CCYS42pH1ur4gz/kZ8MjGwuv4MbjKYXuPXxJ+9p2sVq8TpFihaL3ga3L
        OiWYpUIDPFjIZgZ9CnMwU2mlrRW3/WMDJfS2SqBYd9qIWY6OST8injns6Do0hW5LlP8Sp/
        haVizaclvKA0L+81Pw2138qaN9TGJvI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 351742C142;
        Thu,  9 Jun 2022 09:18:39 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:18:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <YqG67sox6L64E6wV@dhcp22.suse.cz>
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531100007.174649-4-christian.koenig@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 31-05-22 11:59:57, Christian König wrote:
> This gives the OOM killer an additional hint which processes are
> referencing shmem files with potentially no other accounting for them.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  mm/shmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4b2fea33158e..a4ad92a16968 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>  	return inflated_addr;
>  }
>  
> +static long shmem_oom_badness(struct file *file)
> +{
> +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
> +}

This doesn't really represent the in memory size of the file, does it?
Also the memcg oom handling could be considerably skewed if the file was
shared between more memcgs.

-- 
Michal Hocko
SUSE Labs
