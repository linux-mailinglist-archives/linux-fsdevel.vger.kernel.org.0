Return-Path: <linux-fsdevel+bounces-19632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D185C8C7F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 03:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F190282DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B51854;
	Fri, 17 May 2024 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VX9NvMkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8817D2;
	Fri, 17 May 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909225; cv=none; b=FUikKiX5Ju5yWf3qYfOcnZuNs9tyT8Fng4bnSaDV6WacbGQUJ5J+p6ZwguYz0Y9JVSoBpAngrdIwiRgQqBmusj6hoU7NtSWc3+knKSL6Q6oHq38Rf7gHexm7884S4ls7yuG3OtW8sHHn7yzNjbBgjQsNMsBTb0U/tcHYjJHFFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909225; c=relaxed/simple;
	bh=ci2vKGYJPkUX5heEMris7S868/NN3z7NYkLJCN0lrYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+uhBMdvnYaQc7//7Wk76DIeu8yrb9wknTGKJ1KlNmznGA1ZTXWaZ1+T9uAR9w7b7vUQci+/0oNe9YwjPA+LVau1OkD2D6zWfKhZWN7evjNFzvYSyoQ9aWqowVGF/50hp8R5/mG8xLS5qY5To8jaF5PCxGcmSviP+IYHrZbwZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VX9NvMkO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kdToEKd/rzCQk35x9OVJLQQsAOBHBkPUX9V4xj54vVo=; b=VX9NvMkOl/J6GUN8DUit3GIplH
	x6WZog9uIBbJ2XpWOLJnpePQzNcYB3nWqHxPnnMwPpPA7bU/RSMXSpIpOkEDIUDzRqrqFGIU5kY0L
	snktPKMO8EzTIicEdxEpMdhjz+TEIDk8hU+cUni37PoOnI78YpZiZ2G2FRswcYqkY2j/irsLT7Z7K
	XwMW5wClkEmUgAFcCZKIVlhNQRjOG4VV6c9E6P25cJBDm+RNtjFGgapE7SmPUbe5RWnSr8P46aJ52
	LZzBruBsu5t27Ix+QEscMyuHerdhGcarAdiTlcHCwsZ+TZkOOfrjXnRqN1/Vixz9xapu67Y1f/DK1
	QfcxISjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s7mMx-008cYd-0U;
	Fri, 17 May 2024 01:26:47 +0000
Date: Fri, 17 May 2024 02:26:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <20240517012647.GN2118490@ZenIV>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
 <ZkavMgtP2IQFGCoQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkavMgtP2IQFGCoQ@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 17, 2024 at 02:13:22AM +0100, Matthew Wilcox wrote:
> On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > When running syzkaller with the newly reintroduced signed integer
> > overflow sanitizer we encounter this report:
> 
> why do you keep saying it's unintentional?  it's clearly intended.

Because they are short on actual bugs to be found by their tooling
and attempt to inflate the sound/noise rate; therefore, every time
when overflow _IS_ handled correctly, it must have been an accident -
we couldn't have possibly done the analysis correctly.  And if somebody
insists that they _are_ capable of basic math, they must be dishonest.
So... "unintentional" it's going to be.

<southpark> Math is hard, mmkay?  </southpark>

Al, more than slightly annoyed by that aspect of the entire thing...

