Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE681ACE79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgDPRNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727880AbgDPRNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:13:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD4C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mri1NWhCMcPHRYwypLzON75E4Lrzzif/ya45nsbZ/oU=; b=jksf0ahqGNmUWjulQluYS7t4Uc
        M6kPD3+htw/cx88Rwvq662dmktLMv+WYU+fn6zqchl8XmGi/nvSiTmVeLtezVUCiiqSeSmgdQ+qyR
        6EYaU37rhDfCqlgYCqlUjS92fxtIuiWOTGTLsPvI+qTElQ6ckyyhCcZHFkTpuH5sGsCaZPnOwI42T
        PATr/mDK7trq4VrppOkwjK8EKFmYKnHO1GLah4F6Yrefk5W7Dln246W7f08PM3PqO3JFhkp4zzRXZ
        iqLrT50Atre1PlJvHbOn32MjMtLujjq20RPn1lBqoZaGoGbroLyXbkqXy9lKVNGEugqMUvV9UFdvU
        k3xvgwxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP855-0007ZZ-4z; Thu, 16 Apr 2020 17:13:39 +0000
Date:   Thu, 16 Apr 2020 10:13:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>, lkp@intel.com
Subject: Re: [PATCH v2 1/5] mm: Remove definition of
 clear_bit_unlock_is_negative_byte
Message-ID: <20200416171339.GH5820@bombadil.infradead.org>
References: <20200416154606.306-1-willy@infradead.org>
 <20200416154606.306-2-willy@infradead.org>
 <20200416170224.GB32685@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416170224.GB32685@willie-the-truck>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 06:02:24PM +0100, Will Deacon wrote:
> On Thu, Apr 16, 2020 at 08:46:02AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > This local definition hasn't been used since commit 84c6591103db
> > ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using
> > atomic_fetch_*()") which provided a default definition.
> 
> Ok, for my own curiosity I tried building for Alpha because I couldn't for
> the life of me figure it out, and behold:
> 
> mm/filemap.c: In function 'unlock_page':
> mm/filemap.c:1271:6: error: implicit declaration of function 'clear_bit_unlock_is_negative_byte' [-Werror=implicit-function-declaration]
>   if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> I had to enable CONFIG_SMP, so maybe the robot doesn't do that?
> 
> Anyway, it's somewhat reassuring that it broke, if not unfortunate at the same
> time!

Thanks!  The robot says it built two alpha configs,
randconfig-a001-20200325 and defconfig.  I imagine neither has SMP set.

kbuild people, please can you add SMP and non-SMP options to the configs
you test?
