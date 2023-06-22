Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE373AC89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFVWd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFVWd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:33:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C401981
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 15:33:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b4f9583404so59165155ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687473205; x=1690065205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckdenG1i3LyU3fHf2zoe01aFyGsekEsJ7fVPuTD9/YY=;
        b=s8V71EIldaqGYVwOmX25NCzufmwczbjbrgxg/WeEa1tVZ/X7+ZCVYA8hPC4LG3Qvkn
         db8MLPdFQ6qQ8dmBGtQ8t94cTsLQ5Ydi1XOKr/+QanuSm2RstQ8Y/fZpEXhaht/7ZwuB
         GwSuHKtWPc8dq+j7OyEwNJ3i4OpBjaomjqeuva//+BZOjgr0niqPrxVsMO8LY/Oz+uBJ
         3y8uhc1yQjnf6+cbMQDAoEVpEv4m0GgtIXB9uMz8T29TlxqoD4uEwmnE/HBp538nGqHG
         NrfpCP3baC5jZLDd9Avv/tTwU5AteyEYhW+fsQM64bGVS3qrPcJ0+t3AJUmVCtX5bCuS
         e1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687473205; x=1690065205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckdenG1i3LyU3fHf2zoe01aFyGsekEsJ7fVPuTD9/YY=;
        b=T8mZQxJc40N464azJn54qYiwOHjHA0jZS7g/bkJNT9WmMPFJkqa02ur764okHBlB2L
         6Wn42TR/LhENHnh3StkYgpPUvQ6Qg4tKwZB3UbDbLUeZqcJnp2dROR/d5YBkfJr4WgE7
         PUm/9RXNtv0kDK61NQGeYXkUYdUFOOQckcPBkSS5qgirr7jX2ZBEi86e6YJL8ZiZyssY
         Iq381x5wfmC2Ks/8JUSDb8Mgl8TSJpHPB4cCGQcGpNPbQRrzMddYuYkwlGARsCDeCZCH
         OStZmHVNjLO9wkxfpnQdUxa/Nl5RLglm3HheWvlmzUR5Z0W5KPJP2SCnmDBbsvcJgOvk
         MvuQ==
X-Gm-Message-State: AC+VfDzRzD1ZSXxQinkXNkdGWxix5YfWxJmjZUscjtIz5e1FTTTemK1v
        kBv/hqt8qFHKMrJ/MaNzYiOmtQ==
X-Google-Smtp-Source: ACHHUZ5LOl6v4tJzRIJ2CnvEdQKdfTnGSIpNDMNl0rCRrm5pQQdwfVTuR2VbFWMZMSpopn3wI7CtSQ==
X-Received: by 2002:a17:902:d504:b0:1b5:5ad2:6eac with SMTP id b4-20020a170902d50400b001b55ad26eacmr16116467plg.33.1687473205331;
        Thu, 22 Jun 2023 15:33:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b001b3f47ea2e8sm5824366plb.117.2023.06.22.15.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:33:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCSri-00F0rw-0R;
        Fri, 23 Jun 2023 08:33:22 +1000
Date:   Fri, 23 Jun 2023 08:33:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] minimum folio order support in filemap
Message-ID: <ZJTMMhIhvXKfNz/4@dread.disaster.area>
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
 <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
 <ZJN0pvgA2TqOQ9BC@dread.disaster.area>
 <4270b5c7-04b4-28e0-6181-ef98d1f5130c@suse.de>
 <94d9e935-c8a4-896a-13ac-263831a78dd5@suse.de>
 <ZJQggr3ymd7eXgA4@dread.disaster.area>
 <a42b97a9-88d5-b8cd-e36e-81a168dff7cd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42b97a9-88d5-b8cd-e36e-81a168dff7cd@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:23:10PM +0200, Hannes Reinecke wrote:
> On 6/22/23 12:20, Dave Chinner wrote:
> > On Thu, Jun 22, 2023 at 08:50:06AM +0200, Hannes Reinecke wrote:
> > > On 6/22/23 07:51, Hannes Reinecke wrote:
> > > > On 6/22/23 00:07, Dave Chinner wrote:
> > > > > On Wed, Jun 21, 2023 at 11:00:24AM +0200, Hannes Reinecke wrote:
> > > > > > On 6/21/23 10:38, Pankaj Raghav wrote:
> > > > > > Hmm. Most unfortunate; I've just finished my own patchset
> > > > > > (duplicating much
> > > > > > of this work) to get 'brd' running with large folios.
> > > > > > And it even works this time, 'fsx' from the xfstest suite runs
> > > > > > happily on
> > > > > > that.
> > > > > 
> > > > > So you've converted a filesystem to use bs > ps, too? Or is the
> > > > > filesystem that fsx is running on just using normal 4kB block size?
> > > > > If the latter, then fsx is not actually testing the large folio page
> > > > > cache support, it's mostly just doing 4kB aligned IO to brd....
> > > > > 
> > > > I have been running fsx on an xfs with bs=16k, and it worked like a charm.
> > > > I'll try to run the xfstest suite once I'm finished with merging
> > > > Pankajs patches into my patchset.
> > > > Well, would've been too easy.
> > > 'fsx' bails out at test 27 (collapse), with:
> > > 
> > > XFS (ram0): Corruption detected. Unmount and run xfs_repair
> > > XFS (ram0): Internal error isnullstartblock(got.br_startblock) at line 5787
> > > of file fs/xfs/libxfs/xfs_bmap.c.  Caller
> > > xfs_bmap_collapse_extents+0x2d9/0x320 [xfs]
> > > 
> > > Guess some more work needs to be done here.
> > 
> > Yup, start by trying to get the fstests that run fsx through cleanly
> > first. That'll get you through the first 100,000 or so test ops
> > in a few different run configs. Those canned tests are:
> > 
> > tests/generic/075
> > tests/generic/112
> > tests/generic/127
> > tests/generic/231
> > tests/generic/455
> > tests/generic/457
> > 
> THX.
> 
> Any preferences for the filesystem size?
> I'm currently running off two ramdisks with 512M each; if that's too small I
> need to increase the memory of the VM ...

I generally run my pmem/ramdisk VM on a pair of 8GB ramdisks for 4kB
filesystem testing.

Because you are using larger block sizes, you are going to want to
use larger rather than smaller because there are fewer blocks for a
given size, and metadata blocks hold many more records before they
spill to multiple nodes/levels.

e.g. going from 4kB to 16kB needs a 16x larger fs and file sizes for
the 16kB filesystem to exercise the same metadata tree depth
coverage as the 4kB filesystem (i.e. each single block extent is 4x
larger, each single block metadata block holds 4x as much metadata
before it spills).

With this in mind, I'd say you want the 16kB block size ramdisks to
be as large as you can make them when running fstests....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
