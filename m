Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4187F6D9390
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjDFKDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjDFKD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7D83D0;
        Thu,  6 Apr 2023 03:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249D16288B;
        Thu,  6 Apr 2023 10:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9BDC433D2;
        Thu,  6 Apr 2023 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680775391;
        bh=Q91LeGfazZCcvmkNSKQDh2S2zJ4XUfMbkzSQcwu2+kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wqx/xHpwzEgloQBD/CkbVAJsa84OKnowPu4b4Yi11M5ANZ6Wm5L3VLKJ+2JdWegoj
         rF+9HKby+OQju13wlpp3kQ3yNagJHvqu9xAhdqLV4YS4tySFKDnQZJG+XsYj67nkLk
         m7h0DVt/xIgASFFVk3MQNgxNFR7Bd8kZmpsVokXc=
Date:   Thu, 6 Apr 2023 12:03:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rafael@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040635-duty-overblown-7b4d@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406093056.33916-2-frank.li@vivo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
> Use kobject_is_added() instead of directly accessing the internal
> variables of kobject. BTW kill kobject_del() directly, because
> kobject_put() actually covers kobject removal automatically.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/erofs/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 435e515c0792..daac23e32026 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (sbi->s_kobj.state_in_sysfs) {
> -		kobject_del(&sbi->s_kobj);
> +	if (kobject_is_added(&sbi->s_kobj)) {

I do not understand why this check is even needed, I do not think it
should be there at all as obviously the kobject was registered if it now
needs to not be registered.

Meta-comment, we need to come up with a "filesystem kobject type" to get
rid of lots of the boilerplate filesystem kobject logic as it's
duplicated in every filesystem in tiny different ways and lots of times
(like here), it's wrong.

kobjects were not designed to be "used raw" like this, ideally they
would be wrapped in a subsystem that makes them easier to be used (like
the driver model), but filesystems decided to use them and that usage
just grew over the years.  That's evolution for you...

thanks,

greg k-h
