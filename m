Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45316531D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUNef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 08:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLUNee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:34:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD32BC2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 05:34:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bf43so23516214lfb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0FXHdAxlQCKNpVHPu4ljr9mTHK7rsIQ0NRxjjSRv34=;
        b=W8nt8VldUhaBpwI/xNMJ3Bxbtj6Nosqr6KDgWsdch+8IZSqSqqMTaIHnWaFZ6Ik3lG
         jUspcRWQ/FbdttBiDW3CmDqHVPALZnU6spBvYOAsRCoYd204nS41d+2aI1Z7G8OyTyeN
         1yhjSUiiWjVr2GvNfofsZtFpisNWasWGrkXUp5EJGq8IzdNNvJY3u0jv3NmJeyTZQcXU
         CADPUL/7zTS0CnXrwJ4wVOjh7VCJzfQGoQ2d9AWYconnan31xUt4JbGw6troC/1P3i4g
         OSz3JvS0WDWiKN3itScFH2OkQu6g8ywuS9aaKTHHIANJCWKwePlJxsqjLlN2uMPJ15rE
         5AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0FXHdAxlQCKNpVHPu4ljr9mTHK7rsIQ0NRxjjSRv34=;
        b=zdMs27MCcIneJWSW94dfHHWHQ3sVzQlZXnIE1mKQ0hRx1mEVYkNlfVhgTt6+6nm2kl
         caNyOkRbR/3AU41MlLsDs3ouHXKSx8YzP+uRitQK3n5LB3AQRp73ZtDyitsYsWqh1z26
         GpOFsTZFRydoNAWcC5AZCinZvYxw6gk88a69wQKBD/zOHsy0w2okDC9sbHgzRIPhfQ3F
         a1jqn00pbqg1ZltwZ/5ckYCsH8sU2qG8slzWpgHQp72jC7ztJBMH+JZoKSFYsefK7uxC
         se1Uio9nt92XuT6ePogMqClLaMyDbqbCo99U0ncO0HJuBXs+qayx96FEgheTpk6uRoaW
         iSDg==
X-Gm-Message-State: AFqh2kqrYxSeIlKoWg4YtdpSaKfV+Im1YkMBdjf1XabPZUNFMCM1+Naa
        v5J9fYku48JP+9+8O7wPxniTgg==
X-Google-Smtp-Source: AMrXdXviJW015I7NYa4eijEHW4N5KVbIX+8IA0aNfy7QoBevqLdLiSjSiO9lAKC34bmkVJvY/Lbmtg==
X-Received: by 2002:a19:f705:0:b0:4be:a4cb:be37 with SMTP id z5-20020a19f705000000b004bea4cbbe37mr569117lfe.15.1671629670779;
        Wed, 21 Dec 2022 05:34:30 -0800 (PST)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id w23-20020a19c517000000b004b5701b5337sm1843649lfe.104.2022.12.21.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:34:30 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:28 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com, arnd@arndb.de
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
Message-ID: <20221221133428.GE69385@mutt>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2BMonmS0SdOn5yh@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-10-31 12:30, Tejun Heo wrote:
> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
> > The kernfs write lock is held when the kernfs node inode attributes
> > are updated. Therefore, when either kernfs_iop_getattr() or
> > kernfs_iop_permission() are called the kernfs node inode attributes
> > won't change.
> > 
> > Consequently concurrent kernfs_refresh_inode() calls always copy the
> > same values from the kernfs node.
> > 
> > So there's no need to take the inode i_lock to get consistent values
> > for generic_fillattr() and generic_permission(), the kernfs read lock
> > is sufficient.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Hi,

Building an allmodconfig arm64 kernel on yesterdays next-20221220 and
booting that in qemu I see the following "BUG: KCSAN: data-race in
set_nlink / set_nlink".


==================================================================
[ 1540.388669][  T123] BUG: KCSAN: data-race in set_nlink / set_nlink
[ 1540.392779][  T123] 
[ 1540.394302][  T123] write to 0xffff00000adcc3e4 of 4 bytes by task 126 on cpu 0:
[ 1540.398828][ T123] set_nlink (/home/anders/src/kernel/next/fs/inode.c:371) 
[ 1540.401609][ T123] kernfs_refresh_inode (/home/anders/src/kernel/next/fs/kernfs/inode.c:181) 
[ 1540.404925][ T123] kernfs_iop_getattr (/home/anders/src/kernel/next/fs/kernfs/inode.c:194) 
[ 1540.408088][ T123] vfs_getattr_nosec (/home/anders/src/kernel/next/fs/stat.c:133) 
[ 1540.411334][ T123] vfs_statx (/home/anders/src/kernel/next/fs/stat.c:170) 
[ 1540.414224][ T123] vfs_fstatat (/home/anders/src/kernel/next/fs/stat.c:276) 
[ 1540.417166][ T123] __do_sys_newfstatat (/home/anders/src/kernel/next/fs/stat.c:446) 
[ 1540.420539][ T123] __arm64_sys_newfstatat (/home/anders/src/kernel/next/fs/stat.c:440 /home/anders/src/kernel/next/fs/stat.c:440) 
[ 1540.424003][ T123] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142) 
[ 1540.427648][ T123] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197) 
[ 1540.430378][ T123] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638) 
[ 1540.433053][ T123] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656) 
[ 1540.436421][ T123] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
[ 1540.439303][  T123] 
[ 1540.440828][  T123] 1 lock held by systemd-udevd/126:
[ 1540.444055][ T123] #0: ffff00000609b960 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_iop_getattr (/home/anders/src/kernel/next/fs/kernfs/inode.c:193) 
[ 1540.450699][  T123] irq event stamp: 185034
[ 1540.453373][ T123] hardirqs last enabled at (185034): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/mm/page_alloc.c:5302) 
[ 1540.460087][ T123] hardirqs last disabled at (185033): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/include/linux/seqlock.h:103 (discriminator 4)) 
[ 1540.466686][ T123] softirqs last enabled at (185001): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780) 
[ 1540.473310][ T123] softirqs last disabled at (184999): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773) 
[ 1540.479872][  T123] 
[ 1540.481406][  T123] read to 0xffff00000adcc3e4 of 4 bytes by task 123 on cpu 0:
[ 1540.485893][ T123] set_nlink (/home/anders/src/kernel/next/fs/inode.c:368) 
[ 1540.488663][ T123] kernfs_refresh_inode (/home/anders/src/kernel/next/fs/kernfs/inode.c:181) 
[ 1540.491961][ T123] kernfs_iop_permission (/home/anders/src/kernel/next/fs/kernfs/inode.c:290) 
[ 1540.495260][ T123] inode_permission (/home/anders/src/kernel/next/fs/namei.c:458 /home/anders/src/kernel/next/fs/namei.c:525) 
[ 1540.498450][ T123] link_path_walk (/home/anders/src/kernel/next/fs/namei.c:1715 /home/anders/src/kernel/next/fs/namei.c:2262) 
[ 1540.501552][ T123] path_lookupat (/home/anders/src/kernel/next/fs/namei.c:2473 (discriminator 2)) 
[ 1540.504592][ T123] filename_lookup (/home/anders/src/kernel/next/fs/namei.c:2503) 
[ 1540.507740][ T123] user_path_at_empty (/home/anders/src/kernel/next/fs/namei.c:2876) 
[ 1540.511010][ T123] do_readlinkat (/home/anders/src/kernel/next/fs/stat.c:477) 
[ 1540.514097][ T123] __arm64_sys_readlinkat (/home/anders/src/kernel/next/fs/stat.c:504 /home/anders/src/kernel/next/fs/stat.c:501 /home/anders/src/kernel/next/fs/stat.c:501) 
[ 1540.517598][ T123] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142) 
[ 1540.521319][ T123] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197) 
[ 1540.524125][ T123] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638) 
[ 1540.526795][ T123] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656) 
[ 1540.530224][ T123] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
[ 1540.533176][  T123] 
[ 1540.534710][  T123] 1 lock held by systemd-udevd/123:
[ 1540.537977][ T123] #0: ffff00000609b960 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_iop_permission (/home/anders/src/kernel/next/fs/kernfs/inode.c:289) 
[ 1540.544892][  T123] irq event stamp: 216564
[ 1540.547603][ T123] hardirqs last enabled at (216564): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/mm/page_alloc.c:5302) 
[ 1540.554368][ T123] hardirqs last disabled at (216563): seqcount_lockdep_reader_access (/home/anders/src/kernel/next/include/linux/seqlock.h:103 (discriminator 4)) 
[ 1540.561107][ T123] softirqs last enabled at (216533): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780) 
[ 1540.567833][ T123] softirqs last disabled at (216531): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773) 
[ 1540.574496][  T123] 
[ 1540.576050][  T123] Reported by Kernel Concurrency Sanitizer on:
[ 1540.587925][  T123] Hardware name: linux,dummy-virt (DT)
[ 1540.591282][  T123] ==================================================================


Reverting this patch I don't see the data race anymore.

Cheers,
Anders
