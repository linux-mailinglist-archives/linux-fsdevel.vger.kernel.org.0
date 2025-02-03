Return-Path: <linux-fsdevel+bounces-40576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7EA25515
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73D93A71DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F161FE47D;
	Mon,  3 Feb 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qbqxY0fj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE91FC0EA;
	Mon,  3 Feb 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573038; cv=none; b=tHVPc8k1wk6vsm+kvU+EE96Nu/c9Kw1tK+Jm8BrBSsJXmNc2u2wWalpd++ToeFYNHqSKbc51wAP8TkyakFnbTdaHh+L+SWxMp/fjxfM/P22t4isgz6UmIch/9+Tr0j6Km7JObeBBl7Zz+ribgw3iG2mEgqlVSlcvu2Y7rYKUXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573038; c=relaxed/simple;
	bh=SJgIaXOVMyKhCtZ5k3ogP4qNf4MgVQPKGRWgaNCYi48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTZUPK7Lnlp3D0DBIP46QLgwa2pcFmzehMcoSyhDRmjn4Y0zWXOlcarkGhEa+q4glqubjmT+YKUAkvdNR3epJW1AhOGMi3kVG0ogeL6PKvRlb9t2FGm9itXYMW99BrooWGHGoDGi+K02rSRNLaKrGjKhuUF0o0ws9LzMXEMfnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qbqxY0fj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nLBTGoyTXREWOm8+XpqdKdan9El1S9L8BTRgkHy3elg=; b=qbqxY0fjMAAncLy3nDByxKQSky
	IVfplr7a79B1wNDFd9X4YTLDFIH/2OQqkQ2cIvfnKoI1SjjRs6syrNRrtteHIO7Q1jv7w8aKkPAkL
	4cW6WW8Rq5Kj8J0T+RhPRWA3zJuG4KHV+t6kFQA9WA5nF1+O/4qsyiDZysdXaPkQ2Sc6pUDZ9xYs+
	sF8NB9Fv9htdDYYx1TobCv7q6eJVursYgwMTHl648OFYILyI7qRv94OoHziMclexcz6sNlmQ9YAFS
	GEQb8HTTW0a2dTL5DzQulEDaPZ1EXciXWXaSE4h4+5kes8u8bfg5zI7BcM9S4LoowseEFdyymjKqk
	4WH7pbGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tesGW-0000000EvP6-1mSl;
	Mon, 03 Feb 2025 08:57:12 +0000
Date: Mon, 3 Feb 2025 00:57:12 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6CE6GzkldcEGPSQ@infradead.org>
References: <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
 <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
 <Z6CA9sDUZ_nDj5LD@infradead.org>
 <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 07:21:08PM +1030, Qu Wenruo wrote:
> That always falling-back-to-buffered-IO sounds pretty good.
> (For NODATASUM inodes, we do not need to fallback though).

Yes, that's what I meant above.

> 
> The only concern is performance.
> I guess even for the uncached write it still involves some extra folio copy,
> thus not completely the same performance level of direct IO?

In general buffered I/O is going to be slower, but at least the uncached
mode will avoid the cache pollution.

> And always falling back (for inodes with datacsum) may also sound a little
> overkilled.
> If the program is properly coded, and no contents change halfway, we always
> pay the performance penalty but without really any extra benefit.

But you don't know that, and people have very different expectations for
"properly coded" :)  So I'd opt for the safe variant (copy) an allow an
opt-in for the faster but less safe variant (realy direct I/O without
copy with checksums).  And hopefully we can eventually find a version
that will bounce buffer when modifying pages that are in-flight for
direct I/O which would be safe and fast.


