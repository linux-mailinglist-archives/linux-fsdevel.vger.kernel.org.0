Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9722830F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgGUPEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:04:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57A6C061794;
        Tue, 21 Jul 2020 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oknj1lsxLPk9B6E8WnIuKiLyJqHZn66wTZ4CR0EU5sc=; b=m2d2MaWiddXS5EgpeBH2Eryg9d
        j4yVYYcDGO2nVfI0VL+C+RCHxUdrp3PxcIVtVcSKzJOp0Yt91bkUHCLP3bDX0SjXIMI6XR9hJAAlE
        DDjLeA/gtAaUuLSJlsX4hqIzkV+wqn5qOeZZkfGPKjmmJeLt46uOOHq5a3wlxh/+QPq74EVy62UcA
        FdeOMcDg3VhVUU6qnjQJfR66h3v0i8USArJ5Q9JPC5ECO7Ym85iLYMWI41cQzJ2r173EhRaJ/Tvww
        e7jDAZngG+pQBgSr7f3cNVzoZagiCiAf8vi9cG9TGyq4dfOjSl+4w3V48fmO48V+IaF1Y3aOskUk3
        fcnytZDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxtom-0002E4-T6; Tue, 21 Jul 2020 15:04:33 +0000
Date:   Tue, 21 Jul 2020 16:04:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721150432.GH15516@casper.infradead.org>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721145313.GA9217@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:53:13PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 04:51:25PM -0500, Goldwyn Rodrigues wrote:
> > Hi Christoph,
> > 
> > On  9:46 13/07, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series has two parts:  the first one picks up Dave's patch to avoid
> > > invalidation entierly for reads, picked up deep down from the btrfs iomap
> > > thread.  The second one falls back to buffered writes if invalidation fails
> > > instead of leaving a stale cache around.  Let me know what you think about
> > > this approch.
> > 
> > Which kernel version are these changes expected?
> > btrfs dio switch to iomap depends on this.
> 
> No idea.  Darrick, are you ok with picking this up soon so that
> Goldwyn can pull it in?

I thought you were going to respin this with EREMCHG changed to ENOTBLK?
