Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7422459CF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 08:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhKWHrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 02:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhKWHrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:47:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5EC061574;
        Mon, 22 Nov 2021 23:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1zVuUCM6cd7uBkqMzegAmZTAxD2eFcHwR1T5FyIhwTQ=; b=ncTida/krSHTBqUJ2nrBzn0MN+
        GItFwmBkgdjSw2J6R6ys5DrkecE2bG3GyHN2hdFxBl77RtFIjEua5CcaZ0Zd3+Nvt//dqY1uIy5ww
        Af9AWH+ryUqa/AeaNZK8LhAsZtt2qMja0zgMxjbSNpNIYtfbeVRftiQhPXJUXfTvOOS4Tm+MMCj6V
        r57pd2V+V9owpESAntKfQ3uaP/qg9Qok0vKBvDCAYXc3L+cd6u+zhTseEkKxGEOQJ0GOP/TQ4zYTy
        tnJ6Z+xzCts1RhnPN2AgG2EzkRRGWWW1we/eDq+pIHOfLKpTL2qrnlVqyEm/gCB0Ijs70nKN8NyCW
        SfqTmYbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpQT8-0015cU-Fv; Tue, 23 Nov 2021 07:43:58 +0000
Date:   Mon, 22 Nov 2021 23:43:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZybvlheyLGAadFF@infradead.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:44:32PM +0800, Qu Wenruo wrote:
> Hi,
> 
> Although there are some out-of-date comments mentions other
> bio_clone_*() variants, but there isn't really any other bio clone
> variants other than __bio_clone_fast(), which shares bi_io_vec with the
> source bio.
> 
> This limits means we can't free the source bio before the cloned one.
> 
> Is there any bio_clone variant which do a deep clone, including bi_io_vec?

There is no use case for that, unless the actual data changes like in
the bounce buffering code.

> That's why the bio_clone thing is involved, there is still some corner
> cases that we don't want to fail the whole large bio if there is only
> one stripe failed (mostly for read bio, that we want to salvage as much
> data as possible)
> 
> Thus regular bio_split() + bio_chain() solution is not that good here.
> 
> Any idea why no such bio_clone_slow() or bio_split_slow() provided in
> block layer?
> 
> Or really bio_split() + bio_chain() is the only recommended solution?

You can use bio_split witout bio_chain.  You just need your own
bi_end_io handler that first performs the action you want and then
contains code equivalent to __bio_chain_endio.  As a bonus you can
pint bi_private to whatever you want, it does not have to be the parent
bio, just something that allows you to find it.
