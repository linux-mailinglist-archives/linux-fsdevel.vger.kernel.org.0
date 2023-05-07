Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4676F96CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 06:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjEGEIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 00:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEGEIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 00:08:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046FA6E93;
        Sat,  6 May 2023 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b16pvkFJ4Cj1AZWCp8PgHr2DhPedtl50McgM9oFwRH4=; b=uwHwySSrHB8dIxJ03/rCIDCwyx
        oLkh/0RR9rtkJna17tGDdBVXM22zwSZFMFPNZ2LHbQzQgGbBfo4ppYyo+hkevFvIlCjfraQGJUAHK
        G2NC0m9v/CmBeFYxb7iJ+R6lfH4woO7jXWpGSSYPyf9LLtBezHS8EmdIsP/4bPZc6kzS5+fnUX1UJ
        Srj/y92UwWy5zKsbzaYBLp0fRryQFf4weSx9MqyqzwccW6sMwectvN0lObCogsJCJgLLECtFbhXl4
        L8xAWwTW2uRZteJJ1vPi6uGPcFRbCQbIBQrIJMTvfNHUEY7wTPc1mw02g4xQ4CzhRxmVj3MPH1AQ1
        jKXnjhkA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvVhL-00F7Zt-0g;
        Sun, 07 May 2023 04:08:35 +0000
Date:   Sat, 6 May 2023 21:08:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, hch@infradead.org,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZFckQz3udm48kprc@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
 <Y8dYpOyR/jOsO267@magnolia>
 <20230118092812.2gl3cde6mocbngli@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118092812.2gl3cde6mocbngli@quack3>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:28:12AM +0100, Jan Kara wrote:
> On Tue 17-01-23 18:25:40, Darrick J. Wong wrote:
> > [add linux-xfs to cc on this one]
> > 
> > On Fri, Jan 13, 2023 at 04:33:48PM -0800, Luis Chamberlain wrote:
> > > Userspace can initiate a freeze call using ioctls. If the kernel decides
> > > to freeze a filesystem later it must be able to distinguish if userspace
> > > had initiated the freeze, so that it does not unfreeze it later
> > > automatically on resume.
> > 
> > Hm.  Zooming out a bit here, I want to think about how kernel freezes
> > should behave...
> > 
> > > Likewise if the kernel is initiating a freeze on its own it should *not*
> > > fail to freeze a filesystem if a user had already frozen it on our behalf.
> > 
> > ...because kernel freezes can absorb an existing userspace freeze.  Does
> > that mean that userspace should be prevented from undoing a kernel
> > freeze?  Even in that absorption case?
> > 
> > Also, should we permit multiple kernel freezes of the same fs at the
> > same time?  And if we do allow that, would they nest like freeze used to
> > do?
> > 
> > (My suggestions here are 'yes', 'yes', and '**** no'.)
> 
> Yeah, makes sense to me. So I think the mental model to make things safe
> is that there are two flags - frozen_by_user, frozen_by_kernel - and the
> superblock is kept frozen as long as either of these is set.

Makes sense to me.

  Luis
