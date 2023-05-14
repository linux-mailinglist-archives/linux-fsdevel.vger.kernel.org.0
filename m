Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D944701F3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjENTYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjENTYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 15:24:34 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69DE4E
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 12:24:33 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c3e89c73aso591226939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 12:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684092272; x=1686684272;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHW0nI6H2FcFpSl0aYh5htCNfRJ7yLNtk6GzE1OYBpI=;
        b=XbNdgZ57a/sBEtqv1icEpC+BgcO6CZJcLawLthyQfIB571p/ua2yXzqX9Mb8RkdTZU
         /iTxBPuemm6V7iljKAurFnOnNKN5ILCQrD3vEfsZvaXMuBl5YW7Sukxb/a5slRYI8AY9
         kp2yX7v7mSTvOF7oqgR61gwy3ElWxUVzKwedf8Q9H6uC8OrlHF1ACN8btX5nyLbA8sQg
         +9kzwF9BEu7Qwuvo6jVHHlKhmxaVx3hmhf8DeMsX+58IsbQL9IaSDgwG8TchqMW03wzM
         UwYw6WWD5w+DTQDcACPKDWot2w7ugKODwXxMMWTETU4JsdViM5InYpGM4Aa5d+COThJj
         VaPw==
X-Gm-Message-State: AC+VfDyOXgy3Nb4eCcmm7XBqv6k8jKN8v/RHwVZUO9KK8hIlmxwNWelI
        9FQn/bOz1vq7TTThjGwHCHimNrwRQOpJbLK0x3LVOmjwJOLh
X-Google-Smtp-Source: ACHHUZ5Y0vzpnp4+DPbYi+I26fxuBeilv3DJXiAqkOqpAKAHbMzQZER1iFukjU83QXz+KdpegjrEexw9ctomDvJw8rYHPH5mvr6Z
MIME-Version: 1.0
X-Received: by 2002:a5d:9852:0:b0:766:655b:37a3 with SMTP id
 p18-20020a5d9852000000b00766655b37a3mr14007740ios.4.1684092272324; Sun, 14
 May 2023 12:24:32 -0700 (PDT)
Date:   Sun, 14 May 2023 12:24:32 -0700
In-Reply-To: <000000000000a74de505f2349eb1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9377e05fbac4945@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_setattr
From:   syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e372c6280000
start commit:   e922ba281a8d Add linux-next specific files for 20230512
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e372c6280000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e372c6280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17a4c2d44484b62f
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb68193bdb95af4340a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172a21c6280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b67fc6280000

Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
