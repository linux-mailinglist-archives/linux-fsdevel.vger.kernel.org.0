Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12926725014
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjFFWpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbjFFWpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:45:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FB1717
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:45:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38e04d1b2b4so5653800b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686091536; x=1688683536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bcp3ffy5XwTKce5q56EsqOA6PVGSPjy/lGc3gn6qOmU=;
        b=Wj9iARWqwKYgu1upHY1HlgemGOrhjZzWv7NuN6Ahgl/AsNZfjnfA7Auy9tv7nZm4PR
         cDlu/GYxb3Sm/ROvjGgow1ZtN87VDyaCjxTir2f4Z1aJht/Jj8YS0TOdKMy3xdewK/z7
         ruYyjQhptjT9jyitvst2phsnk0OK2HvFuhXTq2OiB4AC42AL7ByRYrnQvAI3kqwk3bXo
         gKXtEZaFURDN6igizQDGKO8HhDy8VbSz7VvVbop2CFqMhcQ9lVdJSgXCTM6St/ymWfdO
         HnryHCajNg/IWpTBRklu65AOYO9egNLWiNS7pYFfEqD0YawgsPxScZXDAu6T02vzZkKc
         N6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686091536; x=1688683536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcp3ffy5XwTKce5q56EsqOA6PVGSPjy/lGc3gn6qOmU=;
        b=V850/H7dgvFk3xuxjFETnIOKaIjG0zSTSSx34+zlGhtcyowNrZVmLrLmOYteCfmhk9
         XyFWotfpaGn4Xug7TPzG6KalBHVhAWBLHmg7NGbLs+us3ek1qTZ/wxsNoZCfVy7igxRO
         NAg57mndm3pWzRkUfa+gBc1EPdBX+o5Js0SqFO3Ng8c/JOl79nRzg3HbqB6KmLZTkx3k
         LGtJX8PKPTv/haM+UE/DYwXFdkw/rrBUFmvzC6lIcGMxMwXSstrXsR2+qbywZGMIYJvJ
         MuNhGdvU6UY2mPvPAZTyzcu2OqBHaEvnOPCGBwObwPJDdIQuQ22vIDnOogKBgv/SJEJX
         Xnsw==
X-Gm-Message-State: AC+VfDzC6DGeBxbly0ccGuRZpQKhdwi4A5ExN6eMs/K3MnmcAxJiaoI/
        b71Cy5DVun33lgOEkuzr0qzEqw==
X-Google-Smtp-Source: ACHHUZ5fi0BA0A0q3DfsBlhTUutkY29CteYXLvsSh9kIVopCpR1sLQ1E5i8v1OAycYH7pgKENB/E3Q==
X-Received: by 2002:aca:130c:0:b0:396:3b9b:d217 with SMTP id e12-20020aca130c000000b003963b9bd217mr3496151oii.18.1686091536046;
        Tue, 06 Jun 2023 15:45:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id b10-20020a63cf4a000000b0050a0227a4bcsm7927471pgj.57.2023.06.06.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:45:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6fQi-008f6H-2S;
        Wed, 07 Jun 2023 08:45:32 +1000
Date:   Wed, 7 Jun 2023 08:45:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     syzbot <syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] INFO: task hung in btrfs_sync_file (2)
Message-ID: <ZH+3DJQC8CUSs+/x@dread.disaster.area>
References: <00000000000086021605fd1b484c@google.com>
 <20230606142405.GI25292@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142405.GI25292@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:24:05PM +0200, David Sterba wrote:
> On Thu, Jun 01, 2023 at 06:15:06PM -0700, syzbot wrote:
> > RIP: 0010:rep_movs_alternative+0x33/0xb0 arch/x86/lib/copy_user_64.S:56
> > Code: 46 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
> > RSP: 0018:ffffc9000becf728 EFLAGS: 00050206
> > RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000000038
> > RDX: fffff520017d9efb RSI: ffffc9000becf7a0 RDI: 0000000020000120
> > RBP: 0000000020000120 R08: 0000000000000000 R09: fffff520017d9efa
> > R10: ffffc9000becf7d7 R11: 0000000000000001 R12: ffffc9000becf7a0
> > R13: 0000000020000158 R14: 0000000000000000 R15: ffffc9000becf7a0
> >  copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
> >  raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
> >  _copy_to_user lib/usercopy.c:41 [inline]
> >  _copy_to_user+0xab/0xc0 lib/usercopy.c:34
> >  copy_to_user include/linux/uaccess.h:191 [inline]
> >  fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
> >  emit_fiemap_extent+0x18e/0x380 fs/btrfs/extent_io.c:2616
> >  fiemap_process_hole+0x516/0x610 fs/btrfs/extent_io.c:2874
> 
> and extent enumeration from FIEMAP, this would qualify as a stress on
> the inode

FWIW, when I've seen this sort of hang on XFS in past times, it's
been caused by a corrupt extent list or a circular reference in a
btree that the fuzzing introduced. Hence FIEMAP just keeps going
around in circles and never gets out of the loop to drop the inode
lock....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
