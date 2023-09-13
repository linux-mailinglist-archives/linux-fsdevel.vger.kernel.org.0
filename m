Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5916C79EA64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjIMOEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240967AbjIMOEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:04:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8029319BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 07:03:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0e7e3d170so111545ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694613837; x=1695218637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbf4pzJMJn3E/mF4AbfFpdKloLbf3OXmB4MymT49h4o=;
        b=3DkpnCwhC+omEKwlN9o1Iz67MaSZ3DQFjVqT6dtud2iyVPHx5OjzLpmon1RfttylPe
         8jral7t0M+rwE05F2CElNGSNECWRh7QesKicZZtRa7zqoA2SdcUrPsi0WtvLYmtiK4OE
         5YUTEpOAgYpKyfNZHg/Wq6zT5iDPfBUQ+gfWCfs0WlUSI68O5p5mCbBiI5FShaEvKCck
         nFiH9aS7rt2htAJCqjEZmp5G4a3p7suDIiPrNfpp49pvCwiNfuOtQOahohnNj3L/lVQi
         8svkpCRdo9/PZCaAOzZQnDuZPedLRtmcFrtCU+Oz3nu2r+n9gGEHqNgXbtoYGJv+qYGi
         PHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613837; x=1695218637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbf4pzJMJn3E/mF4AbfFpdKloLbf3OXmB4MymT49h4o=;
        b=Vmktbat+XNAAlcMMYMhDoLCkd9rKWDdg/KIT0bWF6Rmxb1GrLLX611spJnvoN8J5VE
         s3E7JJUrm0K67zDYubnsQfseAAmeNYOL4Gy624o06N/BzQ7VUBvA3jb9c8e/BunSzr1M
         eBOAUptobtb9X/Lm86FbD3wu7m2OxiP9mBqjN8DKBsQcyuPf66bwrZnTDUHJ5XQHe1jY
         dRGDUuuR6P4ZoACDOrtgAVSi7AO+cRMqBMzJAKJ4/wCRZD0SPoeIJTUlDte1vDoHDm2E
         1OfprA5YsDn0uvBoAk5/a4HxqcLYJHAn0wo/Thw2xfTQjHF1HbQKUQpz1wdC850jWEGA
         JVyA==
X-Gm-Message-State: AOJu0YxRnDjsyiizvU4jHOd4BRXr313hd5D4CrAxdsKHwZoJrp+NCwMr
        24/WyVRLIVsX4e8c783giNTC3U51Rp10qz2rieGkWbAA3WUMyYSzaswncQ==
X-Google-Smtp-Source: AGHT+IE8lDuQw5HXkiPu6QKS/G01K1tdv3YfjR7YUC81eAfVhxONIXWM/2mgAad7LSSicACipvJqALHXy149G9Cpqsk=
X-Received: by 2002:a17:902:e808:b0:1c3:a396:25c5 with SMTP id
 u8-20020a170902e80800b001c3a39625c5mr160302plg.27.1694613836733; Wed, 13 Sep
 2023 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fcf6d705ee1d8947@google.com> <00000000000029cdd406050ccfff@google.com>
In-Reply-To: <00000000000029cdd406050ccfff@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 13 Sep 2023 16:03:45 +0200
Message-ID: <CANp29Y7DrVYZj+1Nw9HLD6JF0NAJgFE+kuJHm1Q1dC_yqckCuA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in do_chunk_alloc
To:     syzbot <syzbot+88247ec7a18c953867d5@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 5:20=E2=80=AFAM syzbot
<syzbot+88247ec7a18c953867d5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit cd361199ff23776481c37023a55d855d5ad5c0f5
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Jul 31 20:28:43 2023 +0000
>
>     btrfs: wait on uncached block groups on every allocation loop
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1582bf1468=
0000
> start commit:   eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8cdf448d3b352=
34
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D88247ec7a18c953=
867d5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10b80ab1880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12dd6d4588000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: btrfs: wait on uncached block groups on every allocation loop
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

It looks related.

#syz fix: btrfs: wait on uncached block groups on every allocation loop
