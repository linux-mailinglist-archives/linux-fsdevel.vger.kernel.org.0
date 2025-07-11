Return-Path: <linux-fsdevel+bounces-54666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FDB020C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2056AB453BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC732ED86E;
	Fri, 11 Jul 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MjOn9wTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CD2ED85D;
	Fri, 11 Jul 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248669; cv=none; b=DpkCy6CR3KP05VEKsH8t/GINAMyuzuUAK3XRY6cfPB3OzS8GEht34byTZnN3TJPEygN/iKsbLGmw3gPlqaM1ZkZf4Z4EC0NHnfg2YqArR2awY8Ko6fSWBqPXQF1Xz/H31fr5uVwTPjfH6LMI+gMKas+gusiF8lBwXuQd6vlJ3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248669; c=relaxed/simple;
	bh=4wLd3qXMcVR/rKQcfGIxYV2jfHi6HY3xdIDh71H99mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aidg4Lk1Yh708Lb+ZTD1XRzYQyB28D5NBLMQgLShvdRM1j8epq5l1jB+W01R1gSon3ByHlDyQAchrzMkX697QjqfWy//b+viIXurzqNffn8zk/TusRGOnrFIL13XCwqUPTrQ+xiit2Z/CoZ20u+WqOOxa0gbtuqHx+KhQ8x29uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MjOn9wTd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=4sp96fAx8brrNBKQIi3t0E9PlnzlKfIPS+tdQ+PkDKg=; b=MjOn9wTdnBMzZtyHIJCDiCPkoD
	BcTkob9i+TaCF1jCnl/E4RtIWxYx/9s3rRyqiXrJC6lpKlPtB/gEBM1iFXMmlzPUwMkdJwXABBa0D
	ylFY4leQ9wUMlLHct5ZslO/hsh5KYA9qNebx2ajiXp8CfjwpFW6uQnu0HzOSTggoJhNWnQREsGT3N
	q2niR8ug/VNZS9OJs5lDV6WFESEanstNcAUQVsV8wDvZs5gj2mwK8OQmgC2nOkk+VEDrRvpSdUQd5
	6dVzxWXqvOzE1Ih/f3Rs1Ym/O0rB6JitEg+Et3DrDMdn61KCOd9A1dE3PqOAJvsLolTPNNAhICf1U
	5N1NPk0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaFvD-000000008qY-0v7g;
	Fri, 11 Jul 2025 15:44:23 +0000
Date: Fri, 11 Jul 2025 16:44:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250711154423.GW1880847@ZenIV>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> Hi Kees, Al, Christian and Honza,
> 
> On Thu, Jun 26, 2025 at 08:10:14AM +0200, Thomas Weißschuh wrote:
> > The KUnit UAPI infrastructure starts userspace processes.
> > As it should be able to be built as a module, export the necessary symbols.

What's wrong with kernel/umh.c?

> could you take a look at these new symbol exports?

> > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");

What's that one for???

