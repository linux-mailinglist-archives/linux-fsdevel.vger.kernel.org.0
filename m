Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57831374B07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhEEWMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 18:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhEEWMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 18:12:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC1C061574;
        Wed,  5 May 2021 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bfddk5G/yEPhchklhRITjMOlFo2bM+jpufSuMTlextA=; b=pGaBTVjWyxSL+WrViv8GWI3PkU
        zHY/Bj8ectHuslJl7xPfFxHFYnL1EhLgYrjv4ilxF+Q3/HHmLC503s2R4hTi1Dkk/NzkqMJyOxdY/
        eGKcP6o5Ah7TU2qbOL9nDXxeN7BB5JTkQ2ytRSvqiyn//IB6/k7mXF8SERyqR4wZ1QP9ZE66Uz8S+
        gbF5lPYf75BY+Q92E8N5j+EEpna8QKw8BefVt6PxC8s8CaW8lamgIXKPyTgBMCl9Kx2gWP3nsfc6j
        8XQjwqHYJxydwU/pCvZo5HJtwBmHpzd5QC+aizzsDUbIaKWsR3yKj7O5N9DD8n+hUbi7fdHsVYQ+L
        X1DNYw0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lePjM-000yeC-In; Wed, 05 May 2021 22:11:16 +0000
Date:   Wed, 5 May 2021 23:10:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 92/96] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <20210505221056.GK1847222@casper.infradead.org>
References: <20210505150628.111735-93-willy@infradead.org>
 <202105060511.863ZVBcq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105060511.863ZVBcq-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 05:36:54AM +0800, kernel test robot wrote:
> config: nds32-defconfig (attached as .config)
>    fs/iomap/buffered-io.c: In function '__iomap_write_end':
> >> fs/iomap/buffered-io.c:645:2: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_dcache_page'? [-Werror=implicit-function-declaration]
>      645 |  flush_dcache_folio(folio);
>          |  ^~~~~~~~~~~~~~~~~~
>          |  flush_dcache_page
>    cc1: some warnings being treated as errors

Argh, nds32 doesn't (always) include asm-generic/cacheflush.h, so it
doesn't pick up the generic implementation of flush_dcache_folio().
Copy-and-pasted it to nds32.

Thanks.
