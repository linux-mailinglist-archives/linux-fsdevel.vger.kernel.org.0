Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5198260DFE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiJZLok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJZLoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:44:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D729DFC00;
        Wed, 26 Oct 2022 04:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA11BB821AB;
        Wed, 26 Oct 2022 11:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D782FC433C1;
        Wed, 26 Oct 2022 11:41:32 +0000 (UTC)
Date:   Wed, 26 Oct 2022 07:41:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221026074145.2be5ca09@gandalf.local.home>
In-Reply-To: <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
        <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
        <20221024144411.GA25172@lst.de>
        <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
        <20221024171042.GF5824@suse.cz>
        <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Oct 2022 07:36:45 +0000
Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:

> [+Cc Steven ]
> 
> Steven, you're on the TAB, can you help with this issue?
> Or bring it up with other TAB members?
> 

Well, Chris Mason was recently the TAB chair.

> Thanks :)
> 
> Full quote below for reference:
> 
> On 24.10.22 19:11, David Sterba wrote:
> > On Mon, Oct 24, 2022 at 11:25:04AM -0400, Chris Mason wrote:  
> >> On 10/24/22 10:44 AM, Christoph Hellwig wrote:  
> >>> On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:  
> >>>> David, what's your plan to progress with this series?  
> >>>
> >>> FYI, I object to merging any of my code into btrfs without a proper
> >>> copyright notice, and I also need to find some time to remove my
> >>> previous significant changes given that the btrfs maintainer
> >>> refuses to take the proper and legally required copyright notice.
> >>>
> >>> So don't waste any of your time on this.  
> >>
> >> Christoph's request is well within the norms for the kernel, given that 
> >> he's making substantial changes to these files.  I talked this over with 
> >> GregKH, who pointed me at:
> >>
> >> https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects
> >>
> >> Even if we'd taken up some of the other policies suggested by this doc, 
> >> I'd still defer to preferences of developers who have made significant 
> >> changes.  
> > 
> > I've asked for recommendations or best practice similar to the SPDX
> > process. Something that TAB can acknowledge and that is perhaps also
> > consulted with lawyers. And understood within the linux project,
> > not just that some dudes have an argument because it's all clear as mud
> > and people are used to do things differently.
> > 
> > The link from linux foundation blog is nice but unless this is codified
> > into the process it's just somebody's blog post. Also there's a paragraph
> > about "Why not list every copyright holder?" that covers several points
> > why I don't want to do that.
> > 
> > But, if TAB says so I will do, perhaps spending hours of unproductive
> > time looking up the whole history of contributors and adding year, name,
> > company whatever to files.

There's no requirement to list every copyright holder, as most developers do
not require it for acceptance. The issue I see here is that there's someone
that does require it for you to accept their code.

The policy is simple. If someone requires a copyright notice for their
code, you simply add it, or do not take their code. You can be specific
about what that code is that is copyrighted. Perhaps just around the code in
question or a description at the top.

Looking over the thread, I'm still confused at what the issue is. Is it
that if you add one copyright notice you must do it for everyone else? Is
everyone else asking for it? If not, just add the one and be done with it.

-- Steve


