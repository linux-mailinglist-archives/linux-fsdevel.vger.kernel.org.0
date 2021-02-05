Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3889D31157B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBEWct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:32:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232374AbhBEOQJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:16:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46DE7B126;
        Fri,  5 Feb 2021 15:36:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C5D4DA6E9; Fri,  5 Feb 2021 16:34:42 +0100 (CET)
Date:   Fri, 5 Feb 2021 16:34:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, Miao Xie <miaox@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Message-ID: <20210205153441.GK1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Miao Xie <miaox@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210128061503.1496847-1-ira.weiny@intel.com>
 <20210203155648.GE1993@suse.cz>
 <20210204152608.GF1993@suse.cz>
 <20210205035236.GB5033@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205035236.GB5033@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 07:52:36PM -0800, Ira Weiny wrote:
> On Thu, Feb 04, 2021 at 04:26:08PM +0100, David Sterba wrote:
> > On Wed, Feb 03, 2021 at 04:56:48PM +0100, David Sterba wrote:
> > > On Wed, Jan 27, 2021 at 10:15:03PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > Changelog is good, thanks. I've added stable tags as the missing unmap
> > > is a potential problem.
> > 
> > There are lots of tests faling, stack traces like below. I haven't seen
> > anything obvious in the patch so that needs a closer look and for the
> > time being I can't add the patch to for-next.
> 
> :-(
> 
> I think I may have been off by 1 on the raid6 kmap...
> 
> Something like this should fix it...
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index b8a39dad0f00..dbf52f1a379d 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2370,7 +2370,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>                         goto cleanup;
>                 }
>                 SetPageUptodate(q_page);
> -               pointers[rbio->real_stripes] = kmap(q_page);
> +               pointers[rbio->real_stripes - 1] = kmap(q_page);

Oh right and tests agree it works.

>         }
>  
>         atomic_set(&rbio->error, 0);
> 
> Let me roll a new version.

No need to, I'll fold the fixup. Thanks.
