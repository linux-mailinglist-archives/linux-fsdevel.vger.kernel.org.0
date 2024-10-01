Return-Path: <linux-fsdevel+bounces-30493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8598BBEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A60A1F22AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A31C233E;
	Tue,  1 Oct 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lOuPq+W6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21531A00D1;
	Tue,  1 Oct 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785127; cv=none; b=MSeaex3Ta7BNEUm8hysLYV8AOnLXaU2sZDTfv8Z2UZfzLCO9wDbHoytdN5CMgoL13GyohCBPqlSiY+V0hBgLvSlBerjMqrksdcdsyfyvYntmHTKXrFDobwL86NitClkWpCQIEjlrydyOfBm6ihgVZHYhrh735EG/GvKiRdlKqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785127; c=relaxed/simple;
	bh=riO2jT8o+ij7TwxJY4+OVu/vj7GB95NJdLYYzv1iHS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2RorsiKEGtfWHRbwjZo7e6G0bIEZNo4FtFOGPsTX6xzlIXfxYg6qWh7XFNmoYU+3KeeK5KZ1r1T+cwEReirQHcEnBTob3jnLAU2MCR7EjlJSusORpkWYBAZA5zAqc35wvWqg7A+CO5Bp/+9I//izjEw8yo2Bq3sKGm2XkUfO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lOuPq+W6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cmmwHHoBxYqtL+q1QFqizof9cw/O9Pm4OMGlQQ2390k=; b=lOuPq+W6fKa2W6FTum9KllTNUJ
	bT2nPfRWpzl4xg0eGWICDxz+AwLXzQmBi9iPsN++dfmNsCHDiqiucvHp51jKzWFE67xqiHnt7lzUR
	Jf1Np65gW+PSSm7N5Vreb9RK59p8nmlKt9OKdj6z9bklbukJqJyF5tPMDnN+ym3bABEwvB6xbD/hS
	vG83bwBbMZnne2AuN6iF9ANGWAQSVNXh1f2ZHgoeQhckL0J3hI/EmJACBYmdwiblfUq3DBclyZIXx
	3tw3HI6hGZimOSi3lkd0MIsw1leFNodu+WWgqt/aiBmpZhOczxB9UrxVGZM7R8zU9yx0Rl8SrFSQ+
	Pu9EUQBA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svbps-00000002OCa-2POs;
	Tue, 01 Oct 2024 12:18:36 +0000
Date: Tue, 1 Oct 2024 13:18:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: yangerkun <yangerkun@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?Q?Ma=C5=82ysa?= <varqox@gmail.com>
Subject: Re: [regression] getdents() does not list entries created after
 opening the directory
Message-ID: <ZvvonHPqrAqSHhgV@casper.infradead.org>
References: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>

On Tue, Oct 01, 2024 at 01:29:09PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > 	DIR* dir = opendir("/tmp/dirent-problems-test-dir");
> > 
> > 	fd = creat("/tmp/dirent-problems-test-dir/after", 0644);

"If a file is removed from or added to the directory after the most
recent call to opendir() or rewinddir(), whether a subsequent call to
readdir() returns an entry for that file is unspecified."

https://pubs.opengroup.org/onlinepubs/007904975/functions/readdir.html

That said, if there's an easy fix here, it'd be a nice improvement to
QoI to do it, but the test-case as written is incorrect.


