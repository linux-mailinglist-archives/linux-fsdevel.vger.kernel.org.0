Return-Path: <linux-fsdevel+bounces-20893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E08FA9EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289991F217DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AB13DBA4;
	Tue,  4 Jun 2024 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EkwUzVRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF877C6D5;
	Tue,  4 Jun 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478547; cv=none; b=U+cXNIyQrJ9GdkXIwMVcvuQuPB7OIhXz33vbqwYRb90UNs4UHbcacTCErpFdHvvDEmY7/das18PcmjA0qy5YXCo4uzNoX+e7hIhC4sX5fAYQ9oN83gjbcHtVoPDCZ7mjnT5TGtYmCavLHJ/k4ItptX6NMj3Ajw3GtLHVXz9To9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478547; c=relaxed/simple;
	bh=mr8J9SWdsAEvT+DfxSemt3ZV6Jo5MqmVNgY1EU4+3qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIVNi5uvan8yZZ2WFblYXseVIrsap3E+Rkib993mOI7OG7zdhgYKcV/63ejctyel4+ELcjplZhD+tAhZ5O2dZ5dZvAfEb47ZFKK9vRkwT5cPCNxoH17OmNeUDiKXVe+Zb+7sFryV5nglu2F0w0hPFN51NVJ0tdwlEnzqSFx8PHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EkwUzVRb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1mOyWxoB94x5TWgcP2yO2aQH6LrzarpsrO8qe7Bl0N4=; b=EkwUzVRbUjCUAryPsum/6jNKfP
	TzkL+n4jlvpRo+Q4sJaGt3s8z75bqjCl/ri13WcRaHciG43y+4zdbvFeeaku4FC3bKtquzL8gW+92
	EB1XPbfDarMHN2xuINhmSd4ljpIr0PCxOCRsIb0tOz10zwBHg58IYV9cQbsJvGZQP6QrMYwn9FXoU
	FPwMf6lifDua5cGX/WBqWXijWnzN+HMnGR5Y2nC/QD1EGA0YREYy2gp0q8Lb7yaxfpb/729GRToj9
	j47jKSZsOWTEw1XEas+B5hk5Tus1v4/+TPBfLxBodrN6QZjWOXYXsb7vO0KSLFJg2D99kmacsc3m7
	E/1jURLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEMco-00000001GJE-30tG;
	Tue, 04 Jun 2024 05:22:22 +0000
Date: Mon, 3 Jun 2024 22:22:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <Zl6kjsiGl0pm-p-o@infradead.org>
References: <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
 <20240529.013815-fishy.value.nervous.brutes-FzobWXrzoo2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529.013815-fishy.value.nervous.brutes-FzobWXrzoo2@cyphar.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 01, 2024 at 01:12:31AM -0700, Aleksa Sarai wrote:
> Not to mention that providing a mount fd is what allows for extensions
> like Christian's proposed method of allowing restricted forms of
> open_by_handle_at() to be used by unprivileged users.

As mentioned there I find the concept of an unprivileged
open_by_handle_at extremely questionable as it trivially gives access to
any inode on the file systems.

> If file handles really are going to end up being the "correct" mechanism
> of referencing inodes by userspace,

They aren't.

> then future API designs really need
> to stop assuming that the user is capable(CAP_DAC_READ_SEARCH).

There is no way to support open by handle for unprivileged users.  The
concept of an inode number based file handle simply does not work for
that at all.


