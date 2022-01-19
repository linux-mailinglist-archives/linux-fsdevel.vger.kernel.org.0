Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00600493B00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354648AbiASNVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 08:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASNVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:21:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C69C061574;
        Wed, 19 Jan 2022 05:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+9su99qQAC8y6dKw8A2X//R/c9y7lfjPSaVbD0mlkIU=; b=E9ZM3eDC/vl/KH/yXJ7nUL6K/l
        NCWWJpsHYRu1Feq1U/7U3Dgps87a3su50/wTSrphRvKDrVOgB9onW0JgyDy/vWUXEEyBnzV09sV/v
        CjLzYgcKr9NmdAs+5tsVk4sPoXun8RfLC434MTzHuHdIZ5v8bNC5Yja1QEXMvMlb3u/TiVRKPRBXQ
        MFPBhW+gZ31Q8UGF4A7OHNlrmAUElpBpZGA/HkIJ/J7UdBGEsgdSgPD/3BVUxkb4in/WFk4NJkNjU
        ChPO1vBidjHj6rqG+FnVPCBrYCyERd3hp9apv88S/ATC6bT26oAkHbaWiVrg12fE3F3GBXn2Gy3i7
        Uf5OpMKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAAtU-00AsCu-PA; Wed, 19 Jan 2022 13:20:56 +0000
Date:   Wed, 19 Jan 2022 13:20:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <YegQOHs9yjIgu1Qi@casper.infradead.org>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
 <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
 <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 05:02:13PM +0800, JeffleXu wrote:
> I'm afraid IDR can't be replaced by xarray here. Because we need an 'ID'
> for each pending read request, so that after fetching data from remote,
> user daemon could notify kernel which read request has finished by this
> 'ID'.
> 
> Currently this 'ID' is get from idr_alloc(), and actually identifies the
> position of corresponding read request inside the IDR tree. I can't find
> similar API of xarray implementing similar function, i.e., returning an
> 'ID'.

xa_alloc().
