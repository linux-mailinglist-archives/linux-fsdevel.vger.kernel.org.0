Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34063E444
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiK3XIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 18:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK3XIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:08:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C8175B0;
        Wed, 30 Nov 2022 15:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B59F61E4E;
        Wed, 30 Nov 2022 23:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7403DC433C1;
        Wed, 30 Nov 2022 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669849720;
        bh=gIsKtLlwreqCB7ezRWhogZnbxTjnJ7Cq3evA1aLIWG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+CM5yo0TIxyPSTLLbKcC6YPQxWwBNlIU8EJ8+4k0n07P3hJmA9DvaqlLHhN0TECG
         I/pFc8ryB5vfagkTlAkts3qa+Ev9mJi/Vs5g31VFbBlRdvaBFdl3c6PMnAeXZFqA2h
         nPiAInI+p6ftAf99zvoYpGS2eBWe0GQybOYgcdyH9mJooQL+k+6H7NxifF3SaB5YCo
         N2IfgXHGXrMKsBl4bQ7ZESqTfXhObAo3i8HgBcijX9ap/UUH0JOwUDaPhWhMit8Lor
         2lfDWtkdidpRUIQZ5N/bizTfkxLkHkNyMCG4+m8VmRM7umz2EayoNbt4n3KfPxKF5n
         boobxJUKbGNQA==
Date:   Wed, 30 Nov 2022 15:08:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
Message-ID: <Y4fid4ZFSUWvWzNH@magnolia>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20221130132725.cd332f03ad3fb5902a54c919@linux-foundation.org>
 <6387cfcbea21f_3cbe0294b9@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6387cfcbea21f_3cbe0294b9@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:48:59PM -0800, Dan Williams wrote:
> Andrew Morton wrote:
> > On Tue, 29 Nov 2022 19:59:14 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > [ add Andrew ]
> > > 
> > > Shiyang Ruan wrote:
> > > > Many testcases failed in dax+reflink mode with warning message in dmesg.
> > > > This also effects dax+noreflink mode if we run the test after a
> > > > dax+reflink test.  So, the most urgent thing is solving the warning
> > > > messages.
> > > > 
> > > > Patch 1 fixes some mistakes and adds handling of CoW cases not
> > > > previously considered (srcmap is HOLE or UNWRITTEN).
> > > > Patch 2 adds the implementation of unshare for fsdax.
> > > > 
> > > > With these fixes, most warning messages in dax_associate_entry() are
> > > > gone.  But honestly, generic/388 will randomly failed with the warning.
> > > > The case shutdown the xfs when fsstress is running, and do it for many
> > > > times.  I think the reason is that dax pages in use are not able to be
> > > > invalidated in time when fs is shutdown.  The next time dax page to be
> > > > associated, it still remains the mapping value set last time.  I'll keep
> > > > on solving it.
> > > > 
> > > > The warning message in dax_writeback_one() can also be fixed because of
> > > > the dax unshare.
> > > 
> > > Thank you for digging in on this, I had been pinned down on CXL tasks
> > > and worried that we would need to mark FS_DAX broken for a cycle, so
> > > this is timely.
> > > 
> > > My only concern is that these patches look to have significant collisions with
> > > the fsdax page reference counting reworks pending in linux-next. Although,
> > > those are still sitting in mm-unstable:
> > > 
> > > http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org
> > 
> > As far as I know, Dan's "Fix the DAX-gup mistake" series is somewhat
> > stuck.  Jan pointed out:
> > 
> > https://lore.kernel.org/all/20221109113849.p7pwob533ijgrytu@quack3/T/#u
> > 
> > or have Jason's issues since been addressed?
> 
> No, they have not. I do think the current series is a step forward, but
> given the urgency remains low for the time being (CXL hotplug use case
> further out, no known collisions with ongoing folio work, and no
> MEMORY_DEVICE_PRIVATE users looking to build any conversions on top for
> 6.2) I am ok to circle back for 6.3 for that follow on work to be
> integrated.
> 
> > > My preference would be to move ahead with both in which case I can help
> > > rebase these fixes on top. In that scenario everything would go through
> > > Andrew.
> > > 
> > > However, if we are getting too late in the cycle for that path I think
> > > these dax-fixes take precedence, and one more cycle to let the page
> > > reference count reworks sit is ok.
> > 
> > That sounds a decent approach.  So we go with this series ("fsdax,xfs:
> > fix warning messages") and aim at 6.3-rc1 with "Fix the DAX-gup
> > mistake"?
> > 
> 
> Yeah, that's the path of least hassle.

Sounds good.  I still want to see patch 1 of this series broken up into
smaller pieces though.  Once the series goes through review, do you want
me to push the fixes to Linus, seeing as xfs is the only user of this
functionality?

--D
