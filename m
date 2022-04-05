Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828D14F54DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbiDFFPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581720AbiDEXkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:40:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE931CABF4;
        Tue,  5 Apr 2022 15:00:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 235M0lKB028891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Apr 2022 18:00:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6D78A15C3EB6; Tue,  5 Apr 2022 18:00:47 -0400 (EDT)
Date:   Tue, 5 Apr 2022 18:00:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <Yky8DzTNiYovRbHb@mit.edu>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
 <20220403232823.GS1609613@dread.disaster.area>
 <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:36:03PM +0530, Ritesh Harjani wrote:
> > > +# blocksize and fact are used in the last case of the fsync/fdatasync test.
> > > +# This is mainly trying to test recovery operation in case where the data
> > > +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
> > > +blocks=32768
> > > +blocksize=4096
> >
> > Block size can change based on mkfs parameters. You should extract
> > this dynamically from the filesystem the test is being run on.
> >
> 
> Yes, but we still have kept just 4096 because, anything bigger than that like
> 65536 might require a bigger disk size itself to test. The overall size
> requirement of the disk will then become ~36G (32768 * 65536 * 18)
> Hence I went ahead with 4096 which is good enough for testing.

What if the block size is *smaller*?  For example, I run an ext4/1k
configuration (which is how I test block size > page size on x86 VM's :-).

> But sure, I will add a comment explaining why we have hardcoded it to 4096
> so that others don't get confused. Larger than this size disk anyway doesn't get
> tested much right?

At $WORK we use a 100GB disk by default when running xfstests, and I
wouldn't be surprised if theree are other folks who might use larger
disk sizes.

Maybe test to see whether the scratch disk is too small for the given
parameters and if so skip the test using _notrun?

							- Ted
