Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C4310E10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhBEPEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:20441 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhBEPBi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:01:38 -0500
IronPort-SDR: I0RQXoqhb8eQw1usaUYHzw6fQNMRPhL2NaNp20B8nqnk7HiRbeJaboxnmmg3IpOiqBuVOMeyll
 JG8i/x7N8MTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="178896135"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="178896135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:39:44 -0800
IronPort-SDR: mkUckrG34FQjlWbQInn1qN7/g3VW/ZmvfgPktbzaQbPAvpXJCi0YN6LEAoJT0CLTRRq54cdfo+
 wNeW4T2KhTSw==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="416249027"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:39:43 -0800
Date:   Fri, 5 Feb 2021 08:39:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, Miao Xie <miaox@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Message-ID: <20210205163943.GD5033@iweiny-DESK2.sc.intel.com>
References: <20210128061503.1496847-1-ira.weiny@intel.com>
 <20210203155648.GE1993@suse.cz>
 <20210204152608.GF1993@suse.cz>
 <20210205035236.GB5033@iweiny-DESK2.sc.intel.com>
 <20210205153441.GK1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205153441.GK1993@twin.jikos.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:34:41PM +0100, David Sterba wrote:
> On Thu, Feb 04, 2021 at 07:52:36PM -0800, Ira Weiny wrote:
> > On Thu, Feb 04, 2021 at 04:26:08PM +0100, David Sterba wrote:
> > > On Wed, Feb 03, 2021 at 04:56:48PM +0100, David Sterba wrote:
> > > > On Wed, Jan 27, 2021 at 10:15:03PM -0800, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > Changelog is good, thanks. I've added stable tags as the missing unmap
> > > > is a potential problem.
> > > 
> > > There are lots of tests faling, stack traces like below. I haven't seen
> > > anything obvious in the patch so that needs a closer look and for the
> > > time being I can't add the patch to for-next.
> > 
> > :-(
> > 
> > I think I may have been off by 1 on the raid6 kmap...
> > 
> > Something like this should fix it...
> > 
> > diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> > index b8a39dad0f00..dbf52f1a379d 100644
> > --- a/fs/btrfs/raid56.c
> > +++ b/fs/btrfs/raid56.c
> > @@ -2370,7 +2370,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
> >                         goto cleanup;
> >                 }
> >                 SetPageUptodate(q_page);
> > -               pointers[rbio->real_stripes] = kmap(q_page);
> > +               pointers[rbio->real_stripes - 1] = kmap(q_page);
> 
> Oh right and tests agree it works.
> 
> >         }
> >  
> >         atomic_set(&rbio->error, 0);
> > 
> > Let me roll a new version.
> 
> No need to, I'll fold the fixup. Thanks.

Oh cool thanks!  :-D
Ira

