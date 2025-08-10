Return-Path: <linux-fsdevel+bounces-57237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2788B1FA96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2498C175908
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EBE26C391;
	Sun, 10 Aug 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdASxwIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2DB29CEB;
	Sun, 10 Aug 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837395; cv=none; b=Ln3achVNnnMxK941psmPrd6HKRCUzkQWdQ6M7abF9f2Ufa4s+1QlHQOea/M6l50KiyNaSEcQNCvyiywuvzYnHMlyhdfB/shQlpuKIHbQuMQtMqnBbDe5IGno6p2vSvf95s567UJeUKfZwEKpyS/+wXDdWpa/VYlrat8jRuLSDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837395; c=relaxed/simple;
	bh=81MmHItPWK5AHBLvNoOHNFtMqB3AK2dNlK7nI81UAfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjDei9vMmJ+knGblhx4+AocN2gHyTd39GF0qEhisS9kyR2GizgsMgzFKYMvJzZusKrNAllhAMT8w1bN9rMa+Rg+mVjXXx0VPmeFrl+Rlr9Auh0RUUtmaV0/H8Uj944unW2LbomA5+GaH0+Tdrz8XBAf1YJxOB57BPse8wqhAhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VdASxwIZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rwHgnvFkI8ol1FQ+5zHPEHRy/dxGqbdVD4J/8Z3UBxw=; b=VdASxwIZcUfPXD0ej7kzZEmUB8
	MHVwuMklV0Y1mYhBir4v43o30PGEb+fMO5v7uxKj7DHmNf4HIMzzamFT39Ujw32EispbuToedYhTP
	Oyuam4G5cQi6rv3riZOxqEd2/ZUsRf3nv/P7xe6AbU71E4S3yXklCJt/maNyXE8EnaHlfytMLyCg8
	AbqvvpqR8VL6z0jRWU5u8yftfWqnvdzKQ5ptqKq5piZ+de9ZcuEfhKAQ6phIwIevXcmXH3ERjElYl
	RWeRQ3MOS0pnt/Ac+/EQM+qGKZG7FS0gUBrj7Al117ACleeoJG8PxlQfvkz/3t4jxpWlyq2BqjIxq
	C64/uLbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7Mv-00000005iNZ-2w7q;
	Sun, 10 Aug 2025 14:49:53 +0000
Date: Sun, 10 Aug 2025 07:49:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <aJixkUfWPo5t8Ron@infradead.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 12:56:53AM -0700, Eric Biggers wrote:
> This is a cleaned-up implementation of moving the i_crypt_info and
> i_verity_info pointers out of 'struct inode' and into the fs-specific
> part of the inode, as proposed previously by Christian at
> https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/

I would really much prefer to move fscrypt to use a hash lookup instead
of bloating all inodes for a each file system supporting it, even if
very few files on very few file systems are using it.  With the fsverity
xfs series posted again this is becoming personal :)

You mentioned you were looking into it but didn't like the rhashtable
API.  My offer to help with that still stands.


