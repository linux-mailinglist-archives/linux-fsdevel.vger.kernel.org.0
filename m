Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA870231F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 07:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjEOFCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 01:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEOFCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 01:02:53 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C04133
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 22:02:51 -0700 (PDT)
Date:   Mon, 15 May 2023 01:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684126969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2mGEUvyHwZiGTrF0TDmaBKI7TfcH+VD1Blkzm5ytFk=;
        b=QJAzPvdoQUkeyTUk6S2C+QWy4jL4zcmYveWG3SSgImiqUUCC42tKyxxcO2zjN7BKZll567
        0ccXmBJd5mbCp9XkvCh9Jw/aMSC5/HQXIWaA8wvZfGp6/o4zsDQVFiMoWCF2m/8nSah/lp
        /VcUxVy7M0z3GWs4tmlJsv/ywE8JtAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGG89NGRKdWJo8gn@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
 <ce5125be-464e-44ad-8d9e-7c818f794db1@csgroup.eu>
 <ZGFyHY6pH9CU4fzf@moria.home.lan>
 <6f049870-1684-1875-3cdc-73e1323ffdb0@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f049870-1684-1875-3cdc-73e1323ffdb0@csgroup.eu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 04:45:42AM +0000, Christophe Leroy wrote:
> 
> 
> Le 15/05/2023 à 01:43, Kent Overstreet a écrit :
> > On Sun, May 14, 2023 at 06:39:00PM +0000, Christophe Leroy wrote:
> >> I addition to that, I still don't understand why you bring back
> >> vmalloc_exec() instead of using module_alloc().
> >>
> >> As reminded in a previous response, some architectures like powerpc/32s
> >> cannot allocate exec memory in vmalloc space. On powerpc this is because
> >> exec protection is performed on 256Mbytes segments and vmalloc space is
> >> flagged non-exec. Some other architectures have a constraint on distance
> >> between kernel core text and other text.
> >>
> >> Today you have for instance kprobes in the kernel that need dynamic exec
> >> memory. It uses module_alloc() to get it. On some architectures you also
> >> have ftrace that gets some exec memory with module_alloc().
> >>
> >> So, I still don't understand why you cannot use module_alloc() and need
> >> vmalloc_exec() instead.
> > 
> > Because I didn't know about it :)
> > 
> > Looks like that is indeed the appropriate interface (if a bit poorly
> > named), I'll switch to using that, thanks.
> > 
> > It'll still need to be exported, but it looks like the W|X attribute
> > discussion is not really germane here since it's what other in kernel
> > users are using, and there's nothing particularly special about how
> > bcachefs is using it compared to them.
> 
> The W|X subject is applicable.
> 
> If you look into powerpc's module_alloc(), you'll see that when 
> CONFIG_STRICT_MODULE_RWX is selected, module_alloc() allocate 
> PAGE_KERNEL memory. It is then up to the consumer to change it to RO-X.
> 
> See for instance in arch/powerpc/kernel/kprobes.c:
> 
> void *alloc_insn_page(void)
> {
> 	void *page;
> 
> 	page = module_alloc(PAGE_SIZE);
> 	if (!page)
> 		return NULL;
> 
> 	if (strict_module_rwx_enabled())
> 		set_memory_rox((unsigned long)page, 1);
> 
> 	return page;
> }

Yeah.

I'm looking at the bpf code now.

<RANT MODE, YOU ARE WARNED>

Can I just say, for the record - god damn this situation is starting to
piss me off? This really nicely encapsulates everything I hate about
kernel development processes and culture and the fscking messes that get
foisted upon people as a result.

All I'm trying to do is write a fucking filesystem here people, I've got
enough on my plate. Dealing with the fallout of a kernel interface going
away without a proper replacement was NOT WHAT I FUCKING HAD IN MIND?

5% performance regression without this. That's just not acceptable, I
can't produce a filesystem that people will in the end want to use by
leaving performance on the table, it's death of a thousand cuts if I
take that attitude. Every 1% needs to be accounted for, a 5% performance
regression is flat out not going to happen.

And the real icing on this motherfucking turd sandwich of a cake, is
that I'm not the first person to have to solve this particular technical
problem.

BPF has the code I need.

But, in true kernel fashion, did they recognize that this was a
subproblem they could write as a library, both making their code more
modular and easier to understand, as well as, oh I don't know, not
leaving a giant steaming turd for the next person to come along?

Nope.

I'd be embarassed if I was responsible for this.
