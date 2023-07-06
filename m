Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE774A0C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjGFPVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGFPVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:21:10 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E72173F
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 08:21:07 -0700 (PDT)
Date:   Thu, 6 Jul 2023 11:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688656865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yhAoOQcwd+d4OLL39cP41fnoMThXfUILYjJ33i61aFU=;
        b=QQmoeKEPL9xuySm8hbfJYwu3y419fER7BZmSfzAqdxmIB0txdzdDY15LCFe/FDNd1lSIVE
        Q5tHXN+llY0W9YMu9YVO4zj6K4ak8CeYIs2MhtqqnuHv3ExJYR/JUQR42h8qJTnz1LvTVO
        9znAKCiJI+R2fKeBsRk5IsX2isSOjjM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706152059.smhy7jdbim4qlr6f@moria.home.lan>
References: <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
 <20230629-fragen-dennoch-fb5265aaba23@brauner>
 <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
 <20230630-aufwiegen-ausrollen-e240052c0aaa@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630-aufwiegen-ausrollen-e240052c0aaa@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:40:32AM +0200, Christian Brauner wrote:
> We're all not very impressed with that's going on here. I think everyone
> has made that pretty clear.
> 
> It's worrying that this reply is so quickly and happily turning to
> "I'm a real engineer" and "you're confused" tropes and then isn't even
> making a clear point. Going forward this should stop otherwise I'll
> cease replying.
>
> Nothing I said was confused. The discussion was initially trying to fix
> this in umount and we're not going to fix async aio behavior in umount.

Christain, why on earth would we be trying to fix this in umount? All
you posted was a stack trace and something handwavy about how fixing it
in umount would be hard, and yes it would be! That's crazy!

This is a basic lifetime issue, where we just need to make sure that
refcounts are getting released at the appropriate place and not being
delayed for arbitrarily long (i.e. the global delayed fput list, which
honestly we should probably try to get rid of).

Furthermore, when issues with fput have caused umount to fail in the
past it's always been considered a bug - see the addition of
__fput_sync(), if you do some searching you should be able to find
multiple patches where this has been dealt with.

> My earlier mail clearly said that io_uring can be changed by Jens pretty
> quickly to not cause such test failures.

Jens posted a fix that didn't actually fix anything, and after that it
seemed neither of you were interested in actually fixing this. So based
on that, maybe we need to consider switching fstests back to AIO just so
we can get work done...
