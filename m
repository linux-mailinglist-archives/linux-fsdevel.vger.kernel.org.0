Return-Path: <linux-fsdevel+bounces-40559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B8A25295
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B3F7A21C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD51D88D0;
	Mon,  3 Feb 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aqa5/RnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA74502F;
	Mon,  3 Feb 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738565068; cv=none; b=sCfEvUNcwOpLTAMkiJeIfVmXcvtsahYIht/A4NZq7IORFtjYnE5fN3OpJnOZNmzDfuzcSa1aOUGXQjoD2qiGRKbykhXDfF2/7sksZSCjXAUyWGiQTayD8qesPnt85Wu1psCoEihwHb2zcPO6RlmzN8SDK3ctoUU5t0naCDncf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738565068; c=relaxed/simple;
	bh=HQKDYOCdHKaakHGV0eqzsWVJdOSGEfM5T8DAjKSLviE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsTSKvRTEO19L2BVHRQ+IDBTzXnzvCvTXYxegCIdwWj55BNadFAefd2DdbsEh78pDThoyMZrlqDkioKV7S0dKesvC+/NszAc0hkz3vzAom8UAmhRPGVXtu+TWeUx7naR7glk8k5yuWlghUCLv9Gi8q6fWRssVgIcDMKf/B7vkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Aqa5/RnF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8X/jA+kTlWlpDDzux2Wj/CLtctKj+eXpCkO2gIJEKI=; b=Aqa5/RnFXfV5vtOdf4273dOiCn
	CRbMZfqUSS8aBWNoGks2hdqyxZNxtCr4SLVs+/gmyZgg7ZnIE3uLeXBDKMy65s86pMXnKlN5MmzR9
	/xudR9kFE7GvxPb6+PuiC/XXGvwu8N6ARkgD6NPw1mKCdRgjsF8mpjNdTrMtXKwsnKv+aiP1bq2n6
	xRv1Ard42TE3bfcPiNthogUpbr+6S/1bwqPPyEqieuZyagmRXPRgG/XtKcyD7+9M7LBvm8ALtuuvm
	Cb5B/+ahPzpYs623D+oNsUFwquc+1yTjGpJ6RKdn/yjSEk6Miu38RdvZhpAX7o5w7eUwE8dDCNxC9
	AfNlh2iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1teqBw-0000000EfQ2-2ueZ;
	Mon, 03 Feb 2025 06:44:20 +0000
Date: Sun, 2 Feb 2025 22:44:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
	"Day, Timothy" <timday@amazon.com>,
	Andreas Dilger <adilger@ddn.com>,
	Christoph Hellwig <hch@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>,
	"neilb@suse.de" <neilb@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <Z6BlxO4YjsjPQyuY@infradead.org>
References: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250202152045.GA12129@macsyma-2.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202152045.GA12129@macsyma-2.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Feb 02, 2025 at 10:26:28AM -0500, Theodore Ts'o wrote:
> Well, in the past I attempted to land a "local" file system type that
> could be used for file systems that were available via docker (and so
> there was no block device to mount and unmount).  This was useful for
> testing gVisor[1] and could also be used for testing Windows Subsystem
> for Linux v1.  As I recall, either Dave or Cristoph objected, even
> though the diffstat was +73, -4 lines in common/rc.

Yes, xfstests should just support upstream code.  Even for things where
we through it would get upstream ASAP like the XFS
rtrmap/reflink/metadir work (which finally did get upstream now) having
the half-finished support in xfstests without actually landing the rest
caused more than enough problems.  Something like lustre that has
historically been a complete trainwreck and where I have strong doubts
that the maintainers get their act together is even worse.

