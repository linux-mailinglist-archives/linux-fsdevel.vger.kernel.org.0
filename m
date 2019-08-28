Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34ECA04F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfH1O1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 10:27:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48329 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbfH1O1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:27:52 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7SERT6U008937
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 10:27:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4AA8F42049E; Wed, 28 Aug 2019 10:27:29 -0400 (EDT)
Date:   Wed, 28 Aug 2019 10:27:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190828142729.GB24857@mit.edu>
References: <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
 <20190828120509.GC22165@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828120509.GC22165@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:05:11PM +1000, Matthew Bobrowski wrote:
> > What is not clear to me at this point though is whether it is still
> > necessary to explicitly track unwritten extents via in-core inode
> > attributes i.e. ->i_unwritten and ->i_state_flags under the new direct
> > IO code path implementation, which makes use of the iomap
> > infrastructure. Or, whether we can get away with simply not using
> > these in-core inode attributes and rely just on checks against the
> > extent record directly, as breifly mentioned by Darrick. I would think
> > that this type of check would be enough, however the checks around
> > whether the inode is currently undergoing direct IO were implemented
> > at some point, so there must be a reason for having them
> > (a9b8241594add)?

The original reason why we created the DIO_STATE_UNWRITTEN flag was a
fast path, where the common case is writing blocks to an existing
location in a file where the blocks are already allocated, and marked
as written.  So consulting the on-disk extent tree to determine
whether unwritten extents need to be converted and/or split is
certainly doable.  However, it's expensive for the common case.  So
having a hint whether we need to schedule a workqueue to possibly
convert an unwritten region is helpful.  If we can just free the bio
and exit the I/O completion handler without having to take shared
locks to examine the on-disk extent tree, so much the better.

> Maybe it's a silly question, although I'm wanting to clarify my
> understanding around why it is that when we either try prepend or
> append to an existing extent, we don't permit merging of extents if

If I recall correctly, the reason for this check was mainly the
concern that we would end up merging an extent that we would then have
to split later on (when the direct I/O completed).

To be honest, i'm not 100% sure what would happen if we removed that
restriction; it might be that things would work just fine (just slower
in some workloads), or whether there is some hidden dependency that
would explode.  I suspect we'd have to try the experiment to be sure.

      		  	       	    - Ted
				    
