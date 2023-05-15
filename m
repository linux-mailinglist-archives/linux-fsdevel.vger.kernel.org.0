Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4429E70243B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 08:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjEOGNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjEOGNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 02:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8CE1;
        Sun, 14 May 2023 23:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5C361F38;
        Mon, 15 May 2023 06:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F42C433EF;
        Mon, 15 May 2023 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684131228;
        bh=Y45E+N01pMi2CMlWB0B+OganKrfzdE6yeEf0dWAO4yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3Y89wxdF1A1pzNHqxrT7L4mihy9RdQllcqFtvj2Ja+ux0lx5o9lynlUAuoHXNvA3
         wx9hwEOsJFlXM3ec3IRUpAat/xUwFv8w7TJPO2FPZI0xYfXnIwG2mjgpArZIx+Cf4u
         sZ3ZuILtK0r7DXqsvUsNH2lSLDipgk5anqaV/yljSxXaVSySMpLeL+BQC44hBnoqmD
         pcH/qj625BS6iurlQoDR/YMyW5D+3qi9RpSjSBs3R/Xw6jh7zN3PDw5h6zzwhz8b4p
         VEQ1t7MDdFQT8RxLIOHY2kRuoOX9DfhQjxUnT9yxY74Ovoc9/tWJC0BCHf1vKDW3Ts
         2/xioqiq8OsAg==
Date:   Sun, 14 May 2023 23:13:46 -0700
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
Message-ID: <20230515061346.GB15871@sol.localdomain>
References: <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGHFa4AprPSsEpeq@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 01:38:51AM -0400, Kent Overstreet wrote:
> On Sun, May 14, 2023 at 11:43:25AM -0700, Eric Biggers wrote:
> > I think it would also help if the generated assembly had the handling of the
> > fields interleaved.  To achieve that, it might be necessary to interleave the C
> > code.
> 
> No, that has negligable effect on performance - as expected, for an out
> of order processor. < 1% improvement.
> 
> It doesn't look like this approach is going to work here. Sadly.

I'd be glad to take a look at the code you actually tried.  It would be helpful
if you actually provided it, instead of just this "I tried it, I'm giving up
now" sort of thing.

I was also hoping you'd take the time to split this out into a userspace
micro-benchmark program that we could quickly try different approaches on.

BTW, even if people are okay with dynamic code generation (which seems
unlikely?), you'll still need a C version for architectures that you haven't
implemented the dynamic code generation for.

- Eric
