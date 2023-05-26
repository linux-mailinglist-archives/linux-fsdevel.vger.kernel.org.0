Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD76712BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbjEZRnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjEZRnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 13:43:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BBC9;
        Fri, 26 May 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685122977; x=1716658977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oVTXTtd3weRthTeMH9i8+iNiVZ06iiPC/ujdhnwNE9A=;
  b=LNXHiNB/tT2TjGA+vUQzpvkR4DGbgaIXYUF++fmYh398N7WvEqNdkE6o
   sqDmRe/2vyYYcmQDx1ggDFuJktpNlF3cNTokW1S/N6I0HELBmBP5npr+r
   7QmuRXnJLzehUfhUuMa5RPe5PpYQY9emgjikAWUuCV+KT2N16M3DMPSg3
   XVxIYUgdbO3jkoMMT+3+lvgkUdlNTo2DpRjWxmefzt8rxiFr62nokICUx
   Q3PaVweTAN/TNFrY8trM5GlhzfnZt3kcBQTAV63p/woXk1pm0y4ZpVoo/
   jbXNRDEqi1mAF828+R685RzY7PgqnogAwUQbVSbaA43NriRYQuQw4/O0i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417744736"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="417744736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 10:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="775163414"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="775163414"
Received: from ggreenle-mobl1.amr.corp.intel.com (HELO [10.212.214.91]) ([10.212.214.91])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 10:42:56 -0700
Message-ID: <ddaf2e42-ea1e-2359-4859-310a126bd0c1@intel.com>
Date:   Fri, 26 May 2023 10:42:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230525175542.GB821358@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/25/23 10:55, Theodore Ts'o wrote:
> Bottom line, having various companies run their own private instances
> of syzkaller is much less useful for the upstream community.

Yes, totally agree.

> If Intel feels that it's useful to run their own instance, maybe
> there's some way you can work with Google syzkaller team so you don't
> have to do that?
I actually don't know why or when Intel started doing this.  0day in
general runs on a pretty diverse set of systems and I suspect this was
an attempt to leverage that.  Philip, do you know the history here?

Pengfei, is there a list somewhere of the things that you think are
missing from Google's syzkaller instance?  If not, could you make one,
please?
