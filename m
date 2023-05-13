Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C143701983
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEMT22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 May 2023 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjEMT2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 May 2023 15:28:25 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF110DD
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 12:28:24 -0700 (PDT)
Date:   Sat, 13 May 2023 15:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684006102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ3u1CrwwU+GfMaup+iHwAK48qBfxEDVoofnNqrsG9Q=;
        b=ic7SAyuoFp7zwWIDHRTVlp796UJt9qNLi/31Bt8w/eCvrxJAb8ItdBTWHvxvgXQZJkAdl+
        FdMITYl/2Ym4nlasoNe8vjuG6KbqiFsHqo5dDLibdpNfqcrjAT+w8d+fZfRUflQOypYJJ8
        V2GD34J/75ugp2k6hJHTyqYEl5dsKQQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZF/k0Xo76q60uk0M@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513015752.GC3033@quark.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 06:57:52PM -0700, Eric Biggers wrote:
> What I would suggest instead is preprocessing the list of 6 field lengths to
> create some information that can be used to extract all 6 fields branchlessly
> with no dependencies between different fields.  (And you clearly *can* add a
> preprocessing step, as you already have one -- the dynamic code generator.)
> 
> So, something like the following:
> 
>     const struct field_info *info = &format->fields[0];
> 
>     field0 = (in->u64s[info->word_idx] >> info->shift1) & info->mask;
>     field0 |= in->u64s[info->word_idx - 1] >> info->shift2;
> 
> ... but with the code for all 6 fields interleaved.
> 
> On modern CPUs, I think that would be faster than your current C code.
> 
> You could do better by creating variants that are specialized for specific
> common sets of parameters.  During "preprocessing", you would select a variant
> and set an enum accordingly.  During decoding, you would switch on that enum and
> call the appropriate variant.  (This could also be done with a function pointer,
> of course, but indirect calls are slow these days...)
> 
> For example, you mentioned that 8-byte packed keys is a common case.  In that
> case there is only a single u64 to decode from, so you could create a function
> that just handles that case:
> 
>     field0 = (word >> info->shift) & info->mask;
> 
> You could also create other variants, e.g.:
> 
> - 16-byte packed keys (which you mentioned are common)
> - Some specific set of fields have zero width so don't need to be extracted
>   (which it sounds like is common, or is it different fields each time?)
> - All fields having specific lengths (are there any particularly common cases?)
> 
> Have you considered any of these ideas?

I like that idea.

Gonna hack some code... :)
