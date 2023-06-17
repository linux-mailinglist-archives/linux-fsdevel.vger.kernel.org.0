Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628F733DEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFQEN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 00:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481430F1;
        Fri, 16 Jun 2023 21:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E694961701;
        Sat, 17 Jun 2023 04:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D6BC433C8;
        Sat, 17 Jun 2023 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686975204;
        bh=O9IhQbkEdVOj/uSoDsWPMJ4oir6I9roRy38/BIcjOhk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=prsSj/MitUcMcJEJJGh9ljH+bbdtrtfA0qq/Vjlz64iphGyMBl/DCSSL5cPlqQSoG
         QFnIyOmE3Nq+O4LtrfXQ6VUkCKfb27Apf74fQF5VwhK5fujZgfD0WTOCZpfWzvNSx9
         hi+TV46ghkkdluXRLPaqiUTwgnHGDVxfqzTFPLny8o6QuB6XgRjdzFNTfNY6yUfDrE
         m2m1wQJ28r/MX9OEDeA096JgwvSYS3df7ZMmtK5XsPy2nHem5s8XfuDU8kTkK+tjLg
         UIAX881i63f/5ULrhFImQlIKzSY3Gr0SXMJA238X687eDSBzWYVPkU4MQJfo+DWb4H
         9ShASJVpIMuww==
Message-ID: <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
Date:   Fri, 16 Jun 2023 21:13:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kees Cook <keescook@chromium.org>
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
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook> <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook> <ZGPzocRpSlg+4vgN@moria.home.lan>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <ZGPzocRpSlg+4vgN@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/23 14:20, Kent Overstreet wrote:
> On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
>> For something that small, why not use the text_poke API?
> 
> This looks like it's meant for patching existing kernel text, which
> isn't what I want - I'm generating new functions on the fly, one per
> btree node.

Dynamically generating code is a giant can of worms.

Kees touched on a basic security thing: a linear address mapped W+X is a big
no-no.  And that's just scratching the surface -- ideally we would have a
strong protocol for generating code: the code is generated in some
extra-secure context, then it's made immutable and double-checked, then
it becomes live.  (And we would offer this to userspace, some day.)
Just having a different address for the W and X aliases is pretty weak.

(When x86 modifies itself at boot or for static keys, it changes out the
page tables temporarily.)

And even beyond security, we have correctness.  x86 is a fairly 
forgiving architecture.  If you go back in time about 20 years, modify
some code *at the same linear address at which you intend to execute 
it*, and jump to it, it works.  It may even work if you do it through
an alias (the manual is vague).  But it's not 20 years ago, and you have
multiple cores.  This does *not* work with multiple CPUs -- you need to 
serialize on the CPU executing the modified code.  On all the but the 
very newest CPUs, you need to kludge up the serialization, and that's
sloooooooooooooow.  Very new CPUs have the SERIALIZE instruction, which
is merely sloooooow.

(The manual is terrible.  It's clear that a way to do this without 
serializing must exist, because that's what happens when code is paged 
in from a user program.)

And remember that x86 is the forgiving architecture.  Other 
architectures have their own rules that may involve all kinds of 
terrifying cache management.  IIRC ARM (32-bit) is really quite nasty in 
this regard.  I've seen some references suggesting that RISC-V has a 
broken design of its cache management and this is a real mess.

x86 low level stuff on Linux gets away with it because the 
implementation is conservative and very slow, but it's very rarely invoked.

eBPF gets away with it in ways that probably no one really likes, but 
also no one expects eBPF to load programs particularly quickly.

You are proposing doing this when a btree node is loaded.  You could 
spend 20 *thousand* cycles, on *each CPU*, the first time you access 
that node, not to mention the extra branch to decide whether you need to 
spend those 20k cycles.  Or you could use IPIs.

Or you could just not do this.  I think you should just remove all this 
dynamic codegen stuff, at least for now.

> 
> I'm working up a new allocator - a (very simple) slab allocator where
> you pass a buffer, and it gives you a copy of that buffer mapped
> executable, but not writeable.
> 
> It looks like we'll be able to convert bpf, kprobes, and ftrace
> trampolines to it; it'll consolidate a fair amount of code (particularly
> in bpf), and they won't have to burn a full page per allocation anymore.
> 
> bpf has a neat trick where it maps the same page in two different
> locations, one is the executable location and the other is the writeable
> location - I'm stealing that.
> 
> external api will be:
> 
> void *jit_alloc(void *buf, size_t len, gfp_t gfp);
> void jit_free(void *buf);
> void jit_update(void *buf, void *new_code, size_t len); /* update an existing allocation */

Based on the above, I regret to inform you that jit_update() will either 
need to sync all cores via IPI or all cores will need to check whether a 
sync is needed and do it themselves.

That IPI could be, I dunno, 500k cycles?  1M cycles?  Depends on what 
cores are asleep at the time.  (I have some old Sandy Bridge machines 
where, if you tick all the boxes wrong, you might spend tens of 
milliseconds doing this due to power savings gone wrong.)  Or are you 
planning to implement a fancy mostly-lockless thing to track which cores 
actually need the IPI so you can avoid waking up sleeping cores?

Sorry to be a party pooper.

--Andy

P.S. I have given some thought to how to make a JIT API that was 
actually (somewhat) performant.  It's nontrivial, and it would involve 
having at least phone calls and possibly actual meetings with people who 
understand the microarchitecture of various CPUs to get all the details 
hammered out and documented properly.

I don't think it would be efficient for teeny little functions like 
bcachefs wants, but maybe?  That would be even more complex and messy.
