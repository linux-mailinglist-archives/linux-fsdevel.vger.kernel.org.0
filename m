Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCE76601D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjG0XGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjG0XGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF730D2;
        Thu, 27 Jul 2023 16:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F198E61F71;
        Thu, 27 Jul 2023 23:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF41C433C7;
        Thu, 27 Jul 2023 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690499171;
        bh=mp+6eeWdbmozGnuHP1CrZuKe7UNHyWNqyT7n1JGbq74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUJuZA7CoC3eLAfCzzxB39paV4bm2lbq6Io0TZ2O698cn1IykRVgs8zNJ1PYLZT8e
         yy7VLGB+Z8W29IqbDI8xttbcli7kd8Ws42RqCr0wU7iOp/5WCp/I4njBjG2Oet8pvU
         YcgHH2STA8N0CfoSCGa8Mddi/t29ccCaBzhHEJS8WUltr5M7oODyJhlOJgPdC9cVSN
         KddM4RSIo97L2xHRfvKpQVOhNPjGp5RWfKtEkkTj+F+hvegVYFHL2bCeMO2SxAAoDs
         rCdbVJ1vbxoP9lU8yqVaaHUgFi8fPYUzyXfQnsHtS4bi6ZdayYVXq5ewmxFJeUmZNw
         65HMPzhJaeXFw==
Date:   Thu, 27 Jul 2023 16:06:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: xfs kdevops baseline for next-20230725
Message-ID: <20230727230610.GG11352@frogsfrogsfrogs>
References: <ZMK1r91ByQERwDK+@bombadil.infradead.org>
 <20230727225859.GF11352@frogsfrogsfrogs>
 <ZML3WJyqSYwzZW0w@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZML3WJyqSYwzZW0w@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:01:44PM -0700, Luis Chamberlain wrote:
> On Thu, Jul 27, 2023 at 03:58:59PM -0700, Darrick J. Wong wrote:
> > On Thu, Jul 27, 2023 at 11:21:35AM -0700, Luis Chamberlain wrote:
> > > The sections tested for are:
> > > 
> > > xfs_crc
> > > xfs_reflink
> > > xfs_reflink-normapbt
> > > xfs_reflink_1024
> > > xfs_reflink_2k
> > > xfs_reflink_4k
> > > xfs_nocrc
> > > xfs_nocrc_512
> > > xfs_nocrc_1k
> > > xfs_nocrc_2k
> > > xfs_nocrc_4k
> > > xfs_logdev
> > > xfs_rtdev
> > > xfs_rtlogdev
> > 
> > Question: Have you turned on gcov to determine how much of fs/xfs/ and
> > fs/iomap/ are actually getting exercised by these configurations?
> 
> Not yet, and it would somehow have to be the aggregate sum of the
> different guests, is that easy to sum up these days, given the same
> kernel is used?

I think so?  I sent out that patch to fstests that automates fstests
pushing gcov data into the report dir.  If you take each machine's data
to the build machine and make the paths match, you can then run lcov on
each report dir to spit out an lcov file, and then tell genhtml to spit
out an html report given all the lcov output files.

(Or you can mount the kernel source in the same place on the test vm as
the build machine, and fstests will at least run lcov for you...)

> > I have for my fstests fleet; it's about ~90% for iomap, ~87% for
> > xfs/libxfs, ~84% for the pagecache, and ~80% for xfs/scrub.  Was
> > wondering what everyone else got on the test.
> 
> Neat, it's something we could automate provided if you already have
> a way to sum this up, dump it somehwere and we I can make a set of
> ansible tasks to do it.

That part gets a little gross, because gcc embeds canonical source code
pathnames into the kernel binary, which has proven to be a tripping
point for getting lcov/genhtml to find the .c and .h files.

--D

> 
>   Luis
