Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D799315884
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhBIVUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhBIVLp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:11:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AA4564E7C;
        Tue,  9 Feb 2021 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612905064;
        bh=ytWLcwYOAUd4IbrcpYpDbdEK5/yTd4hUKIl3OD0fARQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmCRQYb54ZgO/nxjSZAS7fqub0/QfEp6ycoSBu1FD4l8cDvEKSEN6cSzFvAFaU4UF
         TScFPAkFtgIPK5vM4t1e8Z5LIHY8wpHGFy7R8cxD3Ds2MfdO8kUAECxtcMRguiP96t
         OZgeHD5rfSxrtMRJ1b/JZSEU3wUw+sZ3B3HaCXag=
Date:   Tue, 9 Feb 2021 13:11:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-Id: <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
In-Reply-To: <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
        <20210209151123.GT1993@suse.cz>
        <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
        <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 9 Feb 2021 12:52:49 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 09, 2021 at 11:09:31AM -0800, Andrew Morton wrote:
> > On Tue, 9 Feb 2021 16:11:23 +0100 David Sterba <dsterba@suse.cz> wrote:
> > 
> > > On Fri, Feb 05, 2021 at 03:23:00PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > There are many places where kmap/<operation>/kunmap patterns occur.  We lift
> > > > these various patterns to core common functions and use them in the btrfs file
> > > > system.  At the same time we convert those core functions to use
> > > > kmap_local_page() which is more efficient in those calls.
> > > > 
> > > > I think this is best accepted through Andrew's tree as it has the mem*_page
> > > > functions in it.  But I'd like to get an ack from David or one of the other
> > > > btrfs maintainers before the btrfs patches go through.
> > > 
> > > I'd rather take the non-mm patches through my tree so it gets tested
> > > the same way as other btrfs changes, straightforward cleanups or not.
> > > 
> > > This brings the question how to do that as the first patch should go
> > > through the MM tree. One option is to posptpone the actual cleanups
> > > after the 1st patch is merged but this could take a long delay.
> > > 
> > > I'd suggest to take the 1st patch within MM tree in the upcoming merge
> > > window and then I can prepare a separate pull with just the cleanups.
> > > Removing an inter-tree patch dependency was a sufficient reason for
> > > Linus in the past for such pull requests.
> > 
> > It would be best to merge [1/4] via the btrfs tree.  Please add my
> > 
> > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > 
> > Although I think it would be better if [1/4] merely did the code
> > movement.  Adding those BUG_ON()s is a semantic/functional change and
> > really shouldn't be bound up with the other things this patch series
> > does.
> 
> I proposed this too and was told 'no'...
> 
> <quote>
> If we put in into a separate patch, someone will suggest backing out the
> patch which tells us that there's a problem.
> </quote>
> 	-- https://lore.kernel.org/lkml/20201209201415.GT7338@casper.infradead.org/

Yeah, no, please let's not do this.  Bundling an offtopic change into
[1/4] then making three more patches dependent on the ontopic parts of
[1/4] is just rude.

I think the case for adding the BUG_ONs can be clearly made.  And that
case should at least have been clearly made in the [1/4] changelog!

(Although I expect VM_BUG_ON() would be better - will give us sufficient
coverage without the overall impact.)

Let's please queue this up separately.
