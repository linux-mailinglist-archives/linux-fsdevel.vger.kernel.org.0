Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F04D0335
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiCGPpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiCGPpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:45:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2B7EA1D;
        Mon,  7 Mar 2022 07:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6592614B5;
        Mon,  7 Mar 2022 15:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0485DC340E9;
        Mon,  7 Mar 2022 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646667898;
        bh=U0RuGnkHGZSN7rcOCs7fzKl6Y7/Lp0fhUWcoOUZcq5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ij3eAcL4q9iwJKBYHI831XyC2X3aweJTDGKv6pq1qYjqFEHhsWcwvpfB4x74p7jeI
         jFVHLTLY/v/fHZGjI13dQeb/stTFMTUwwewrvRGShRnmRMpzfD4CzTq8UH75DJsGDx
         r0WKa4OnhjgUMOWB7xEGpUJBcf8WpA6K0sJJ9iRggWFEXACaqjHBng5aBZAJw4w+KM
         Ar3x3Ce8iUywGtRo6BWM6TWzj4MetT1f1Ul5K0nGGW0FPta87KPXS8vPUoHbgrrlsy
         Iq/eaXjutkywtcI/65tVlISD1sXTttoZX4PxUOO0P8p65u7DT9fjliaLz36kMGk1pb
         203t6MtlONLhA==
Date:   Mon, 7 Mar 2022 17:44:17 +0200
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
Message-ID: <YiYoUfYuTDsld6L0@iki.fi>
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
 <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com>
 <YiXsJRE8CWOvFNWH@iki.fi>
 <3c974f25-ece6-102b-01c3-bd7e6274f613@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c974f25-ece6-102b-01c3-bd7e6274f613@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:29:22AM -0800, Dave Hansen wrote:
> On 3/7/22 03:27, Jarkko Sakkinen wrote:
> > But e.g. in __mm_populate() anything with (VM_IO | VM_PFNMAP) gets
> > filtered out and never reach that function.
> > 
> > I don't know unorthodox that'd be but could we perhaps have a VM
> > flag for SGX?
> 
> SGX only works on a subset of the chips from one vendor on one
> architecture.  That doesn't seem worth burning a VM flag.

What do you think of Matthew's idea of using ra_state for prediction?

BR, Jarkko
