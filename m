Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7AF6A431B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjB0Nmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjB0Nms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:42:48 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819510401;
        Mon, 27 Feb 2023 05:42:47 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.2.39.140])
        by gnuweeb.org (Postfix) with ESMTPSA id A06DC831EE;
        Mon, 27 Feb 2023 13:42:43 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677505366;
        bh=sPMDNczqziOn29+Dhl16L3xNY5YIHG7rWMEp6/Gq5uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuXtL1GppH1wQW8Q9hth0QwTBc8n5vLNgDjnfqM322/I9Vvl1VVn/XHxMdG6dlef5
         6QYC0/T1kAya1lzJsDd/0wcZExODJgc1DTW7E9islsADWEL+6jX1AqjeLddLEq00TT
         kcthdylzgNMJyIywzUOPFJ1S7brs93pGp1K3rhaBwvGJRO0SAUC9iHrAB1GhlUOAPZ
         y0oGkcrDtKl4K6sd7wZgHrsVwT5rMP3AQs1pbddQ5EC75Y1H/1Twj2JtwDE+yFnj8t
         Z5OJ3r7v+uRVKmggYDlrDpM2GgM11yK9qW71gzmlNNfnb8bEBbtG9oACJLW1nLBkIo
         bGH91GxKPXZtQ==
Date:   Mon, 27 Feb 2023 20:42:35 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/yzS7aQ6PDyFsbm@biznet-home.integral.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <19732428-010d-582c-0aed-9dd09b11d403@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19732428-010d-582c-0aed-9dd09b11d403@gmx.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:18:43PM +0800, Qu Wenruo wrote: 
> I'm not sure if pinning the wq is really the best way to your problem.
> 
> Yes, I understand you want to limit the CPU usage of btrfs workqueues, but
> have you tried "thread_pool=" mount option?
> 
> That mount option should limit the max amount of in-flight work items, thus
> at least limit the CPU usage.

I have tried to use the thread_poll=%u mount option previously. But I
didn't observe the effect intensively. I'll try to play with this option
more and see if it can yield the desired behavior.

> For the wq CPU pinning part, I'm not sure if it's really needed, although
> it's known CPU pinning can affect some performance characteristics.

What I like about CPU pinning is that we can dedicate CPUs for specific
workloads so it won't cause scheduling noise to the app we've dedicated
other CPUs for.

-- 
Ammar Faizi

