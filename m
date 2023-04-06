Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A606D94E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbjDFLSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDFLSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1949CC;
        Thu,  6 Apr 2023 04:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C39036461B;
        Thu,  6 Apr 2023 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60D6C433EF;
        Thu,  6 Apr 2023 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680779884;
        bh=GyJOOLUgPQG224uVjUpkRJJAcshV6DM2oQoUOr1cS1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjUoDe2+6RDMyo9BLMvHjvcbbxBkcF+kLXTQY4fa1bGOPvfLCjlZnDQr30Ei7P2/m
         73gXcpIPFQMH6CE/IsyYFgCiGRvMeOfATcd2AumKv4fvZ/lxuuGHTT2ZKxOHrCMvu4
         dkQSyA6xzVe2MeKyz22DSYwYXI400iyEMVvXeLCk=
Date:   Thu, 6 Apr 2023 13:18:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <dlemoal@fastmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Message-ID: <2023040627-platter-twisted-c1e6@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
 <2023040627-paver-recipient-3713@gregkh>
 <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:58:38PM +0900, Damien Le Moal wrote:
> On 4/6/23 19:26, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
> >> On 4/6/23 19:05, Greg KH wrote:
> >>> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
> >>>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
> >>>> BTW kill kobject_del() directly, because kobject_put() actually covers
> >>>> kobject removal automatically.
> >>>>
> >>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >>>> ---
> >>>>  fs/zonefs/sysfs.c  | 11 +++++------
> >>>>  fs/zonefs/zonefs.h |  1 -
> >>>>  2 files changed, 5 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
> >>>> index 8ccb65c2b419..f0783bf7a25c 100644
> >>>> --- a/fs/zonefs/sysfs.c
> >>>> +++ b/fs/zonefs/sysfs.c
> >>>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> -	sbi->s_sysfs_registered = true;
> >>>
> >>> You know this, why do you need to have a variable tell you this or not?
> >>
> >> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
> >> fill_super will also return that error. vfs will then call kill_super, which
> >> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
> >> added the kobj.
> > 
> > Ok, but then why not just 0 out the kobject pointer here instead?  That
> > way you will always know if it's a valid pointer or not and you don't
> > have to rely on some other variable?  Use the one that you have already :)
> 
> but sbi->s_kobj is the kobject itself, not a pointer.

Then it should not be there if the kobject is not valid as it should
have been freed when the kobject_init_and_add() call failed, right?

> I can still zero it out in
> case of error to avoid using the added s_sysfs_registered bool. I would need to
> check a field of s_kobj though, which is not super clean and makes the code
> dependent on kobject internals. Not super nice in my opinion, unless I am
> missing something.

See above, if a kobject fails to be registered, just remove the whole
object as it's obviously "dead" now and you can not trust it.

> > And you really don't even need to check anything, just pass in NULL to
> > kobject_del() and friends, it should handle it.>
> >>>> -
> >>>>  	return 0;
> >>>>  }
> >>>>  
> >>>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
> >>>>  {
> >>>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >>>>  
> >>>> -	if (!sbi || !sbi->s_sysfs_registered)
> >>>
> >>> How can either of these ever be true?  Note, sbi should be passed here
> >>> to this function, not the super block as that is now unregistered from
> >>> the system.  Looks like no one has really tested this codepath that much
> >>> :(
> >>>
> >>>> +	if (!sbi)
> >>>>  		return;
> >>>
> >>> this can not ever be true, right?
> >>
> >> Yes it can, if someone attempt to mount a non zoned device. In that case,
> >> fill_super returns early without setting sb->s_fs_info but vfs still calls
> >> kill_super.
> > 
> > But you already had a sbi pointer in the place that this was called, so
> > you "know" if you need to even call into here or not.  You are having to
> > look up the same pointer multiple times in this call chain, there's no
> > need for that.
> 
> I am not following here. Either we check that we have sbi here in
> zonefs_sysfs_unregister(), or we conditionally call this function in
> zonefs_kill_super() with a "if (sbi)". Either way, we need to check since sbi
> can be NULL.

In zonefs_kill_super() you have get the spi at the top of the function,
so use that, don't make zonefs_sysfs_unregister() have to compute it
again.

But again, if the kobject fails to be registered, you have to treat the
memory contained there as not valid and get rid of it as soon as
possible.

thanks,

greg k-h
