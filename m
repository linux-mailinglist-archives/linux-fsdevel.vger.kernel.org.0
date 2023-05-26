Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B36712EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjEZVUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZVUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 17:20:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475B99;
        Fri, 26 May 2023 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685136023; x=1716672023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xLztI1z/bt8u7ZWjF6Lk6lSk8LyetuzzR2QE/9h7Ys8=;
  b=NLLsHNBS+iOT/Szy/NWdPUQWAMc4gPMA1Lby2CvfqquLrh1WMNHaT8bZ
   pgZynHA6CE+qE82Qa3qDXfioGlyLskaaj0VQy3sjMzXjTsEF+E3CSAJeo
   EkLfmaM7OMVRWKGvvlOLdRm31fpi4yetXM8Q+JASAm9mKbZW9311jGXUM
   fFm06nQluw4/GKH2MWTO3wh3nzwld7A8DizIzpMK0/eCsKd7lc42RMFFD
   UnrtPveMDxCOJK37gQrp3UeT1HJGft/o6b9O2unD8h7nFZMAYu+86tMhN
   0LfCauEqRxARC3eWde35MVKs1N8FAAd+Qd+cXslZUf4i8O8oZfx1koAvm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="343804416"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="343804416"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="655769998"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="655769998"
Received: from ggreenle-mobl1.amr.corp.intel.com (HELO [10.212.214.91]) ([10.212.214.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:20:22 -0700
Message-ID: <3ac927ab-35ae-4b6b-4308-fab5bf072e9c@intel.com>
Date:   Fri, 26 May 2023 14:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Eric Sandeen <sandeen@sandeen.net>, dchinner@redhat.com,
        djwong@kernel.org, heng.su@intel.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lkp@intel.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Li, Philip" <philip.li@intel.com>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com> <ZG785SwJtvR4pO/6@dread.disaster.area>
 <20230525175542.GB821358@mit.edu>
 <ddaf2e42-ea1e-2359-4859-310a126bd0c1@intel.com>
 <20230526205434.GA973485@mit.edu>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230526205434.GA973485@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/23 13:54, Theodore Ts'o wrote:
> On Fri, May 26, 2023 at 10:42:55AM -0700, Dave Hansen wrote:
>>
>>> If Intel feels that it's useful to run their own instance, maybe
>>> there's some way you can work with Google syzkaller team so you don't
>>> have to do that?
>>
>> I actually don't know why or when Intel started doing this.  0day in
>> general runs on a pretty diverse set of systems and I suspect this was
>> an attempt to leverage that.  Philip, do you know the history here?
> 
> Yeah, I think that's at least part of the issue.  Looking at some of
> the reports that, the reported architecture was Tiger Lake and Adler
> Lake.  According to Pengfei, part of this was to test features that
> require newer cpu features, such as CET / Shadow Stack.  Now, I could
> be wrong, because Intel's CPU naming scheme is too complex for my tiny
> brain and makes my head spin.  It's really hard to map the names used
> for mobile processors to those used by Xeon server class platforms,
> but I *think*, if Intel's Product Managers haven't confused me
> hopelessly, Google Cloud's C3 VM's, which use Sapphire Rapids, should
> have those hardware features which are in Tiger Lake and Adler Lake,
> while the Google Cloud's N2 VM's, which use Ice Lake processors, are
> too old.  Can someone confirm if I got that right?

That's roughly right.  *But*, there are things that got removed from
Tiger->Alder Lake like AVX-512 and things that the Xeons have that the
client CPUs don't, like SGX.

Shadow stacks are definitely one of the things that got added from Ice
Lake => Sapphire Rapids.

But like you mentioned below, I don't see any actual evidence that
"newer" hardware is implicated here at all.

> So this might be an issue of Intel submitting the relevant syzkaller
> commits that add support for testing Shadow Stack, CET, IOMMUFD, etc.,
> where needed to the upstream syzkaller git repo --- and then
> convincing the Google Syzkaller team to turn up run some of test VM's
> on the much more expensive (per CPU/hour) C3 VM's.  The former is
> probably something that is just a matter of standard open source
> upstreaming.  The latter might be more complicated, and might require
> some private negotiations between companies to address the cost
> differential and availability of C3 VM's.

Yeah, absolutely.

If Intel keeps up with its own instance of syzkaller, Intel should
constantly be asking itself why the Google instance isn't hitting the
same bugs and how we can close the gap if there is one.

> The other thing that's probably worth considering here is that
> hopefully many of these reports are one that aren't *actually*
> architecture dependent, but for some reason, are just results that one
> syzkaller's instance has found, but another syzkaller instance has not
> yet found.  So perhaps there can be some kind of syzkaller state
> export/import scheme so that a report that be transferred from one
> syzkaller instance to another.  That way, upstream developers would
> have a single syzkaller dashboard to pay attention to, get regular
> information about how often a particular report is getting triggered,
> and if the information behind the report can get fed into receiving
> syzkaller's instance's fuzzing seed library, it might improve the test
> coverage for other kernels that Intel doesn't have the business case
> to test (e.g., Android kernels, kernels compiled for arm64 and RISC-V,
> etc.)

Absolutely, a unified view of all of the instances would be really nice.

> After all, looking at the report which kicked off this thread ("soft
> lockup in __cleanup_mnt"), I don't think this is something that should
> be hardware specific; and yet, this report appears not to exist in
> Google's syzkaller instance.  If we could import the fuzzing seed for
> this and similar reports into Google's syzkaller instance, it seems to
> me that this would be a Good Thing.

Very true.  I don't see anything obviously Intel-specific here.  One of
the first questions we should be asking ourselves is why _we_ hit this
and Google didn't.
