Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690696C424B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 06:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCVFlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCVFlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:41:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330D3FBBF;
        Tue, 21 Mar 2023 22:41:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c4so10439242pfl.0;
        Tue, 21 Mar 2023 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679463706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4AvIXzvw3CsklYuLdsWfKiwZldi09EF5IbRCiC4jps=;
        b=W53WgOijzJdl9bNR6Y5U3IeV+x7LsP7b5DM7BqVukp+H9lsvLycVb8gMuirAKiMQv8
         8WkPNdUvCCW2lk7SyFGv1kllOHKbBQ+x1JGDLWtJyi9o339XR+ldbOG4EijMlOYPu7rY
         qrezg49ISozTc/b/zCxrFfhHnrbCVzBKnSK4q4sPT7KNJbwRfdqjwuAHbSWBvKw+FcfD
         ly6psFiOj7HX/YhkhUTFFACsnaHhu+jvSf88m76P6fedkICdUDVS/gMd7ryOP4Wbcbjy
         dBFwW2jfSlIrFbtE9JWNNkePvUWX+ctfJmyK7frAOpE8ONsy7Bd+s3d/G1slIM+kj6uN
         cEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679463706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4AvIXzvw3CsklYuLdsWfKiwZldi09EF5IbRCiC4jps=;
        b=QuPkFVqSOko8JIXUkvQViEoaYxhjxw5ss4WPg7qLsJGNRTL5jA4UFLJxM/F3yADXWJ
         7HX0mpMz3etsim8nwdE8d15QFzRDYV7l7JD32CUbto4IRSzL+pwKLVdPiO1/ldOVaYii
         UVmPY1+0TQCY7rkTu6V0HjStVQcbiSZH6PoKvIU36TXVE86v+FQo/gMp4Kfx7tzNZ+8E
         HQIJoCEMZABLesc0RlYdssPtY+/tJC7aw+/VGdymOCI41W1oJQId7vc0cgxIns+VHjS3
         8EcZTAeIUHh7zLqrMGEMmk+7r4TiHRqPrLbWqs/WdxzlsKHJRHwjcCTMDzbHb6FsCf7m
         Emog==
X-Gm-Message-State: AO0yUKV8g9w5wYEMQqTuw4URMhRGWV3uVSSLEkGPJJcE4MPZaJUwirmY
        7tLBjxm8uffNMMUCZRq2bRYRF66sCSfZDFirAHc=
X-Google-Smtp-Source: AK7set9sjy9O1ZU4ulXRaSJ2vkwJpdnlLEUIA+hL7pQ8pbtoxWVAkmgK7pGt2P70e8sjiZQP7aO6FCNgLqa6US4uCfc=
X-Received: by 2002:a05:6a00:2d10:b0:625:ccea:1627 with SMTP id
 fa16-20020a056a002d1000b00625ccea1627mr1196919pfb.5.1679463705542; Tue, 21
 Mar 2023 22:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056cdc905f76c0733@google.com>
In-Reply-To: <00000000000056cdc905f76c0733@google.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Wed, 22 Mar 2023 05:41:34 +0000
Message-ID: <CAA5enKbNWqTp13a6dgkbm+aDY-PBr24x=aGXz6=JUxc0OM1UPg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] BUG: sleeping function called from invalid
 context in vm_map_ram
To:     syzbot <syzbot+6d9043ea38ed2b9ef000@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Mar 2023 at 17:03, syzbot
<syzbot+6d9043ea38ed2b9ef000@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    73f2c2a7e1d2 Add linux-next specific files for 20230320
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ad6e1cc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f22105589e896af1
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d9043ea38ed2b9ef000
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d199bac80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c7281c80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2e4e105e18cf/disk-73f2c2a7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/08d761112297/vmlinux-73f2c2a7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4b39e3e871ce/bzImage-73f2c2a7.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/662e0db5efdd/mount_0.gz
>
> The issue was bisected to:
>
> commit 8f4977bdd77ee3dce8af81488231e7535695f889
> Author: Lorenzo Stoakes <lstoakes@gmail.com>
> Date:   Sun Mar 19 07:09:31 2023 +0000
>
>     mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock

This patch has already been dropped in mm-unstable which will
eventually reach linux-next. The current revision of this patch set
retains the spinlocks.

[snip]

-- 
Lorenzo Stoakes
https://ljs.io
