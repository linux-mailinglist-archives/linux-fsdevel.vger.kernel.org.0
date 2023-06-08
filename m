Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E474728706
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjFHSQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFHSQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FF1BD3;
        Thu,  8 Jun 2023 11:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8F465050;
        Thu,  8 Jun 2023 18:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D951CC433EF;
        Thu,  8 Jun 2023 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686248210;
        bh=0F5VKq0HkkvER9fIMap91gj7noH+t+ITf+G4dCasmLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOqVE9G/yqfBHoE40yBk4gZdvdwddzIxHZHs0q7JfIdOKbR5KqY1cznII0SwsqYCJ
         Xay/7aOXsTDxwkQ0S+zc3dQMWfiMCDHyfTm6NSF+RAkbTI38vWEd3ibHFmHi2tQKY0
         CVdkZL9npzbY50SY1BPzSjK6G6pY6v6WoNH5bSNOsX1xRxLLOIYp9QZtq0uzZx0n6e
         cUFU9sqPp7GBNJSyDnizRjYBD3skd+0ROxvoszQKH+VvoIKHk4pMwyBNWOX+Phd1ri
         bjaL/CLHX+NEdjhsgPqhanvDQaKA6GNv5Gp/N1whuWVyqQ1dCLxIWG+MikAewEEaig
         d/oaQQ/JXUy0Q==
Date:   Thu, 8 Jun 2023 11:16:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jikos@kernel.org, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608181649.GF72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <ZIFnID9ZNpd7zrNa@infradead.org>
 <20230608091130.bthttzsmdeeiagof@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608091130.bthttzsmdeeiagof@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:11:30AM +0200, Jan Kara wrote:
> On Wed 07-06-23 22:29:04, Christoph Hellwig wrote:
> > On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> > > Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> > > 
> > > I'd just note that this would need rebasing on top of Luis' patches 1 and
> > > 2. Also:
> > 
> > I'd not do that for now.  1 needs a lot more work, and 2 seems rather
> > questionable.
> 
> OK, I agree the wrappers could be confusing (they didn't confuse me but
> when you spelled it out, I agree).
> 
> > > Now the only remaining issue with the code is that the two different
> > > holders can be attempting to freeze the filesystem at once and in that case
> > > one of them has to wait for the other one instead of returning -EBUSY as
> > > would happen currently. This can happen because we temporarily drop
> > > s_umount in freeze_super() due to lock ordering issues. I think we could
> > > do something like:
> > > 
> > > 	if (!sb_unfrozen(sb)) {
> > > 		up_write(&sb->s_umount);
> > > 		wait_var_event(&sb->s_writers.frozen,
> > > 			       sb_unfrozen(sb) || sb_frozen(sb));
> > > 		down_write(&sb->s_umount);
> > > 		goto retry;
> > > 	}
> > > 
> > > and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> > > in freeze_super().
> > 
> > Let's do that separately as a follow on..
> 
> Well, we need to somehow settle on how to deal with a race when both kernel
> & userspace race to freeze the filesystem and make the result consistent
> with the situation when the fs is already frozen by someone.

<nod> I'll see what I can do about that.

> > > BTW, when reading this code, I've spotted attached cleanup opportunity but
> > > I'll queue that separately so that is JFYI.
> > > 
> > > > +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> > > > +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
> > > 
> > > Why not start from 1U << 0? And bonus points for using BIT() macro :).
> > 
> > BIT() is a nasty thing and actually makes code harder to read. And it
> > doesn't interact very well with the __bitwise annotation that might
> > actually be useful here.
> 
> OK. I'm not too hung up on BIT() macro.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
