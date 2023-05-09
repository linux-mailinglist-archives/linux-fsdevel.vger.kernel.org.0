Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB86FD18C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEIVkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjEIVkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:40:19 -0400
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284583
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 14:40:18 -0700 (PDT)
Date:   Tue, 9 May 2023 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683667754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BLmDLz3BiMEr2LiLldeMxPISO3gLTAAmsfZ3LAk8jY=;
        b=VsfqGbr4zmcegdCNeOps8Tym8iTSXsp82l46/RQQeimltbUGVyaxe0SRmZCKkOhjp/WOGo
        6STHO1rpPpMOgnZ2guu4NVaqHLb0JSo5iwlLOvqhpgKezzpIXgHuBYtnYwjflDEofwV98s
        Hz6z9dW8EYVZ3k7IfvXGRc55GJUSZS4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFq7JhrhyrMTNfd/@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFq3SdSBJ_LWsOgd@murray>
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

On Tue, May 09, 2023 at 02:12:41PM -0700, Lorenzo Stoakes wrote:
> On Tue, May 09, 2023 at 01:46:09PM -0700, Christoph Hellwig wrote:
> > On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > >
> > > This is needed for bcachefs, which dynamically generates per-btree node
> > > unpack functions.
> >
> > No, we will never add back a way for random code allocating executable
> > memory in kernel space.
> 
> Yeah I think I glossed over this aspect a bit as it looks ostensibly like simply
> reinstating a helper function because the code is now used in more than one
> place (at lsf/mm so a little distracted :)
> 
> But it being exported is a problem. Perhaps there's another way of acheving the
> same aim without having to do so?

None that I see.

The background is that bcachefs generates a per btree node unpack
function, based on the packed format for that btree node, for unpacking
keys within that node. The unpack function is only ~50 bytes, and for
locality we want it to be located with the btree node's other in-memory
lookup tables so they can be prefetched all at once.

Here's the codegen:

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/bkey.c#n727
