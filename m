Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC0D8137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfJOUn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 16:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfJOUn7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:43:59 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7599320854;
        Tue, 15 Oct 2019 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571172237;
        bh=9Qj8AYZCrF57ox3fBSNqCP0O0J3goZvHpDiYb87LWFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKCAx9yRrgOHGf17Ho7NijWIxSqW//fWkAaXM++2B9jn58qVFpRX7zcPFiLKUNm95
         fFIDKKRdL4lJGfwTEffPuD/A6yyJtu9TlVr5pHzUOwKbFGx7jb6HWhNeutbLSkWRnS
         g///Z862TTLWr7U4qJlq/nN5XcyZs3WYjWTkl3Fw=
Date:   Tue, 15 Oct 2019 13:43:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] mm, swap: disallow swapon() on zoned block devices
Message-Id: <20191015134357.042f39a02ae438d961aa2aca@linux-foundation.org>
In-Reply-To: <20191015090641.GB7199@infradead.org>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
        <20191015085814.637837-1-naohiro.aota@wdc.com>
        <20191015090641.GB7199@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Oct 2019 02:06:41 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> > +		/*
> > +		 * Zoned block device contains zones that have
> > +		 * sequential write only restriction. For the restriction,
> > +		 * zoned block devices are not suitable for a swap device.
> > +		 * Disallow them here.
> > +		 */
> > +		if (blk_queue_is_zoned(p->bdev->bd_queue))
> 
> Please use up all 80 chars per line  Otherwise this looks fine:

I redid the text a bit as well.

--- a/mm/swapfile.c~mm-swap-disallow-swapon-on-zoned-block-devices-fix
+++ a/mm/swapfile.c
@@ -2888,10 +2888,9 @@ static int claim_swapfile(struct swap_in
 		if (error < 0)
 			return error;
 		/*
-		 * Zoned block device contains zones that have
-		 * sequential write only restriction. For the restriction,
-		 * zoned block devices are not suitable for a swap device.
-		 * Disallow them here.
+		 * Zoned block devices contain zones that have a sequential
+		 * write only restriction.  Hence zoned block devices are not
+		 * suitable for swapping.  Disallow them here.
 		 */
 		if (blk_queue_is_zoned(p->bdev->bd_queue))
 			return -EINVAL;
_

