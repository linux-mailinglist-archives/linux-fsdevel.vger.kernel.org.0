Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736D2CCCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgLCCpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:45:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:42056 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgLCCpq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:45:46 -0500
IronPort-SDR: vwVPEfuTvxupxXteHk9FI48+5tcRTM9Ay+DJexvkkUT+XpSLw/IpAGiKfdrGJOma6nGTpgXtey
 r7VlkYUnKJHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173284224"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="173284224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 18:45:05 -0800
IronPort-SDR: PGAN7asU6CT7MhvSoks4tzPepYKMkHCPYKjWpAlnBlN7Eguo/8nq5n485HI2O0v69vXLklCK4g
 iXXaILwCUJ3g==
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="481796846"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 18:45:04 -0800
Date:   Wed, 2 Dec 2020 18:45:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201203024504.GA1563847@iweiny-DESK2.sc.intel.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
 <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
 <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:42:08PM -0800, Linus Torvalds wrote:
> On Tue, Dec 1, 2020 at 6:16 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > This will force a change to xfstests at a minimum.  And I do know of users who
> > have been using this value.  But I have gotten inquires about using the feature
> > so there are users out there.
> 
> If it's only a few tests that fail, I wouldn't worry about it, and the
> tests should just be updated.

Done[1]

> 
> But if there are real user concerns, we may need to have some kind of
> compat code. Because of the whole "no regressions" thing.
> 
> What would the typical failure cases be in practice?

The failure will be a user not seeing their file operating in DAX mode when
they expect it to.

I discussed this with Dan Williams today.  He and I agreed the flag is new
enough that we don't think users have any released code to the API just yet.
So I think we will be ok.

Also, after learning what the other flag was for I agree with Christoph that
the impact is going to be minimal since users are not typically operating on
the root inode.

So I think we are ok with just making the change and getting it into stable
quickly.

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20201202214629.1563760-1-ira.weiny@intel.com/
