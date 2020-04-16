Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB11AC5F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405616AbgDPObR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394298AbgDPObI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:31:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1EC061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vhhheZDRF5ha3in5VMD/IA78tE/F9ey45sQgR/A8ceU=; b=VnctTWyTPa1YBWxtIZkFBSsr6T
        CMAO2ezJRjbSywnkl3wpS5BRSull8mEK8dSy13pBuz8YBohxgrMQDHjAB66aOsDTtQi8LGGnet/Xm
        p2htxmoYt/au7yBV5T9784/31DwfHdN9eVsPOOBqIa/3Rf7otG/KRpOnfB9g9rqDnJn6/Tr1T3Erz
        bDpRhdRma2xOLvaYh2lQwoEYD1veoVBa6iVuOYeEpMI/z+zpAfm2EdFisaf8jsFrGNvmZhIupjnE8
        qmF6QkUcyHWuIfa/IzDqIjdLe4sNO03IlIx6Cy5YelfK/pKFIaGrW9MDefSsUoYBq47Y5kTGLYb1W
        9lfKxf3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP5Xl-00056H-Cb; Thu, 16 Apr 2020 14:31:05 +0000
Date:   Thu, 16 Apr 2020 07:31:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/2] mm: Remove definition of
 clear_bit_unlock_is_negative_byte
Message-ID: <20200416143105.GG5820@bombadil.infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-2-willy@infradead.org>
 <20200416124536.GA32565@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416124536.GA32565@willie-the-truck>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:45:39PM +0100, Will Deacon wrote:
> Sorry I missed this, I'm over on @kernel.org now and don't have access to
> my old @arm.com address anymore.

Oops.  Shame they haven't started bouncing it yet, so I didn't know.

> > -static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)
> > -{
> > -	clear_bit_unlock(nr, mem);
> > -	/* smp_mb__after_atomic(); */
> > -	return test_bit(PG_waiters, mem);
> > -}
> 
> I'd really like to do this, but I worry that the generic definition still
> isn't available on all architectures depending on how they pull together
> their bitops.h. Have you tried building for alpha or s390? At a quick
> glance, they look like they might fall apart :(

I haven't, but fortunately the 0day build bot has!  It built both s390 and
alpha successfully (as well as 120+ other configurations).
