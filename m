Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6EB74FBE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGKXr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKXr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:47:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFE1711
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 16:47:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55767141512so3394299a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689119277; x=1691711277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCay/U1RrEecnRFjhTVjnG65uF6mvqkW/xdC2I0frE4=;
        b=lmvt7ZTI9XgTPI9CU/xbWuKnvnKy0d0muySJbYf6G2fXnXF8KJPoflclfaLKiJGkFP
         HG3C6Epehxl5ZJDeUwWOrA2YE8iG+zamIlg4a+15rRZrIf5nPodEk7NzV4+gF3jeKO2a
         MHDlbARt28rc9H1N3tZSMfU5ylLR7KpLZ70t45Ipbrs8viyQgM17Pn21236khPcIyVpM
         q8vt3teHXqT9uybmv4iUeM0q/3Kr40DspOTJ3s8VwBNcIV1m1merdWsyWO1SV2p6YMUv
         AvLcx2vmCDd7Hi/2dO8MVNbjEcvbnVRQQFtJFAsVM3BsU8p910/rLK2hKgSoGtuxU82I
         oTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689119277; x=1691711277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCay/U1RrEecnRFjhTVjnG65uF6mvqkW/xdC2I0frE4=;
        b=Cn95m91utp8kyT3/JAPWzA6bQx7abAUPdU9usNt117Hh0VH/3MhjZboKfyPtwc59lB
         KPvEOP2vAAkh4MxaiYTKNxeRkbHLS885x9+c5Dx7WCzT5Pu+QHWNcbhyxKGWUzlt3aG2
         E5uAS3zQuG1wr4xDERgTmmVJmyg+SNpSjLT+7Ze5lrKjpQTsroPPtfA3B+WXwq00wypH
         yU1Epu3UbxEnSM/7UIctWhyP3YNt8fkNfTbc8yE4JLjwNT0gPXut6TXPjJNfQR/xZoSU
         0SQCuvuOtRvygI4B9pkZLrMt5aHjVii6dk6fWRPhUj+4ZUBS41KmOyH1VssxGSduOuqQ
         Z9+A==
X-Gm-Message-State: ABy/qLYyX9PCRoJ3VpX3LXTTcRjmc0EXJUPYN3nzvauTdLEkD3td7PFX
        tcviP7CROeHsBhuQAjafBvfLRg==
X-Google-Smtp-Source: APBJJlHV6Rle475Ry7ncBqyxCTLlNFLiOaL0axgkatoQ/9FPY4rIHH6lmMoeC9SIK4xxpd/+JjtZBQ==
X-Received: by 2002:a05:6a20:8e25:b0:127:7ea7:e039 with SMTP id y37-20020a056a208e2500b001277ea7e039mr16261637pzj.62.1689119277206;
        Tue, 11 Jul 2023 16:47:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-246-40.pa.nsw.optusnet.com.au. [49.180.246.40])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8761c739csm2459281plb.271.2023.07.11.16.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 16:47:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qJN5G-004yaH-1D;
        Wed, 12 Jul 2023 09:47:54 +1000
Date:   Wed, 12 Jul 2023 09:47:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hao Xu <hao.xu@linux.dev>
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH v3 0/3] io_uring getdents
Message-ID: <ZK3qKrlOiLxS/ZEK@dread.disaster.area>
References: <20230711114027.59945-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711114027.59945-1-hao.xu@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:40:24PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> This series introduce getdents64 to io_uring, the code logic is similar
> with the snychronized version's. It first try nowait issue, and offload
> it to io-wq threads if the first try fails.
> 
> 
> v2->v3:
>  - removed the kernfs patches
>  - add f_pos_lock logic
>  - remove the "reduce last EOF getdents try" optimization since
>    Dominique reports that doesn't make difference
>  - remove the rewind logic, I think the right way is to introduce lseek
>    to io_uring not to patch this logic to getdents.
>  - add Singed-off-by of Stefan Roesch for patch 1 since checkpatch
>    complained that Co-developed-by someone should be accompanied with
>    Signed-off-by same person, I can remove them if Stefan thinks that's
>    not proper.
> 
> 
> Dominique Martinet (1):
>   fs: split off vfs_getdents function of getdents64 syscall
> 
> Hao Xu (2):
>   vfs_getdents/struct dir_context: add flags field
>   io_uring: add support for getdents

So what filesystem actually uses this new NOWAIT functionality?
Unless I'm blind (quite possibly) I don't see any filesystem
implementation of this functionality in the patch series.

I know I posted a prototype for XFS to use it, and I expected that
it would become part of this patch series to avoid the "we don't add
unused code to the kernel" problem. i.e. the authors would take the
XFS prototype, make it work, add support into for the new io_uring
operation to fsstress in fstests and then use that to stress test
the new infrastructure before it gets merged....

But I don't see any of this?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
