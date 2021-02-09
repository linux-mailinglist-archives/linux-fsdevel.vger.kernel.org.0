Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCF3156B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhBITVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 14:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233456AbhBITLy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:11:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A3BF64E7C;
        Tue,  9 Feb 2021 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612897772;
        bh=C1sO+7VHfI5EfcVi7WgJbSPsEPe7iFjqDf9cNt777Ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2TPqJJ45vfBYwEkmpfK3UKSwFbePfHIwIxYQ4rM3obvc0X7IKXTWvo0seXlu6Lfr
         yBojLOQfHNvrxEurKRRiddcZmFz/RO5I/CyS5PxWL16REAeI/e56f/+0RBaW0sqxyU
         5W+chH4Ca6TUiDWOItSBvR0pr3PLEdSSECtXvQyE=
Date:   Tue, 9 Feb 2021 11:09:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     dsterba@suse.cz
Cc:     ira.weiny@intel.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-Id: <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
In-Reply-To: <20210209151123.GT1993@suse.cz>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
        <20210209151123.GT1993@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 9 Feb 2021 16:11:23 +0100 David Sterba <dsterba@suse.cz> wrote:

> On Fri, Feb 05, 2021 at 03:23:00PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > There are many places where kmap/<operation>/kunmap patterns occur.  We lift
> > these various patterns to core common functions and use them in the btrfs file
> > system.  At the same time we convert those core functions to use
> > kmap_local_page() which is more efficient in those calls.
> > 
> > I think this is best accepted through Andrew's tree as it has the mem*_page
> > functions in it.  But I'd like to get an ack from David or one of the other
> > btrfs maintainers before the btrfs patches go through.
> 
> I'd rather take the non-mm patches through my tree so it gets tested
> the same way as other btrfs changes, straightforward cleanups or not.
> 
> This brings the question how to do that as the first patch should go
> through the MM tree. One option is to posptpone the actual cleanups
> after the 1st patch is merged but this could take a long delay.
> 
> I'd suggest to take the 1st patch within MM tree in the upcoming merge
> window and then I can prepare a separate pull with just the cleanups.
> Removing an inter-tree patch dependency was a sufficient reason for
> Linus in the past for such pull requests.

It would be best to merge [1/4] via the btrfs tree.  Please add my

Acked-by: Andrew Morton <akpm@linux-foundation.org>


Although I think it would be better if [1/4] merely did the code
movement.  Adding those BUG_ON()s is a semantic/functional change and
really shouldn't be bound up with the other things this patch series
does.  This logically separate change raises questions such as

- What is the impact on overall code size?  Not huge, presumably, but
  every little bit hurts.

- Additional runtime costs of those extra comparisons?

- These impacts could be lessened by using VM_BUG_ON() rather than
  BUG_ON() - should we do this?

- Linus reeeeeeeally doesn't like new BUG_ON()s.  Maybe you can sneak
  it past him ;)

See what I mean?  I do think it would be best to take those assertions
out of the patch and to propose them separately, at a later time.

