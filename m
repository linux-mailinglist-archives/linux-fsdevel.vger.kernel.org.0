Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196087353B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjFSKsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFSKsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:48:03 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23F19BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 03:47:25 -0700 (PDT)
Date:   Mon, 19 Jun 2023 06:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687171643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZKRBkZ0ttaMYNfcQAMNVdRDLq4DTvfw19IqRp9/498=;
        b=hhTLFaPHGLhjUPVUucumvTtPkGXXnl+DXMHskhBeT6Eb/n5enTSphDDjDJR4mvDm1HHFZn
        be5snaxlFRuFg47l9QnUy2rKCbMINg9UNFuPEq1XFrcgkPnAXPHNqXOcCawsFMe2NKNFPB
        Damiynm2hii9W4qhCoSnFdjRqUs/FV8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230619104717.3jvy77y3quou46u3@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 10:19:00AM +0100, Mark Rutland wrote:
> On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This is needed for bcachefs, which dynamically generates per-btree node
> > unpack functions.
> 
> Much like Kees and Andy, I have concerns with adding new code generators to the
> kernel. Even ignoring the actual code generation, there are a bunch of subtle
> ordering/maintenance/synchronization concerns across architectures, and we
> already have a fair amount of pain with the existing cases.

Look, jits are just not that unusual. I'm not going to be responding to
vague concerns that don't have any actual engineering rational.

> Can you share more detail on how you want to use this?
> 
> From a quick scan of your gitweb for the bcachefs-for-upstream branch I
> couldn't spot the relevant patches.

I've already written extensively in this thread.
