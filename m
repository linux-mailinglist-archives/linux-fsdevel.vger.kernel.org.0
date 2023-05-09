Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E46FD199
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjEIVnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjEIVnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409544BA;
        Tue,  9 May 2023 14:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19748611EF;
        Tue,  9 May 2023 21:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE2C433D2;
        Tue,  9 May 2023 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683668600;
        bh=2wgNGj7IRW2IEkHkrYYCOyn9Q8mDflypIGx2KHMdfs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnG6UmOqAoqjkEFma9E6VFvw3wm4LuZW7KuhuEHuxfHCBNoxtwTt3JGlY6GkLUIvu
         ji80MClXV2oa39iA0lqwqN5oTRmq1Gl/+X1tbCDilnYZSkObKO/5vo77sWGap2thyh
         8eKfzPbEbLt7wHx2knWN3Kdjf86J8kpTVqxqJZaFrvfyjuOYE5T6eg2gtPGDJLfjZV
         /O14s6TWsy4bMmbinHaeHp5387HyBS4hdEoAMXj76FrLb+uYy5iFLVjAua8adhumch
         ZHETd7SqJujh2SHfCcacdVlIOMdlDdRUv5E1XkggKrswJ6E6FAW1qtRiTim7Y2U6rY
         mH3pJVaJr3U2Q==
Date:   Tue, 9 May 2023 14:43:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230509214319.GA858791@frogsfrogsfrogs>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFq3SdSBJ_LWsOgd@murray>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

I already trolled Kent with this on IRC, but for the parts of bcachefs
that want better assembly code than whatever gcc generates from the C
source, could you compile code to BPF and then let the BPF JIT engines
turn that into machine code for you?

(also distracted by LSFMM)

--D
