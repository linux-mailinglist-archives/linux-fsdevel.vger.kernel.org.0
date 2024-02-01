Return-Path: <linux-fsdevel+bounces-9922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D988461E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 21:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D45328BFAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0D085654;
	Thu,  1 Feb 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQvSp7Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD212880D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819008; cv=none; b=pvJ6U1EmeoS3tRZbW61nUjsXTqjvQ9czpwocV5PO5eM1B8jNTCc4Tr+7+7f59tpqOct7so1ok4w8nSj8lNvDkduf7gXw44a3KvyIPdO/KJrS1QOWOuJxEBO2HuNp0jC/W81TidChSHX0S0Depm3Szrr2YPh4GbGjN0BLJxveOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819008; c=relaxed/simple;
	bh=Ul+NGisJHiIjILztE+udTNbfja29Xn6UZg3lAr3kDHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdmfby0Vwm535ikZpKvUvdEW1rUYdDxTRgFHETYNHmeU5bxdT8sr+ryFMSgVQnr69avTIYt08QpR0h12ylChAB5LxtZV5cnmy92D8xfb2wSwHR7f0cub3enuJ+++ffUsMlN8MFThHEybAWk2hdKdjSnwdIUxVuzJGwwEbk07SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQvSp7Ln; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ls73UDXLTul69kZxFyEUzYQs+IXMDVS27If7g9tm5jc=; b=qQvSp7Ln+qaGIdJxaR9LI10OeP
	6oou1d6bk/0uILyLl2LYkyoRg/3N2dPJNk49vrqLPDYmmsZUYT4Sw88zDj+uJQMaQ6WdWJBnxpKEc
	9LELpQ7SGEPUwTrpEGoXFbfJtoA3BZTHpH1aKXmd5XU1MxxxyiqZNGlxjupaCztSwCLWnwU+DExj6
	ST7YVH1azmB1elQdPv3I0z8SIf9gj3I4pLFKWiy+ZohAZM4kfhn6jL5Exfj250ljpUVEyJAIo6yEB
	NTDe/lxZ3r+hTJVL96uFvXBRq0z0D7Rl1L1eJvmI7z2jhKNbn18jWFujJGimspZNPKOOh9CJ3N9ys
	cs2OGBLA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVdag-0000000GjJx-3Ppq;
	Thu, 01 Feb 2024 20:23:18 +0000
Date: Thu, 1 Feb 2024 20:23:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rfc 4/9] mm: remove MIGRATE_SYNC_NO_COPY mode
Message-ID: <Zbv9tnv4Fs1XVTIh@casper.infradead.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-5-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070934.3717659-5-wangkefeng.wang@huawei.com>

On Mon, Jan 29, 2024 at 03:09:29PM +0800, Kefeng Wang wrote:
> Commit 2916ecc0f9d4 ("mm/migrate: new migrate mode MIGRATE_SYNC_NO_COPY")
> introduce a new MIGRATE_SYNC_NO_COPY mode to allow to offload the copy to
> a device DMA engine, which is only used __migrate_device_pages() to decide
> whether or not copy the old page, and the MIGRATE_SYNC_NO_COPY mode only
> set in hmm, as the MIGRATE_SYNC_NO_COPY set is removed by previous cleanup,
> it seems that we could remove the unnecessary MIGRATE_SYNC_NO_COPY.

Ah!  I didn't understand the point of what you were doing in the
previous patch.  Now it makes a lot more sense.  This is a big
improvement, thanks!

