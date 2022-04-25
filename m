Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299550EADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiDYUzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYUzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:55:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDD344C4;
        Mon, 25 Apr 2022 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UezYTpkGwwWHLr7TCtI1U2DaUhIahmheDQtz2U252E8=; b=AiubjeiyEAbQT1rdssolc9+eZK
        naeZMgkl43Z0EmDFbEoCYDmvpiO4T72GaML9jlCS+eBzGNwOKFluO2V07O5H9zyulLE72HREp993g
        EXbExZH1WBQbZ6NXNeSd/EgfIObs2hEz6ebhZ/YY6iBd1FPKu2Xs/RzlDZuJ86EpubGQLJeCVZybG
        ENn1LZgUp/3ycXHGzA2iHKMOOoc/Sa5Yv3jKfTBNfLU7fGO4i+abaRcpsCln6CyOEXtzy+QpodVaY
        DOIlS+GDlzsu0zNAtfWtFNkX+xNHdZrsII3emTPOXAeCcbJMF9nncvshtVS3p+oJmFpWZtWyTiYU2
        I2JvPTvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj5gb-00BOQb-7n; Mon, 25 Apr 2022 20:51:57 +0000
Date:   Mon, 25 Apr 2022 13:51:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, kernel@openvz.org
Subject: Re: [PATCH] sysctl: minor cleanup in new_dir()
Message-ID: <YmcJ7V0ywWcwvS/6@bombadil.infradead.org>
References: <b1b9cf79-d0a8-bb9a-5dca-42ceb74ffcbf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b9cf79-d0a8-bb9a-5dca-42ceb74ffcbf@openvz.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:28:54PM +0300, Vasily Averin wrote:
> Byte zeroing is not required here, since memory was allocated by kzalloc()
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  fs/proc/proc_sysctl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 7d9cfc730bd4..094c24e010ae 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -978,7 +978,6 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
>  	table = (struct ctl_table *)(node + 1);
>  	new_name = (char *)(table + 2);
>  	memcpy(new_name, name, namelen);
> -	new_name[namelen] = '\0';
>  	table[0].procname = new_name;
>  	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>  	init_header(&new->header, set->dir.header.root, set, node, table);

Queued onto sysctl-testing, thanks!

  Luis
