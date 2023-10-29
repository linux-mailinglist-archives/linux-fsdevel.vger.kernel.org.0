Return-Path: <linux-fsdevel+bounces-1512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813E7DB0C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 00:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7220E1C2099C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F414F7D;
	Sun, 29 Oct 2023 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s3Bd+dzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADF14F90
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 23:17:37 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717E4E3E9;
	Sun, 29 Oct 2023 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VT3Ad4lScHgALY3lYyr+KQk9MBuJnneunm0wQQrliGI=; b=s3Bd+dzA8IVaL7EAr7sc9o7QFs
	RqxVYSQ+/gE1vs83o8o05Nml83SpfDzOtgZwmw3laXu4TZAQOHivFfFgiowRBqjspvKLEudIEYb9i
	bnznG0G9e0ZqqWXA5OKNdT31xCgyrgPn/vVwWmiWpKoynl0nRIHymyOuTgjTTEgSwdVlR4133p8j9
	GV0Gtf2XLrx/3RAzU1e6NNQEhOYi+0cO999GMT0P8v1HoSCFe1b1ddiflYIb5fGoS62Kulwjlm5ex
	cRIS3gQfrNH2j8IzX/5qauNRHa/g+//WQ+zdwkekYx6e6hkwGqOallL7PfrmxdS8aBZ7dirFGyR41
	D5zM70qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxEzW-000dtM-3j; Sun, 29 Oct 2023 23:14:46 +0000
Date: Sun, 29 Oct 2023 23:14:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 06/11] shmem: trace shmem_add_to_page_cache folio
 order
Message-ID: <ZT7nZqMylFYEqpg/@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1@eucas1p2.samsung.com>
 <20231028211518.3424020-7-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-7-da.gomez@samsung.com>

On Sat, Oct 28, 2023 at 09:15:44PM +0000, Daniel Gomez wrote:
> To be able to trace and account for order of the folio.
> 
> Based on include/trace/filemap.h.

Why is this better than using trace_mm_filemap_add_to_page_cache()?
It's basically the same thing.

