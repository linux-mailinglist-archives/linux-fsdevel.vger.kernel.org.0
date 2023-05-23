Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744570CFB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjEWApz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjEWApS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359E90;
        Mon, 22 May 2023 17:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B0462CE9;
        Tue, 23 May 2023 00:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D0C4339B;
        Tue, 23 May 2023 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684801986;
        bh=Wc57SKsFBDE16TH7waBFfpgF5H4uaoIYfuZNE4myOQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4LrZz2dEMvGM/CkhAugkjKp5JNmUzSX+WlbBTW4fEqMZ/fzjuXVhXME0AT1hhFqx
         saI8I2Tl6/aPd2k6zQUQ0nJvmaLaH8Kw51kXjaSWu0yWzd5do0SXJl5VkhcKZBc3nP
         bLroTTpGqKLxjZ+QU3h1pmSNqRVwuuGSD3b/5mVim3S0KuljSCzj+GKmVIYsh2cOmz
         7yH84M7+INoTyxVyK4Y/WeA7hObG4hbdnLG6OvbUlrEfbNcMZ03Q+KGFeHJ1RPEWGX
         2Ad78LOGwjG+a2vZjg1A2sMgJwpkKR0jQTNpxN73GrgbJsgF4e/fbDacxtHJqrs1u9
         tu7yWqbY+fdzA==
Date:   Mon, 22 May 2023 17:33:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hch@infradead.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230523003305.GD11620@frogsfrogsfrogs>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
 <Y8dYpOyR/jOsO267@magnolia>
 <20230118092812.2gl3cde6mocbngli@quack3>
 <ZFckQz3udm48kprc@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFckQz3udm48kprc@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06, 2023 at 09:08:35PM -0700, Luis Chamberlain wrote:
> On Wed, Jan 18, 2023 at 10:28:12AM +0100, Jan Kara wrote:
> > On Tue 17-01-23 18:25:40, Darrick J. Wong wrote:
> > > [add linux-xfs to cc on this one]
> > > 
> > > On Fri, Jan 13, 2023 at 04:33:48PM -0800, Luis Chamberlain wrote:
> > > > Userspace can initiate a freeze call using ioctls. If the kernel decides
> > > > to freeze a filesystem later it must be able to distinguish if userspace
> > > > had initiated the freeze, so that it does not unfreeze it later
> > > > automatically on resume.
> > > 
> > > Hm.  Zooming out a bit here, I want to think about how kernel freezes
> > > should behave...
> > > 
> > > > Likewise if the kernel is initiating a freeze on its own it should *not*
> > > > fail to freeze a filesystem if a user had already frozen it on our behalf.
> > > 
> > > ...because kernel freezes can absorb an existing userspace freeze.  Does
> > > that mean that userspace should be prevented from undoing a kernel
> > > freeze?  Even in that absorption case?
> > > 
> > > Also, should we permit multiple kernel freezes of the same fs at the
> > > same time?  And if we do allow that, would they nest like freeze used to
> > > do?
> > > 
> > > (My suggestions here are 'yes', 'yes', and '**** no'.)
> > 
> > Yeah, makes sense to me. So I think the mental model to make things safe
> > is that there are two flags - frozen_by_user, frozen_by_kernel - and the
> > superblock is kept frozen as long as either of these is set.
> 
> Makes sense to me.

Just sent a patch for this, sorry it took a couple of weeks while I was
busy merging in parent pointers...

--D

>   Luis
