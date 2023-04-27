Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EE6F0259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbjD0ILr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbjD0ILq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEE30C5;
        Thu, 27 Apr 2023 01:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318F463AED;
        Thu, 27 Apr 2023 08:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6819FC433EF;
        Thu, 27 Apr 2023 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682583104;
        bh=pb4bckBSRPc/CTexeqHXV1WvIia8nZi/q4H647lbl4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6HHrcDyR2aMi24XI2PD4NDKDxsAuff6P1UFwrUY52obJwMDL8sp1hhUdx4GO/ONL
         fPObh/pS99RJa0R2yd2kbhBSXirEWwWsEDcudeQudKFlIlWsEvhPQf1WAcgmxN+DUP
         5Fj5hSNOAbUR/hvtIzd6y1+aJKFP5cE7B0GpKv9WN6bygwq8S+o+Ec9Xj4gfL28J5d
         kJnihYBBeAoWfZn7ZEEozpxHMbMWHyZ0dP667Jgbm5KpNAxU0VSP9TmO85HSSdcIQ+
         FYw4dxbTmk8fKieCiIYHGH+Kvzu5jHokZxkBZ0SLZkz20/9DRDRRNS1zHCKcHOMIdo
         KMu8iqDbJKRvQ==
Date:   Thu, 27 Apr 2023 10:11:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427-abgesackt-gedruckt-aff2d3398369@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427010715.GX3390869@ZenIV>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 02:07:15AM +0100, Al Viro wrote:
> On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:
> 
> 
> > struct fd_file {
> > 	struct file *file;
> > 	int fd;
> > 	int __user *fd_user;
> 
> Why is it an int?  Because your case has it that way?
> 
> We have a bunch of places where we have an ioctl with
> a field in some structure filled that way; any primitive
> that combines put_user() with descriptor handling is
> going to cause trouble as soon as somebody deals with
> a structure where such member is unsigned long.  Gets
> especially funny on 64bit big-endian...
> 
> And that objection is orthogonal to that 3-member structure -
> even if you pass int __user * as an explicit argument into
> your helper, the same trouble will be there.

Ignoring for a second that there are other ways to achieve this. This is
literally the sketch on top of a sketch to encompass an api that _we do
already have today_...
