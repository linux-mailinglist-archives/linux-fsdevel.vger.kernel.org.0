Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D321F5543
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgFJM7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 08:59:24 -0400
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:34965 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728965AbgFJM7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:59:23 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 557231945
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 13:59:22 +0100 (IST)
Received: (qmail 31682 invoked from network); 10 Jun 2020 12:59:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Jun 2020 12:59:22 -0000
Date:   Wed, 10 Jun 2020 13:59:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200610125920.GM3127@techsingularity.net>
References: <20200608140557.GG3127@techsingularity.net>
 <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net>
 <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
 <20200608180130.GJ3127@techsingularity.net>
 <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
 <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:39:26PM +0300, Amir Goldstein wrote:
> > Let me add your optimizations on top of my branch with the needed
> > adaptations and send you a branch for testing.
> 
> https://github.com/amir73il/linux/commits/fsnotify_name-for-mel
> 

Sorry for the delay getting back. The machine was busy with other tests
and it took a while to reach this on the queue. Fairly good news

hackbench-process-pipes
                              5.7.0                  5.7.0                  5.7.0                  5.7.0
                            vanilla      fastfsnotify-v1r1          amir-20200608           amir-for-mel
Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*      0.4967 *  -2.69%*      0.4680 (   3.24%)
Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)      1.6587 *  -7.38%*      1.4807 (   4.14%)
Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)      2.6400 (  -1.40%)      2.4900 (   4.37%)
Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)      3.9040 *  -8.48%*      3.5130 (   2.38%)
Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)      6.2593 (  -7.43%)      5.6967 (   2.23%)
Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)      8.9940 (  -6.56%)      7.7240 *   8.48%*
Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*     11.7247 *  -6.41%*      9.5793 *  13.06%*
Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)     14.0290 *  -7.08%*     12.1630 (   7.16%)
Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)     14.7140 *  -5.71%*     13.2457 *   4.84%*

First two sets of results are vanilla kernel and just my patch respectively
to have two baselines. amir-20200608 is the first git branch you pointed
me to and amir-for-mel is this latest branch. Comparing the optimisation
and your series, we get

hackbench-process-pipes
                              5.7.0                  5.7.0
                  fastfsnotify-v1r1           amir-for-mel
Amean     1       0.4630 (   0.00%)      0.4680 (  -1.08%)
Amean     3       1.4557 (   0.00%)      1.4807 (  -1.72%)
Amean     5       2.4363 (   0.00%)      2.4900 (  -2.20%)
Amean     7       3.4757 (   0.00%)      3.5130 (  -1.07%)
Amean     12      5.6983 (   0.00%)      5.6967 (   0.03%)
Amean     18      8.1327 (   0.00%)      7.7240 (   5.03%)
Amean     24     10.0290 (   0.00%)      9.5793 (   4.48%)
Amean     30     12.8510 (   0.00%)     12.1630 (   5.35%)
Amean     32     13.2410 (   0.00%)     13.2457 (  -0.04%)

As you can see, your patches with the optimisation layered on top is
comparable to just the optimisation on its own. It's not universally
better but it would not look like a regression when comparing releases.
The differences are mostly within the noise as there is some variability
involved for this workload so I would not worry too much about it (caveats
are other machines may be different as well as other workloads). A minor
issue is that this is probably a bisection hazard. If a series is merged
and LKP points the finger somewhere in the middle of your series then
I suggest you ask them to test the optimisation commit ID to see if the
regression goes away.

Thanks Amir.

-- 
Mel Gorman
SUSE Labs
