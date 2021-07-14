Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036FA3C818B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhGNJ3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 05:29:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhGNJ3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:29:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0DFC20279;
        Wed, 14 Jul 2021 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626254799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sVJ14eP5Dhs7hjTWK+25o786he7viL7UI7OZPLHs3k=;
        b=h5oMAEIadAFWhzNdxHpJrXUdBsClutzJNgfBV1VPIFq6w8rMIlBxG7x3USTDedDU0uAzsQ
        SAoSajFE7PO79IbsoUe59hVJhA37SSdOONhyS3mHAjSyLGF36dNNUOFXed7BHPWDIzu/UW
        kDObthMiVWQg9z8Ep8+EKy48jfhaE5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626254799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sVJ14eP5Dhs7hjTWK+25o786he7viL7UI7OZPLHs3k=;
        b=e3/jxXYfrU+GVtR31i6eSkbwtmbgnqz7Ekk4lhBKIGqE1AZoxtbBTpSnBTfYgbjEx29kIL
        ulxTteQ14oOz+mBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E3B45A3B8D;
        Wed, 14 Jul 2021 09:26:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C59731E0BD1; Wed, 14 Jul 2021 11:26:39 +0200 (CEST)
Date:   Wed, 14 Jul 2021 11:26:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <20210714092639.GB9457@quack2.suse.cz>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> Hi Roman,
> 
> On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > Hello,
> > >
> > > I'm not sure if this is the right place to report this bug, please
> > > correct me if I'm wrong.
> > >
> > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > it looks like the bug had been introduced by the commit
> > >
> > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > >
> > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > was performed with the latest xfstests, and the bug can be reproduced
> > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> >
> > Hello Boyang,
> >
> > thank you for the report!
> >
> > Do you know on which line the oops happens?
> 
> I was trying to inspect the vmcore with crash utility, but
> unfortunately it doesn't work.

Thanks for report!  Have you tried addr2line utility? Looking at the oops I
can see:

[ 4371.307867] pc : cleanup_offline_cgwbs_workfn+0x320/0x394

Which means there's probably heavy inlining going on (do you use LTO by
any chance?) because I don't think cleanup_offline_cgwbs_workfn() itself
would compile into ~1k of code (but I don't have much experience with
aarch64). Anyway, add2line should tell us.

Also pasting oops into scripts/decodecode on aarch64 machine should tell
us more about where and why the kernel crashed.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
