Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F163A81E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiK1MV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 07:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiK1MVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:21:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A924FF3C;
        Mon, 28 Nov 2022 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0jTjPnEXF9rvIRpE8DHNiBs/FGP8+7Q4ANL2wupzRnQ=; b=hWIFkQXDePyN3yKlfK7LM7fukb
        WXti2Z6NTUVKJ5YgB5mkZ4Z2oC5dEV+hOBTeiZcw6pk7Nb1o5pwaVToQRPj8Oyu77fwhoCeCpkBSk
        RQI211NAaYIViiRkmRe21+yJDeTuf4EoNQRwvVYUYFc7f/Nk+n+DjDXre/7AR2M+Gf9aunw0DQ+jT
        f/3ojFWNjL3imou0P94bNd0gduEXn0P4yGYfD8h/GcHOoidwUpGdFnPWbASmjNOvCLXuTRaDU2Jkb
        sLXQEGuOJL5XqNwS5Apa+s02RaiZeWeYKOzTubcY4GFSCPbP14dyhnh0C+tnQZZgQwUsx8j2RYNK4
        l26G5nGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozd61-00CiHL-3C; Mon, 28 Nov 2022 12:18:49 +0000
Date:   Mon, 28 Nov 2022 12:18:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jorropo <jorropo.pgm@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, nborisov@suse.com
Subject: Re: [REGRESSION] XArray commit prevents booting with 6.0-rc1 or later
Message-ID: <Y4SnKWCWZt0LtYVN@casper.infradead.org>
References: <CAHWihb_EYWKXOqdN0iDBDygk+EGbhaxWHTKVRhtpm_TihbCjtw@mail.gmail.com>
 <Y3h118oIDsvclZHM@casper.infradead.org>
 <CAHWihb_HugpV44NdvUc2CV_0q2wk-XWyhmGdQhwCP6nDmo1k7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWihb_HugpV44NdvUc2CV_0q2wk-XWyhmGdQhwCP6nDmo1k7g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 12:20:13AM +0100, Jorropo wrote:
> Matthew Wilcox <willy@infradead.org> wrote :
> >
> > On Sat, Nov 19, 2022 at 05:07:45AM +0100, Jorropo wrote:
> > > #regzbot introduced v5.19-rc6..1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
> > >
> > > Hi, I recently tried to upgrade to linux v6.0.x but when trying to
> > > boot it fails with "error: out of memory" when or after loading
> > > initramfs (which then kpanics because the vfs root is missing).
> > > The latest releases I tested are v6.0.9 and v6.1-rc5 and it's broken there too.
> > >
> > > I bisected the error to this patch:
> > > 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae "XArray: Add calls to
> > > might_alloc()" is the first bad commit.
> > > I've confirmed this is not a side effect of a poor bitsect because
> > > 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae~1 (v5.19-rc6) works.
> >
> > That makes no sense.  I can't look into this until Wednesday, but I
> > suggest that what you have is an intermittent failure to boot, and
> > the bisect has led you down the wrong path.
> 
> I rebuilt both 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae and
> the parent commit (v5.19-rc6), then tried to start each one 8 times
> (shuffled in a Thue morse sequence).
> 0 successes for 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
> 8 successes for v5.19-rc6
> 
> This really does not look like an intermittent issue.

OK, you convinced me.  Can you boot 1dd685c414 with the command line
parameters "debug initcall_debug" so we get more information?
