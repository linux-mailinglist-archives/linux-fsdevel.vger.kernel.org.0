Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21A1ACE41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbgDPRCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 13:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbgDPRC3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:02:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40830206D9;
        Thu, 16 Apr 2020 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587056549;
        bh=SskQMVRoUuqxTsTT4M+b0jWWskvnCF4LTgOnJX4qCGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyN+pTmtScj5UVmLJ5nyPnYvNtKMRbAlFgQ+Tspk+FzvPi1Xh2D4Dtg0Hqtraieph
         F8+QstZpki8Sl+s5PjSkqqc5LZgflo4EZcTNFZRZ66roYCEsRT8wOjiZ+CgB2TGypn
         B9iyPcYSGryhblmos08GuemDKcbb2uK9CMmgMS7o=
Date:   Thu, 16 Apr 2020 18:02:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/5] mm: Remove definition of
 clear_bit_unlock_is_negative_byte
Message-ID: <20200416170224.GB32685@willie-the-truck>
References: <20200416154606.306-1-willy@infradead.org>
 <20200416154606.306-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416154606.306-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 08:46:02AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This local definition hasn't been used since commit 84c6591103db
> ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using
> atomic_fetch_*()") which provided a default definition.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  mm/filemap.c | 23 -----------------------
>  1 file changed, 23 deletions(-)

Ok, for my own curiosity I tried building for Alpha because I couldn't for
the life of me figure it out, and behold:

mm/filemap.c: In function 'unlock_page':
mm/filemap.c:1271:6: error: implicit declaration of function 'clear_bit_unlock_is_negative_byte' [-Werror=implicit-function-declaration]
  if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:267: mm/filemap.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1722: mm] Error 2
make: *** Waiting for unfinished jobs....

I had to enable CONFIG_SMP, so maybe the robot doesn't do that?

Anyway, it's somewhat reassuring that it broke, if not unfortunate at the same
time!

Will
