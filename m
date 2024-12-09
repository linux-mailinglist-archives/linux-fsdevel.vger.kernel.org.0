Return-Path: <linux-fsdevel+bounces-36801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63819E97B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B285188287F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E4F1B041C;
	Mon,  9 Dec 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wKzci/M0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E01A238E;
	Mon,  9 Dec 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752019; cv=none; b=B/0WHGxxcMY3KYCxQOlIdXIU/VlQ6FLVtwq5wDbIPkTkTmQXD9qS1m0ruRpcJb4f19N9exHhAcpZPcGm/4teJ3OGyyN52DwLL+ykIi1gjt5CcxEJTQQDIUIcBqHUV47sj0Mcl9bxrTMXdw/FXr5cqZjXt7X5BSKLseP4gmcKqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752019; c=relaxed/simple;
	bh=7YMcql3307lL7mtzM9GeKeg6x8rr1woEKBhM4L9q1YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJOhfmibDoOYeUuuF4eINXd5JtZZ2mkDKSMoN+l1pG1sszoH733hAjTH9oGSUqZVN2ILkcDTvxK9qaP8Tdjy0HLgFnREhycUcB0u+eVgsUhxdxQDnxVii6DBDpmWRex/H9H0XQz+fjVayk08gwDJeJo/26GqGpkftzsiZh/2IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wKzci/M0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w43T1I6/sKwJscxNGbfJG/M/ns6oG3NjgCwcsgsn5ec=; b=wKzci/M0+tJjPJMVBnZLPgTW6a
	gQ0H2/IbEZgQ212cFKxiI67Ey3pi4lT7duv3vIwB2y04YsEr92pdfx0aWKdU/4yVmOaqIFcpGH9Is
	EjIxHi64qjRFHLWwuCN5auy0pEWLWC+owNk1M+sCEg6d9tN3+CBnkshw+Q1lW6L/tHv/5SGJqXS4e
	zLwswz4JzBakMqKXAutVpypips45STjMrkTaTHpSmMVPuenOe3ZPca/u3u/7sFNvRY0Kf1TzRli1q
	cYqXnnOJBFkt8sAKVhLMp9H3ygZCfGRLtHe25KSjCx+n4dBlAajd1XZDTR7sBaSTOOq2hFU8Q6GRS
	nnV26qqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKe6C-000000083to-3T6r;
	Mon, 09 Dec 2024 13:46:56 +0000
Date: Mon, 9 Dec 2024 05:46:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <Z1b00KG2O6YMuh_r@infradead.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> To be clear, exporting pidfs or internal shmem via an anonymous fd is
> probably not possible with existing userspace tools, but with all the new
> mount_fd and magic link apis, I can never be sure what can be made possible
> to achieve when the user holds an anonymous fd.
> 
> The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
> was that when kernfs/cgroups was added exportfs support with commit
> aa8188253474 ("kernfs: add exportfs operations"), there was no intention
> to export cgroupfs over nfs, only local to uses, but that was never enforced,
> so we thought it would be good to add this restriction and backport it to
> stable kernels.

Can you please explain what the problem with exporting these file
systems over NFS is?  Yes, it's not going to be very useful.  But what
is actually problematic about it?  Any why is it not problematic with
a userland nfs server?  We really need to settle that argumet before
deciding a flag name or polarity.


