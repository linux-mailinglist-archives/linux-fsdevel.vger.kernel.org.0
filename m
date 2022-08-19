Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B959A918
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbiHSXJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiHSXJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D554F6B2;
        Fri, 19 Aug 2022 16:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA04B8280F;
        Fri, 19 Aug 2022 23:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD3C433C1;
        Fri, 19 Aug 2022 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660950591;
        bh=jyQMlfDyLfQswfrcmubQj7ukvdgCEoTA8LhJP39mZNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuOfKLcTLqSxarEIMozH41HlKKSXIw1Ha5z+iGobBTp0XC/190sxrbX4xymxeQZFF
         3WudYVrb63Ic60WpCeWYRRbbMC6sNiKGVAznV8UysIUN6uVjyi5NDY0XFhaprIuD8A
         pF59daiDM0+L9HkOjVyll+2uPITOtrvjzgrPS16r1XJmBV5ma+KvcLc+BHhqr03upy
         fMsLt1xcBM7/2jnJiXFv+FJPXeiiS+0sz7tw4jOhLuKIjQw+8yi7bYCZL/cqb3a2bJ
         OHxlSv4rJUDd6AvnKU3c4q61YHoNXW9ZdFJr7Qw7jTpstVUaoUe5id8DJL1pk0juet
         AgN1uJU3z9Rkg==
Date:   Fri, 19 Aug 2022 16:09:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        xfs <linux-xfs@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <YwAYPFxW7VV4M9D1@sol.localdomain>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
 <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
 <20220816090312.GU3600936@dread.disaster.area>
 <D1CDACE3-EC7E-43E4-8F49-EEA2B6E71A41@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1CDACE3-EC7E-43E4-8F49-EEA2B6E71A41@dilger.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:42:29AM -0600, Andreas Dilger wrote:
> 
> IMHO, this whole discussion is putting the cart before the horse.
> Changing existing (and useful) IO behavior to accommodate an API that
> nobody has ever used, and is unlikely to even be widely used, doesn't
> make sense to me.  Most applications won't check or care about the new
> DIO size fields, since they've lived this long without statx() returning
> this info, and will just pick a "large enough" size (4KB, 1MB, whatever)
> that gives them the performance they need.  They *WILL* care if the app
> is suddenly unable to read data from a file in ways that have worked for
> a long time.
> 
> Even if apps are modified to check these new DIO size fields, and then
> try to DIO write to a file in f2fs that doesn't allow it, then f2fs will
> return an error, which is what it would have done without the statx()
> changes, so no harm done AFAICS.
> 
> Even with a more-complex DIO status return that handles a "direction"
> field (which IMHO is needlessly complex), there is always the potential
> for a TOCTOU race where a file changes between checking and access, so
> the userspace code would need to handle this.
> 

I'm having trouble making sense of your argument here; you seem to be saying
that STATX_DIOALIGN isn't useful, so it doesn't matter if we design it
correctly?  That line of reasoning is concerning, as it's certainly intended to
be useful, and if it's not useful there's no point in adding it.

Are there any specific concerns that you have, besides TOCTOU races and the lack
of support for read-only DIO?

I don't think that TOCTOU races are a real concern here.  Generally DIO
constraints would only change if the application doing DIO intentionally does
something to the file, or if there are changes that involve the filesystem being
taken offline, e.g. the filesystem being mounted with significantly different
options or being moved to a different block device.  And, well, everything else
in stat()/statx() is subject to TOCTOU as well, but is still used...

- Eric
