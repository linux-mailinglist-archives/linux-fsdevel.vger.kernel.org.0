Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51E39F9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhFHO4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhFHO4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:56:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431DC061574;
        Tue,  8 Jun 2021 07:54:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ei4so12064851pjb.3;
        Tue, 08 Jun 2021 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecMLMqcE8EeIbuN513nFwbk5RzSrqoR2JVfpDeyBHiQ=;
        b=hhfh1uvzextiNN5Z9ttuL6IojH7aEw0WSbEOCUkpsgIIcTtYDcy5oXc8nyh9y2m25Q
         5eiJrvwNMXL9XKYr51VeiUBoUk8Cu4zdZ3VfAeLQV2ioCQrttjPDu7KMCVSnmhBf7FiF
         ebcbBcXBi9vDwyBgVYU6bOLacWjT5FLnlWapuJBILIOmCuf38N9PQz6HcwsHB+gCa1Ge
         FfmA9wwsJl1TE9pvYx7BegBKAdzIxXFOCdFMgVM9EE00WY5KwD/dvfFXluGNfabFGjV0
         M4SJjBWX0dIC9WT99zWrjI8qHRvn78c0uWmDKOf8RY+yxskiaoqx1IL+u76jo2bWr5XC
         P6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ecMLMqcE8EeIbuN513nFwbk5RzSrqoR2JVfpDeyBHiQ=;
        b=PlTivDJqB+bFZ9QtcKGaPz1VHJyeIC7EX5BnQ5pwaYTj3k0EH1/AER7yyYJrH/wHKV
         EIKn1tvrNiT4NKTj68U1crs7twXVp9fcr9LqlCgn/QYKQJFcLE/oPXw17GLzALrLSzCA
         w0RTzkxSedW8Rne1TmO55ige1Sn/D6SGLOXxmnom5f3DTcjIIc5vr/7/K42RVhwXZtH4
         q0x+60kGtpFCrMOQDLcGSqlRNbLzJ6EZ6J4K5ql5P+4JevEqUPg0cIlIzyZ1StHp7dZn
         nONhMLuv125GXTkCV9NVdEAlKko0BHOGjtWufXyvCPoWp9qM4HBPnJkVmojbqYuqMzhp
         Uf7A==
X-Gm-Message-State: AOAM533X8XqKI3/ulnZrQOb6Ao6l/lk9Btdti+xlY+viSp26L5pYpMux
        IOrbbFBlWAM5unLKG7ZcTl0=
X-Google-Smtp-Source: ABdhPJx+XgdfHeO51+cCWNG5czFR+df7dLUPQj3BYSlBjqpwNILpNVry7RH0BDVF9KkhOGJh/nOoEg==
X-Received: by 2002:a17:902:e00e:b029:ef:5f1c:18a8 with SMTP id o14-20020a170902e00eb02900ef5f1c18a8mr415620plo.38.1623164084185;
        Tue, 08 Jun 2021 07:54:44 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id u14sm16171304pjx.14.2021.06.08.07.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:54:43 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenguanyou@xiaomi.com
Subject: Re:[PATCH] fuse: alloc_page nofs avoid deadlock
Date:   Tue,  8 Jun 2021 22:54:36 +0800
Message-Id: <20210608145436.1695-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603125242.31699-1-chenguanyou@xiaomi.com>
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ABCA deadlock

kswapd0 D 0 159 2 0x00000000
Call trace:
__switch_to+0x134/0x150
__schedule+0x12ac/0x172c
schedule+0x70/0x90
bit_wait+0x14/0x54
__wait_on_bit+0x74/0xe0
inode_wait_for_writeback+0xa0/0xe4
evict+0xa4/0x298
iput+0x33c/0x38c
dentry_unlink_inode+0xd8/0xe4
__dentry_kill+0xe8/0x22c
shrink_dentry_list+0x1e8/0x4f0
prune_dcache_sb+0x54/0x80
super_cache_scan+0x114/0x164
shrink_slab+0x5f8/0x708
shrink_node+0x144/0x318
kswapd+0xa10/0xc24
kthread+0x124/0x134
ret_from_fork+0x10/0x18

 
Thread-5 D 0 3396 698 0x01000808
Call trace:
__switch_to+0x134/0x150
__schedule+0x12ac/0x172c
schedule+0x70/0x90
try_to_free_pages+0x280/0x67c
__alloc_pages_nodemask+0x918/0x145c
fuse_copy_fill+0x15c/0x210
fuse_dev_do_read+0x4e8/0xcd4
fuse_dev_splice_read+0x84/0x1d8
SyS_splice+0x6ac/0x8fc
__sys_trace_return+0x0/0x4


u:r:kernel:s0 root 159 159 2 0 0 inode_wait_for_writeback 0 D 19 0 - 0 fg 6 [kswapd0] kswapd0
u:r:kernel:s0 root 25798 25798 2 0 0 __fuse_request_send 0 S 19 0 - 0 fg 2 [kworker/u16:0] kworker/u16:0
u:r:mediaprovider_app:s0:c203,c256,c512,c768 u0_a203 3254 3396 698 5736296 62012 try_to_free_pages 0 D 19 0 - 0 ta 4 com.android.providers.media.module Thread-5
