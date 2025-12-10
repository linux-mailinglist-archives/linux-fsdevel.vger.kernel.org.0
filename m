Return-Path: <linux-fsdevel+bounces-71054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D76BFCB3093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B712F30052D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC32325498;
	Wed, 10 Dec 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YGs52B8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804645948;
	Wed, 10 Dec 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373656; cv=none; b=Fm6ckSZVSRLjZtvQtaU/Sc2nkDY7rFsuchQiTJ/Z7toqcH34lFOQPaZi9fdKYAQn40kTWmCXqFdVF37FZ/Jvk2ML9vbtCsFZt/T3n+kVSFyWTUBkbE68/nw8u6lnmUfid0V6NiKxF+dKUimSnihIUkc7Vb3vY1JZ4vWvWzXuM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373656; c=relaxed/simple;
	bh=9In1NsxkWtLDv8pCbfUEj22suatG6WoAPTQDneAYSyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKmjs/TzKFhZTuxa8QLvnPyDQT+8yK44qbqxoU/O8vsF1EL2h3aE/6K1rgsMcqSRsbeP2FCNjR6tv7/TjY9M/brRU8hiSsDxfLwn8TiCupgpJijWTszPuRIxPCoQFnsayfeZeoOWXl2g3AUkXXRS2z/rDNI0aMOZFtjHQOTKzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=YGs52B8O; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=z4rVeB5KmFkVF4IbrkNZFDmV4plSREzVqZi6Tlz/vg8=; b=YGs52B8OHsW81numTFHU9CjSDV
	AdfGeQ/ZQTpJxiG9wonOez26enUqmRrBUdSFpeZIB84N6kEkX9fxuHfVbZ/p2uXBL6STo1bmwtvVJ
	o0L1sJqVu7xAd3ZXBExjKRHSvo7Vh3K8t8JJ3hUgETzZJVhQyKwi5bDwek31PDG922WYwipfF/0xy
	hiQpuIXzw/vtn3W6U5to5KSc+RJSJ2xovbuIa7MDRQIkNpt/J7kKhQYkEna0MgWXP3Y0ZSNqx6iMI
	HvvuCKgtlj51x6mkfrCZFMmnhZ1X1MFgPaAh+vjbBQQyp/i+RlD2PzFiD7oGdelid9pR+MuH8fcom
	TEemcehtk2M0ybKGBpGErftHxOqJ/1LKYWLN1iLNe672oNuHTLjdgYAe0xQpcLsyewtFStIG3nc2T
	3o+v4tavhNwPc5PyRaGI00drCngnRPR+Jvl1v77DwXjri397fDBxd5T7vsFEdpghsEfA3oVFOlWri
	Blxk5iCXxV1fpdLNLHlSKDQfrSxC5Nfe61oyXLFNAIac8KPfClR5MzfO0MxLUPxH6LN59h0wvh5hH
	DLY2jAhASzLjRzLg6HEo7dD4F2gFc6K1ZEj1HQu6JpLAmVenAwUd7tHKjBQ37z4H/BJjdObOZWHlt
	Q8zLduVAoYOnmp1gsStNAK5QBnvAAuWX0vhAHiH9E=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org, Christoph Hellwig <hch@infradead.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 Chris Arges <carges@cloudflare.com>
Subject:
 Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Date: Wed, 10 Dec 2025 14:33:56 +0100
Message-ID: <3385064.aeNJFYEL58@weasel>
In-Reply-To: <aTkNbptI5stvpBPn@infradead.org>
References:
 <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 10 December 2025 07:04:30 CET Christoph Hellwig wrote:
> On Wed, Dec 10, 2025 at 06:04:23AM +0900, Dominique Martinet via B4 Relay
> wrote:
[...]
> > The problem is that iov_iter_get_pages_alloc2() apparently cannot be
> > called on folios (as illustrated by the backtrace below), so limit what
> > iov we can pin from !iov_iter_is_kvec() to user_backed_iter()
> 
> As willy pointed out this is a kmalloc.
> 
> And 9p (just like NFS) really needs to switch away from
> iov_iter_get_pages_alloc2 to iov_iter_extract_pages, which handles not
> just this perfectly fine but also fixes various other issues.
> 
> Note that the networking code still wants special treatment for kmalloc
> pages, so you might have more work there.

But couldn't this patch be used as a preliminary solution for this issue 
before switching to iov_iter_extract_pages(), as the latter does not look like 
a trivial change?

Maybe I'm still missing something important here, not sure.

/Christian



