Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE6585D00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 05:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiGaDId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 23:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiGaDIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0687712D1B;
        Sat, 30 Jul 2022 20:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDE92B80C95;
        Sun, 31 Jul 2022 03:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38810C433D6;
        Sun, 31 Jul 2022 03:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659236908;
        bh=tawPftnF94jyXfV2ZmURRfIrH7cFklH6ixzelkdY6vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3PgaArNxgaBWU0TwQ7i9JXcghaMQBe+njO4dt2ETXSDmDPQdoUc7kkKPAs6gs3ir
         dKRoNbPddLaqkyzJBf/s73FN4CsT+anw/YXvcsyO97vODzyrgtyheOGsSBeR/KmFd3
         l0HBiL65yvRvJLakDLqAzgOSgRFqnAguq3ahykb2UuWx2Br0IJXjZSINU5XUHTnJvy
         09CG02eD4Vi3eq0o/LgIqRCQhVi6MPDIfHxhjxTBZud5EIqVn9XiZ8CCn4JlzUMk9Q
         cf87fjR7QKSKs8lTSQfBgORJxJjeLdihqWOr19SaKyrdWDL76pz/FbUB7a0sV6LfFe
         l8+AbGlYl20tw==
Date:   Sat, 30 Jul 2022 20:08:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <YuXyKh8Zvr56rR4R@google.com>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt7dCcG0ns85QqJe@sol.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/25, Eric Biggers wrote:
> On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
> > On 07/22, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Currently, if an f2fs filesystem is mounted with the mode=lfs and
> > > io_bits mount options, DIO reads are allowed but DIO writes are not.
> > > Allowing DIO reads but not DIO writes is an unusual restriction, which
> > > is likely to be surprising to applications, namely any application that
> > > both reads and writes from a file (using O_DIRECT).  This behavior is
> > > also incompatible with the proposed STATX_DIOALIGN extension to statx.
> > > Given this, let's drop the support for DIO reads in this configuration.
> > 
> > IIRC, we allowed DIO reads since applications complained a lower performance.
> > So, I'm afraid this change will make another confusion to users. Could
> > you please apply the new bahavior only for STATX_DIOALIGN?
> > 
> 
> Well, the issue is that the proposed STATX_DIOALIGN fields cannot represent this
> weird case where DIO reads are allowed but not DIO writes.  So the question is
> whether this case actually matters, in which case we should make STATX_DIOALIGN
> distinguish between DIO reads and DIO writes, or whether it's some odd edge case
> that doesn't really matter, in which case we could just fix it or make
> STATX_DIOALIGN report that DIO is unsupported.  I was hoping that you had some
> insight here.  What sort of applications want DIO reads but not DIO writes?
> Is this common at all?

I think there's no specific application to use the LFS mode at this
moment, but I'd like to allow DIO read for zoned device which will be
used for Android devices.

> 
> - Eric
