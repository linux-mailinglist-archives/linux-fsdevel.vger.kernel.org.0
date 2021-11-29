Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6B462626
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhK2Wrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhK2WrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:47:04 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5BC0C20EF;
        Mon, 29 Nov 2021 09:30:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 67FB26EFB; Mon, 29 Nov 2021 12:30:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 67FB26EFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638207058;
        bh=J8hR9aJ4MN8Gx0xzcg4OJxlfhFJutINDOp1oyILDLoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ay5XorAWY3HUbZuO2Qwa/BKQ+jUJZBw43cxSLKzNKPVtgRbOW0gN9YM4TX/YSXonN
         3mgGisA9HOogdga6ZPsLJ3QJsFPrxywzzkmmrpRPc6HQvV5Q9uhxw4pjK7OawYBn+N
         Gvb8LZ7vNCtKc4vKO3kM97ger7v+3kYrHn/BhRWc=
Date:   Mon, 29 Nov 2021 12:30:58 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211129173058.GD24258@fieldses.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
> Hi Bruce,
> 
> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
> >
> >On 11/17/21 4:34 PM, J. Bruce Fields wrote:
> >>On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
> >>>On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
> >>>>On 11/17/21 6:14 AM, J. Bruce Fields wrote:
> >>>>>On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
> >>>>>>Just a reminder that this patch is still waiting for your review.
> >>>>>Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
> >>>>>failure for me....
> >>>>Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
> >>>>all OPEN tests together with 5.15-rc7 to see if the problem you've
> >>>>seen still there.
> >>>I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
> >>>5.15-rc7 server.
> >>>
> >>>Nfs4.1 results are the same for both courteous and
> >>>non-courteous server:
> >>>>Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
> >>>Results of nfs4.0 with non-courteous server:
> >>>>Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
> >>>test failed: LOCK24
> >>>
> >>>Results of nfs4.0 with courteous server:
> >>>>Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
> >>>tests failed: LOCK24, OPEN18, OPEN30
> >>>
> >>>OPEN18 and OPEN30 test pass if each is run by itself.
> >>Could well be a bug in the tests, I don't know.
> >
> >The reason OPEN18 failed was because the test timed out waiting for
> >the reply of an OPEN call. The RPC connection used for the test was
> >configured with 15 secs timeout. Note that OPEN18 only fails when
> >the tests were run with 'all' option, this test passes if it's run
> >by itself.
> >
> >With courteous server, by the time OPEN18 runs, there are about 1026
> >courtesy 4.0 clients on the server and all of these clients have opened
> >the same file X with WRITE access. These clients were created by the
> >previous tests. After each test completed, since 4.0 does not have
> >session, the client states are not cleaned up immediately on the
> >server and are allowed to become courtesy clients.
> >
> >When OPEN18 runs (about 20 minutes after the 1st test started), it
> >sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
> >server to check for conflicts with courtesy clients. The loop that
> >checks 1026 courtesy clients for share/access conflict took less
> >than 1 sec. But it took about 55 secs, on my VM, for the server
> >to expire all 1026 courtesy clients.
> >
> >I modified pynfs to configure the 4.0 RPC connection with 60 seconds
> >timeout and OPEN18 now consistently passed. The 4.0 test results are
> >now the same for courteous and non-courteous server:
> >
> >8 Skipped, 1 Failed, 0 Warned, 577 Passed
> >
> >Note that 4.1 tests do not suffer this timeout problem because the
> >4.1 clients and sessions are destroyed after each test completes.
> 
> Do you want me to send the patch to increase the timeout for pynfs?
> or is there any other things you think we should do?

I don't know.

55 seconds to clean up 1026 clients is about 50ms per client, which is
pretty slow.  I wonder why.  I guess it's probably updating the stable
storage information.  Is /var/lib/nfs/ on your server backed by a hard
drive or an SSD or something else?

I wonder if that's an argument for limiting the number of courtesy
clients.

--b.
