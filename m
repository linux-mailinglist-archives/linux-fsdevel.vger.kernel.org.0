Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7C459D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhKWIQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhKWIQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:16:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEEC061574;
        Tue, 23 Nov 2021 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4YijtBTyJPe4CDtmFP69Gbz6r5Wn+fqLJAH4gW9UzE=; b=ZG+gid7LRNVNkX5nndfyIUTtGS
        A6lYXFuPq7An+aVm2VQy7Ry04d7MtZ8cP09CmzYss2S8hUXWRy1jK/jmID+oXAPyg+3R+L/F2Wm+C
        3OSMcfaaihQ4L5Lp3rBjZEtWPxtriaFIHTiEEgFFimH7lj9EUG8seIgiMO9ppA/ICE6nv2SBuT/u9
        zzikpHW4gfXL4gYEhcF44bxNV6f3g08DhsYVT66bBUlDAuEW/kzYts2gH/FTQVdvdW1MaPCA7v5b1
        O5aoFOZOQwTsP3Sm40SA25MHsxmDiIuVgzYiA2niftp7dMe1JadnBHI/rcXqi30DHj7aZ9twZEBFa
        NHHRNPKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpQvw-001DKY-4W; Tue, 23 Nov 2021 08:13:44 +0000
Date:   Tue, 23 Nov 2021 00:13:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZyiuFxAeKE/WMrR@infradead.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:10:35PM +0800, Qu Wenruo wrote:
> Without bio_chain() sounds pretty good, as we can still utilize
> bi_end_io and bi_private.
> 
> But this also means, we're now responsible not to release the source bio
> since it has the real bi_io_vec.

Just call bio_inc_remaining before submitting the cloned bio, and then
call bio_endio on the root bio every time a clone completes.
