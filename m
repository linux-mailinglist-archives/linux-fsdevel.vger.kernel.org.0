Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4638145B547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhKXHZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbhKXHZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:25:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFCEC061714;
        Tue, 23 Nov 2021 23:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZFBMQ8sXX5veF02o0GTPxkdseQuzOQdI9/4JIqRRwA=; b=j7XqXmrOn+xYNs1cxUaKDxxIzN
        zJwp/GQ053mzG58fC3IZVapJjzt8QCXBPAZM9X8eOmxnf59Yx1qBZKuui40CZP49cN3Rb6qCl8Men
        Gy2MAzH0vA4QE5nfiGEYIqrN3PF/KyO7RHlNOMOGz9/+ucqoIBlL3rEsW//xepwpifM2SwiwDWjIY
        cYsgKEDiKjY3AsXc9ROmU1PprUWNRVfPpddycmIuHPZLL7nzETg3I6q99MkhKEZjxv96hscDEAwoU
        wu/j2HuFKHwDf58jw+gfDOzy5cYgnyn/CpwaNOVJOBcO/Mp/QCvZOvFGiuAHaZvvqBeE69O0a+zwn
        LHzCJwew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpmc2-0044bY-GE; Wed, 24 Nov 2021 07:22:38 +0000
Date:   Tue, 23 Nov 2021 23:22:38 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZ3oPrgI1GFugzVY@infradead.org>
References: <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
 <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
 <YZ3XH2PWwrIl/XMy@infradead.org>
 <e3fce9af-429c-a1e3-3f0b-4d90fa061d94@gmx.com>
 <YZ3jnFWk05058h/J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ3jnFWk05058h/J@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:02:52PM -0800, hch@infradead.org wrote:
> > Does it mean as long as our splitted bio doesn't exceed zone limit, we
> > can do the convert without any further problem?
> 
> You need to look at the limits when splitting.  I have modified
> blk_bio_segment_split and exported it to deal with that.  Let me split
> those changes out cleanly and push out a branch.

Here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/zone-append-split
