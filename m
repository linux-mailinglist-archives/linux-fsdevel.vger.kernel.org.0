Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB84D3BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiCIVUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiCIVUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:20:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABF818AE
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 13:19:24 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v15so2868947qkg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlZNbila5z1+otTKSUqT/cUy3TNhtVzRrogJrg/OjoY=;
        b=SxbulSgkhNMU9yfPV80TPGT49sEbiJR5t9ZshUSwhN4yQUUu6y8hWxizYGCTplKTiF
         syJdcy4nfBFhctAswbESjMFBSHgLTHjG+heRIpwhRJkQyDykAv0zlhBYnr9Qtxp4URVM
         Q3HuEAqNAtEvyoueuKDY8xjmKsAGZSzq6KOveooRPUK2LaO06DJYvKJVhydcRF9a5Z90
         4USxy4dxFfnSkgvIXK1ajy0dXTS6CyNXng5S8aYr2ZyHclWf3BptcMkaVjWZudf0k1fu
         eHvmeZgucgp0dxzr85VN8NkaI3NhuhFOL/tJqYf54YRKwdytQQ2c5EojzV/3BGGwYHUB
         tmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlZNbila5z1+otTKSUqT/cUy3TNhtVzRrogJrg/OjoY=;
        b=FVTU5OeAkG6ID91HVqPOKo2djmwiNQ4vW1njqYIqdffNdc7gaiowWjnpUuj8g7A4le
         XTG0pai+HnWCxh1RxwpxGyrzDAWBHjZJwieO79UfHd98esBdFdIgVRunbF3Vtzhf+1mE
         RBw2BZI5wdbsgGPHpuMp4wm+TMJ0Osld7EE3lsSUEnqEQ27gY1aSc0sPq0Xtx9NA2cct
         PLS/QgHivqGMX2JWccfqs/4VTJsWwp4uB4zMidDkljYMZLWCvEqagqOs9Nx6xKdajfPv
         nB4gBG5WSRyagRz7HCpJGZPaYC6geBcRhgBiDQolkFANibMJqq/3k/bfqHyHo87eVf6D
         oTzQ==
X-Gm-Message-State: AOAM531jIvEiJ3WKV3i3O9g4IFDrEo/GCYkgJ9gO/P2HL3KgoBl/N804
        /UN0PTVnV7UAwG3uMsx73ysVKA==
X-Google-Smtp-Source: ABdhPJx4F6JZFCUwOk1VHr6d/Tc4XHzIrneEi7jmeA4zXTsf1rw+qdb7e8+KG+ez3vxR6U+F7Da4YA==
X-Received: by 2002:a05:620a:13f2:b0:60b:d595:6db1 with SMTP id h18-20020a05620a13f200b0060bd5956db1mr1159960qkl.366.1646860763135;
        Wed, 09 Mar 2022 13:19:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm1410016qkb.86.2022.03.09.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:19:22 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:19:21 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> On Wed, Mar 09, 2022 at 01:49:18PM -0500, Josef Bacik wrote:
> > On Wed, Mar 09, 2022 at 10:41:53AM -0800, Luis Chamberlain wrote:
> > > On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> > > > One of my team members has been working with Darrick to set up a set
> > > > of xfs configs[1] recommended by Darrick, and she's stood up an
> > > > automated test spinner using gce-xfstests which can watch a git branch
> > > > and automatically kick off a set of tests whenever it is updated.
> > > 
> > > I think its important to note, as we would all know, that contrary to
> > > most other subsystems, in so far as blktests and fstests is concerned,
> > > simply passing a test once does not mean there is no issue given that
> > > some test can fail with a failure rate of 1/1,000 for instance.
> > > 
> > 
> > FWIW we (the btrfs team) have been running nightly runs of fstests against our
> > devel branch for over a year and tracking the results.
> 
> That's wonderful, what is your steady state goal? And do you have your
> configurations used public and also your baseline somehwere? I think
> this later aspect could be very useful to everyone.
> 

Yeah I post the results to http://toxicpanda.com, you can see the results from
the runs, and http://toxicpanda.com/performance/ has the nightly performance
numbers and graphs as well.

This was all put together to build into something a little more polished, but
clearly priorities being what they are this is as far as we've taken it.  For
configuration you can see my virt-scripts here
https://github.com/josefbacik/virt-scripts which are what I use to generate the
VM's to run xfstests in.

The kernel config I use is in there, I use a variety of btrfs mount options and
mkfs options, not sure how interesting those are for people outside of btrfs.

Right now I have a box with ZNS drives waiting for me to set this up on so that
we can also be testing btrfs zoned support nightly, as well as my 3rd
RaspberryPi that I'm hoping doesn't blow up this time.

I have another virt setup that uses btrfs snapshots to create a one off chroot
to run smoke tests for my development using virtme-run.  I want to replace the
libvirtd vms with virtme-run, however I've got about a 2x performance difference
between virtme-run and libvirtd that I'm trying to figure out, so right now all
the nightly test VM's are using libvirtd.

Long, long term the plan is to replace my janky home setup with AWS VM's that
can be fired from GitHub actions whenever we push branches, that way individual
developers can get results for their patches before they're merged, and we don't
have to rely on my terrible python+html for test results.

> Yes, everyone's test setup can be different, but this is why I went with
> a loopback/truncated file setup, it does find more issues and so far
> these have all been real.
> 
> It kind of begs the question if we should adopt something like kconfig
> on fstests to help enable a few test configs we can agree on. Thoughts?
> 

For us (and I imagine other fs'es) the kconfigs are not interesting, it's the
combo of different file system features that can be toggled on and off via mkfs
as well as different mount options.  For example I run all the different mkfs
features through normal mount options, and then again with compression turned
on.  Thanks,

Josef
