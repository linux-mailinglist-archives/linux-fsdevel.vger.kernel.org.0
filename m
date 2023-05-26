Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA575712E88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbjEZUzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbjEZUzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 16:55:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D5FBC
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 13:55:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34QKsZW6022218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685134478; bh=8meQMKSEE9PZHXfPMmFKBLo/EW3as8+hvwSlHcLUHZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dIXYGMN2tXD1S2mknoREeXyPV6/1dNx+SiHSgp8NNMNX7ltpDpyggULo/qvmBTP0C
         sk39pOLllRBx9JvaF0ECKOnAHSHPSNbxb77z6CHzBmibgi0agvnrx3/+/B/kh308QD
         Ft3rMiMWS+6bH/dfThRDE0Qc4eHs0VweSwr2n+fbybKVN2zQA+/Jx8SpCSxx6YjyGi
         dUk6KnNzPD0a8MfPj9MVmjYhIodQlf2WUTnpqUyH2vWtxpVSfPwnA5qOtoS0kCzsCd
         XHP+PRhHFN6J+iH1GtPQKSE4hpWfcksVSWryBvCcj9V4Rm/xWKDXQlzu9Qj1IpjlEq
         afCWUZCAFEKNA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 01CB015C02DC; Fri, 26 May 2023 16:54:34 -0400 (EDT)
Date:   Fri, 26 May 2023 16:54:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Eric Sandeen <sandeen@sandeen.net>, dchinner@redhat.com,
        djwong@kernel.org, heng.su@intel.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lkp@intel.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <20230526205434.GA973485@mit.edu>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
 <ZG785SwJtvR4pO/6@dread.disaster.area>
 <20230525175542.GB821358@mit.edu>
 <ddaf2e42-ea1e-2359-4859-310a126bd0c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddaf2e42-ea1e-2359-4859-310a126bd0c1@intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:42:55AM -0700, Dave Hansen wrote:
> 
> > If Intel feels that it's useful to run their own instance, maybe
> > there's some way you can work with Google syzkaller team so you don't
> > have to do that?
>
> I actually don't know why or when Intel started doing this.  0day in
> general runs on a pretty diverse set of systems and I suspect this was
> an attempt to leverage that.  Philip, do you know the history here?

Yeah, I think that's at least part of the issue.  Looking at some of
the reports that, the reported architecture was Tiger Lake and Adler
Lake.  According to Pengfei, part of this was to test features that
require newer cpu features, such as CET / Shadow Stack.  Now, I could
be wrong, because Intel's CPU naming scheme is too complex for my tiny
brain and makes my head spin.  It's really hard to map the names used
for mobile processors to those used by Xeon server class platforms,
but I *think*, if Intel's Product Managers haven't confused me
hopelessly, Google Cloud's C3 VM's, which use Sapphire Rapids, should
have those hardware features which are in Tiger Lake and Adler Lake,
while the Google Cloud's N2 VM's, which use Ice Lake processors, are
too old.  Can someone confirm if I got that right?

So this might be an issue of Intel submitting the relevant syzkaller
commits that add support for testing Shadow Stack, CET, IOMMUFD, etc.,
where needed to the upstream syzkaller git repo --- and then
convincing the Google Syzkaller team to turn up run some of test VM's
on the much more expensive (per CPU/hour) C3 VM's.  The former is
probably something that is just a matter of standard open source
upstreaming.  The latter might be more complicated, and might require
some private negotiations between companies to address the cost
differential and availability of C3 VM's.


The other thing that's probably worth considering here is that
hopefully many of these reports are one that aren't *actually*
architecture dependent, but for some reason, are just results that one
syzkaller's instance has found, but another syzkaller instance has not
yet found.  So perhaps there can be some kind of syzkaller state
export/import scheme so that a report that be transferred from one
syzkaller instance to another.  That way, upstream developers would
have a single syzkaller dashboard to pay attention to, get regular
information about how often a particular report is getting triggered,
and if the information behind the report can get fed into receiving
syzkaller's instance's fuzzing seed library, it might improve the test
coverage for other kernels that Intel doesn't have the business case
to test (e.g., Android kernels, kernels compiled for arm64 and RISC-V,
etc.)

After all, looking at the report which kicked off this thread ("soft
lockup in __cleanup_mnt"), I don't think this is something that should
be hardware specific; and yet, this report appears not to exist in
Google's syzkaller instance.  If we could import the fuzzing seed for
this and similar reports into Google's syzkaller instance, it seems to
me that this would be a Good Thing.

Cheers,

						- Ted
