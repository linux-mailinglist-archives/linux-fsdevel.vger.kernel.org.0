Return-Path: <linux-fsdevel+bounces-31699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D343D99A3E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728E31F24439
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B92178F2;
	Fri, 11 Oct 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z9NtgQEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA01E529;
	Fri, 11 Oct 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649815; cv=none; b=h0bhsJYxR58yKdGZteJ5F28HJorPghq11Wc9LCASOPukiRTEtc57CTaQl2KB2/QkXzB+QLaI8aOd+bpAPffbgZMDZfdjX2dN9cAX6g1jKTkyAAVhXkMuQfK8EDoXabbbxRebSjHRaEdNljIZGrcOqKrWKT8+ax+su/HkHEDqmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649815; c=relaxed/simple;
	bh=QmtD+4etwI9vatzBvb5JYLlAOJh+rWuCgzzlz3dda3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDsMxFVsMivlZKtnan/xdtS5rqBoCUgNwLMEXYJLXGqsoRTFHas6/pIhccfncx9RbuMIqwoRtmex7+UI6Al/DyGb2lO/DN4JlN6uBMMr9ona7pbyVeBa189v82vZTO99hRcXDbJtg9iLd8StcyhTNwZIuCJAHibq+6l4ScV9H+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z9NtgQEr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8LG06hBWV5wmxANUqRDTL8bJLde+3OwBM3fSFHg8JTs=; b=z9NtgQEritpcTiPo0Bx02C6eS+
	rO8uLg3iQHVoh5oN8r0YAygyv8tWKWaoP5ja4f1U3m+zswblMMqjgdtinuEQ+shGkqixODO2HTf2n
	M6509LcknXUYXHaCHQc8+/rac5Ei/nbO6cA8QGWOS8QWabEgEtjSp03Gi7w1zJBV0FYrQJRcy0yeV
	0zPmF4dpvz7V1eS0/Hu1NB5xnqLb7C2Y2DWo56QTFut77Fje8Twa6hiH+e+2NYKnG6KOW9VrWMgDp
	2s1i3AIp1vivzVVjQHy286jqZuvw1anqd1mkJuKB2ML5aK4+bS/XdXrYX1Tf+HVQb2fzBp/bPHdzO
	RLMHFyPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szEma-0000000GIjp-1psR;
	Fri, 11 Oct 2024 12:30:12 +0000
Date: Fri, 11 Oct 2024 05:30:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZwkaVLOFElypvSDX@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 10, 2024 at 05:26:41PM +0200, Mickaël Salaün wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid shown
> to user space with getattr(), other part of the kernel may still expose
> the private inode->ino through kernel logs and audit.
> 
> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64 bits.
> 
> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of an
> inode number.  inode_get_ino() is called by generic_fillattr().
> 
> Implement get_ino() for NFS.

The proper interface for that is ->getattr, and you should use that for
all file systems (through the proper vfs wrappers).

And yes, it's really time to move to a 64-bit i_ino, but that's a
separate discussion.


