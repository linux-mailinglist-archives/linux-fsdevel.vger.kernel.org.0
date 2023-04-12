Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F16DED40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDLILW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 04:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLILV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C134EE8;
        Wed, 12 Apr 2023 01:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208FD62F50;
        Wed, 12 Apr 2023 08:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F0C433D2;
        Wed, 12 Apr 2023 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681287079;
        bh=FIFGKwc8ADqtamNsYvQNXYsD5pvd8UTs6V9mMgv0Mj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aE+32cCyNMiXrlGD/hjKKRPBOEj0En5abKrVpHH21PDM8T9uNBg8MEvGnFrnE1C+s
         bPRPrYdILick1AoTxdq+bpqPMoOtRIXXc5eIEgeckiPS2fEnvTYu6a00p7aoWTJyC9
         ezql/3SalD2X5gT3eFfHJHH3Pe9QFB5P9kwTvUWE=
Date:   Wed, 12 Apr 2023 10:11:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zonefs: remove unnecessary kobject_del()
Message-ID: <2023041238-stench-magnetism-0256@gregkh>
References: <20230412031904.13739-1-frank.li@vivo.com>
 <9a92e541-cf98-4ac5-c181-4a6ba76d08f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a92e541-cf98-4ac5-c181-4a6ba76d08f8@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 05:04:16PM +0900, Damien Le Moal wrote:
> On 4/12/23 12:19, Yangtao Li wrote:
> > kobject_put() actually covers kobject removal automatically, which is
> > single stage removal. So kill kobject_del() directly.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/zonefs/sysfs.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> > index 8ccb65c2b419..a535bdea1097 100644
> > --- a/fs/zonefs/sysfs.c
> > +++ b/fs/zonefs/sysfs.c
> > @@ -113,7 +113,6 @@ void zonefs_sysfs_unregister(struct super_block *sb)
> >  	if (!sbi || !sbi->s_sysfs_registered)
> >  		return;
> >  
> > -	kobject_del(&sbi->s_kobj);
> >  	kobject_put(&sbi->s_kobj);
> >  	wait_for_completion(&sbi->s_kobj_unregister);
> >  }
> 
> What I am not sure about here is that if CONFIG_DEBUG_KOBJECT_RELEASE is
> enabled, the kobj release is delayed, so the kobject will stay in sysfs
> potentially after the umount() returns. Not exactly nice as that potentially
> create races in user space... Not 100% sure though.
> 
> Greg ? Any thoughts on this ?

Yes, it's all a mess :(

See the other messatges in this thread:
	https://lore.kernel.org/r/20230406120716.80980-1-frank.li@vivo.com

Please don't take this patch for now, this all needs to be revisited.

We have two reference counted objects with different lifespans trying to
be embedded in the same structure, causing a mess.

But, if we split them apart, that too has issues.  I've been thinking
about how to resolve this, but don't have any solid ideas yet, and been
swamped with other things...

For now, let's just leave this all alone, it's not unique to this one
filesystem, they all have the same pattern, and we need to solve them
all properly at the same time by moving the common code into the driver
core so that filesystems don't have to worry about this mess.

thanks,

greg k-h
