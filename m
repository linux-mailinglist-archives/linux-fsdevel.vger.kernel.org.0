Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4539617CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 13:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKCMkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCMkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:40:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C210BE;
        Thu,  3 Nov 2022 05:40:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F40E868AA6; Thu,  3 Nov 2022 13:40:30 +0100 (CET)
Date:   Thu, 3 Nov 2022 13:40:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for
 compressed reads)
Message-ID: <20221103124030.GA29839@lst.de>
References: <20220915094200.139713-1-hch@lst.de> <20220915094200.139713-4-hch@lst.de> <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:46:52AM +0100, Thorsten Leemhuis wrote:
> It seems this patch makes systemd-oomd overreact on my day-to-day
> machine and aggressively kill applications. I'm not the only one that
> noticed such a behavior with 6.1 pre-releases:
> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
> https://bugzilla.redhat.com/show_bug.cgi?id=2134971
> 
> I think I have a pretty reliable way to trigger the issue that involves
> starting the apps that I normally use and a VM that I occasionally use,
> which up to now never resulted in such a behaviour.
> 
> On master as of today (8e5423e991e8) I can trigger the problem within a
> minute or two. But I fail to trigger it with v6.0.6 or when I revert
> 4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads").
> And yes, I use btrfs with compression for / and /home/.

So, I did in fact not want to include this patch because it is a little
iffy and includes PSI accounting for reads where btrfs just does
aggresive readaround for compression, but Johannes asked for it to be
added.  I'd be perfectly fine with just reverting it.
