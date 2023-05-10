Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2AC6FD761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjEJGs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjEJGsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 02:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4564486;
        Tue,  9 May 2023 23:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C83063850;
        Wed, 10 May 2023 06:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABB8C4339B;
        Wed, 10 May 2023 06:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683701331;
        bh=QKjgd6OZtwhEvhLfeWWvvsdF4yk6O8j8A4mBRN11HD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk0VpdvsyWLksbyhs4Z1NrZD4LJ5QdonevQNcOvcM08T8L86PE+W/YSP3gsHMx3Ld
         w1J7Nd3oXb/24AuzE7CSRHMqV4Vp/rvChYoxweyGfvz3C28Fj0bBOGnYnwPOjobo1u
         sbpuRlRS/vjD/hdOuVmEHDBuVBJZoEOuucgK9evjOGWdNyu3JfpEGgoSXQe+LgUU2O
         LRrLbSjXFK+KUi6ayXDB2eE8cfZnJPh6h6Id2KALDryzK6frofDa/Wkm1C6elVCaxi
         5YMu3r6iAplHyprHXOpc1ZQQe081HNKMLHEZ9m0NVIfwlvAx9aYQCpfu048N+hbljJ
         LU6+Nyr8QwVeg==
Date:   Tue, 9 May 2023 23:48:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230510064849.GC1851@quark.localdomain>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFq7JhrhyrMTNfd/@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 05:29:10PM -0400, Kent Overstreet wrote:
> On Tue, May 09, 2023 at 02:12:41PM -0700, Lorenzo Stoakes wrote:
> > On Tue, May 09, 2023 at 01:46:09PM -0700, Christoph Hellwig wrote:
> > > On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > > >
> > > > This is needed for bcachefs, which dynamically generates per-btree node
> > > > unpack functions.
> > >
> > > No, we will never add back a way for random code allocating executable
> > > memory in kernel space.
> > 
> > Yeah I think I glossed over this aspect a bit as it looks ostensibly like simply
> > reinstating a helper function because the code is now used in more than one
> > place (at lsf/mm so a little distracted :)
> > 
> > But it being exported is a problem. Perhaps there's another way of acheving the
> > same aim without having to do so?
> 
> None that I see.
> 
> The background is that bcachefs generates a per btree node unpack
> function, based on the packed format for that btree node, for unpacking
> keys within that node. The unpack function is only ~50 bytes, and for
> locality we want it to be located with the btree node's other in-memory
> lookup tables so they can be prefetched all at once.
> 
> Here's the codegen:
> 
> https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/bkey.c#n727

Well, it's a cool trick, but it's not clear that it actually belongs in
production kernel code.  What else in the kernel actually does dynamic codegen?
Just BPF, I think?

Among other issues, this is entirely architecture-specific, and it may cause
interoperability issues with various other features, including security
features.  Is it really safe to leave a W&X page around, for example?

What seems to be missing is any explanation for what we're actually getting from
this extremely unusual solution that cannot be gained any other way.  What is
unique about bcachefs that it really needs something like this?

- Eric
