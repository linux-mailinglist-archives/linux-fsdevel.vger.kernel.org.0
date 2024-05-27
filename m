Return-Path: <linux-fsdevel+bounces-20222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37828CFEBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435B21F22635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978CF13C3E7;
	Mon, 27 May 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPwvttZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810750263;
	Mon, 27 May 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808828; cv=none; b=ZH1vsdAEkn+GuITigPMUe8RqwS7q8/Mj/0Db4WXvsX3rCA0Qd4BRPX0HvCvkSZaE+qxX00+5OpAMajQnBsgFQ4WIurJk36Yqw998yM/WyY0u5dKIS4JLgxwubLkM+zAZiB7eyvb7d0A6EW1Ojlp/qvVJ+JKL109mhYFQUHpMmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808828; c=relaxed/simple;
	bh=C4ig7pnNrD9KcVWPBjfpkf9cRRDu3PvbceAHNo/SBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWzuUyJvIIIA5n17S1nG2QQJFi3JSOXxS/MJsim5VvZJw1Jj/74Ex3edZXohI0kWjy5v5r8PzcJwauzJc4tsiBzifgvPZWvLkfRTYdTY3wkGysBOMje74PdzztpmVwSRPJTDyQyCeGrPJHcNtcYdNPUT3ZINQW5COth3Z6MDaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NPwvttZ8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C4ig7pnNrD9KcVWPBjfpkf9cRRDu3PvbceAHNo/SBOI=; b=NPwvttZ8eDpxEUbhRJDhlBIIBj
	V0yGbg0E4vxxLEbKCrQIeZKct0O9VJSECzafm7cOIsXdmiFvVuAy6+gGGwxLqbXpfZ+XMLgJSl7Xh
	xN2klJWVa2G9F7khhGESraR+33z9l2hSfSPDvv4yqJzsF8oEPOyFowQ2QJW/bk9nufw5vGkFIxtdP
	0aEctTtYreiUqTv7lWDBIrgdoNfLxsmNcYi+obl7Q8Z6YMOtY6z3FgJ3YuV9jRP6pz9K95BgZi6On
	eYdoHr+QAaNweRPrx3j0IDHLQEBnDA1eIHkIJN6V5AJYkxAhynxLXHP+Pp9eX5xGNV1UEC8dGpkH3
	Ya7DCiig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYOu-0000000Egcm-1G5Q;
	Mon, 27 May 2024 11:20:24 +0000
Date: Mon, 27 May 2024 04:20:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Message-ID: <ZlRseMV1HgI4zXNJ@infradead.org>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <Zk+c532nfSCcjx+u@duo.ucw.cz>
 <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 11:06:11AM +0000, Sukrit.Bhatnagar@sony.com wrote:
> We can pass the starting physical block offset of a swapfile into
> /sys/power/resume_offset, and hibernate can directly read/write
> into it using the swap extents information created by iomap during
> swapon. On resume, the kernel would read this offset value from
> the commandline parameters, and then access the swapfile.

Reading a physical address from userspace is not a proper interface.
What is this code even trying to do with it?


