Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544745B4DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 08:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhKXHGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhKXHGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:06:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21D6C061574;
        Tue, 23 Nov 2021 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=031Lzzl4d+xOUl0R6dbxENareszoxPdA01S4TGMveuI=; b=Aq9kKlNd/oBQClZqNHZX+NyBwg
        tA8/MzQHE/hfmBtNHRH4MYCKzosSeXGIkiJZyRIeDExhAVi8fOW4zaIygK8x7IetG3CHCpTBUKjra
        1WXOdCZjY3rN/yxQye2Sg7KnaqPzXXmOYcXXl0PCK/6pHMhwvw8DoXuipb4mN+TgimY+U4lN9FQfE
        2sOEcZDTEyiueDKEiCFpbT3GX17SsfVc/WspT5eYvjNMNrXJRyGhQL8a412FKWUlC4kxpXt3kqMRb
        dHQKVL1NXXZoMBs0C0cAk2m3KGi5VnDvtGX7N+yUQY3/PjmNiGXKzRHhRf7eyeqN13Ly8mwfId7tl
        JuShG7mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpmIu-0042ri-AX; Wed, 24 Nov 2021 07:02:52 +0000
Date:   Tue, 23 Nov 2021 23:02:52 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZ3jnFWk05058h/J@infradead.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
 <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
 <YZ3XH2PWwrIl/XMy@infradead.org>
 <e3fce9af-429c-a1e3-3f0b-4d90fa061d94@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fce9af-429c-a1e3-3f0b-4d90fa061d94@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:18:00PM +0800, Qu Wenruo wrote:
> Just so simple? Then that's super awesome.
> 
> But I'm a little concerned about the bio_add_hw_page() call in
> bio_add_zoned_append().
> 
> It's not exactly the same as bio_add_page().
> 
> Does it mean as long as our splitted bio doesn't exceed zone limit, we
> can do the convert without any further problem?

You need to look at the limits when splitting.  I have modified
blk_bio_segment_split and exported it to deal with that.  Let me split
those changes out cleanly and push out a branch.
