Return-Path: <linux-fsdevel+bounces-17536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E508AF57B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755291C23E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394A13DDB4;
	Tue, 23 Apr 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6t8fl11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8E13DBA8;
	Tue, 23 Apr 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893194; cv=none; b=stcBqzjkHR0odN72wuGD5/vMg7lEcHVOtUNDf4IiwOL3tXk4B5PANAJ1N9O+z500Ksu/CdpcSC8fu0+xhHv2xW+yRbT28+kjaFQNHcekSZjH5HWVQbJX1b5Iv4WITpHnAzm97OnCZHacScoTlxX3SsnjhR3lrbN+bt7EyLHHa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893194; c=relaxed/simple;
	bh=2Eit2zONEy7ACadg8HF+rWSu61pawyNV76G1vZL0tK4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlmBEw5yaWN5zQPug6s3XE6cQWMWdbozjvxUecYlrn0GIg+r3cN70+9jGXf4YjxAHd/ru9zvGgwIrxc0QXrIDaFvX64tFqoo+Yr1YpkBBiSgAjf7Zhrqx/GBZJjvOSPqPSOcrC7iRbK4QMVws500R4u5TPrrSUph8lV+JqjoO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z6t8fl11; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description;
	bh=SFu4S4N401hobfWJm/IQ3Si2iVoGv8l6ArVO3sqzwjk=; b=Z6t8fl11XS07USzn5AtUq0bvDN
	P0h97NL5GAqQPBlER+VhEN62gjSmxbxc4CCNgxGjVX4CkMYy/1/oNcd9I9rjvJsXLe6ke2Orv+2OY
	LqMNm9sBIMy7bUfQZwLZq83/AHc2q2yqAXpM9Tm9TzVC8rqX3eQHxENIQuPRiLwPXWsvq33eZxwa9
	Ov1CZTC6upR/8hqfnXJZZ/CoCccgprFDewRi8waHGmjYOtobGIAYv+1K3hntFLzNroAOdpDX3P53f
	i9B/7GW0zd/qfWg5oRArZK7xtupj52WBLZujX7+eZAK58olp8WJ9M2B8WHnmS2ti+cfXAWyG/SXom
	UoCzNf+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzJuZ-00000000y74-1yy0;
	Tue, 23 Apr 2024 17:26:31 +0000
Date: Tue, 23 Apr 2024 10:26:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hare@suse.com, p.raghav@samsung.com,
	da.gomez@samsung.com, djwong@kernel.org, david@fromorbit.com,
	willy@infradead.org, akpm@linux-foundation.org
Subject: Re: Broken xarray testing in v6.9-rc1
Message-ID: <ZifvRx0-aGQoDQgO@bombadil.infradead.org>
References: <vm5b7c2jwmvptcnpgofwunjg4supq3snn63xqklidudnzlnhuv@kanproehzmdr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vm5b7c2jwmvptcnpgofwunjg4supq3snn63xqklidudnzlnhuv@kanproehzmdr>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Apr 23, 2024 at 10:18:36AM -0400, Liam R. Howlett wrote:
> Hello,
> 
> Testing of the xarray using the radix tree test suite is currently
> broken in v6.9-rc1 and beyond.  A bisect resulted in your commit failing
> to build:
> 
> a60cc288a1a2604bd86d3df129f269887018c3cb is the first bad commit
> commit a60cc288a1a2604bd86d3df129f269887018c3cb
> Author: Luis Chamberlain <mcgrof@kernel.org>
> 
> ...
> 
> Building in the test suite now fails in linux/tools/testing/radix-tree:
> 
> {bisect/bad(bisect)//radix-tree} $ make
> cc  -O2 -g -Wall -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o xarray.o xarray.c
> In file included from xarray.c:18:
> ../../../lib/test_xarray.c: In function ‘test_get_entry’:
> ../../../lib/test_xarray.c:750:17: warning: implicit declaration of function ‘schedule’ [-Wimplicit-function-declaration]
>   750 |                 schedule();
>       |                 ^~~~~~~~
> ../../../lib/test_xarray.c: In function ‘check_xa_multi_store_adv’:
> ../../../lib/test_xarray.c:767:24: error: ‘PAGE_SHIFT’ undeclared (first use in this function)
>   767 |         index = pos >> PAGE_SHIFT;
>       |                        ^~~~~~~~~~
> ../../../lib/test_xarray.c:767:24: note: each undeclared identifier is reported only once for each function it appears in
> make: *** [<builtin>: xarray.o] Error 1
> 
> Can you please have a look?

Sure, I'll post patches right away, this also demonstrated an issue in
the test code too which I've fixed and will post a fix for too.

Thanks for reporting it.

  Luis

