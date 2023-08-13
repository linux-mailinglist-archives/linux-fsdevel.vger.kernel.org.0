Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1580477A4F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 06:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHMEaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 00:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHMEaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 00:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF21701;
        Sat, 12 Aug 2023 21:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3387160A6D;
        Sun, 13 Aug 2023 04:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54070C433C7;
        Sun, 13 Aug 2023 04:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691901024;
        bh=C9pWXxBilxJdH8Y7mBGisX4v0+MjqIvuoPcip0f+Zu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1+iWqUxRkDve5Ugw1GmTMdyIORsu+T3tGZxclefsBMszOaJNk358YyigYEFw7m+3
         vjQNl9X950SqC48q7G9q4jG8hrL3D7Sg2HCG6RaT+yZKRSt7B0W/ingZWrdkWFHQLw
         zVNqmwMNrLIJv7UHT6b6TpTs7FuxN9bixOrEN+OT1yUi1nWzPm7c1OQR3rckCo0247
         W9icUGUqaMmRPVQX4/QxSjlb/CUzBiwSXb/9jAAq5boL5KUo+Us1N3facjhouxQrbo
         5NpTiV5pXmbfHmGauDtKW0Y6vfqdvs9xxOu1reMg/GmgLuUIh2Ild8w/t/2Mkw7xXv
         3xwkolkyKcnrw==
Date:   Sat, 12 Aug 2023 21:30:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230813043022.GA3545@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
 <ZNhJSlaLEExcoIiT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNhJSlaLEExcoIiT@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 13, 2023 at 04:08:58AM +0100, Matthew Wilcox wrote:
> On Sat, Aug 12, 2023 at 07:06:47PM -0400, Theodore Ts'o wrote:
> > One could say that this is an insane threat model, but the syzbot team
> > thinks that this can be used to break out of a kernel lockdown after a
> > UEFI secure boot.  Which is fine, except I don't think I've been able
> > to get any company (including Google) to pay for headcount to fix
> > problems like this, and the unremitting stream of these sorts of
> > syzbot reports have already caused one major file system developer to
> > burn out and step down.
> > 
> > So problems like this get fixed on my own time, and when I have some
> > free time.  And if we "simplify" the code, it will inevitably cause
> > more syzbot reports, which I will then have to ignore, and the syzbot
> > team will write more "kernel security disaster" slide deck
> > presentations to senior VP's, although I'll note this has never
> > resulted in my getting any additional SWE's to help me fix the
> > problem...
> > 
> > > So just __ext4_iget() needs to be fixed.  I think we should consider doing that
> > > before further entrenching all the extra ->s_encoding checks.
> > 
> > If we can get an upstream kernel consensus that syzbot reports caused
> > by writing to a mounted file system aren't important, and we can
> > publish this somewhere where hopefully the syzbot team will pay
> > attention to it, sure...
> 
> What the syzbot team don't seem to understand is that more bug reports
> aren't better.  I used to investigate one most days, but the onslaught is
> relentless and I just ignore syzbot reports now.  I appreciate maintainers
> don't necessarily get that privilege.
> 
> They seem motivated to find new and exciting ways to break the kernel
> without realising that they're sapping the will to work on the bugs that
> we already have.
> 

Well, one thing that the kernel community can do to make things better is
identify when a large number of bug reports are caused by a single issue
("userspace can write to mounted block devices"), and do something about that
underlying issue (https://lore.kernel.org/r/20230704122727.17096-1-jack@suse.cz)
instead of trying to "fix" large numbers of individual "bugs".  We can have 1000
bugs or 1 bug, it is actually our choice in this case.

- Eric
