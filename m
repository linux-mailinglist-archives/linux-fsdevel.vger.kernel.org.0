Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A459AA10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbiHTAeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbiHTAd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8ED13E33;
        Fri, 19 Aug 2022 17:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD9E61900;
        Sat, 20 Aug 2022 00:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A39C433D7;
        Sat, 20 Aug 2022 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660955618;
        bh=2UioO3jIqUCggDOliY/3dPwIKxowKS7N1pNMvwgRRJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7YXCiqntWaRVlaJVs0qsv0/0okcSkkBv5tX156c0hQa69FiHuFAOuyU2H14/uhPh
         qkFkQqxM4QZW8Uk24/T8GgmF1hsH9T7n23yOG11yBTTC78vlPfWfsuoSmR6p/47Zwd
         S7rQFXLxLwXMyC84969EnRkhQDcVdOTnKURgs1tJrEqikdWe3N0un1XrVFCRdz704n
         Ievfd5LYGzKFanXasRnR0PNi5+gnbYVmn2sZlUsswTIJIYEs4ag4Vyn/LqgZa4kkcK
         eAom2kY4OTnmNb9mf0PNZqubwgxSrHGt6gCL1UeiAtkbhFzyiP5LLMH88dZk/owdi9
         YbUQ3xISxHF3Q==
Date:   Fri, 19 Aug 2022 17:33:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <YwAr4MKgnjljdXiA@sol.localdomain>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
 <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
 <YwAlbsorBsshkxfU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwAlbsorBsshkxfU@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:06:06PM -0700, Jaegeuk Kim wrote:
> On 08/15, Eric Biggers wrote:
> > On Sat, Jul 30, 2022 at 08:08:26PM -0700, Jaegeuk Kim wrote:
> > > On 07/25, Eric Biggers wrote:
> > > > On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
> > > > > On 07/22, Eric Biggers wrote:
> > > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > > 
> > > > > > Currently, if an f2fs filesystem is mounted with the mode=lfs and
> > > > > > io_bits mount options, DIO reads are allowed but DIO writes are not.
> > > > > > Allowing DIO reads but not DIO writes is an unusual restriction, which
> > > > > > is likely to be surprising to applications, namely any application that
> > > > > > both reads and writes from a file (using O_DIRECT).  This behavior is
> > > > > > also incompatible with the proposed STATX_DIOALIGN extension to statx.
> > > > > > Given this, let's drop the support for DIO reads in this configuration.
> > > > > 
> > > > > IIRC, we allowed DIO reads since applications complained a lower performance.
> > > > > So, I'm afraid this change will make another confusion to users. Could
> > > > > you please apply the new bahavior only for STATX_DIOALIGN?
> > > > > 
> > > > 
> > > > Well, the issue is that the proposed STATX_DIOALIGN fields cannot represent this
> > > > weird case where DIO reads are allowed but not DIO writes.  So the question is
> > > > whether this case actually matters, in which case we should make STATX_DIOALIGN
> > > > distinguish between DIO reads and DIO writes, or whether it's some odd edge case
> > > > that doesn't really matter, in which case we could just fix it or make
> > > > STATX_DIOALIGN report that DIO is unsupported.  I was hoping that you had some
> > > > insight here.  What sort of applications want DIO reads but not DIO writes?
> > > > Is this common at all?
> > > 
> > > I think there's no specific application to use the LFS mode at this
> > > moment, but I'd like to allow DIO read for zoned device which will be
> > > used for Android devices.
> > > 
> > 
> > So if the zoned device feature becomes widely adopted, then STATX_DIOALIGN will
> > be useless on all Android devices?  That sounds undesirable. 
> 
> Do you have a plan to adopt STATX_DIOALIGN in android?

Nothing specific, but statx() is among the system calls that are supported by
Android's libc and that apps are allowed to use.  So STATX_DIOALIGN would become
available as well.  I'd prefer if it actually worked properly if apps, or
Android system components, do actually try to use it (or need to use it)...

> > What we need to do is make a decision about whether this means we should build
> > in a stx_dio_direction field (indicating no support / readonly support /
> > writeonly support / readwrite support) into the API from the beginning.  If we
> > don't do that, then I don't think we could simply add such a field later, as the
> > statx_dio_*_align fields will have already been assigned their meaning.  I think
> > we'd instead have to "duplicate" the API, with STATX_DIOROALIGN and
> > statx_dio_ro_*_align fields.  That seems uglier than building a directional
> > indicator into the API from the beginning.  On the other hand, requiring all
> > programs to check stx_dio_direction would add complexity to using the API.
> > 
> > Any thoughts on this?
> 
> I haven't seen the details of the implementation tho, why not supporting it
> only if filesystem has the same DIO RW policy?

As I've mentioned, we could of course make STATX_DIOALIGN report that DIO is
unsupported when the DIO support is read-only.

The thing that confuses me based on the responses so far is that there seem to
be two camps of people: (1) people who really want STATX_DIOALIGN, and who don't
think that read-only DIO support should exist so they don't want STATX_DIOALIGN
to support it; and (2) people who feel that read-only DIO support is perfectly
reasonable and useful, and who don't care whether STATX_DIOALIGN supports it
because they don't care about STATX_DIOALIGN in the first place.

While both camps seem to agree that STATX_DIOALIGN shouldn't support read-only
DIO, it is for totally contradictory reasons, so it's not very convincing.  We
should ensure that we have rock-solid reasoning before committing to a new UAPI
that will have to be permanently supported...

- Eric
