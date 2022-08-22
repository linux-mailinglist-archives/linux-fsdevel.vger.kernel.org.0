Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF84459CA87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiHVVIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiHVVIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F32F038;
        Mon, 22 Aug 2022 14:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED65261315;
        Mon, 22 Aug 2022 21:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D3EC433C1;
        Mon, 22 Aug 2022 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661202525;
        bh=nKbiyNWYpVKB+Hwt2mf/xNvxcNjbAbIus/sQjP8jnW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LBb/wjffwju7RJR12v2axipRiMOItkI7iMW6Uh4KYfDKSVtlaTO5RzkJxt24N0eDZ
         15xjNUw5vEr1u+oswKkWyMfGX6T+VoA7QsdV4KNVpN36Trr3LNf89PEOuCsP0OpmL5
         lPvd03vcEP0kHIiIVj0eTqjUIVsdxspxaOM80dEE=
Date:   Mon, 22 Aug 2022 14:08:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xu xin <cgel.zte@gmail.com>
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] ksm: count allocated ksm rmap_items for each process
Message-Id: <20220822140844.26cfb85dead5e0e5c4de4737@linux-foundation.org>
In-Reply-To: <20220822053653.204150-1-xu.xin16@zte.com.cn>
References: <20220822053653.204150-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Aug 2022 05:36:53 +0000 xu xin <cgel.zte@gmail.com> wrote:

> KSM can save memory by merging identical pages, but also can consume
> additional memory, because it needs to generate rmap_items to save
> each scanned page's brief rmap information. Some of these pages may
> be merged, but some may not be abled to be merged after being checked
> several times, which are unprofitable memory consumed.
> 
> The information about whether KSM save memory or consume memory in
> system-wide range can be determined by the comprehensive calculation
> of pages_sharing, pages_shared, pages_unshared and pages_volatile.
> A simple approximate calculation:
> 
> 	profit ≈ pages_sharing * sizeof(page) - (all_rmap_items) *
> 	         sizeof(rmap_item);
> 
> where all_rmap_items equals to the sum of pages_sharing, pages_shared,
> pages_unshared and pages_volatile.
> 
> But we cannot calculate this kind of ksm profit inner single-process wide
> because the information of ksm rmap_item's number of a process is lacked.
> For user applications, if this kind of information could be obtained,
> it helps upper users know how beneficial the ksm-policy (like madvise)
> they are using brings, and then optimize their app code. For example,
> one application madvise 1000 pages as MERGEABLE, while only a few pages
> are really merged, then it's not cost-efficient.
> 
> So we add a new interface /proc/<pid>/ksm_alloced_items for each
> process to indicate the total allocated ksm rmap_items of this process.

Please add documentation for this profcs item in the appropriate place
under Documentation/.  And please ensure that the documentation
provides readers with a decent amount of information about how to use
this information to improve their system's operation.

