Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94359546A47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbiFJQVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJQVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:21:34 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9B3A3903;
        Fri, 10 Jun 2022 09:21:31 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 911C91D99;
        Fri, 10 Jun 2022 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654878049;
        bh=ioFgM6y+XdcF78saLPERgD1M4sbpP2D6QZPHFDZ9vvM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Jvmkrgx162jlNF4axBM0VM7hdMFogDadVe78W2/U6nIUULF1a9PVKdVlVLRfieBO+
         MrGGkX1zIh/bk8yx4gXZqT2uR0SLgJBZJLkDo2DoHMc09sB4k769MJZwWDNZOOYTH3
         CCi7I0BhjvNaL11AOtTwvTxmU/3bfF5FTnik8wRM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 10 Jun 2022 19:21:29 +0300
Message-ID: <01e2f814-1fcf-bc0c-b580-e3879eda85b6@paragon-software.com>
Date:   Fri, 10 Jun 2022 19:21:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fs/ntfs3: Don't clear upper bits accidentally in
 log_replay()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <YnjY58EpRzaZP+YC@kili>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <YnjY58EpRzaZP+YC@kili>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/9/22 12:03, Dan Carpenter wrote:
> The "vcn" variable is a 64 bit.  The "log->clst_per_page" variable is a
> u32.  This means that the mask accidentally clears out the high 32 bits
> when it was only supposed to clear some low bits.  Fix this by adding a
> cast to u64.
> 
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Why am I getting new Smatch warnings in old ntfs3 code?  It is a mystery.
> 
>   fs/ntfs3/fslog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 915f42cf07bc..0da339fda2f4 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -5057,7 +5057,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>   		goto add_allocated_vcns;
>   
>   	vcn = le64_to_cpu(lrh->target_vcn);
> -	vcn &= ~(log->clst_per_page - 1);
> +	vcn &= ~(u64)(log->clst_per_page - 1);
>   
>   add_allocated_vcns:
>   	for (i = 0, vcn = le64_to_cpu(lrh->target_vcn),

Thanks for patch, applied!
