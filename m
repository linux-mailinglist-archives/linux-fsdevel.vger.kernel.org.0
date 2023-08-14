Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06977BEDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjHNRXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjHNRWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994B10D5;
        Mon, 14 Aug 2023 10:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC434621EC;
        Mon, 14 Aug 2023 17:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFFCC433C8;
        Mon, 14 Aug 2023 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692033766;
        bh=HcH8g72IkEwqVXV3lVVbi32T8H+EA8+1qJxaP105Xfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrOYKvFiqhixgSM3rPYD6HDsAi1fNiaEvml5tIsXeUZuaYCMdhBJy+xLXaA1boJcX
         bWCVTn/8F1xBm3i27RgrGdjLTC+cHeHejNbeKLT5R5u9OOqRtCmz8EBcn2tIvR+RaD
         ACVydvxnj5JQdh5euSNa9NvD3133Jfjhcifv5rpQ3u26XLs2LNwbTD//oaT3DmPdHi
         44XdHIPj6FEn7hGOppi2pHVrZT0EXHC5wH7Ax0YQ+fJyVPdo6LHiysFbvgMjezMGyL
         Yu+T2qJjzcXnDKtNVPNKo20MtYo9Uyv+C9LToeSxQeOEzeoeYfQAQmKC156z0kIEyK
         EIHXNkzekshKw==
Date:   Mon, 14 Aug 2023 10:22:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230814172244.GA1171@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
 <ZNhJSlaLEExcoIiT@casper.infradead.org>
 <20230813043022.GA3545@sol.localdomain>
 <20230814113852.GD2247938@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814113852.GD2247938@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:38:52AM -0400, Theodore Ts'o wrote:
> On Sat, Aug 12, 2023 at 09:30:22PM -0700, Eric Biggers wrote:
> > Well, one thing that the kernel community can do to make things better is
> > identify when a large number of bug reports are caused by a single issue
> > ("userspace can write to mounted block devices"), and do something about that
> > underlying issue (https://lore.kernel.org/r/20230704122727.17096-1-jack@suse.cz)
> > instead of trying to "fix" large numbers of individual "bugs".  We can have 1000
> > bugs or 1 bug, it is actually our choice in this case.
> 
> That's assuming the syzbot folks are willing to enable the config in
> Jan's patch.  The syzbot folks refused to enable it, unless the config
> was gated on CONFIG_INSECURE, which I object to, because that's
> presuming a threat model that we have not all agreed is valid.
> 
> Or rather, if it *is* valid some community members (or cough, cough,
> **companies**) need to step up and supply patches.  As the saying
> goes, "patches gratefully accepted".  It is *not* the maintainer's
> responsibility to grant every single person whining about a feature
> request, or even a bug fix.

They did disable CONFIG_XFS_SUPPORT_V4.  Yes, there was some pushback, but they
are very understandably (and correctly) concerned about ending up in a situation
where buggy code is disabled for syzkaller but enabled for everyone else.  They
eventually did accept the proposal to disable CONFIG_XFS_SUPPORT_V4, for reasons
including the fact that there is a concrete deprecation plan.  (FWIW, the XFS
maintainers had also pushed back strongly when I suggested adding a kconfig
option for XFS v4 support back in 2018.  Sometimes these things just take time.)

Anyway, syzkaller is just the messenger that is reminding us of a problem.  The
actual problem here is that "make filesystems robust against concurrent changes
to block device's page cache" is effectively unsolvable.  *Every* memory access
to the cache would need to use READ_ONCE/WRITE_ONCE, and *every* re-read of
every field would need to be fully re-validated.  PageChecked would need to go
away for metadata, as it would be invalid to cache the checked status at all.
There's basically zero chance of getting this correct; filesystems struggle to
validate even the metadata read from disk correctly, so how are they going to
successfully continually revalidate all cached metadata in memory?

I don't understand why we would waste time trying to do that instead of focusing
on an actual solution.  Sure, probably The Linux Filesystem Maintainers(TM)
don't have time to help with migrating legacy use cases of writing to mounted
block devices, but that just means that someone needs to step up to do it.  It
doesn't mean that they need to instead waste time on pointless "fixes".

Keep in mind, the syzkaller team isn't asking for these pointless "fixes"
either.  They'd very much prefer 1 fix to 1000 fixes.  I think some confusion
might be arising from the very different types of problems that syzkaller finds.
Sometimes 1 syzkaller report == 1 bug == 1 high-priority "must fix" bug == 1
vulnerability == 1 fix needed.  But in general syzkaller is just letting kernel
developers know about a problem, and it is up to them to decide what to do about
it.  In this case there is one underlying issue that needs to be fixed, and the
individual syzkaller reports that result from that issue are not important.

- Eric
