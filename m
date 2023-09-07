Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D0796F37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 05:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbjIGDOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbjIGDOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:14:32 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F119B5
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 20:14:13 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5735282d713so286132eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694056452; x=1694661252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vj3i6Xm3aT1ZnQ3daxbVq6RG4JnRtM08w+X0vw1mExo=;
        b=k1cAe2uP92u91QzpkkIgYWCdenq29XUaY8cKxSHTzKOKGYQtw7t6FRe7ze5UeuR7L8
         a7LHnhprGEG82XEVosMi0V/AEDSsxBx4vWmirTBTgKdm9rO1DOI9f7GPxz9OwIPyrhNi
         iIKMuRrClsBY2mnhL95Qy/urBAAkb/wDnVUz50XGSjwp+3zj6BDLlipDa7PpH1L5Kt7T
         i1IiMMr/Mx2k8e8L9A3PoMFwGiP4TqWfCzueTQa0+gnk18OUyztZQL291F62eTTQbKuz
         TMI4su3Q7NvwsRmLIyBg02I6MGBW4g1gCyoFhiPdiS6FuA8ej6fJD5x1i4iA8K3GWZ0U
         iEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056452; x=1694661252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj3i6Xm3aT1ZnQ3daxbVq6RG4JnRtM08w+X0vw1mExo=;
        b=VIdQEFIxNlTuyAwAnf6j9PscfHuKR3HyhJO9lF1kO/Z3gnGqVLxTxRNFqKvxQ95guT
         GxNmyDmYFpWVgnkVfuGSg8OcBv7gLK539qpKiORuoJQiCvASQ0MIY45jiq1wmDj71Wze
         MfJHBWrjcgL/7rFOm4VnOn21CnjT0gth0bF45bNZ53/t89iSNhKS8RaQbsOP/UrOihnh
         kaTAjrasPp7M1YKKusIYJqpUuL62xW2VeUhi1kpvHOmbdpgOiUcG+hviUX88fAR8Bxan
         JUdpH5VySm21HAXcE51v3H8STFyadnyV+FAep5PXavxAHQV/mSZTUEtFoVO65ic90rVP
         fn3w==
X-Gm-Message-State: AOJu0Yz3kHlc1/Kjh/02qCUT/zwcRHmXddJbNnFOIK7nsipTKGRJXOJn
        /jxUs9m1tsTbZyo7t8u7X9PAug==
X-Google-Smtp-Source: AGHT+IEfy6DclIqqkSkE74UpMs3vv8gKv3DEqPytuAq3cLsyQKYY07PLM+vXkf+CzNB0KAlDEt+rsw==
X-Received: by 2002:a05:6358:9389:b0:134:cb1d:6737 with SMTP id h9-20020a056358938900b00134cb1d6737mr5465205rwb.7.1694056452253;
        Wed, 06 Sep 2023 20:14:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id ds1-20020a17090b08c100b002680dfd368dsm451073pjb.51.2023.09.06.20.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:14:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qe5T6-00BrEb-30;
        Thu, 07 Sep 2023 13:14:08 +1000
Date:   Thu, 7 Sep 2023 13:14:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPlAALO3o3Nnnh1R@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <ZPkfEFTsBOk3iVuQ@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPkfEFTsBOk3iVuQ@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:53:36AM +0700, Bagas Sanjaya wrote:
> On Thu, Sep 07, 2023 at 08:54:38AM +1000, Dave Chinner wrote:
> > There's a bigger policy question around that.
> > 
> > I think that if we are going to have filesystems be "community
> > maintained" because they have no explicit maintainer, we need some
> > kind of standard policy to be applied.
> > 
> > I'd argue that the filesystem needs, at minimum, a working mkfs and
> > fsck implementation, and that it is supported by fstests so anyone
> > changing core infrastructure can simply run fstests against the
> > filesystem to smoke test the infrastructure changes they are making.
> 
> OK.
> 
> > 
> > I'd suggest that syzbot coverage of such filesystems is not desired,
> > because nobody is going to be fixing problems related to on-disk
> > format verification. All we really care about is that a user can
> > read and write to the filesystem without trashing anything.
> > 
> > I'd also suggest that we mark filesystem support state via fstype
> > flags rather than config options. That way we aren't reliant on
> > distros setting config options correctly to include/indicate the
> > state of the filesystem implementation. We could also use similar
> > flags for indicating deprecation and obsolete state (i.e. pending
> > removal) and have code in the high level mount path issue the
> > relevant warnings.
> 
> Something like xfs v4 format?

Kind of, but that's a story of obsolescence, not a lack of
maintenance.  For those that don't know the back story, it's below.
For those that do, skip the bit between the '----' lines.

----

We deprecated the v4 XFS on-disk format back in 2020 because it was
superceded by the v5 format that was merged in 2013 (a decade ago).
Since then we have not been adding features to the v4 format because
the v5 format fixes a heap of problems with that old format that
can't otherwise be fixed without changing the on-disk v4 format to
something like the V5 format.

Now throw in the fact that the v4 format is not y2038 compliant.
It's got a hard "end of life" date without putting resources and
effort into an on-disk format change. We aren't going to do that
largely because the V4 format is a development dead end.

Because the v4 format has a hard end of life date, we needed to
have a deprecation plan for the format that was sympathetic to
enterprise distro feature removal policies. 

Given that there's usually a 10 year support life from first release
in an enterprise kernel, and typically a 2-3 year lead in cycle,
we're looking at need to have filesystem feature removal occur 10-15
years before the hard end of support date. Further, feature removal
policies required us to mark the feature deprecated for an entire
major before we can remove it in the subsequent release. This means
we needed to make a decision about the V4 format in 2020, a full 18
years before the hard end of life actually occurs.

[ How many people reading this are thinking about what impact a
decision made has on people using that functionality in 10 years
time? This is something filesystem developers have to do all the
time, because the current on-disk format is almost certainly going
to be in use in 10 years time....]

So we deprecated the v4 format upstream, and the enterprise kernels
inherited that in 2020 before the major release went out the door.
That means we can remove support in the next major release, and the
upstream deprecation schedule reflects this - we're turning off v4
support by default in 2025...

We don't want to carry v4 support code forever, so we have a
removal date defined as well. All upstream support for the v4 format
will stop in 2030, and we will remove the relevant code at that
point in time.

Long story short, we recognised that we have obsolete functionality
that we cannot support forever, and we defined and documented the
long term EOL process for to removing support of the obsolete
functionality from the filesystem.

This, however, does not mean the V4 code is unmaintained or
untested; while it is supported it will be tested, though at a
lesser priority than the v5 format code we want everyone to be
using. THe V4 and V5 formats and code share huge amounts of
commonality, so even when we are testing V5 formats we are
exercising almost all the same code that the V4 format uses....

-----

It should be clear at this point that we cannot equate a well
planned removal of obsolescent functionality from a maintained
filesystem with the current situation of kernel being full of
unmaintained filesystem code.  The two cases are clearly at opposite
ends of spectrum.

However, we should have similar policies to deal with both
situations. If the filesystem is unmaintained and/or obsolete, we
should have a defined policy and process that leads to it being
either "community maintained" for some period of time and/or
deprecated and removed from the code base.

Look at reiserfs.

The maintainer stepped back and said "I'm happy just to remove the
code from the kernel". It has been unmaintained since.

Rather than pulling the rug out from under any remaining users,
we've marked the filesystem as deprecated (and now obsolete) and
documented a planned removal schedule.

This is the sort of process we need to discuss, formalise and
document - how we go about removing kernel features that are no
longer maintained but may still have a small number of long tail
users with the minimum of disruption to everyone....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
