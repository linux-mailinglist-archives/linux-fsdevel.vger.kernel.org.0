Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA69BD4542
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfJKQVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:21:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfJKQVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7yGSM9xcAHN/X9j3aG0KDWpux1hcEmDmeeJWRUqsfj4=; b=NwziWKENcP2LRKnIEMC6EIVkN
        tBmo7CgwpISlk3y7dqAgpo1MH1c9ZI6TuTS+ywbjiqvqJUxTN9j/hivsEzT3rlfQYAHqbbhmwmyQi
        R+GTqNY/4wpckACEibpyRj1N4t25yV4OqobDkjX3Lyi6i9FzqdKQcMOngFJ2pgwz/1OiCp2Kmdgq3
        OegBr5YmsSuarU3hOvqTjIgxPk99fw81FY4XxtWB9on1zvNVVOZG/0JMwqQrB2rT0L+IOqrr+OtWk
        FKEV+pPdb/GGZKePLhGKL1XmL6FZNzQEX2C4gKnOz1szteWsZzaspHVx/nsZNicAu1yacbGEqDXV9
        jU8wii+Ag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIxf8-0005DY-1v; Fri, 11 Oct 2019 16:21:06 +0000
Date:   Fri, 11 Oct 2019 09:21:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 14/26] mm: back off direct reclaim on excessive shrinker
 deferral
Message-ID: <20191011162105.GU32665@bombadil.infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-15-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-15-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:12PM +1100, Dave Chinner wrote:
> +			if ((reclaim_state->deferred_objects >
> +					sc->nr_scanned - nr_scanned) &&
> +			    (reclaim_state->deferred_objects >
> +					reclaim_state->scanned_objects)) {
> +				wait_iff_congested(BLK_RW_ASYNC, HZ/50);

Unfortunately, Jens broke wait_iff_congested() recently, and doesn't plan
to fix it.  We need to come up with another way to estimate congestion.
