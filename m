Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA913462487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhK2WUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhK2WSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:18:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E5C200871;
        Mon, 29 Nov 2021 11:13:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A752F506D; Mon, 29 Nov 2021 14:13:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A752F506D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638213213;
        bh=nkUbylggLsjyDS70dHqAQl5G/jJWiH1XIk2TRER67nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hy6U+Fcs/QEsiV6feOlySSNyNqlP141HKkBAo1vFwlnuzOaNATI2t3YWWtfccyFDk
         gtbJId+7uTk1YwcpZc8hn3n/ZtMF8aGd9SsGOm+WAu9h1nJNbb0WjvfmtlI3wtXsWd
         FAXf176CmjcwMFR2O5TYwjRzsy/Y6YJLd/rt2nUc=
Date:   Mon, 29 Nov 2021 14:13:33 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211129191333.GE24258@fieldses.org>
References: <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:03:12PM +0000, Chuck Lever III wrote:
> Hello Dai!
> 
> 
> > On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > 
> > On 11/29/21 9:30 AM, J. Bruce Fields wrote:
> >> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
> >>> Hi Bruce,
> >>> 
> >>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
> >>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
> >>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
> >>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
> >>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
> >>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
> >>>>>>>>> Just a reminder that this patch is still waiting for your review.
> >>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
> >>>>>>>> failure for me....
> >>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
> >>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
> >>>>>>> seen still there.
> >>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
> >>>>>> 5.15-rc7 server.
> >>>>>> 
> >>>>>> Nfs4.1 results are the same for both courteous and
> >>>>>> non-courteous server:
> >>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
> >>>>>> Results of nfs4.0 with non-courteous server:
> >>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
> >>>>>> test failed: LOCK24
> >>>>>> 
> >>>>>> Results of nfs4.0 with courteous server:
> >>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
> >>>>>> tests failed: LOCK24, OPEN18, OPEN30
> >>>>>> 
> >>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
> >>>>> Could well be a bug in the tests, I don't know.
> >>>> The reason OPEN18 failed was because the test timed out waiting for
> >>>> the reply of an OPEN call. The RPC connection used for the test was
> >>>> configured with 15 secs timeout. Note that OPEN18 only fails when
> >>>> the tests were run with 'all' option, this test passes if it's run
> >>>> by itself.
> >>>> 
> >>>> With courteous server, by the time OPEN18 runs, there are about 1026
> >>>> courtesy 4.0 clients on the server and all of these clients have opened
> >>>> the same file X with WRITE access. These clients were created by the
> >>>> previous tests. After each test completed, since 4.0 does not have
> >>>> session, the client states are not cleaned up immediately on the
> >>>> server and are allowed to become courtesy clients.
> >>>> 
> >>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
> >>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
> >>>> server to check for conflicts with courtesy clients. The loop that
> >>>> checks 1026 courtesy clients for share/access conflict took less
> >>>> than 1 sec. But it took about 55 secs, on my VM, for the server
> >>>> to expire all 1026 courtesy clients.
> >>>> 
> >>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
> >>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
> >>>> now the same for courteous and non-courteous server:
> >>>> 
> >>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
> >>>> 
> >>>> Note that 4.1 tests do not suffer this timeout problem because the
> >>>> 4.1 clients and sessions are destroyed after each test completes.
> >>> Do you want me to send the patch to increase the timeout for pynfs?
> >>> or is there any other things you think we should do?
> >> I don't know.
> >> 
> >> 55 seconds to clean up 1026 clients is about 50ms per client, which is
> >> pretty slow.  I wonder why.  I guess it's probably updating the stable
> >> storage information.  Is /var/lib/nfs/ on your server backed by a hard
> >> drive or an SSD or something else?
> > 
> > My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
> > disk. I think a production system that supports this many clients should
> > have faster CPUs, faster storage.
> > 
> >> 
> >> I wonder if that's an argument for limiting the number of courtesy
> >> clients.
> > 
> > I think we might want to treat 4.0 clients a bit different from 4.1
> > clients. With 4.0, every client will become a courtesy client after
> > the client is done with the export and unmounts it.
> 
> It should be safe for a server to purge a client's lease immediately
> if there is no open or lock state associated with it.
> 
> When an NFSv4.0 client unmounts, all files should be closed at that
> point, so the server can wait for the lease to expire and purge it
> normally. Or am I missing something?

Makes sense to me!

> > Since there is
> > no destroy session/client with 4.0, the courteous server allows the
> > client to be around and becomes a courtesy client. So after awhile,
> > even with normal usage, there will be lots 4.0 courtesy clients
> > hanging around and these clients won't be destroyed until 24hrs
> > later, or until they cause conflicts with other clients.
> > 
> > We can reduce the courtesy_client_expiry time for 4.0 clients from
> > 24hrs to 15/20 mins, enough for most network partition to heal?,
> > or limit the number of 4.0 courtesy clients. Or don't support 4.0
> > clients at all which is my preference since I think in general users
> > should skip 4.0 and use 4.1 instead.

I'm also totally fine with leaving out 4.0, at least to start.

--b.
