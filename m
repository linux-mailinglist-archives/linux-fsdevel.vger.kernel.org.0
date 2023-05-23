Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B870E9B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjEWXqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 19:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEWXqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 19:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F190;
        Tue, 23 May 2023 16:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4623C63581;
        Tue, 23 May 2023 23:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EE2C433EF;
        Tue, 23 May 2023 23:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684885573;
        bh=hy6VE9loTK6zmHLdZEYYJlKXBdhGlHAMSBuVMqSkYR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUzzM5yl0hW5QdsTB+hdJwUiYiWlArc/Z7PL4V8BGkzM+OW28urXzmJ3/BZZ2m2qb
         2QTaWtjlh+Jnvy43jTuAqN93tR3z7cQcN9/VPc2w4rGJUIkdARMhDa93/rBdOLcvTJ
         2Cqq5IIcYfzsDZ2FGqzQ8/rR8ZEWVNS2GXqpbtfSDHDKYcZvtzXov6BIdv40zZB27n
         qILKIetEW4Fb2D4pd5ZENfN2yhPLSJpDlboP8G/m4cZG9vj+o71nPgIQl59S+/xpJL
         iRpO9tdfB+Brib5lxkD4qkG0m6aHf6gjPysmJoyVYTfuEWKIWLDvGOymuNwW+mE9+c
         MCYuJY9eCaZBQ==
Date:   Tue, 23 May 2023 23:46:12 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pengfei Xu <pengfei.xu@intel.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, heng.su@intel.com,
        dchinner@redhat.com, lkp@intel.com,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <20230523234612.GG888341@google.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <20230523000029.GB3187780@google.com>
 <ZGxry4yMn+DKCWcJ@dread.disaster.area>
 <20230523165044.GA862686@google.com>
 <ZG07WoKnBzaN4T1L@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG07WoKnBzaN4T1L@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 08:16:58AM +1000, Dave Chinner wrote:
> config XFS_SUPPORT_V4
>         bool "Support deprecated V4 (crc=0) format"
>         depends on XFS_FS
>         default y
>         help
>           The V4 filesystem format lacks certain features that are supported
>           by the V5 format, such as metadata checksumming, strengthened
>           metadata verification, and the ability to store timestamps past the
>           year 2038.  Because of this, the V4 format is deprecated.  All users
>           should upgrade by backing up their files, reformatting, and restoring
>           from the backup.
> 
>           Administrators and users can detect a V4 filesystem by running
>           xfs_info against a filesystem mountpoint and checking for a string
>           beginning with "crc=".  If the string "crc=0" is found, the
>           filesystem is a V4 filesystem.  If no such string is found, please
>           upgrade xfsprogs to the latest version and try again.
> 
>           This option will become default N in September 2025.  Support for the
>           V4 format will be removed entirely in September 2030.  Distributors
>           can say N here to withdraw support earlier.
> 
>           To continue supporting the old V4 format (crc=0), say Y.
>           To close off an attack surface, say N.
> 
> This was added almost 3 years ago in mid-2020. We're more than half
> way through the deprecation period and then we're going to turn off
> v4 support by default. At this point, nobody should be using v4
> filesystems in new production systems, and those that are should be
> preparing for upstream and distro support to be withdraw in the next
> couple of years...

Great to see that this exists now and there is a specific deprecation plan!

> > Then you could just tell the people fuzzing XFS filesystem images
> > that they need to use that option.  That would save everyone a lot of time.
> > (To be clear, I'm not arguing for the XFS policy on v4 filesystems being right
> > or wrong; that's really not something I'd like to get into again...  I'm just
> > saying that if that's indeed your policy, this is what you should do.)
> 
> It should be obvious by now that we've already done this. 3 years
> ago, in fact. And yet we are still having the same problems. Maybe
> this helps you understand the level of frustration we have with all
> the people running fuzzing bots out there....

I don't see evidence that this actually happened, though perhaps we are not
looking in the same places.  https://lore.kernel.org/all/?q=XFS_SUPPORT_V4
brings up little except the original patch thread, nor did
https://github.com/search?q=XFS_SUPPORT_V4&type=issues find anything.

Anyway, I took 3 minutes to file an issue in the syzkaller repo
(https://github.com/google/syzkaller/issues/3918), so at least this should get
resolved for syzbot soon.

- Eric
