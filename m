Return-Path: <linux-fsdevel+bounces-34385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1C9C4E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782E7284A9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB3209F39;
	Tue, 12 Nov 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2M1qwh1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2717333A;
	Tue, 12 Nov 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388442; cv=none; b=Ac01vXamfoOR2YgrUBEhNOhls4Fzvft3KNBCqSQvM+18dfIgfu7uPaZJRjY6ZzDwYulipRr/tJFGjLojwu0xN3rW9w73lWwmz0PqW3Br41aMPV+3Nq106CrOxYZtanvcLRE1jxU3bapH32F6+yDzb195/pAIEApxV5r2mU8iFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388442; c=relaxed/simple;
	bh=Dr9U/4oz07RlHxnTsWciJmgmIYvSDCJP5I8UA7RzFQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6aHIi8FGvElhZhDxEoCBSrwhijRFTeP+CgWUnCQIgP66FoIBnndvhTnhnzGeyf2DUMmncTXwGFWkouyeIjJ6f1XDW469G5VBTlwHKCOaTXkdjkjFCXnrusT6j7rvH3SamfjJhnaiaY2t3/iDYeJezRwpF70mJ7YUPSHaUo7vLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2M1qwh1A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dr9U/4oz07RlHxnTsWciJmgmIYvSDCJP5I8UA7RzFQM=; b=2M1qwh1AqGirj4hVK6iD5rkK9e
	ADJWHNyuibF7ECP4yEs3+yNhaWKAiv1gOGF2Z1ehePvP2eJqrcy1ovpM6DX2j7vWrmRhgw9pzltKj
	OM5At4evBviDWhv45Rsoe9w7om9Qzd/dzkvV6QA9wBLGqP689fnVXxN+dRE5xUB57zwjBN+qfXqVV
	6SIiuxUDML62sBggkGgRUwL3zBd9a92QEi7qEeTJVe1EexMMugG5p21mvgnuGO6Y3rU4Q2K6C3mz3
	aVvFmUzPT9BMBbheQuQDmh4rzJeDJdA5rP60IbMoH/uJ82xrQalrBSKGnse6OikyJp7nc9f1cJHWh
	Ooe8+lPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjDz-00000002EO4-0eub;
	Tue, 12 Nov 2024 05:13:59 +0000
Date: Mon, 11 Nov 2024 21:13:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzLkF-oW2epzSEbP@infradead.org>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> Here's the slightly cleaned up version, this is the one I ran testing
> with.

Looks reasonable to me, but you probably get better reviews on the
fstests lists.


