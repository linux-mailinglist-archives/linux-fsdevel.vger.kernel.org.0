Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8504CE9E4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfJ3PEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:04:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51128 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:04:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9UF4bG3006443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 11:04:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7BF1F420456; Wed, 30 Oct 2019 11:04:37 -0400 (EDT)
Date:   Wed, 30 Oct 2019 11:04:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: bio_alloc never fails
Message-ID: <20191030150437.GB16197@mit.edu>
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
 <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 03:43:10PM +0530, Ritesh Harjani wrote:
> 
> 
> On 10/30/19 9:56 AM, Gao Xiang wrote:
> > Similar to [1] [2], it seems a trivial cleanup since
> > bio_alloc can handle memory allocation as mentioned in
> > fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> > 
> 
> AFAIU, the reason is that, bio_alloc with __GFP_DIRECT_RECLAIM
> flags guarantees bio allocation under some given restrictions,
> as stated in fs/direct-io.c
> So here it is ok to not check for NULL value from bio_alloc.
> 
> I think we can update above info too in your commit msg.

Please also add a short comment in the code itself, so it's clear why
it's OK to skip the error check, and reference the comments for
bio_alloc_bioset().  This is the fairly subtle bit which makes this
change not obvious:

 *   When @bs is not NULL, if %__GFP_DIRECT_RECLAIM is set then bio_alloc will
 *   always be able to allocate a bio. This is due to the mempool guarantees.
 *   To make this work, callers must never allocate more than 1 bio at a time
 *   from this pool. Callers that need to allocate more than 1 bio must always
 *   submit the previously allocated bio for IO before attempting to allocate
 *   a new one. Failure to do so can cause deadlocks under memory pressure.
 *
 *   Note that when running under generic_make_request() (i.e. any block
 *   driver), bios are not submitted until after you return - see the code in
 *   generic_make_request() that converts recursion into iteration, to prevent
 *   stack overflows.
 *
 *   This would normally mean allocating multiple bios under
 *   generic_make_request() would be susceptible to deadlocks, but we have
 *   deadlock avoidance code that resubmits any blocked bios from a rescuer
 *   thread.

Otherwise, someone else may not understand why it's safe to not check
the error return then submit cleanup patch to add the error checking
back.  :-)

					- Ted
					
