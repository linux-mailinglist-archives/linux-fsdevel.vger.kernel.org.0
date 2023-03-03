Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA46A9035
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 05:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCCEUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 23:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCEUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:20:40 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DB1589F
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 20:20:39 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3234KQlt012375
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 23:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677817228; bh=UnVn9SQXj+xQGHz65tda2oIv7yPINQJtjR6aYPfdJQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WgYhcgiqsg+8sSl2tOb2NDrxj/5T0ISlbi0RcKr2x0kBTqiWGBlYNE8QE4Q27lPsp
         eyw+YObQY+obW56PQZApKtdg8b4zNsReYomY6W+n4rHtS+WOooAfcd5n5sB9looxwN
         28b983j4GY13CIWhaYkHbORFZVjEiwJXUoxA+07f1cb50w9r8iv2pUyHt0o4DKudq3
         YSC36+1NK2qlCdl/icP9DtI7UF+/Vplf729UHt3KGaEGJbAAPwtsK0ZifbrD5vpFYm
         hfaMjP4NyPIOOT2nZqqGFH9/LuDLgd6t+nwvxv+14MR+qa2LnlkhXHeTLd/53WfhYp
         a2kfSYlsg5piw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C34215C3593; Thu,  2 Mar 2023 23:20:26 -0500 (EST)
Date:   Thu, 2 Mar 2023 23:20:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAF1iuaXTJEvOe5c@mit.edu>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <yq1356mh925.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1356mh925.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:54:59PM -0500, Martin K. Petersen wrote:
> 
> Hi Ted!
> 
> > With NVMe, it is possible for a storage device to promise this without
> > requiring read-modify-write updates for sub-16k writes.  All that is
> > necessary are some changes in the block layer so that the kernel does
> > not inadvertently tear a write request when splitting a bio because it
> > is too large (perhaps because it got merged with some other request,
> > and then it gets split at an inconvenient boundary).
> 
> We have been working on support for atomic writes and it is not a simple
> as it sounds. Atomic operations in SCSI and NVMe have semantic
> differences which are challenging to reconcile. On top of that, both the
> SCSI and NVMe specs are buggy in the atomics department. We are working
> to get things fixed in both standards and aim to discuss our
> implementation at LSF/MM.

I'd be very interested to learn more about what you've found.  I know
more than one cloud provider is thinking about how to use the NVMe
spec to send information about how their emulated block device work.
This has come up at our weekly ext4 video conference, and given that I
gave a talk about it in 2018[1], there's quite a lot of similarity of
what folks are thinking about.  Basically, MySQL and Postgres use 16k
database pages, and if we can avoid their special doublewrite
techniques to avoid torn writes, because they can depend on their
Cloud Block Devices Working A Certain Way, it can make for very
noticeable performance improvements.

[1] https://www.youtube.com/watch?v=gIeuiGg-_iw

So while the standards might allow standards-compliant physical
devices to do some really wierd sh*t, it might be that if all cloud
vendors do things in the same way, I could see various cloud workloads
starting to depending on extra-standard behaviour, much like a lot of
sysadmins assume that low-numbered LBA's are on the outer diamenter of
the HDD and are much more performant than sectors on the i.d. of the
HDD.  This is completely not guaranteed by the standard specs, but
it's become a defacto standard.

That's not a great place to be, and it would be great if can find ways
that are much more reliable in terms of querying a standards-compliant
storage device and knowing whether we can depend on a certain behavior
--- but I also know how slowly storage standards bodies move.  :-(

> Hinting didn't see widespread adoption because we in Linux, as well as
> the various interested databases, preferred hints to be per-I/O
> properties. Whereas $OTHER_OS insisted that hints should be statically
> assigned to LBA ranges on media. This left vendors having to choose
> between two very different approaches and consequently they chose not to
> support any of them.

I wasn't aware of that history.  Thanks for filling that bit in.

Fortunately, in 2023, it appears that for many cloud vendors, the
teams involved care a lot more about Linux than $OTHER_OS.  So
hopefully we'll have a lot more success in getting write hints
generally available to hyperscale cloud customers.

From an industry-wide perspective, it would be useful if the write
hints used by Hyperscale Cloud Vendor #1 are very similar to what
write hints are supported by Hyperscale Cloud Vendor #2.  Standards
committees aren't the only way that companies can collaborate in an
anti-trust compliant way.  Open source is another way; and especially
if we can show that a set of hints work well for the Linux kernel and
Linux applications ---- then what we ship in the Linux kernel can help
shape the set of "write hints" that cloud storage devices will
support.

					- Ted

P.S.  From a LSF/MM program perspective, I suspect we may want to have
more than one session; one that is focused on standards and atomic
writes, and another that is focused on write hints.  The first might
be mostly block and fs focused, and the second would probably be of
interest to mm folks as well.
