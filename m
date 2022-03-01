Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688BF4C92B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiCASO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiCASOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:14:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7465154
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 10:14:09 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z16so15022957pfh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N36sF4HUer+rUuc5VxWx2NxZT2Mje9G1bKhkVtQFmow=;
        b=O9Pc4FRhQaHO8JwtvKmEa7P/p93QhIWPziYnJxBP3SmXkKfXwbS/+UXcAcizlZe2qE
         5++D1AzgFSiNA6GVcHz58RghXwcZj0T+stAg2S8I6BdGwjnEpqEP1SHJlTJIwhdk7I/A
         Km+JuAoSqO/aabb7J1BxN3aslickTdbOZI2Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N36sF4HUer+rUuc5VxWx2NxZT2Mje9G1bKhkVtQFmow=;
        b=bwvVsMYzQuNqdoUZFkgfZLeUDQY0RQ3M92Ga6CO1jfavf+WdbymNuhjrO+klgo93aB
         RmO8LdOOvWpU3b8b+Sc+uukenM0dm/rNGSJw5RZ44beIdnj52jWScZ4jcg5i95+A0X7N
         LzywVvc2LX05N2fcAYhiLKWMxI7KfyPLAkhTRgNVbLrpma9578cCJUXIe/LYa8nF1qRK
         PHkVL++0+fHrVL8T3JYgUe/i6oRyX3H3oHoUVlWXIl1N9S0Q9ojtJT/0IbWUDC8wmY/Q
         G/tynjb7soEQPiY7ljXQ7dbAsEQOmEySN/TuW98zBMxXGFg++cLeq/5Qd3s3sOVdtIub
         WokA==
X-Gm-Message-State: AOAM5316ovry9x3b0DjVyNUaLByxeQ4xU64xoYbtxsE9ed26bluRLygh
        Vf01bEO4dB06Hc0jU9EM2JCxWg==
X-Google-Smtp-Source: ABdhPJwl/oZl7jTR8Xbiy0diMdVywUoBtjuUV8iCsVjT5dJdX8x+nPRIiFjmEv3Xm0s1V2wXWPjOfA==
X-Received: by 2002:a62:d156:0:b0:4cd:fd21:e406 with SMTP id t22-20020a62d156000000b004cdfd21e406mr28741951pfl.44.1646158448831;
        Tue, 01 Mar 2022 10:14:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn10-20020a17090b38ca00b001bc3a60b324sm2540095pjb.46.2022.03.01.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:14:08 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:14:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
Message-ID: <202203011008.AA0B5A2D@keescook>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org>
 <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
 <Yh1aMm3hFe/j9ZbI@casper.infradead.org>
 <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 04:45:11PM -0800, Linus Torvalds wrote:
> Really. The "-Wshadow doesn't work on the kernel" is not some new
> issue, because you have to do completely insane things to the source
> code to enable it.

The first big glitch with -Wshadow was with shadowed global variables.
GCC 4.8 fixed that, but it still yells about shadowed functions. What
_almost_ works is -Wshadow=local. At first glace, all the warnings
look solvable, but then one will eventually discover __wait_event()
and associated macros that mix when and how deeply it intentionally
shadows variables. :)

Another way to try to catch misused shadow variables is
-Wunused-but-set-varible, but it, too, has tons of false positives.

I tried to capture some of the rationale and research here:
https://github.com/KSPP/linux/issues/152

-- 
Kees Cook
