Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D887020AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjENXng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjENXne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 19:43:34 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE610DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 16:43:31 -0700 (PDT)
Date:   Sun, 14 May 2023 19:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684107809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mggwEpH/XfQSgikEQX+k7jG5jsZJxafKLG7tZ7lLfpw=;
        b=OobDuuQTCFp7GRpcbbdm5KWHoEDDSxa6orNliLPqe6jh/lLy2gYgq3nnBl6YmX2w0KPz6o
        tUCwQ8VtQY6HHlqkOtt3I++X1mDl00GGgKEjaAT+6pfgUJE72HPUtYI5rX018dKoR44SJA
        0g2A4B9Z9yGIXTzH0S3Wq70l1qJu4NM=
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
Message-ID: <ZGFyHY6pH9CU4fzf@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
 <ce5125be-464e-44ad-8d9e-7c818f794db1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce5125be-464e-44ad-8d9e-7c818f794db1@csgroup.eu>
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

On Sun, May 14, 2023 at 06:39:00PM +0000, Christophe Leroy wrote:
> I addition to that, I still don't understand why you bring back 
> vmalloc_exec() instead of using module_alloc().
> 
> As reminded in a previous response, some architectures like powerpc/32s 
> cannot allocate exec memory in vmalloc space. On powerpc this is because 
> exec protection is performed on 256Mbytes segments and vmalloc space is 
> flagged non-exec. Some other architectures have a constraint on distance 
> between kernel core text and other text.
> 
> Today you have for instance kprobes in the kernel that need dynamic exec 
> memory. It uses module_alloc() to get it. On some architectures you also 
> have ftrace that gets some exec memory with module_alloc().
> 
> So, I still don't understand why you cannot use module_alloc() and need 
> vmalloc_exec() instead.

Because I didn't know about it :)

Looks like that is indeed the appropriate interface (if a bit poorly
named), I'll switch to using that, thanks.

It'll still need to be exported, but it looks like the W|X attribute
discussion is not really germane here since it's what other in kernel
users are using, and there's nothing particularly special about how
bcachefs is using it compared to them.
