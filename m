Return-Path: <linux-fsdevel+bounces-31728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C899A74A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB631F249C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B31953A9;
	Fri, 11 Oct 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1dB57+pP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3E194A44;
	Fri, 11 Oct 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659609; cv=none; b=AuBSYyMuqULgQvkjNYoVoO9fvgiiZSCN55j3YBsTkibgOoUu3D6FNFPYhRTChRRiVJ2mO9lde0WyAJviu3Bl3IOBkHC3IxFKAmvCBDal6XGfCkwvBpWjGCDRoFf6NZJ6XClN0S/x3/rRGWiUBKQANuf8p2Uh68MBXSx5PBFhQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659609; c=relaxed/simple;
	bh=jWTP9n4XeMGgwEQukodrgSGXh+wuI0eNICyoqwsYQvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRzzuPvaUtBkP6hASftjn6dBP3EOu4J6ap+UYAburqabBrLd51t0GRzLmgJ2p/vG6WFxiC9XPs6fs5E5+VQuDkiO4xqSh8mfEuyhPCY9GVnAx6GycFGeZt788hkt+8YQp4H5UVNdXmiYdJ5nM2nP37sbcIMx42CtWEa6C2o15Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1dB57+pP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n2+YOXDB4tUEMWL/JGJm9sq6bJqaw4xNI4A6UIQEj4k=; b=1dB57+pPuw1aTyAZqO6opKqSnE
	rhVnHyVFalJfSvGtpsSSVlnk28bV0qcX7G1vilt6mZ+LH7G0Qsq5xV6XRT1mhxYb3J13oeBQ8dZtA
	EKkKaZZs71PmwgbfnQMHljFBsmg0GcYe3wJ94OMniduZ1JQuuvvqmAXaY0MPB5M2epTrwa9hBESUF
	mRiJmw28991MRxRzD68rFGoFTQIji64LVUDyGkmUprl08ejeoMQZGi4DxOa8lBVI6mXjyZ56k70+b
	/fnK8Rd2/qADa0BvsFk2Dur7FluAH+twEJE/xS8d+xsvKsLlCsgJAQioToTvSOJkvh5zlYhddZDgV
	AEM0gXtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szHKX-0000000Gk8B-1Otk;
	Fri, 11 Oct 2024 15:13:25 +0000
Date: Fri, 11 Oct 2024 08:13:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZwlAlW62Kvjwi4Ix@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
 <20241011.Di7Yoh5ikeiX@digikod.net>
 <7b379fd1-d596-4c19-80fc-53838175834e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b379fd1-d596-4c19-80fc-53838175834e@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 11:27:45PM +0900, Tetsuo Handa wrote:
> Or, some filesystems are already using inode numbers beyond UINT_MAX but the
> capacity limitation on 32-bit architectures practically prevented users from
> creating/mounting filesystems with so many inodes enough to require inode
> numbers going beyond UINT_MAX?

Plenty of file systems use 64-bit inode numbers.  XFS and btrfs for
example if you care about commonly used local file systems.

