Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D2705962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEPVUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEPVUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:20:42 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A025FD6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 14:20:40 -0700 (PDT)
Date:   Tue, 16 May 2023 17:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684272038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbkTng8H6hiTn8uKTCVsk8fFMRZsv0G437tHoNcRdyw=;
        b=SibD303eoaJKDw/Qhvvh03L8pvarBF0nYUklNoNZHgjjEpZ53aMlv5snN9FpqFXPEHQbx0
        LHXWrEV8byrPRslwxSNZj55hzeuxAFGK+ubsNu2p2v/2BFgQ2akuSeiuhIiYnhMwXR9Doi
        pF/mjBYG4GZWtq5+dZGjxFVscbKXIck=
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
Message-ID: <ZGPzocRpSlg+4vgN@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305161401.F1E3ACFAC@keescook>
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

On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> For something that small, why not use the text_poke API?

This looks like it's meant for patching existing kernel text, which
isn't what I want - I'm generating new functions on the fly, one per
btree node.

I'm working up a new allocator - a (very simple) slab allocator where
you pass a buffer, and it gives you a copy of that buffer mapped
executable, but not writeable.

It looks like we'll be able to convert bpf, kprobes, and ftrace
trampolines to it; it'll consolidate a fair amount of code (particularly
in bpf), and they won't have to burn a full page per allocation anymore.

bpf has a neat trick where it maps the same page in two different
locations, one is the executable location and the other is the writeable
location - I'm stealing that.

external api will be:

void *jit_alloc(void *buf, size_t len, gfp_t gfp);
void jit_free(void *buf);
void jit_update(void *buf, void *new_code, size_t len); /* update an existing allocation */
