Return-Path: <linux-fsdevel+bounces-30055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E2985730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592921F24335
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A4188582;
	Wed, 25 Sep 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7cRb2uC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603B1B85DD;
	Wed, 25 Sep 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260283; cv=none; b=nfc4wc6jusYYWSIqxluPaIbY6RXjQWlzjy0hYpcwZpaU9/2xz+KkoodRMcpJ3BsEj/HG+2qasEgbaeMtXeDQxE02u35wZ5W9DiGgvX9zKKvNwcWfuk0wrzl1vv6DGNCc+jGHktgOC7azptWEJX71H6QMkFyRBL2MKa8Sr4d6BSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260283; c=relaxed/simple;
	bh=azYpPCRc7Fpbb2pqhBjEq/yVygWme8hOTL1tIFJNaK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt2AKogIar5jOr1OJCNZXSy/61CZ+eSf7FaDCbOpOXdQFaGgl+HylawSxWryNCzzj/OZv5+pfQTnZRXocpdMpdvezv/0f6aVVhfQJpbDZTlppqcQO9LwzYoGc+E+6jDUccNkpBsyvF20yPeWeWSxIvsJTd2ncMCwDibjWWb7v/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7cRb2uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D09AC4CEC3;
	Wed, 25 Sep 2024 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727260282;
	bh=azYpPCRc7Fpbb2pqhBjEq/yVygWme8hOTL1tIFJNaK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7cRb2uCSSGYlrTYOMEkLkLJVOvOsQCMhJxNZE4VBoyjE7Gq9o6SrUMyXirimlK0E
	 McSps++Q2aGwn4KdkOIuSMCsy3CbLPaeiyfRhm/l01iDsfhIhlIPhnbfFUZFeYGsKJ
	 aKZKMFqtRCSipuRw/1WbpImuw9tKxoyA/LAiu+FUsU6K+65c0JDfa5Bwd2UnBcyd5j
	 3QnFPplvGm09sqRiYq5x5mC5kji/QEtY0ec6n7UoL2uLBp6C8Iy2TEB0wSIVUkMeVP
	 uy1dTuxxY8VG6XbzT6GVhe1lO/x4nUkht3sJu2EhRJWrPe4wYn0i5oqac34vFn3Rad
	 ktd405WzhKKSA==
Date: Wed, 25 Sep 2024 13:31:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
	hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
	smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240925103118.GE967758@unreal>
References: <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>

On Tue, Sep 24, 2024 at 05:01:13PM -0700, Eduard Zingerman wrote:
> On Wed, 2024-09-25 at 00:20 +0100, David Howells wrote:
> > Could you try the attached?  It may help, though this fixes a bug in the
> > write-side, not the read-side.
> >
> 
> Hi David,
> 
> I tried this patch on top of bpf-next but behaviour seems unchanged,
> dmesg is at [1].
> 
> [1] https://gist.github.com/eddyz87/ce45f90453980af6a5fadeb652e109f3


BTW, I'm hitting the same issue over Linus's tree now, but unfortunately
there is no WA in my case as I don't have "cache=mmap" in rootflags.
https://lore.kernel.org/all/20240924094809.GA1182241@unreal/#t

It came to Linus with Christian Brauner's pull request.
https://lore.kernel.org/all/20240913-vfs-netfs-39ef6f974061@brauner/

Thanks

> 
> Thanks,
> Eduard
> 
> [...]
> 
> 

