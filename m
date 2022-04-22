Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9E50B773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447599AbiDVMhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447594AbiDVMhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:37:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB310A2;
        Fri, 22 Apr 2022 05:34:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23MCYCib010551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 08:34:14 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BAA8615C3EA1; Fri, 22 Apr 2022 08:34:12 -0400 (EDT)
Date:   Fri, 22 Apr 2022 08:34:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Message-ID: <YmKgxGFc4SMi7MnB@mit.edu>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
 <YmJDqceT1AiePyxj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJDqceT1AiePyxj@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:56:57PM -0700, Christoph Hellwig wrote:
> > This should also apply to other test debug modules like null_blk,
> > nvme target loop drivers, etc, it's all the same long term. But yeah
> > scsi surely make this... painful today. In any case hopefully folks
> > with other test debug drivesr are running tests to ensure you can
> > always rmmod these modules regardless of what is happening.
> 
> Maybe fix blktests to not rely on module removal  I have such a hard
> time actually using blktests because it is suck a f^^Y% broken piece
> of crap that assumes everything is modular.  Stop making that whole
> assumption and work fine with built-in driver as a first step.  Then
> start worrying about module removal.

I would love it if blktests didn't require modules, period.  That's
because it's super-convenient to be able to pluck a kernel out from
the build tree without having to install it first.  If all of the
necessary devices could be built-into the kernel, this would allow
this to work:

     make
     kvm-xfstests --blktests

which ends up running something like this:

/usr/bin/kvm -boot order=c -net none -machine type=pc,accel=kvm:tcg \
	     ... \
	     --kernel /build/ext4/arch/x86/boot/bzImage
	     --append "quiet loglevel=0 root=/dev/vda console=ttyS0,115200 nokaslr fstestopt=blktests,aex ..."

Unfortunately, because blktests requires modules, I can only do this
sort of thing using gce-xfstests and by passing in a kernel.deb file
so I can get the !@#@! modules installed.  (If I could use kexec with
gce-xfstets, I'd shave almost a minute of test appliance setup time,
and starting a GCE VM talks a minute or two extra over using
kvm-xfstests.)

I think we would need to make some changes to how scsi_debug and other
block device modules, first, though.  blktests is using modules
because that appears to be the only way to configure some of these
test/debug drivers and then have the debug device show up with the
specified characteristics.

						- Ted
