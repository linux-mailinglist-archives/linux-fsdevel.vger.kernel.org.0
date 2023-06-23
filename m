Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03C73AE59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFWBfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 21:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFWBfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0AE1FE6;
        Thu, 22 Jun 2023 18:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EAE6192D;
        Fri, 23 Jun 2023 01:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBBFC433C0;
        Fri, 23 Jun 2023 01:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687484115;
        bh=BENbwHHfW81MdCp/+XdRp7Ie0dwQl1EB71KhGk24v9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ly2socOM67onLI5zRrn2Mf3HGRSnt11h5ezz4RzpWhNSRUCtIzu2CH5hhpPoAA2xM
         r8mRZiroC7fvol2mpqBFzMxrB3PNzs9ZWKQsCzURneB54OA6hSD+9r0xavcW3/32Iv
         y/KQrIIXjGvtef7L2jpuMJzfCC9SLO+I7q8d42fzQNPO9JOKLAXVxG81QZdoh6przm
         0JPSSZhreG1rSl83BTWoCVgsp1fbP+5ftm8rMvM8quPozXl1gu+Cd8l0kmf7VB/s4Q
         4PEX9NyYP/6BZ1h1Cw3dTSvWyx5ZnkIp7bVMRrmt2m7IwlCgDiN//NjpfSqmE3Uq+O
         7k1as+iTioViw==
Date:   Thu, 22 Jun 2023 18:35:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in
 xfs_attr3_leaf_add_work
Message-ID: <20230623013513.GB1949@sol.localdomain>
References: <0000000000001c8edb05fe518644@google.com>
 <ZI+3QXDHiohgv/Pb@dread.disaster.area>
 <20230621080521.GB56560@sol.localdomain>
 <ZJQZm+UGyJZZNTvN@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQZm+UGyJZZNTvN@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 07:51:23PM +1000, 'Dave Chinner' via syzkaller-bugs wrote:
> > 
> > My understanding is that the main motivation for the conversions to flex arrays
> > is kernel hardening, as it allows bounds checking to be enabled.
> 
> <sigh>
> 
> Do you think we don't know this?

You said the only reason to fix this would be to "shut up UBSAN and/or syzbot".
So it seemed you were not aware of the kernel hardening motivation.

> 
> We can't actually rely on the compiler checking here. We *must* to
> do runtime verification of these on-disk format structures because
> we are parsing dynamic structures, not fixed size arrays.  IOWs, we
> already bounds check these arrays (in multiple ways!) before we do
> the memcpy(), and have done so for many, many years.
> 
> *This code is safe* no matter what the compiler says.
> 
> Last time this came up in a FORTIFY_SOURCE context, Darrick proposed
> to change this to use unsafe_memcpy() to switch off the compile time
> checking because we *must* do runtime checking of the array lengths
> provided in the structure itself.
> 
> Kees pretty much knocked that down by instead proposing some
> "flex_cpy()" API he was working on that never went anywhere. So
> kernel security people essentially said "no, we don't want you to
> fix it that way, but then failed to provide the new infrastructure
> they said we should use for this purpose.
> 
> Damned if we do, damned if we don't.
> 
> So until someone from the security side of the fence ponies up the
> resources to fix this in a way that is acceptible to the security
> people and they do all the testing and validation we require for
> such an on-disk format change, the status quo is unlikely to change.

I think you've missed the point.  The point is not about improving the bounds
checks for this specific field.  Rather, it's about eliminating a "false
positive" so that automatic bounds checking of known-sized arrays can be enabled
universally as a hardening measure.  Without code like this fixed, it will be
impossible to enable automatic bounds checking, at least in the affected files.

> 
> > You can probably get away with not fixing this for a little while longer, as
> > that stuff is still a work in progress.  But I would suggest you be careful
> > about potentially getting yourself into a position where XFS is blocking
> > enabling security mitigations for the whole kernel...
> 
> <sigh>
> 
> I'm really getting tired of all these "you'll do what we say or
> else" threats that have been made over the past few months.
> 
> As I said: if this is a priority, then the entities who have given
> it priority need to provide resources to fix it, not demand that
> others do the work they want done right now for free. If anyone
> wants work done for free, then they'll just have to wait in line
> until we've got time to address it.

Well, good news: Gustavo Silva, Kees Cook, and others are going through the
kernel and doing the conversions to flex arrays.

I am trying to help you understand the problem, not force you to fix it.  If you
do not want to fix it yourself, then you can simply consider this bug report as
a heads up.

I would just ask that you please try to be cooperative when you eventually do
get a patch from someone trying to fix it.

XFS does not need to be the "problem subsystem" every time.

- Eric
