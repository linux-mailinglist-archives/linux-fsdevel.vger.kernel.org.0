Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E866706D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjEQPon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEQPoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 11:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E441558B;
        Wed, 17 May 2023 08:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD1D63860;
        Wed, 17 May 2023 15:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4798C433EF;
        Wed, 17 May 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684338266;
        bh=CWH2pztIOxMe+ekz7FPDOiiqxPpYYmkV6Bjtj8FaKhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8yqKPipt+vunH2g5aUufq37y/MGQZ4ijZGLIT3VzuwM9BzjnhxDZz471LRMl4jXD
         8ZpG4eUF8dr8JxX99DI1OaxcFhorHnv4oWxGM8C8TNz9Fdj9vKgsX/TwvEN1MroAoJ
         sNc5C9I5qJDT5Mzh5bqUw499jLFaYAM67otU1Bl62J8WQfsEImW4sZ0PYuVoQVN+1Z
         fgRDJMMz1IYy7a9GV87WnXxyv7DjvDLCrZF7P7iLTGM6yCCrNObF2i1vrxco+JfEXT
         B2rZ417mW+tSWt7xZKCkfHnT8h7lmnqNksSLOUczAdTmQY5MAX60pTJGirG3bNKM2r
         WDdi6PFoLVdRw==
Date:   Wed, 17 May 2023 18:44:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
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
Message-ID: <20230517154412.GC4967@kernel.org>
References: <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <ZGP54T0d89TMySsf@casper.infradead.org>
 <ZGRmC2Qhe6oAHPIm@moria.home.lan>
 <ZGTe6zFYL25fNwcw@kernel.org>
 <ZGTiI49s8+YjBxVX@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGTiI49s8+YjBxVX@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 10:18:11AM -0400, Kent Overstreet wrote:
> On Wed, May 17, 2023 at 05:04:27PM +0300, Mike Rapoport wrote:
> 
> And I'm really curious why text_poke() is needed at all. Seems like we
> could just use kmap_local() to create a temporary writeable mapping,

On 64 bit kmap_local_page() is aliased to page_address() and does not map
anything. text_poke() is needed to actually create a temporary writable
mapping without touching page tables in vmalloc and/or direct map.

-- 
Sincerely yours,
Mike.
