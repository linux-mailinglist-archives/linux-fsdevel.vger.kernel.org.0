Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C156BDBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiGHPVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiGHPVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:21:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37D1ADA3;
        Fri,  8 Jul 2022 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2qYi6QRAXIoC5/GJOd8/GV/65rQmXuZYuqFcmMvOenA=; b=tDqThvukfm6Rl5xaMglGGZGrf1
        MiBVvWRZyhOOG1UkM2V3/fcFJhNBTIj9vf2VxfKOonHWkgcvn2236UOsja3d9CFiR+8Ab7bvTFJMi
        D4ndHEUZJMfJVdOIkVZpC38Yi+5VL9t0m9NdBkV8ToKZywmYeV56R2dW7tp4cJAawwEzw5zI8dG6e
        /8+oD7Pb4b3LCi0LZn+7YJgF8Cph+r1gWE7lq6EHH/MP5YAMMfoas6FGGrd/TuZdtFAp/Vzmc8TKn
        rTwQa77sxBCuee+HfbI1mk5Rv+tYb92XbSpI4lSkiDY5hOfSRfEPTXyC4+9Hb0XI1TqMK7YMy5sAa
        oMKIcETQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9pmy-003b17-Ag; Fri, 08 Jul 2022 15:21:04 +0000
Date:   Fri, 8 Jul 2022 16:21:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <YshLYPTxyOosmSKt@casper.infradead.org>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
 <20220705232159.2218958-2-ira.weiny@intel.com>
 <YshE/pwSUBPAeybU@casper.infradead.org>
 <YshGSgHiAiu9QwiZ@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YshGSgHiAiu9QwiZ@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 07:59:22AM -0700, Ira Weiny wrote:
> On Fri, Jul 08, 2022 at 03:53:50PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> > > The main issue I see with this is defining devm_xa_init() in device.h.
> > > This makes sense because a device is required to use the call.  However,
> > > I'm worried about if users will find the call there vs including it in
> > > xarray.h?
> > 
> > Honestly, I don't want users to find it.  This only makes sense if you're
> > already bought in to the devm cult.  I worry people will think that
> > they don't need to do anything else; that everything will be magically
> > freed for them, and we'll leak the objects pointed to from the xarray.
> > I don't even like having xa_destroy() in the API, because of exactly this.
> > 
> 
> Fair enough.  Are you ok with the concept though?

I'd rather have it in one place than open-coded in two.
