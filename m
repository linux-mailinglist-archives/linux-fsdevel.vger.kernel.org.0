Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36956D93F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbjDFK0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjDFK0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51510D5;
        Thu,  6 Apr 2023 03:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C5360C98;
        Thu,  6 Apr 2023 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA4C433EF;
        Thu,  6 Apr 2023 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680776806;
        bh=Bsh9tIqIOFj0EL11HwEKb+7UATkQiSzOLRPewqBv8aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aidUVLAQPrfxqyxIJ8H2KA3Iu3QUlCzSt1mPN2LXJAUinCNhCQr5NOIsC93/jkqT3
         LMgoBgHx7BDkNBDJfjglJhI+glRVMJuDVKQ98K3XACArPJs4SZXBxgU+WaAWjnfA/0
         PsjsODrFNVfT/dKlZgVxaQ14zXY1RQo9rPK5RSAE=
Date:   Thu, 6 Apr 2023 12:26:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <dlemoal@fastmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040627-paver-recipient-3713@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
> On 4/6/23 19:05, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> >> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> >> BTW kill kobject_del() directly, because kobject_put() actually covers
> >> kobject removal automatically.
> >>
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >> ---
> >>  fs/zonefs/sysfs.c  | 11 +++++------
> >>  fs/zonefs/zonefs.h |  1 -
> >>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> >> index 8ccb65c2b419..f0783bf7a25c 100644
> >> --- a/fs/zonefs/sysfs.c
> >> +++ b/fs/zonefs/sysfs.c
> >> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
> >>  		return ret;
> >>  	}
> >>  
> >> -	sbi->s_sysfs_registered = true;
> > 
> > You know this, why do you need to have a variable tell you this or not?
> 
> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
> fill_super will also return that error. vfs will then call kill_super, which
> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
> added the kobj.

Ok, but then why not just 0 out the kobject pointer here instead?  That
way you will always know if it's a valid pointer or not and you don't
have to rely on some other variable?  Use the one that you have already :)

And you really don't even need to check anything, just pass in NULL to
kobject_del() and friends, it should handle it.

> >> -
> >>  	return 0;
> >>  }
> >>  
> >> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
> >>  {
> >>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >>  
> >> -	if (!sbi || !sbi->s_sysfs_registered)
> > 
> > How can either of these ever be true?  Note, sbi should be passed here
> > to this function, not the super block as that is now unregistered from
> > the system.  Looks like no one has really tested this codepath that much
> > :(
> > 
> >> +	if (!sbi)
> >>  		return;
> > 
> > this can not ever be true, right?
> 
> Yes it can, if someone attempt to mount a non zoned device. In that case,
> fill_super returns early without setting sb->s_fs_info but vfs still calls
> kill_super.

But you already had a sbi pointer in the place that this was called, so
you "know" if you need to even call into here or not.  You are having to
look up the same pointer multiple times in this call chain, there's no
need for that.

thanks,

greg k-h
