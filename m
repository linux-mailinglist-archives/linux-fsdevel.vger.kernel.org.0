Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E806DED2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDLIEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLIEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4B4EE8;
        Wed, 12 Apr 2023 01:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7437C62F40;
        Wed, 12 Apr 2023 08:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85F1C433D2;
        Wed, 12 Apr 2023 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681286658;
        bh=M4jm0qcEHwHN2rg4cpI8iL/HUSBE5oILgTN4CgEI91E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PQU6x5s4Rz7n21TaZgbEDSkM2Eo3fLV/ykDjS4alLCLmzcGLs0Hynv2HRltrKfQ6j
         +rS9dQFHZqDDhZDp3EcTZWedICmjan0GAKnRPAHbzqywfRC7mY1KReenOZEMnXqwZ6
         GJ7WQswzCIhBKBX9mFPmXuL4TTFQ8cQMBT8bgqDTzntsjmr083r0Dpee4jbLPaK0RJ
         0VHMpgpTa7dyf9Hl3P3cCtWOPa/+O+L8G05s2FJdFzAoqVeYgnYPZVUYTjQ+U1PCHm
         B12jlctvn4D7JZNmomMAzq0pz8eYCARUDgg8+bx348Sk/Rn1wgug+4YoNBrRvrHGq9
         5eVGDLUBcHJmw==
Message-ID: <9a92e541-cf98-4ac5-c181-4a6ba76d08f8@kernel.org>
Date:   Wed, 12 Apr 2023 17:04:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] zonefs: remove unnecessary kobject_del()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230412031904.13739-1-frank.li@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412031904.13739-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/23 12:19, Yangtao Li wrote:
> kobject_put() actually covers kobject removal automatically, which is
> single stage removal. So kill kobject_del() directly.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/zonefs/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> index 8ccb65c2b419..a535bdea1097 100644
> --- a/fs/zonefs/sysfs.c
> +++ b/fs/zonefs/sysfs.c
> @@ -113,7 +113,6 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>  	if (!sbi || !sbi->s_sysfs_registered)
>  		return;
>  
> -	kobject_del(&sbi->s_kobj);
>  	kobject_put(&sbi->s_kobj);
>  	wait_for_completion(&sbi->s_kobj_unregister);
>  }

What I am not sure about here is that if CONFIG_DEBUG_KOBJECT_RELEASE is
enabled, the kobj release is delayed, so the kobject will stay in sysfs
potentially after the umount() returns. Not exactly nice as that potentially
create races in user space... Not 100% sure though.

Greg ? Any thoughts on this ?
