Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304587AE9F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjIZKI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZKIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:08:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD497
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 03:08:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B3C433C7;
        Tue, 26 Sep 2023 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695722928;
        bh=zykksIGqZoBdbMss/bnZGnUX9BMIwBK5x+gpg5W14as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRaakjMgpEzIU6gDUxwG76Bi5f2HsTL0XZeNI102ywyROvfzBjtpc4k2HZWBFyT4L
         FzXDLZYEEGXnlz7m/uWijbHp6+LPAFHvSm6eeX2MJjA1yRZzuwJpK/gR0VFO8JT47j
         pRo+iE9U/2JJzL9vu0fAA59mObN5WNU24L8Azja1XQxW2MNLp40MEwUpxvCC35QDlt
         p2oGqCnXMAe72rOqTEVqPLotw2zHcJOwLHZnVKKlet02oo9P+0CglrUmZZM7TUJeRd
         tYmjjvFbUR4JLamFpMyZ5dLyPZtN2X9JyeuxVDJ9rVfJf0qQJXhcsFvj5nJjx0+UCK
         ykkDFeoibXl0w==
Date:   Tue, 26 Sep 2023 12:08:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <20230926-leinen-kaltlassen-b5cef5a1e877@brauner>
References: <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
 <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
 <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> What you are saying makes sense.
> And if we are being honest, I think that the right thing to do from the
> beginning was to separate the bug fix commit from the UAPI change.
> 
> The minimal bug fix is S_ISREG || S_ISBLK, which
> mentions the Fixes commit and will be picked for stable kernels.
> 
> Following up with another one or two patches that change
> the behavior of posix_fadvise on socket and readahead on
> socket and pipe.
> 
> The UAPI change is not something that has to go to stable
> and it should be easily revertable independently of the bug fix.
> Doing it otherwise would make our lives much harder if regressions
> turn up from the UAPI change.
> 
> Christian, Matthew,
> 
> Do you agree?

Fine by me.
