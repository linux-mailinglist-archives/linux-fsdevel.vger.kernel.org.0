Return-Path: <linux-fsdevel+bounces-39062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D615A0BD1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A9718881DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898320F086;
	Mon, 13 Jan 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwRJWEpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AF20F074;
	Mon, 13 Jan 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785151; cv=none; b=tQznz/Pg9HpomcT77QAjHD4h3dLBej/Qrcyh/mwngjTdbu1uggJRbUq8csXWO6ges8UQfhPLwpT0SCVV86TPS9t/FZXjcGdCZkEaYX+xyJkCz4qlQWuJKL/AffND0kGOLos8nfXD5DbfaccvsswVI+vY6d3a7DGZjW8u87aZ+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785151; c=relaxed/simple;
	bh=fK4gYsfCgj6ZVqwAWuXwpzOO1+7z8dY9SS6OtakC7N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+JPPDtt5kKMvbqBlWn3Kb+OJ7JanedJJf5qoz23puymLvztE2PzMlOjew1C0kKXNGZq9JfU/dzbJrl0DC5UP1UHQaOaGu18TECaZWj4IGu91iJUFO3thKD+1Boy8OeiH9xnjB0flzV1v5x4sKYIvcs26LnI6woifGWgTeIcZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NwRJWEpV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZiUejJ8E2BuzaoeknAu7S+rZ0cnnspza4Teuenya/Js=; b=NwRJWEpVAYL4IXcn7z5th2yY0z
	5t7g9QVAmgPdHPPJRujmeLx0mt3x4b4kYp088b9z4gXAcDCG5lqfF28LQL0zFLNsB7zx6u4066wUv
	vcCe9KTMroHIQT0EvXjUbKDJwAKNl2yKbr7Wjt1x7YeuAYXFmfwmI1IP5ALZ2LkPjx9BYaFieiKOc
	nDydHaTR/es6zbATuxzxkbRJ82RITbPnqrSCZzD7MpLh3C1hxMN585ObLotLQ1aYTOh0FNwKBUmxw
	6v6CC2yW4tAG2M7tdtD/gwWxrYM1IG9ZUMoUZ74dnNgQ3/FgEq2hfxZ/o4f1k5CbThRst8ACzAkWq
	Xs6gAE3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXN9Z-000000013dv-2Je2;
	Mon, 13 Jan 2025 16:19:01 +0000
Date: Mon, 13 Jan 2025 16:19:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, jack@suse.cz,
	jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk,
	christian.brauner@ubuntu.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <Z4U89Wfyaz2fLbCt@casper.infradead.org>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <20250113-herzhaft-desolat-e4d191b82bdf@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-herzhaft-desolat-e4d191b82bdf@brauner>

On Mon, Jan 13, 2025 at 03:38:57PM +0100, Christian Brauner wrote:
> On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> > Hello,
> > 
> > When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> > was triggered.
> 
> I think we need to come to an agreement at LSFMM or somewhere else that
> we will by default ingore but reports from non-syzbot fuzzers. Because
> we're all wasting time on them.

I think it needs to be broader than that to also include "AI generated
bug reports" (while not excluding AI-translated bug reports); see

https://daniel.haxx.se/blog/2024/01/02/the-i-in-llm-stands-for-intelligence/

so really, any "automated bug report" system is out of bounds unless
previously arranged with the developers who it's supposed to be helping.
We need to write that down somewhere in Documentation/process/ so we
can point misguided people at it.

We should also talk about how some parts of the kernel are basically
unmaintained and unused, and that automated testing should be focused
on parts of the kernel that are actually used.  A report about being
able to crash a stock configuration of ext4 is more useful than being
able to crash an unusual configuration of ufs.

Distinguishing between warnings, BUG()s and actual crashes would also
be a useful thing to put in this document.

