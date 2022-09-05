Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7D5AD3E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiIEN2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiIEN2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:28:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B848E8E
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 06:28:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qh18so17100631ejb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3+TygZ6C/ca7p6cYpThJAS4ANN1kqwgRbR3LogM6jy4=;
        b=SMmUMLsLOtmXPTKCFc+BwpGOoBC8qQHWHR59kvcdiyKX299wl/rdptPcsXasGHh/Eh
         KC1Aowl4rEGYRXPfn5jRy9aLX4pflyyTHJtVFnWCMByusY1z0VDTLTc+a73UAvoRlcaf
         GPlOyue3MZWssFO5WxzF5s2v6iOfHiaErfWu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3+TygZ6C/ca7p6cYpThJAS4ANN1kqwgRbR3LogM6jy4=;
        b=10NKxKwrufhIp3REsEz7KMQhG7Ldca9r5RY9k0/E7es657k75IN7v87kAqzdehq1AU
         D1kxPi/41zLH8AlL5ZQfNagVEXO+L4GT3vq0j6sZ0QGC86tumzkWrhBZVd8tTfZbqS44
         DJYEJiY8wjzK1p6u4iV31urDpxPR451XryPJCTwy6FrksAeBRmfhYwdP0x/CoLd3569m
         n0UY9SL+gTc9lmWXFDmoLVWTBnY7UC8lJS1IQ2/C1g4CNx2jB2o9nkN+E36cUGkRt18N
         a0ybAUvHTJVZS6BgU1cUUbuAySjiXiMCAmpZQbjV1cc70cRtf/mnnTwPciUMYrhQYLTd
         8Qgw==
X-Gm-Message-State: ACgBeo24nbv6hNY4VJ4AFw5eZEcqB5cJpmXt8kN/FewPNrrzvST2Ry8/
        UENRw4RMKj4IxcVq9vq1TMbg//KYlWheQWTcnTAEAV3mBBQrCA==
X-Google-Smtp-Source: AA6agR6KDEE8G7UQIpvEyWbZakHT5DQW+kVRgd98/oxZV+wWv1xUqMZwu0IRedxIlY/DohCoylxRt4Ad48WT8RAjXvM=
X-Received: by 2002:a17:907:9495:b0:734:e049:3d15 with SMTP id
 dm21-20020a170907949500b00734e0493d15mr37211082ejc.187.1662384512219; Mon, 05
 Sep 2022 06:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220905071744.8350-1-quic_yingangl@quicinc.com>
In-Reply-To: <20220905071744.8350-1-quic_yingangl@quicinc.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 5 Sep 2022 15:28:21 +0200
Message-ID: <CAJfpegs6Jbr8eF9ZNycEjfCtJNVQJECjFnOC9-v8WSXHvpWxCg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix the deadlock in race of reclaim path with kswapd
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     linux-fsdevel@vger.kernel.org, quic_maow@quicinc.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Sept 2022 at 09:17, Kassey Li <quic_yingangl@quicinc.com> wrote:
>
> Task A wait for writeback, while writeback Task B send request to fuse.
> Task C is expected to serve this request, here it is in direct reclaim
> path cause deadlock when system is in low memory.
>
> without __GFP_FS in Task_C break throttle_direct_reclaim with an
> HZ timeout.
>
> kswpad (Task_A):                    writeback(Task_B):
>     __switch_to+0x14c                   schedule+0x70
>     __schedule+0xb5c                    __fuse_request_send+0x154
>     schedule+0x70                       fuse_simple_request+0x184
>     bit_wait+0x18                       fuse_flush_times+0x114
>     __wait_on_bit+0x74                  fuse_write_inode+0x60
>     inode_wait_for_writeback+0xa4       __writeback_single_inode+0x3d8
>     evict+0xa8                          writeback_sb_inodes+0x4c0
>     iput+0x248                          __writeback_inodes_wb+0xb0
>     dentry_unlink_inode+0xdc            wb_writeback+0x270
>     __dentry_kill[jt]+0x110             wb_workfn+0x37c
>     shrink_dentry_list+0x17c            process_one_work+0x284
>     prune_dcache_sb+0x5c
>     super_cache_scan+0x11c
>     do_shrink_slab+0x248
>     shrink_slab+0x260
>     shrink_node+0x678
>     kswapd+0x8ec
>     kthread+0x140
>     ret_from_fork+0x10
>
> Task_C:
>     __switch_to+0x14c
>     __schedule+0xb5c
>     schedule+0x70
>     throttle_direct_reclaim
>     try_to_free_pages
>     __perform_reclaim
>     __alloc_pages_direct_reclaim
>     __alloc_pages_slowpath
>     __alloc_pages_nodemask
>     alloc_pages
>     fuse_copy_fill+0x168
>     fuse_dev_do_read+0x37c
>     fuse_dev_splice_read+0x94

Should already be fixed in v5.16 by commit 5c791fe1e2a4 ("fuse: make
sure reclaim doesn't write the inode").

Thanks,
Miklos
