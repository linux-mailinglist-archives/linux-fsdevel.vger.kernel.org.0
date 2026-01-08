Return-Path: <linux-fsdevel+bounces-72805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49699D03DBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18CF73026499
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA343A232;
	Thu,  8 Jan 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FjlRmM8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C843A20F;
	Thu,  8 Jan 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864298; cv=none; b=g/db5RVsdZoqNHRoE0ErCHPKT5fJLT+D7oialtLm0ZoCVYdR13NcSuSdNw2rAWQx2PoDT3fYB5+wHd+Qg74/f+LRe3o7wMPPyeWeot9ayMnsUXJjMXcvS7PXgdgwQ4uCki2dEyLHHRv2F7UH8ySslMhCRamKjVNb53DUbWkc3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864298; c=relaxed/simple;
	bh=yttrd/eJ2yxcEzFLZWXppW/kffU28ZPHb/N3HOkJVzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwt9/Ap5ULMDXgJBfgoSCyz/cn2Y3xdQL7D5Dv9Lc3uJriwblRoEWu9WFN82UhQXpBoNfyhPvfSl09qE/lKGInxTFwuoL2v1CldU4mSNybPhIiKe1EqndVRNzZg0SMhTMWF4hrAzSTbcOZpRPJJJs7dGPugALmIRu80TRaRI8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FjlRmM8n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yttrd/eJ2yxcEzFLZWXppW/kffU28ZPHb/N3HOkJVzM=; b=FjlRmM8nkIwznD5H8n7jrbipqI
	ZYom57ErGnVY32s1Pzlqojdoqe7yrdCalIPZaWZ8mfSSjNB8Bpdi0n79Fjlf+9inNnE6WBBJTEdyI
	OujX7VFQfwvvJONFqmhQFwGXWo4WIdJH0jQjXBHieogaMpw059F/4F5BtCqGqnmK9bTpLZh8E9NhP
	txe1+QTBUDOWB54/iyTd8UJoQL1w8KDjUazbCnMg+Jm3s8rKVMZolJCIrc3uO5WEkGB58dsSQyGGU
	MLTOpha3+UqbxXRZzeJWM1f2rEh+j3+Oq6Syf/ooyF6Tzk8kfvLzJUfz6i7w+jvJIYPzmuukYIjZr
	IzaJW7sQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdmFn-0000000GRiW-1B3x;
	Thu, 08 Jan 2026 09:24:27 +0000
Date: Thu, 8 Jan 2026 01:24:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Hans de Goede <hansg@kernel.org>, NeilBrown <neil@brown.name>,
	Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev,
	gfs2@lists.linux.dev, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] nfs: properly disallow delegation requests on
 directories
Message-ID: <aV93y-xeWk16s48r@infradead.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
 <20260107-setlease-6-19-v1-1-85f034abcc57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-setlease-6-19-v1-1-85f034abcc57@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 09:20:09AM -0500, Jeff Layton wrote:
> Checking for S_ISREG() in nfs4_setlease() is incorrect, since that op is
> never called for directories. The right way to deny lease requests on
> directories is to set the ->setlease() operation to simple_nosetlease()
> in the directory file_operations.

This fixes generic/786 on NFSv4.2 for me, so:

Tested-by: Christoph Hellwig <hch@lst.de>

