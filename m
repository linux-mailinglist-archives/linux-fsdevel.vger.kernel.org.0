Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2648D729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 13:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiAMMIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 07:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230310AbiAMMIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642075697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCNkeFEK71+LV6A7k+ZbeQqGlDkwam6mXnXbXpILn2s=;
        b=Hs2CxMpU2yw1fXFlDGVM6qARbmKDAjT/UjT+JKCKFOZP971KQJ5sxn9jHyUqQzkrG/limh
        WvlG7Oxw//RZ5R6diYu9fv9XX2DSKWaGPQxp1buDIw2AH4uAbK8dTRR8Fr1eAF8oQBlr+z
        6byZfwpUJ66AUVvmQ1EG6tXzk8tEdUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-jwoGwns4MtiJQq0oalNNIQ-1; Thu, 13 Jan 2022 07:08:14 -0500
X-MC-Unique: jwoGwns4MtiJQq0oalNNIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2564F10247B4;
        Thu, 13 Jan 2022 12:08:13 +0000 (UTC)
Received: from work (unknown [10.40.194.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D203D7A8C7;
        Thu, 13 Jan 2022 12:08:11 +0000 (UTC)
Date:   Thu, 13 Jan 2022 13:08:07 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 12/13] ext4: switch to the new mount api
Message-ID: <20220113120807.xlyg4wmbbhajuftu@work>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-13-lczerner@redhat.com>
 <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:29:24AM +0000, Jon Hunter wrote:
> Hi Lukas,
> 
> On 21/10/2021 12:45, Lukas Czerner wrote:
> > Add the necessary functions for the fs_context_operations. Convert and
> > rename ext4_remount() and ext4_fill_super() to ext4_get_tree() and
> > ext4_reconfigure() respectively and switch the ext4 to use the new api.
> > 
> > One user facing change is the fact that we no longer have access to the
> > entire string of mount options provided by mount(2) since the mount api
> > does not store it anywhere. As a result we can't print the options to
> > the log as we did in the past after the successful mount.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> 
> I have noticed the following error on -next on various ARM64 platforms that
> we have ...
> 
>  ERR KERN /dev/mmcblk1: Can't open blockdev
> 
> I have bisected this, to see where this was introduced and bisect is
> pointing to this commit. I have not looked any further so far, but wanted to
> see if you had any ideas/suggestions?

Hi,

this error does not come from the ext4, but probably rather from vfs. More
specifically from get_tree_bdev()

        bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type);
        if (IS_ERR(bdev)) {
                errorf(fc, "%s: Can't open blockdev", fc->source);
                return PTR_ERR(bdev);
        }

I have no idea why this fails in your case. Do you know what kind of
error it fails with? Any oher error or warning messages preceding the one you
point out in the logs?

I assume that this happens on mount and the device that you're trying to
mount contains ext4 file system? Ext4 is not the only file system
utilizing the new mount api, can you try the same with xfs on the device?

Does this happen only on some specific devices? I see that the error
is mentioning /dev/mmcblk1. Is it the case that it only affects MMC ?
Does this happen when you try to mount a different type of block device
with ext4 on it?

Any specific mount options you're using? Is it rw mount? If so, any
chance the device is read only?

Do you have any way of reliably reproducing this?

Thanks!
-Lukas
> 
> Cheers
> Jon
> 
> -- 
> nvpublic
> 

