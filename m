Return-Path: <linux-fsdevel+bounces-18918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B18BE860
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD861C243CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139C016ABC7;
	Tue,  7 May 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuuOPfON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25316190C;
	Tue,  7 May 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098215; cv=none; b=kvNnWyM1eef4RGQpddKMHWad9In1hWIvCT+Rd5y2qug1zoUAnsS8Sg1YdUhAA8g6k6heP9u3epE3AdJf27XAkH+jEnJYQKD+dLwfRRnl8/c1If9HkJTjPhL817d0ivxIQJcwEtRd59bL2y+AwFKkh0MUdjotSHoZb4hXIA2AZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098215; c=relaxed/simple;
	bh=hLYDsltQ05H/znVafLWvttCroONJlwnxpfgRlA4/7dE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfCNMrazb0v1o1Z8IT/f1h7KyGgwoNMWFtSp17lmUhlZUkAmHGqEZC3Z3q8VKEABXLIY88q5lU8F2r0RqbUQTFYPp0Wwgnb/MyxuundIp6kPFB8FfBKyQJtT9EAX5UFHbw7ZsOTfLcVVsRoDdUrwKQq75/A5umDkz11+wPoMOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OuuOPfON; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OQpEMexH/p2b9fJXVGlJcO2qUX+tniwQulgfe9+fwbI=; b=OuuOPfONiiYumwTnE5/zujKkHi
	BE1/QvlMdMfKtOcI6i5zaX2JPJYRKZiSlhCvByFTWVrt6Uz6aDkvsnXyVqxGn9aMfUxQcRSf4Tfxl
	vIfKEJq6pV0SM7+7pnEtsgb1l/LNbeXFk4I+mehFe08Ok6n2ERMiTQEa3lclxAAy8bMTGgz2/H4NY
	P/KDOsT1pH3yaBIV7nGdBitco0MAvoMyfh1X5Y4MCrwlA++Bs9TLSfhkpR1k3vxdKMotYVaeRD70B
	ZlTz3Vaeu+gvOa75EKuSylwmeu96iqqnuCLX4jM5HNFFCOY5wO6NxwDa5YkbquUfuP3FXhTVJYw75
	I5QvvvMA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NOM-0000000Da2A-0aym;
	Tue, 07 May 2024 16:10:10 +0000
Date: Tue, 7 May 2024 17:10:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <ZjpSYmgNdmIAF9su@casper.infradead.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
 <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>

On Tue, May 07, 2024 at 11:48:44AM -0400, Liam R. Howlett wrote:
> .. Adding Suren & Willy to the Cc

I've been staying out of this disaster.  i thought steven rostedt was
going to do all of this in the kernel anyway.  wasn't thre a session on
that at lsfmm in vancouver last year?

