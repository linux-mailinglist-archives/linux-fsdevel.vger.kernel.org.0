Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1524CFCF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiCGLdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiCGLcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:32:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7961C104;
        Mon,  7 Mar 2022 03:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A2C60F9D;
        Mon,  7 Mar 2022 11:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232DCC340E9;
        Mon,  7 Mar 2022 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646652494;
        bh=CoioyM0zIXElo8AmL5lOe9QJ9NofNT4LxKFCkZhNubU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKA3As2Yp0LuIulW1zXgVDONqGP5hbS9VFG+vVYQod0UmHUi6UPA8Y8VxsEutOIxK
         RdqcQTK2KdDpqkLso/Ze/vknDLOudeZqMzI4IyWs1I1RKkLK9P4P8w6EaAO5sjx6G4
         Y9jdSiMw8DWfTtAdMHy3mhqsUDbwHqjgPm4WPBVE5pmFou86QdYv7Icu79rkyLMlr3
         y1FObIg9d+jqzRRs3JF8h6WBEky7RdBwEqh/+KVxkT2O6t/pnHpmZTmzwMpPCJ5g6Y
         eSn+tbxZFwThOFwyhU36MfvqJjhZ/XfObC59oeVuDQX1k2u5PfI3xt16lzDpGvD12s
         qH+rdZcT7wO/w==
Date:   Mon, 7 Mar 2022 13:27:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, jaharkes@cs.cmu.edu,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@telemann.coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2] mm: Add f_ops->populate()
Message-ID: <YiXsJRE8CWOvFNWH@iki.fi>
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
 <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 03:41:54PM -0800, Dave Hansen wrote:
> On 3/6/22 15:24, Andrew Morton wrote:
> > On Sun,  6 Mar 2022 05:26:55 +0200 Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> >> Sometimes you might want to use MAP_POPULATE to ask a device driver to
> >> initialize the device memory in some specific manner. SGX driver can use
> >> this to request more memory by issuing ENCLS[EAUG] x86 opcode for each
> >> page in the address range.
> > Why is this useful?  Please fully describe the benefit to kernel users.
> > Convince us that the benefit justifies the code churn, maintenance
> > cost and larger kernel footprint.
> 
> In short: page faults stink.  The core kernel has lots of ways of
> avoiding page faults like madvise(MADV_WILLNEED) or mmap(MAP_POPULATE).
>  But, those only work on normal RAM that the core mm manages.
> 
> SGX is weird.  SGX memory is managed outside the core mm.  It doesn't
> have a 'struct page' and get_user_pages() doesn't work on it.  Its VMAs
> are marked with VM_IO.  So, none of the existing methods for avoiding
> page faults work on SGX memory.
> 
> This essentially helps extend existing "normal RAM" kernel ABIs to work
> for avoiding faults for SGX too.  SGX users want to enjoy all of the
> benefits of a delayed allocation policy (better resource use,
> overcommit, NUMA affinity) but without the cost of millions of faults.
> 
> That said, this isn't how I would have implemented it.  I probably would
> have hooked in to populate_vma_page_range() or its callers.

The exact implementation path is not driver in this. I'm open for
better options. The point of these patches is more to show an issue
rather than solution, and they do carry RFC because of that.

Hooking into populate_vma_page_range() does sound like a better idea,
because then it would be nicely embedded into __mm_populate() and
other functionality that calls that function.

But e.g. in __mm_populate() anything with (VM_IO | VM_PFNMAP) gets
filtered out and never reach that function.

I don't know unorthodox that'd be but could we perhaps have a VM
flag for SGX?

BR, Jarkko
