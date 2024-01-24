Return-Path: <linux-fsdevel+bounces-8674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E554383A0E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FC31C2721B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D4CA7A;
	Wed, 24 Jan 2024 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lsOmmtX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B4C2D2;
	Wed, 24 Jan 2024 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072747; cv=none; b=BbuFsd0WDL+kV45Exvjj2e+M5OWRNplLe7jWAKKCS7MAmbXjM8Cb23AscQtio8cU9rvOD6pq+xQZyPGPl/BxDjXk70sLejuqT7w2Kfrf8LLb4QTTJw8nQlQfR6rGU24uLc7BxTtXWT9rZ0zqdYOyMklxrE/ZLaj0GzHaFrbu65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072747; c=relaxed/simple;
	bh=5Th9xUmUgDOCOzurmaMkvZIPb01LId0tFQT0gYufSx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeLoL48DjqsvzNVMyaRTGx84zJFe+cYDYwDLwDsTaap0vq243DcEcXZQEebjQu2/PXYboi6hWCHG82dUUlxU7jHrFKNZou6rhDOHJRV+vlOHeIMHHYQ6Dmt3YYq7BlZRkWBgZJpf0OS5s/QuuN2lx5wTIqmvQMgDXHSvHFxzySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lsOmmtX0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r3Fxs5lxURbCrXIwDfacnwpDa1k983FO+zqj1XxEYMk=; b=lsOmmtX0OrCAi+P2O5DAFUf1rD
	vVCxvEc8AV2asDCZvCCwj0Zj6H0qSzD1km9Dw3TglE3YkZgxBRmoMI8aXPWSQHcE/wzHJowDudK8s
	XmQaUblFz1tM9ULGTkZdIEqICvK5NqjGrlGdgXrmpODlRwTQRRoadMzT8I9pAntmQrNkCN3JlI/YY
	Yp72i9qV6kHTaOv+uMWvPP0xh9/z8zETcATIYR+3HeXa6eh3MqbhKYiWOQLm6HDjSPUoVVeiZhzxs
	HfVYdOpNrsYKDQn8WjbZlRl6CoDEvUXtAOxrADAHM2GFmH6LpO10jiWQz9+ol7SFTmfYxi+O/M/MD
	y6RTmL+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVSJ-00000005RyV-0tq7;
	Wed, 24 Jan 2024 05:05:43 +0000
Date: Wed, 24 Jan 2024 05:05:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZbCap4F41vKC1PcE@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-20-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> +config TARFS_FS
> +	tristate "TAR file system support"
> +	depends on RUST && BLOCK
> +	select BUFFER_HEAD

I didn't spot anywhere in this that actually uses buffer_heads.  Why
did you add this select?

