Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0742E6B395A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCJJAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 04:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCJI7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:59:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453F102B77;
        Fri, 10 Mar 2023 00:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B9161133;
        Fri, 10 Mar 2023 08:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44835C433D2;
        Fri, 10 Mar 2023 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678438380;
        bh=UOkvQ0uqHHfL785oiVqIn6OhjgZ1kHQ35LvccbGpGp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhfvytSvwJti2QPRmi2gD461byc7l2E2sCS1EbTDlWGw2vgs9ls6Oiomxxssezwir
         2Vm0Gngbm/tDoPG1oaCkD0Ejqh/0Eh51gJKjGa+r9S2e8gav8bwcPXZhrgmu3VI0kP
         b64j2JeGaorc1KjuiCe9ma74/B38OFVZKuvmSqJUd+iO3eMboqnQj+kndlCmU2RdjT
         dBA6bkASMioz+pMZRyJqer+wKcKFFBmVrVyDzcv1XOkTVCGEPHQnEIy09xZ93iUwXh
         xwOBwWYIT1S/o8bZhVC70j75bHUD4oZ3JpQxoxkWZq40Ob04J+7LlR9MlWtxsEm/Vc
         u5gpxanSRYeVQ==
Date:   Fri, 10 Mar 2023 09:52:54 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/locks: Remove redundant assignment to cmd
Message-ID: <20230310085254.counxoqhuv5bmkr5@wittgenstein>
References: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
 <167835349787.767856.6018396733410513369.b4-ty@kernel.org>
 <fd7e0f354da923ebb0cbe2c41188708e4d6c992a.camel@kernel.org>
 <20230310034016.GH3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310034016.GH3390869@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:40:16AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 06:50:15AM -0500, Jeff Layton wrote:
> > On Thu, 2023-03-09 at 10:25 +0100, Christian Brauner wrote:
> > > From: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > 
> > > 
> > > On Wed, 08 Mar 2023 15:13:16 +0800, Jiapeng Chong wrote:
> > > > Variable 'cmd' set but not used.
> > > > 
> > > > fs/locks.c:2428:3: warning: Value stored to 'cmd' is never read.
> > > > 
> > > > 
> > > 
> > > Seems unused for quite a while. I've picked this up since there's a few other
> > > trivial fixes I have pending. But I'm happy to drop this if you prefer this
> > > goes via the lock tree, Jeff.
> > > 
> > > [1/1] fs/locks: Remove redundant assignment to cmd
> > >       commit: dc592190a5543c559010e09e8130a1af3f9068d3
> > 
> > Thanks Christian,
> > 
> > I had already picked it into the locks-next branch (though I didn't get
> > a chance to reply and mention that), but I'll drop it and plan to let
> > you carry it.
> 
> IMO that's better off in locks tree; unless Christian is planning some
> work in the area this cycle (I definitely do not), it's better to have
> it in the branch in your git - we can always pull a branch from it if
> needed and it's less likely to cause conflicts that way.

I have picked up another fix for fs/locks.c for idmapped mounts so I
plan on sending that with some other smaller fixes soon. (And that
idmapped thing needs to be backported as well.)

So if there's non-trivial changes then I fully agree that the locking
tree is absolutely the right place. Especially since Jeff will also be
able to describe the changes properly and as you said we can always just
pull a branch to minimize conflicts.

However, when we have simple stuff like this let's just collect it in
our for *.misc trees and send it to Linus if we think enough stuff has
piled up (2+?). There's no point in holding fixes like this back for a
long time.

The likelihood of getting merge conflicts for smallish things that we
send weekly is rather low judging from my personal experience. Stephen
will tell us that quickly anyway. And even if we do get them Linus has
said repeatedly that he doesn't mind fixing them so we shouldn't be
fuzzed about it. Worst(/best?) case, everyone gets to watch my head
being torn off...
