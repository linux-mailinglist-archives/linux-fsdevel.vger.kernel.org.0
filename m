Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADB47A86B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 12:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLTLMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 06:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhLTLMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639998758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Colqd1+vztV8MREU7m92bsxhTJ4ApYVfBievhCi7brY=;
        b=Av11XHwzM9q8cbSOl9Ws66YUm6FjdCwi3LGIc3xmkRX0xiI/uJopiB9WWvTnYr1c4m7otb
        sAOaEfmCCnlvcuQFawU+iDAJgQ43UzmgSD6qh3ghs70rSIALAJlpSFNzJtf1ARqLrgKnAb
        LIqXbYTLkxbqhlrFAPTegihLcMUjyu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-F0Wui8kBPcmhjzO9NAIdvA-1; Mon, 20 Dec 2021 06:12:35 -0500
X-MC-Unique: F0Wui8kBPcmhjzO9NAIdvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 724F018C8C02;
        Mon, 20 Dec 2021 11:12:34 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D33E1037F5B;
        Mon, 20 Dec 2021 11:12:33 +0000 (UTC)
Date:   Mon, 20 Dec 2021 12:12:31 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
Message-ID: <20211220111231.ncdfcynvoiidl7is@work>
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work>
 <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
 <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com>
 <d05a95a9-0bbd-3495-2b81-18673909edd4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05a95a9-0bbd-3495-2b81-18673909edd4@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 07:26:30PM +0100, Heiner Kallweit wrote:
> On 17.12.2021 18:02, Heiner Kallweit wrote:
> > On 17.12.2021 16:34, Heiner Kallweit wrote:
> >> On 17.12.2021 16:24, Lukas Czerner wrote:
> >>> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
> >>>> On linux-next systemd-remount-fs complains about an invalid mount option
> >>>> here, resulting in a r/o root fs. After playing with the mount options
> >>>> it turned out that data=ordered causes the problem. linux-next from Dec
> >>>> 1st was ok, so it seems to be related to the new mount API patches.
> >>>>
> >>>> At a first glance I saw no obvious problem, the following looks good.
> >>>> Maybe you have an idea where to look ..
> >>>>
> >>>> static const struct constant_table ext4_param_data[] = {
> >>>> 	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
> >>>> 	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
> >>>> 	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
> >>>> 	{}
> >>>> };
> >>>>
> >>>> 	fsparam_enum	("data",		Opt_data, ext4_param_data),
> >>>>
> >>>
> >>> Thank you for the report!
> >>>
> >>> The ext4 mount has been reworked to use the new mount api and the work
> >>> has been applied to linux-next couple of days ago so I definitelly
> >>> assume there is a bug in there that I've missed. I will be looking into
> >>> it.
> >>>
> >>> Can you be a little bit more specific about how to reproduce the problem
> >>> as well as the error it generates in the logs ? Any other mount options
> >>> used simultaneously, non-default file system features, or mount options
> >>> stored within the superblock ?
> >>>
> >>> Can you reproduce it outside of the systemd unit, say a script ?
> >>>
> >> Yes:
> >>
> >> [root@zotac ~]# mount -o remount,data=ordered /
> >> mount: /: mount point not mounted or bad option.
> >> [root@zotac ~]# mount -o remount,discard /
> >> [root@zotac ~]#
> >>
> >> "systemctl status systemd-remount-fs" shows the same error.
> >>
> >> Following options I had in my fstab (ext4 fs):
> >> rw,relatime,data=ordered,discard
> >>
> >> No non-default system features.
> >>
> >>> Thanks!
> >>> -Lukas
> >>>
> >> Heiner
> > 
> > Sorry, should have looked at dmesg earlier. There I see:
> > EXT4-fs: Cannot change data mode on remount
> > Message seems to be triggered from ext4_check_opt_consistency().
> > Not sure why this error doesn't occur with old mount API.
> > And actually I don't change the data mode.
> 
> Based on the old API code: Maybe we need something like this?
> At least it works for me.
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b72d989b7..9ec7e526c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2821,7 +2821,9 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
>                                  "Remounting file system with no journal "
>                                  "so ignoring journalled data option");
>                         ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
> -               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
> +               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS &&
> +                          (ctx->vals_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) !=
> +                          (sbi->s_mount_opt & EXT4_MOUNT_DATA_FLAGS)) {

Hi,

indeed that's where the problem is. It's not enogh to check whether
we have a data= mount options set, we also have to check whether it's
the same as it already is set on the file system during remount. In
which case we just ignore it, rather then error out.

Thanks for tracking it down. I think the condition can be simplified a
bit. I also have to update the xfstest test to check for plain remount
without changing anything to catch errors like these. I'll send patch
soon.

Thanks!
-Lukas

>                         ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
>                                  "on remount");
>                         return -EINVAL;
> 

