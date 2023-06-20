Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE8373609A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFTAkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTAj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:39:59 -0400
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FEE7C
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 17:39:57 -0700 (PDT)
Date:   Mon, 19 Jun 2023 20:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687221595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Zfq6ittE0IV5j42l7ltYn23CXJNIzl2rvAKGvH0VyM=;
        b=KzSvOqKfcMmVN0w3Me9IkrmC6QouMRyyeBRH9zO6fPglTbdqGSKPREw3qxo0JuMprczB+a
        gBh1CcjSxjKA3BjoaGZbjBi7W8Crd4fevq+XE9cwgXwlSom7mcz3T+IDoDO/tyZEexRtCl
        jpWFuxuqDHgVBnAVdPv5to1A6xKl/Zs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
Message-ID: <20230620003949.kjs2z524hodwwcnt@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
 <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
 <202306191228.6A98FD25@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306191228.6A98FD25@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:45:43PM -0700, Kees Cook wrote:
> I think there's a misunderstanding here about the threat model I'm
> interested in protecting against for JITs. While making sure the VM of a
> JIT is safe in itself, that's separate from what I'm concerned about.
> 
> The threat model is about flaws _elsewhere_ in the kernel that can
> leverage the JIT machinery to convert a "write anything anywhere anytime"
> exploit primitive into an "execute anything" primitive. Arguments can
> be made to say "a write anything flaw means the total collapse of the
> security model so there's no point defending against it", but both that
> type of flaw and the slippery slope argument don't stand up well to
> real-world situations.

Hey Kees, thanks for the explanation - I don't think this is a concern
for what bcachefs is doing, since we're not doing a full jit. The unpack
functions we generate only write to the 40 bytes pointed to by rsi; not
terribly useful as an execute anything primitive :)
