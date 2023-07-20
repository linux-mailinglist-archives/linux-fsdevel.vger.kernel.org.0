Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F375BAAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGTWf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGTWf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:35:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B217171A
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 15:35:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66869feb7d1so876414b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689892555; x=1690497355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=827HsqvX6WBlFw51vCxOTglmk2dU45yyuzKnxw3gMFY=;
        b=hdETDh6yc3F9HiYilCKMcow2i5Yvt2ogRY9RMlASC92EZO/pENHRO/DkNRC+JIJvYs
         6xBmO7KFx41oC2dM2Rl1qV1pnGWxAhjV6fARi7Z52UDZ4ovyZADcBKrNLgmtZ0j5k5sy
         8Nbd6Tw42TUNPkukZTgeQBWV0VxAdlAGOBgIlA2maw5Rv90rgDS9tHpbbKiVictqQAsh
         7rOE/rKiYTyN2XS1Jypx3+3P2csQY9BrCNZHpJn2M5uIVQF2XGC1sVKjjxtkDz3AFK/R
         5wA+TihzYU4jRtyhuPJ492HXdXyF5YeewfLR/fnB+4ksVOkyIsLsmuG6KpHIjyEW3T6z
         NFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892555; x=1690497355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=827HsqvX6WBlFw51vCxOTglmk2dU45yyuzKnxw3gMFY=;
        b=IaP3ns0eCkkNxMP67JcxxWZoZT8fE6XwxENQ/9IxQHilU0WGyAT6Sc/dt3BSte67ZL
         /105NKjB1iXGc2Ns5uz76vEw6hI8UNQKOpZK69WLkIZiPqz8JawP+BgFZmPJ0Xz/LUpQ
         pvgqo6ofCU1q2d53pjU2OwaH2xuyshyJ2sNenBnVeONkGX44TsTUydzUBfUNLywzCCAc
         nMaI1JPCMFpgCCPeji5htRRE0d3RVHubVm+YzSCpXGxAB32mxXMKM+DMojvU345duxuv
         K7UAehGVuR2iFeW+Q27P5+ieh4x6LgXL+4s99l+Oy28y1b/ZQE1eAhLb94VBNuBXAqnj
         TaPg==
X-Gm-Message-State: ABy/qLaAQKMnCsNQk5oGDiMlSWrdAGZMTCWXPejZYDoaJMw7BlYbBFpM
        ZSzeWnSkObmKAf8laRJV61/fgQ==
X-Google-Smtp-Source: APBJJlFwpPCbuXUzrPoRRI+nJlu/Yh86JY5lPuCfjMaUfPIKEZhU6apW0FMuGV4M4R5IofhAtenjcQ==
X-Received: by 2002:a05:6a00:1747:b0:677:bdc:cd6b with SMTP id j7-20020a056a00174700b006770bdccd6bmr140500pfc.19.1689892554927;
        Thu, 20 Jul 2023 15:35:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id c1-20020a639601000000b00563826c66eesm183814pge.61.2023.07.20.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:35:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qMcFS-008X1K-1q;
        Fri, 21 Jul 2023 08:35:50 +1000
Date:   Fri, 21 Jul 2023 08:35:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com>
Cc:     dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_pack_data
Message-ID: <ZLm2xooY/H81v5Xi@dread.disaster.area>
References: <00000000000029729c05fe5c6f5c@google.com>
 <000000000000b76f3a0600e28b22@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b76f3a0600e28b22@google.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:14:26PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit f1e1765aad7de7a8b8102044fc6a44684bc36180
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Wed Jun 28 18:04:33 2023 +0000
> 
>     xfs: journal geometry is not properly bounds checked
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d43cc6a80000
> start commit:   fb054096aea0 Merge tag 'mm-hotfixes-stable-2023-06-12-12-2..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcee04c3b2a8237
> dashboard link: https://syzkaller.appspot.com/bug?extid=b7854dc75e15ffc8c2ae
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482afc7280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429c5e7280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: journal geometry is not properly bounds checked

-- 
Dave Chinner
david@fromorbit.com
