Return-Path: <linux-fsdevel+bounces-55447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44DB0A8DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523EB1C84291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A92EA486;
	Fri, 18 Jul 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rBc4oqcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07E2E8E12;
	Fri, 18 Jul 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857086; cv=none; b=OXy6ckaNX2B/6csYjxXX0rKAvwIRPS1WqnnSq1NK4T+bt46MJbaUAtVuJzTxXwlCbQqjCmMjPRo5MhVfDDspNYnBrttJq00l7LHMZR1mgX6+8itvY+TEUT16c6Saw8RuUL/8kPECzywSx4B9E4oWnfucitthY66f+pRTc3pJWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857086; c=relaxed/simple;
	bh=j2UJ9FOO66mq/xih2emKqjIh6oJ0U5eMySQykubT36I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqC1Evh4WYDeSK5tagsGznK40VeHmWu9oq5T49xzgyOKByVx80khRcQk8/hsufbwkhl6GMPGDNhEheE0+M+sMlT2IycipLhRemOOZ3AwRmAhfZgWVot3Yd90RVa54KPDXxJE2EJwuevd7V9Dyiru9g9UBE2ZMp5suTu+MKn8ULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rBc4oqcI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=+0KHRWq6i37ZM7MezYdHPmtRz/2NspRTQD/ZZBbyTv0=; b=rBc4oqcIYo5r0vfEnlB/XqXlky
	M5UHceSwD77kirjCboTRNk2dVrD7IF8NF7+QQfNFgzIn2Twsc97+JsVC0ORwNG18ssxg8d19OzjUE
	ARligVVJNckW8nH/IQRvSwmhuIP+H02qICEJzIIIx5tLpLFvupfRA1/tIq1Z58HfavsxSe23bqkaP
	9BwDhmBxba/wJsS7ZJKvwRFahWhorfM65kduv+yaTCMOWmAkKDCH1CojtBfk4tXMuidgo2sdPfmDj
	pBCxg/jBoDJwbRtBH8f6SVeSnkV/4n8eo5x5jsJgnVr7I79QlszalVck1qgUqv5560DI8nMnkoECu
	M0Wer/bg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucoBw-0000000CMH5-3Ggd;
	Fri, 18 Jul 2025 16:44:12 +0000
Date: Fri, 18 Jul 2025 17:44:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250718164412.GD2580412@ZenIV>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
 <20250717-kunit-kselftests-v5-6-442b711cde2e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717-kunit-kselftests-v5-6-442b711cde2e@linutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 17, 2025 at 10:48:08AM +0200, Thomas Weiﬂschuh wrote:
> The KUnit UAPI infrastructure starts userspace processes.
> As it should be able to be built as a module, export the necessary symbols.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

No.  This is just plain wrong.  This is way too low-level; teach kernel/umh.c
to provide what you need, but do *not* add more kernel_execve() callers.
And the situation with ramfs needs cleaning up, but "export put_filesystem()"
is not a solution.

