Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F81A2B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 01:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfH2XvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 19:51:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfH2XvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:51:00 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1i3UBu-0001yj-7H
        for linux-fsdevel@vger.kernel.org; Thu, 29 Aug 2019 23:50:58 +0000
Received: by mail-io1-f69.google.com with SMTP id t8so6001127iom.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 16:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bplvyURywyrZUbCnQRJbRY3iQ4HwcWNIDQydpGaXzw=;
        b=kGmzErBnfOK1F41gUXQ6vlM4ap9S0wBrKTVPyyciyBiTn/75MfBaLwEmLVURs9Ns8l
         g77rho2A2SVpd7LlK++8FnV1Q2Jbp8ZfpnsdswBSaTjRnQNTO/91aFampcJ5pMeCufwg
         9RCqgErc8OX9omjHyUvaRTbS0EHDJI1DtURJVqFa/g7zGLb63iCQJGfFjQ/Vs3IIh9MZ
         2+JEarvWC5Bb0pKlWnBB4iPpQ7r3CJMC9HybMQuFX2AqdJtJP83rOx95SPphO/S69QEu
         BLpsFngHaB6887vTy2wOXqiQ4A2NqbtPu5D+Ff5O3RmRz3WHUhTd5GFND9tRVEauMs2q
         7Msg==
X-Gm-Message-State: APjAAAWqlHYkf+CLhDJ718JFy2ae4lx68N6glS7cwahmJlOx/DMUWND+
        hTkOMcihQwp1RxYaNOVVx5Nbszf3L1Ex2cppRVJ4HNqMF1Dho+WbThaHLRJtXDtHiFgR40OghVA
        RegYe3jlplLO43lbRgndP6Idhm4jQwFBp08NDStxgThE=
X-Received: by 2002:a5e:c601:: with SMTP id f1mr1460473iok.57.1567122657091;
        Thu, 29 Aug 2019 16:50:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVuQnZ/cvr+tJx6ohprUk+vQVxjt8IJle6PnfnhhWSHmODgvICpS6ziu4ipRwqPguJYD5bpQ==
X-Received: by 2002:a5e:c601:: with SMTP id f1mr1460442iok.57.1567122656802;
        Thu, 29 Aug 2019 16:50:56 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id v12sm3744576ios.16.2019.08.29.16.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:50:55 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:50:54 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
Subject: Re: ext4 fsck vs. kernel recovery policy
Message-ID: <20190829235054.GB13045@xps13.dannf>
References: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
 <db1128a9-1316-e409-9dc6-9470bd2191f7@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1128a9-1316-e409-9dc6-9470bd2191f7@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:29:09PM -0500, Eric Sandeen wrote:
> On 8/27/19 2:10 PM, dann frazier wrote:
> > hey,
> >   I'm curious if there's a policy about what types of unclean
> > shutdowns 'e2fsck -p' can recover, vs. what the kernel will
> > automatically recover on mount. We're seeing that unclean shutdowns w/
> > data=journal,journal_csum frequently result in invalid checksums that
> > causes the kernel to abort recovery, while 'e2fsck -p' resolves the
> > issue non-interactively.
> > 
> > Driver for this question is that some Ubuntu installs set fstab's
> > passno=0 for the root fs - which I'm told is based on the assumption
> > that both kernel & e2fsck -p have parity when it comes to automatic
> > recovery - that's obviously does not appear to be the case - but I
> > wanted to confirm whether or not that is by design.
> > 
> >   -dann
> 
> Ted or others more involved w/ ext4 will speak w/ authority but it's my
> understanding that log replay, whether done by userspace or by the kernel,
> should always return the filesystem to a consistent state.  If that's not
> the case, scripting things so that you grab a qcow-format e2image prior
> to fsck so that you can share the problematic image with developers may
> help.

Thanks Eric. I captured an image in case it's useful:

  https://people.canonical.com/~dannf/md2.e2ic.qcow2

  -dann


> 
> (In XFS land, a large portion of the unreplayable logs we see are the
> result of storage that didn't /actually/ persist IOs that it claimed were
> persisted prior to the crash/poweroff.)
> 
> -Eric
