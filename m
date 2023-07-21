Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E575BBC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGUBZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 21:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUBZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:25:34 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF891998;
        Thu, 20 Jul 2023 18:25:33 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3489cd4e3d3so7291905ab.3;
        Thu, 20 Jul 2023 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689902732; x=1690507532;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZqixkMebZCsM97BxEH3OKrgsuW4WW+mzbaKw56ziPA=;
        b=Wbfj34d7v4HVvq4v7ZnXIZR1/vaNl8EYpDwbbU6oV2D5lVO5stb7a4OT3dsCrtl+Or
         h+s8YDh3Pv7uzd/p4572BJ81q0cb9m0SrOVX2QvuCjLf71F52FnMzKgytXLKHoTgVC25
         FwhDom0beSiCFoEprJ1vMJWSf4Ypsj6quXfY0YdFpTTJQ6HH6k3YPYTNzVksO10HEEbE
         sxQd1jDIZ4lJ7vGm9prMqL1Fyd2pcYyJ2IQdlfSbFOLBD36MyfyGKpWnLsI8zDpDygLn
         0QYqzy4dYwsBmyoH04K06TZVloBIv7xWXLw9R5oJCfEbecgdIJ/45dh7CkIjtCZBingD
         qbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689902732; x=1690507532;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zZqixkMebZCsM97BxEH3OKrgsuW4WW+mzbaKw56ziPA=;
        b=Y9P3x7Ztv7rBSsaLTnDvrAtgxqg8nWmeIY1mctEId5Q2+LvmnaHKIHxEYthXs+8Mdb
         00GwgvRlfj3Ud4S02jMMgwskKIeqHaYHAfWW206y9U6IKWezJGNpb6vNZg9t+1er8ve6
         h3Wcv84Uj8dP4AOtcvHCqN3W83BzxbIda1miny6DCHDvAzzyVQv1Sbtflqw0iJ05rFhf
         HvQzpB1XbNOcaYFAkSeVRAwl+sWuJBgy+8r78gGfdzXWIZ9Gj2deurC1uocllJTuJgaB
         6bXiB65zIV6BVt9VvVdyS+SXPu9sMckxqPrLYQ/Yk9G9YkuoCKTfpTSHoSdgB2ljs0VX
         Mc+A==
X-Gm-Message-State: ABy/qLYR64qhEqwEMqvGTCM1EqU469vmv43E+uxfFV4eFzSWDAqCBlC6
        lKpWL39xEyf+8FJ3GgEIlDSqPjJHezcctA==
X-Google-Smtp-Source: APBJJlEOUafjOMIVHPQMCzxz/WV5yWTR2AIHYfgQhNMImcwG1xVJfWmfN6s1dN5XztZqalTExQ9eHA==
X-Received: by 2002:a05:6e02:f02:b0:346:8b4:34c with SMTP id x2-20020a056e020f0200b0034608b4034cmr661814ilj.16.1689902732151;
        Thu, 20 Jul 2023 18:25:32 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id c1-20020aa781c1000000b00679dc747738sm1866659pfn.10.2023.07.20.18.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 18:25:31 -0700 (PDT)
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Matthew Wilcox <willy@infradead.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
 <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
 <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
 <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
 <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <15ddfcec-8c2a-6f86-db99-8ce5bdc8078d@gmail.com>
Date:   Fri, 21 Jul 2023 13:25:21 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Am 21.07.2023 um 13:11 schrieb Matthew Wilcox:
> You've misunderstood.  Google have decided to subject the entire kernel
> (including obsolete unmaintained filesystems) to stress tests that it's
> never had before.  IOW these bugs have been there since the code was
> merged.  There's nothing to back out.  There's no API change to blame.
> It's always been buggy and it's never mattered before.
>
> It wouldn't be so bad if Google had also decided to fund people to fix
> those bugs, but no, they've decided to dump them on public mailing lists
> and berate developers into fixing them.

Dumping these reports on public mailing lists may still be OK (leaving 
aside that this invites writing code to exploit these bugs). Asking 
nicely for a fix, too.

'Berating developers' clearly oversteps the mark.

Maybe Google need to train their AI (that they're evidently training on 
kernel source, so ought to be grateful for such a nice training set) 
with a view to manners? We'd sure hate Google's input to go ignored for 
lack of civility?

(We could always reassign bugs of this sort against e.g. HFS to 
distrubtions, of course. They might have the resources to do something 
about it. Doesn't Google distribute Linux in some form or other? Is 
Android or ChromeOS susceptible to this issue? Time to find out ...)

Be that as it may - removing code that still has use, just to appease 
pushy Google staff (or AI) is just plain wrong IMO.

Cheers,

	Michael
