Return-Path: <linux-fsdevel+bounces-60713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF9B5040F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FA41C83585
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5231D39B;
	Tue,  9 Sep 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="unIJxWPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063231D36B;
	Tue,  9 Sep 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437687; cv=none; b=hS+HoZ9C17oaoZiWVJOmq84U8hWvBPuuYzBtwimFfLdku2gJ/GDPqf+sx5AI13GQzflyS80zK7Zou63sNQmfeSYPoVj6b3/jNnlAWuHewgFTW3r0gpiNngJY+BNEgimx55hJhxliB6rbhNQymNc9Mx4rrp0DVq5naoxXWFAiO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437687; c=relaxed/simple;
	bh=ZJSAZHuicoq2bC1w243q+SO3yx70v+uNLml3bxVYWQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG9GjCyGhzA3g/Z1PBi4iJKZBTvVa3q6IiuFqIFCX+YuQe6oQpTYoS0hSZq+qc69I59PcL99RyvaRUYYeXSRgLdPAOgI8IkYKyObi+adfcCpovCaj6YOVBZLRNqByZV2NnBwh0LL/e9FsyZX5CXq8Zn03yjilCeaEUMLCd03gLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=unIJxWPZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJSAZHuicoq2bC1w243q+SO3yx70v+uNLml3bxVYWQY=; b=unIJxWPZS9qiT4M1jtOz3vw1h0
	mJkrp1LILYc/hxb8eoGs78xq2aIYfUQRmpU+EEcJv0I6tJbcKm46tNTZpopK1xRUswiJNmeYJiAXt
	45x7K3NQxy4qT2I5BeWfqzU5Wgy50pxtFaqzXYJBk9In2bZ9+cjxGZxXTfrOGdK7FYQPiwC51fB7m
	WnbVpEaJ0tzihRWgj8UYHqY8pJbTPZaUCx0MxSxuQNNXNtk3LpNSDmyjmGLJ8qw8fqdmqcNTA4mBs
	1xszQvg7SnOkEFNO2LclplSZCf8VpnF6ms1d8n/OvRr4VuB6kGKL81yrk+XHFAmGDCmVAUSYkDZEj
	O/qg/4hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1p2-00000005rI3-3Fgp;
	Tue, 09 Sep 2025 17:08:01 +0000
Date: Tue, 9 Sep 2025 18:08:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH RESEND] fs/namespace: describe @pinned parameter in
 do_lock_mount()
Message-ID: <20250909170800.GO31600@ZenIV>
References: <20250909165744.8111-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909165744.8111-1-suchitkarunakaran@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 09, 2025 at 10:27:44PM +0530, Suchit Karunakaran wrote:
> Add a description for the @pinned parameter in do_lock_mount() to suppress
> a compiler warning. No functional changes

This is the least of problems with that comment, really - or calling
conventions it tries to describe.

Check linux-next, it's rewritten there.

