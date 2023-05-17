Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA8706D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjEQQBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjEQQBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 12:01:02 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7288DD8A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 09:00:32 -0700 (PDT)
Date:   Wed, 17 May 2023 11:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684339203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uj5Rjh+AN0r/Ht1trw7qzyL7wBHUsoOZQ8wgW5hbJew=;
        b=DKzUV2fMhLT8gizPcUiaWKOzbYxc5ECoXth7Jg+gW5iquDVvCug3k6eHhkGXh2VnHvbXsh
        WF7yrhikG1PJYZw7Vgi2IvcQJXxvUN+yQTvVEiCRi+ldsou1jQ5un2NZgJyqsC8Ff95uqE
        +hOLNw5zcm0cdTCRdL7KgsuYii08Ng8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        song@kernel.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGT5/gBbh5kNYQgf@moria.home.lan>
References: <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <ZGP54T0d89TMySsf@casper.infradead.org>
 <ZGRmC2Qhe6oAHPIm@moria.home.lan>
 <ZGTe6zFYL25fNwcw@kernel.org>
 <ZGTiI49s8+YjBxVX@moria.home.lan>
 <20230517154412.GC4967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517154412.GC4967@kernel.org>
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

On Wed, May 17, 2023 at 06:44:12PM +0300, Mike Rapoport wrote:
> On Wed, May 17, 2023 at 10:18:11AM -0400, Kent Overstreet wrote:
> > On Wed, May 17, 2023 at 05:04:27PM +0300, Mike Rapoport wrote:
> > 
> > And I'm really curious why text_poke() is needed at all. Seems like we
> > could just use kmap_local() to create a temporary writeable mapping,
> 
> On 64 bit kmap_local_page() is aliased to page_address() and does not map
> anything. text_poke() is needed to actually create a temporary writable
> mapping without touching page tables in vmalloc and/or direct map.

Duh - thanks!
