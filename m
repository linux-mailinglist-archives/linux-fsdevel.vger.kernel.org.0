Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB06C83B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 18:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCXRuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCXRuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:50:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996386AB;
        Fri, 24 Mar 2023 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L97NvfZpT4YYB2rdfhkEMctBAC/jl2cw0YL5PLc13BA=; b=fEbTH4nis2CZPnj27yrwBEsGhj
        VM8eoqNH3bifgYPWDCswe9n/9bMkqmOy5COrPuXPq4Zk9hgfyuzvaoV5lJnxFOVwlirmh3qGokOap
        gI8qA0vHgkAiGdwPhOrHDHwh9Ft4PFmhVXByjsyv1q7xoXroweqTci/Lm4OwbZzTHcoqS5K3eWW40
        8bwrRv9LAuYDumh0kixTbWDUIaipmMMp0XeQd/Z4WDHZTFY/XyWX78aXnrNGuEoN7z1sO9N6G54Zt
        dcJ5LLvgtXkcsnx55jlrdO00uFGTjlS7RVsTI8WPbrlIdYiODx7X1RKXfzx6ehe95i1P1hVejhj+o
        dxXo5IsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pflXA-00577f-BH; Fri, 24 Mar 2023 17:49:00 +0000
Date:   Fri, 24 Mar 2023 17:49:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, ying.huang@intel.com
Subject: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
 <ZB25xqRMgTrQas5W@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB25xqRMgTrQas5W@casper.infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:55:02PM +0000, Matthew Wilcox wrote:
> No, that's not true.  You can allocate kernel memory from ZONE_MOVABLE.
> You have to be careful when you do that, but eg filesystems put symlinks
> and directories in ZONE_MOVABLE, and zswap allocates memory from
> ZONE_MOVABLE.  Of course, then you have to be careful that the kernel
> doesn't try to move it while you're accessing it.  That's the tradeoff.

I want to talk a little bit about what it would take to use MOVABLE
allocations for slab.

Initially, one might presume that it is impossible to have slab use a
movable allocation.  Usually, we need a relatively complex mechanism of
reference counting where one takes a reference on the page, uses it,
then puts the reference.  Then migration can check the page reference
and if it's unused, it knows it's safe to migrate (much handwaving here,
of course it's more complex).

The general case of kmalloc slabs cannot use MOVABLE allocations.
The API has no concept of "this pointer is temporarily not in use",
so we can never migrate any slab which has allocated objects.

But for slab caches, individual objects may have access rules which allow
them to be moved.  For example, we might be able to migrate every dentry
in a slab, then RCU-free the slab.  Similarly for radix_tree_nodes.

There was some work along these lines a few years ago:
https://lore.kernel.org/all/20190603042637.2018-16-tobin@kernel.org/

There are various practical problems with that patchset, but they can
be overcome with sufficient work.  The question is: Why do we need to do
this work?  What is the high-level motivation to make slab caches movable?
