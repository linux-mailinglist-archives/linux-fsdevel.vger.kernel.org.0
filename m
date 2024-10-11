Return-Path: <linux-fsdevel+bounces-31707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68F99A43D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0951C228C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBE21859A;
	Fri, 11 Oct 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cB3SRmzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251E2178FF;
	Fri, 11 Oct 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651279; cv=none; b=oA3Yjs0jM47QNkauNj3SF+bJnNhDVHmwaQoZZYJZHLoo2nPrhn5yI6yPhwbDsK2Dgn9bjS87lpRiUIBsGUSwQqzA5X4XcGC7roA/pKtHeBCbUSan4PPJ9VGuuToojnH+6HBqPLyt5+F+Tao4L+yAPTt07KF1VjBaY86kSXCD3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651279; c=relaxed/simple;
	bh=hUF503SshZFnhDTc/TnXqrKN0/ZZy1/GZ3WEZ0BbrjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHM+f3ZIjal4ywvVSQDj/avcAy/AtLp5N8GeieDRvnPeQpvkUYtxrLdsXS84iDXyOfXJ+h25es6RpKowjoxfA1QNaEW8pcILgkXMNIeFCp8J6lEAVd8Ysx+mQmK3fTsa7mdrVj31QnNuKfoG9EBf7yyiFAltaMOcYm9HDElluQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cB3SRmzC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hUF503SshZFnhDTc/TnXqrKN0/ZZy1/GZ3WEZ0BbrjI=; b=cB3SRmzCdneY8cgh56Eemb7PlF
	yFL6JsxdLZw5J8sO/8eTqXbSXxtqP/5OUxS4fTzQszsMfug6ufol/YKP9zR9hgGAsxGpJn7/OIA7Y
	Ukt8xNXuhKMm7AVpf6e6cWMkWl0ucqIU9AQCuG5Dqf5evD9ueIIVwZig66QEMgv5oOZ8EsZYjPBDo
	8EQdNBwT74H5jk801UgF8s7AsRA1dP6osrdrTbCE9jwZcSKgFXSMtx8mxCpmQTj0W6uO3Hs0u8OLz
	0P9712ZQ2x8pfTIzp9Cs0aaqyI0VsWlkNsiL4vEsLaK7SR+lY1B87x+OKc/uCzFemw2KDF+YXd3ya
	E4T692cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szFAD-0000000GMXd-1Y70;
	Fri, 11 Oct 2024 12:54:37 +0000
Date: Fri, 11 Oct 2024 05:54:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZwkgDd1JO2kZBobc@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011.ieghie3Aiye4@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 02:47:14PM +0200, Mickaël Salaün wrote:
> How to get the inode number with ->getattr and only a struct inode?

You get a struct kstat and extract it from that.


