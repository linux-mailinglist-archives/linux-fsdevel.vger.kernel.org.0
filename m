Return-Path: <linux-fsdevel+bounces-62852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C326BA2607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 06:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A23C56168B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAA26A087;
	Fri, 26 Sep 2025 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vsCJpF5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44315E56A;
	Fri, 26 Sep 2025 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860417; cv=none; b=Wse5uspih9rowDebwflEAm5dOMzD+6i5WUK43LSGmk96nDVM98io/a9caLrFCGNBUeOVtfpIl6VAsb2Lj50YC8Aj8CUUNZtRSYrW5CIiTsy1FejMmct/BTMFQbC9AOnbJZrvaVW9zI+2pPsdS4A7G5g6XH3H8yeYymTusrL16gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860417; c=relaxed/simple;
	bh=X4PdrDrFbkp3MFXXfAeb1dJWlDR6bD2MT+nhNYJQV2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEqnVQ9rMnwcSJRCsp1KQzGbqHp7LfqwQ8MRz9l+/fgdNayIJLR7ti1O9QVb+yV+rMnnmsnBnPc9qoB06dnRmtfFGVeqvAZs81VGFshRmgfUxr/TFDc0LMbXP5YaOiAfMHoa57bokPG22z7Ab/zM9PgHxx6o1ZkhQduqWFrz3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vsCJpF5R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uKfgiezRXF5XNoZ7aaruUUoqzHkPDnF4Fr4VoYlH+3U=; b=vsCJpF5RoLTqqUNqirx5TYXPEd
	evTBvklSA3T63VqASmfmJpLLrNsHTBscQR9s6lYDo334CcfAgXl8YJcC98Jlr0SUkFtj3Uo5WIV+7
	Umgsf4L2LQol1UjYA9axynZJx4loESFtorad/+oEJeHeAAtoifVgKLN29YNO913joAICB3POn24Af
	qU3Iaa6Kj26B5DgqDZMwt52RRfs/TtBaL8r+s5CBaJStkuoYuFvYynEAfOSTWgJzbyj0J/Snk6HQ3
	Uap2igPN9ZUh2hoCSpJVQfyHQhEEsGqwxMlZUUeA1aFHUJ9s+cEB+ukx+KPtde/2DCXk88QhRs822
	wZeoz+8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1zwN-0000000Ffmw-0eDn;
	Fri, 26 Sep 2025 04:20:15 +0000
Date: Thu, 25 Sep 2025 21:20:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Volker Lendecke <Volker.Lendecke@sernet.de>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Message-ID: <aNYUfyiVMaWtQ0V5@infradead.org>
References: <20250925151140.57548-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925151140.57548-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 25, 2025 at 11:11:40AM -0400, Chuck Lever wrote:
> +	if (request_mask & STATX_CASE_INFO) {
> +		stat->result_mask |= STATX_CASE_INFO;
> +		/* STATX_CASE_PRESERVING is cleared */
> +		stat->case_info = statx_case_ascii;

FAT is using code pages specified on the command line for it's case
insensitivity handling, which coverse much more than ASCISS.

> +/* Values stored in the low-order byte of .case_info */
> +enum {
> +	statx_case_sensitive = 0,
> +	statx_case_ascii,
> +	statx_case_utf8,
> +	statx_case_utf16,
> +};

What are these supposed to mean?  ASCII, utf8 and utf16 are all
encodings and not case folding algorithms.  While the folding is obvious
for ASCII, it is not for unicode and there are all kinds of different
variants.  Also I don't know of any file systems using utf16 encoding
and even if it did, it would interact with the VFS and nfsd using
utf8.  Note that the 16-bit ucs-2 encoding used by windows file systems
is a different things than unicode encodings like utf16.


