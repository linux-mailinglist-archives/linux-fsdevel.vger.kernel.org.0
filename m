Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FF70F0C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjEXIbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjEXIbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 04:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B139184;
        Wed, 24 May 2023 01:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4DB63A92;
        Wed, 24 May 2023 08:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC7CC433D2;
        Wed, 24 May 2023 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684917079;
        bh=ZlVoxwIsaYAgxSC4RI1ZotSzStbW0T0NJv0jKHHFdw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDiadXvYffS1uYZMc9oGkxjm7GOukTwe6358e0XUGe9Eu4euNu/2NH57X5Wg+ss06
         pK565keJNG0Kyp19fEuAG9gx/kftjWcID4u2eawJRyPxFvx2Bx8LxDIMLh+J4mxFKy
         zYLPJQTyGe0CKwc2kydC8gUDk7Tr4lf58P+onM0/KRVXNcxIaTCE6F+7OE+VD4Jwb0
         0KlBOoo0LnVT5gIQRk/upbeRKYK5niRa2XXSdcwBr/1jR0HdGPGoJFRe2PeuwHbf5I
         hrzyGzrSHFcFohE4YvjTL6GaRpYwM2rNnwi04+dmxE3qbMo4ooYfalv2AziSNdXimM
         Bp3P8yDudj9rw==
Date:   Wed, 24 May 2023 10:31:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 20/32] vfs: factor out inode hash head
 calculation
Message-ID: <20230524-zumeist-fotomodell-8b772735323d@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-21-kent.overstreet@linux.dev>
 <20230523-plakat-kleeblatt-007077ebabb6@brauner>
 <ZG1D4gvpkFjZVMcL@dread.disaster.area>
 <ZG2yM1vzHZkW0yIA@infradead.org>
 <ZG2+Jl8X1i5zGdMK@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZG2+Jl8X1i5zGdMK@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 05:35:02PM +1000, Dave Chinner wrote:
> On Tue, May 23, 2023 at 11:44:03PM -0700, Christoph Hellwig wrote:
> > On Wed, May 24, 2023 at 08:53:22AM +1000, Dave Chinner wrote:
> > > Hi Christian - I suspect you should pull the latest version of these
> > > patches from:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale
> > > 
> > > The commit messages are more recent and complete, and I've been
> > > testing the branch in all my test kernels since 6.4-rc1 without
> > > issues.
> > 
> > Can you please send the series to linux-fsdevel for review?
> 
> When it gets back to the top of my priority pile. Last time I sent
> it there was zero interest in reviewing it from fs/vfs developers
> but it attracted lots of obnoxious shouting from some RTPREEMPT
> people about using bit locks. If there's interest in getting it

I think there is given that it seems to have nice perf gains.

> merged, then I can add it to my backlog of stuff to do...
> 
> As it is, I'm buried layers deep right now, so I really have no
> bandwidth to deal with this in the foreseeable future. The code is
> there, it works just fine, if you want to push it through the
> process of getting it merged, you're more than welcome to do so.

I'm here to help get more review done and pick stuff up. I won't be able
to do it without additional reviewers such as Christoph helping of
course as this isn't a one-man show.

Let's see if we can get this reviewed. If you have the bandwith to send
it to fsdevel that'd be great. If it takes you a while to get back to it
then that's fine too.
