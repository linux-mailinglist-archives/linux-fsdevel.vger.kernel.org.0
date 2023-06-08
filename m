Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242C072856D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjFHQk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjFHQjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23130FF
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 09:39:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 358GaM2E029198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 12:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686242186; bh=shiW3MxbgeJoRhHHYMf+Lg7J4ykrzks2P+y1IqsB/aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RqfXkYoZ5EfyswFT/IoHwD28IyGaSArs6cGCB/H0TD4xHGHzpBVP2vwPhrxaz6S4M
         /3rwqaPRGQ8aSiECtd052yWKcpmZGeSVS6MBJPjCE7//VdQu9n6EkMBmkPIExzyvk/
         7ne4YcOKUq6w3GNtlSuqCHJfkyScdvJ8Oo8F2i2igkP8q1ngkCaJAU+UbCJG6S5dUK
         jI26E84MM/d1eGpejXwsiRKo7MGZP5McibXcPH5PfXdh6aeiLWRpZSpKGSNWhfq0Fl
         kdsMH9OBXqpvCo1DiXaIgO6ZGpfxA6cjLQnaHU+Jd4GblQ5c06R1VbK2SqM18K2atM
         PUynhlqNqAPwQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6B6CD15C04C3; Thu,  8 Jun 2023 12:36:22 -0400 (EDT)
Date:   Thu, 8 Jun 2023 12:36:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <20230608163622.GA1435580@mit.edu>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6K0McWBeCjaf16@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:24:32AM +1000, Dave Chinner wrote:
> On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> > Hm, it makes the API more complex and easier to mess with. Like what will happen
> > if the second part is never called? Or it's called without the first part being
> > called first?
> 
> Bad things.
> 
> Also, it doesn't fix the three other unregister_shrinker() calls in
> the XFS unmount path, nor the three in the ext4/mbcache/jbd2 unmount
> path.
> 
> Those are just some of the unregister_shrinker() calls that have
> dynamic contexts that would also need this same fix; I haven't
> audited the 3 dozen other unregister_shrinker() calls around the
> kernel to determine if any of them need similar treatment, too.
> 
> IOWs, this patchset is purely a band-aid to fix the reported
> regression, not an actual fix for the underlying problems caused by
> moving the shrinker infrastructure to SRCU protection.  This is why
> I really want the SRCU changeover reverted.

There's been so much traffic on linux-fsdevel so I missed this thread
until Darrick pointed it out to me today.  (Thanks, Darrick!)

From his description, and my quick read-through of this thread....
I'm worried.

Given that we're at -rc5 now, and the file system folks didn't get
consulted until fairly late in the progress, and the fact that this
may cause use-after-free problems that could lead to security issues,
perhaps we shoould consider reverting the SRCU changeover now, and try
again for the next merge window?

Thanks!!

						- Ted
