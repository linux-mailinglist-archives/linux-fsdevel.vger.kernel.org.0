Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720C3988EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfHVBZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 21:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfHVBZJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:25:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEF82070B;
        Thu, 22 Aug 2019 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566437108;
        bh=fAmchYbKEVyEzsyvePBupZlerJN00M59W8q92U6VFWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JLwdMo+hkWLZOEkgdKA7JoF8CUwv8bb3SEouBLk6DfZo3p8jwE/B/YUmbd73PqoP+
         pY043x+Frcc6EJOugkUGrR78tacGWuftGkakWA8i4+mYeMXkiiuW6eVbkNLH1We1iR
         zmiIgwJwszIRadhGE56IP6mnlCmzfKY7o3pfKh90=
Date:   Wed, 21 Aug 2019 18:25:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Denis Efremov <efremov@ispras.ru>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-media@vger.kernel.org, Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
Subject: Re: [PATCH] lib/memweight.c: optimize by inlining bitmap_weight()
Message-Id: <20190821182507.b0dea16f57360cf0ac40deb6@linux-foundation.org>
In-Reply-To: <20190821074200.2203-1-efremov@ispras.ru>
References: <20190821074200.2203-1-efremov@ispras.ru>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Aug 2019 10:42:00 +0300 Denis Efremov <efremov@ispras.ru> wrote:

> This patch inlines bitmap_weight() call.

It is better to say the patch "open codes" the bitmap_weight() call.

> Thus, removing the BUG_ON,

Why is that OK to do?

I expect all the code size improvements are from doing this?

> and 'longs to bits -> bits to longs' conversion by directly calling
> hweight_long().
> 
> ./scripts/bloat-o-meter lib/memweight.o.old lib/memweight.o.new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-10 (-10)
> Function                                     old     new   delta
> memweight                                    162     152     -10
> 

