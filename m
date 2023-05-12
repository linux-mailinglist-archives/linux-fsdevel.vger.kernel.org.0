Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B22700EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbjELSl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbjELSl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:41:57 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [IPv6:2001:41d0:203:375::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C8213E
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:41:54 -0700 (PDT)
Date:   Fri, 12 May 2023 14:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683916913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOnY8c/lkag14SwpbgN3+7P0+KsfhnCfHTsBvfxLgio=;
        b=cIHho+FfHJMWMTsZ/N4RXcZep7VCfnvUNYdJrQllaDrmrotT2SUDGE/aHck2l6nZoZ0CbH
        0Fkfdpcl1H8lNKNlg0uD5E1JTq7pzKxPky5aDLIUmKvPKEBSSRmvPWhrdW3Rg9i6PrJYJP
        T/Rx9juakd3xD/niy4bTd9Uj/lcX2I0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZF6Ibvi8U9B+mV1d@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305111525.67001E5C4@keescook>
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

On Thu, May 11, 2023 at 03:28:40PM -0700, Kees Cook wrote:
> On Wed, May 10, 2023 at 03:05:48PM +0000, Johannes Thumshirn wrote:
> > On 09.05.23 18:56, Kent Overstreet wrote:
> > > +/**
> > > + * vmalloc_exec - allocate virtually contiguous, executable memory
> > > + * @size:	  allocation size
> > > + *
> > > + * Kernel-internal function to allocate enough pages to cover @size
> > > + * the page level allocator and map them into contiguous and
> > > + * executable kernel virtual space.
> > > + *
> > > + * For tight control over page level allocator and protection flags
> > > + * use __vmalloc() instead.
> > > + *
> > > + * Return: pointer to the allocated memory or %NULL on error
> > > + */
> > > +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> > > +{
> > > +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > > +			gfp_mask, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> > > +			NUMA_NO_NODE, __builtin_return_address(0));
> > > +}
> > > +EXPORT_SYMBOL_GPL(vmalloc_exec);
> > 
> > Uh W+X memory reagions.
> > The 90s called, they want their shellcode back.
> 
> Just to clarify: the kernel must never create W+X memory regions. So,
> no, do not reintroduce vmalloc_exec().
> 
> Dynamic code areas need to be constructed in a non-executable memory,
> then switched to read-only and verified to still be what was expected,
> and only then made executable.

So if we're opening this up to the topic if what an acceptible API would
look like - how hard is this requirement?

The reason is that the functions we're constructing are only ~50 bytes,
so we don't want to be burning a full page per function (particularly
for the 64kb page architectures...)

If we were to build an allocator for sub-page dynamically constructed
code, we'd have to flip the whole page to W+X while copying in the new
function. But, we could construct it in non executable memory and then
hand it off to this new allocator to do the copy, which would also do
the page permission flipping.

It seem like this is something BPF might want eventually too, depending
on average BPF program size...
