Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB60525F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378705AbiEMJ60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379240AbiEMJ6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 05:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EB2A9CCD;
        Fri, 13 May 2022 02:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0128362212;
        Fri, 13 May 2022 09:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B15C34100;
        Fri, 13 May 2022 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652435902;
        bh=geXCIWlkv+OlijzBTHXYxcV6pNiY0Up+Vp3bfhyaJJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH1Dfntm87x1wiZBLLaTYTEEDS0pFYEPM9XGeAJDbpIGPy93alwWKx0qA7fMShBJ7
         L6pZ98Pa7wdLEUkiolkgot55ptGmQPqsrAT9VfNbJMTSqRaCJBqN/xRQCMiz/14KXY
         t+MkFBI+A4ZWYENR+pG9DkF499tfT8YdlkUgN7OsjUnwU+iWfMi2E9ryi4/qg5mm2I
         tqAe6oD5h3ko1mHVAlrs6oyaTBOW8N/Cq6fcvuCU0nqigE6YOuku9ZDtzjQxTJwU1Q
         ReGP3jNzoYLV1m5S8WB1tbO+2zzAIx1whsfhojPU13Fc/75kJDGbqO5WFBxqO7rU3y
         aOFeKr897J43A==
Date:   Fri, 13 May 2022 11:58:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Simon Ser <contact@emersion.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <20220513095817.622gcrgx3fffwk4h@wittgenstein>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
 <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
 <CAJfpegs4GVirNVtf4OqunzNwbXQywZVkxpGPtpN=ZonHU2SpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs4GVirNVtf4OqunzNwbXQywZVkxpGPtpN=ZonHU2SpiA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 02:56:22PM +0200, Miklos Szeredi wrote:
> On Thu, 12 May 2022 at 14:41, Simon Ser <contact@emersion.fr> wrote:
> >
> > On Thursday, May 12th, 2022 at 12:37, Simon Ser <contact@emersion.fr> wrote:
> >
> > > what would be a good way to share a FD to another
> > > process without allowing it to write to the underlying file?
> >
> > (I'm reminded that memfd + seals exist for this purpose. Still, I'd be
> > interested to know whether that O_RDONLY/O_RDWR behavior is intended,
> > because it's pretty surprising. The motivation for using O_RDONLY over
> > memfd seals is that it isn't Linux-specific.)
> 
> Yes, this is intended.   The /proc/$PID/fd/$FD file represents the
> inode pointed to by $FD.   So the open flags for $FD are irrelevant
> when operating on the proc fd file.

Fwiw, the original openat2() patchset contained upgrade masks which we
decided to split it out into a separate patchset.

The idea is that struct open_how would be extended with an upgrade mask
field which allows the opener to specify with which permissions a file
descriptor is allowed to be re-opened. This has quite a lot of
use-cases, especially in container runtimes. So one could open an fd and
restrict it from being re-opened with O_WRONLY. For container runtimes
this is a huge security win and for userspace in general it would
provide a backwards compatible way of e.g., making O_PATH fds
non-upgradable. The plan is to resend the extension at some point in the
not too distant future.

Christian
