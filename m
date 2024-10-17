Return-Path: <linux-fsdevel+bounces-32221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33349A2683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D221C21F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DDB1DED58;
	Thu, 17 Oct 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0Ctp9E7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE51386B4;
	Thu, 17 Oct 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178723; cv=none; b=all8cSUQJkrlkoZQhV7jKTvcX6Q0tyAP4nBp3lPUJ6BWACKk54GvzS24PI+SpjASsYd9/LeJo/b+WK0K4AjFfXeOK5WYO71vFert3nW/UtrL1T9CfK4SNSREGS02ZxhclVI4yDMIKzyBAteo8+JaDtA1yvxIIeMqJVUMUY74aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178723; c=relaxed/simple;
	bh=e14vARFRPXFqWE5D+9wUOfggw9iDjwOHiJ15L5WX/GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRbU4rfUC6JQVR0g+GaDoC7VwKJU17q3ujNBPwdMec+ttrqZfPBqsmga2Xf0Ziw/AscMSK7C5SrphnzJwWD9g0FQO2uce30PbYvXxk7Vs/UYu7lGW/rXuYEF062Qx+C1Kg8UTqhxInUi0EmSKTC0cfogyBcpAzX1HkO0Ayk9nO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D0Ctp9E7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7rcG0T4e0Ytb++3vrNQWHwgqkLkV3jBFMznndDC1Hgc=; b=D0Ctp9E7JuGeTLONn5TGkYrXJ9
	SpqvU04G9Z+qn7DS13eNCU3QnkRVgOdb2j5PgtGfB87YO/k1szrTsjLzOBO78UAuTV4jr6NsYDFxv
	J9eimeMjhybUptkAXiRGe6NVfFIz3kbbndWoAahIcpHb3DgC7xkNfIxt/1UAH3h9xJI85a+edmx2u
	ujjM25KFJyhptmrJxb/yL+bqmsgPK21dONbYkRoOw+7tEZVMS/1w3Pli25pTWYBZN78LyWL8VHuDp
	vINKm9XAuJmLK0ZRSgNTD9uiuW3s/DwhIUyzDXsWKsN1GL2FhjJwZ0xB+8tYycrvKI039CbK+n3N3
	pI2eZssA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SNL-0000000FH85-3cSF;
	Thu, 17 Oct 2024 15:25:19 +0000
Date: Thu, 17 Oct 2024 08:25:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZxEsX9aAtqN2CbAj@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 11:15:49AM -0400, Paul Moore wrote:
> Also good to know, thanks.  However, at this point the lack of a clear
> answer is making me wonder a bit more about inode numbers in the view
> of VFS developers; do you folks care about inode numbers?

The VFS itself does not care much about inode numbers.  The Posix API
does, although btrfs ignores that and seems to get away with that
(mostly because applications put in btrfs-specific hacks).  Various
other non-native file systems that don't support real inodes numbers
also get away with that, but usually the applications used on those
file systems are very limited.

