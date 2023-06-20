Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97050737487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 20:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjFTSs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjFTSsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:48:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E11710;
        Tue, 20 Jun 2023 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687286921; x=1718822921;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cIjOp3qxDgmIfUXuVTvaRq9H0mpWEZcDYyV4VtVHbgs=;
  b=c68AKpRfMkgDRji7BAvfQgJHJFfJKZsbLstujxRqbgjTo3jAAe4Q+wGN
   hfLXmLjRlOZ/2uvSmu26XfZP9etzv2/Cbi4uYKv9NsGMU41P2KWWphWiP
   hmcqeqv4tI7nJ4Fmef81oe2OJUnIFmqs5omESPOczZa3o1cZxKBpsr/bY
   eqXrW1U2IlvtJ4Hz1Kfp+SzNC1fl9SaSGgS4oRdEi7239BXPZ+MNVy3Y2
   j7BYlfSFHLNuQ2kFrrG+uEeOqAoE/JklFu/E+O3rVZfDwR3Ci2U1uB97P
   9fGhzDP9lWpHbBGrhDqoJxPAiDPjU02VkN16mfwktcrrRfGdv5dQbiNCh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358826313"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="358826313"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743878869"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="743878869"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO [10.255.228.28]) ([10.255.228.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:48:34 -0700
Message-ID: <37d2378e-72de-e474-5e25-656b691384ba@intel.com>
Date:   Tue, 20 Jun 2023 11:48:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
 <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
 <20230620180839.oodfav5cz234pph7@moria.home.lan>
 <dcf8648b-c367-47a5-a2b6-94fb07a68904@app.fastmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <dcf8648b-c367-47a5-a2b6-94fb07a68904@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> No, I'm saying your concerns are baseless and too vague to
>> address.
> If you don't address them, the NAK will stand forever, or at least
> until a different group of people take over x86 maintainership.
> That's fine with me.

I've got a specific concern: I don't see vmalloc_exec() used in this
series anywhere.  I also don't see any of the actual assembly that's
being generated, or the glue code that's calling into the generated
assembly.

I grepped around a bit in your git trees, but I also couldn't find it in
there.  Any chance you could help a guy out and point us to some of the
specifics of this new, tiny JIT?

>> Andy, I replied explaining the difference between text_poke() and
>> text_poke_sync(). It's clear you have no idea what you're talking about,
>> so I'm not going to be wasting my time on further communications with
>> you.

One more specific concern: This comment made me very uncomfortable and
it read to me very much like a personal attack, something which is
contrary to our code of conduct.
