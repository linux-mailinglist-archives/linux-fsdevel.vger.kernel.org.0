Return-Path: <linux-fsdevel+bounces-40468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD53A239BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CF13A1E61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BF14F117;
	Fri, 31 Jan 2025 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sVHrj2JB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31813A3ED;
	Fri, 31 Jan 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307272; cv=none; b=CIW0N9GOzrMQ0pjDUcU4teJvE/5q9t7gZKARNwSA0kANmSg7jD6YrZCoKTI/eGZGM6++HIpGvpv/8CWsRL2epX5/PYTXgzL+QTA+/EeT692AicvhNGdgcE41orsZY8+xKiiFduX2mVDuY+1G4jMcuPKaUo7J+6sZm7JpwAP+ESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307272; c=relaxed/simple;
	bh=yF9eVRU9oSJPqBIYBBVDPJR3R0AGMgmsbXNsMW8bBAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDFr/GdgCV4D/1126mTIeuN+zNcr6LKFxpAsJA78G71V68YqxT2Yns0BjdLGKLWarSMEXLF1Vu4gBZCvPxoasnOmtItGzbxcr2iy74QByGDJXkzyT4fg2+ObhyNPOZxH8P0uXKo0FG6X1FCgzOsWhmHjfwRdSgLN+AF6hNo3p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sVHrj2JB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BuNkhA4U2EXzY3UIav9rX8ABnEiVHzXbjByWKZyeJio=; b=sVHrj2JBnjKfGR4qyrfUZ+JM80
	P2mJ5gTCoRKUZtdYm8JjQmtzAjy7JsUB/JbxUdSByrcCN5iSrEyC8ae5xNJJGG/9f3O0SslEgb/h4
	Pov7iB9r+FXsESIAyr/vFoJWlhJErtG8DDYlohxJLowqi6W03ZArdrhMI7dkXW/C/idDNkzMJegT6
	YzbgnAcBiBpnai9F5S3eeGn7MDzuNsnGqbkC8xNT+jboeCkYLcWWkvQydhc0x1x6zLFG6LBDdU1qM
	zucAZLp+XrdlqKTPIybhZfO4BR6k2M8QJT0GdRXkzNhrPyaaTtqJA3lYJsIsPXOsvKB46fKOiDwXi
	xnkzfAUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdl7w-0000000A5J4-1JuT;
	Fri, 31 Jan 2025 07:07:44 +0000
Date: Thu, 30 Jan 2025 23:07:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z5x2wDP1Y6l1FVr5@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
 <20250131044015.GB416991@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131044015.GB416991@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 30, 2025 at 08:40:15PM -0800, Theodore Ts'o wrote:
> On Thu, Jan 30, 2025 at 03:39:20PM -0500, Martin K. Petersen wrote:
> > It already works that way. If a device advertises being
> > integrity-capable, the block layer will automatically generate
> > protection information on write and verify received protection
> > information on read. Leveraging hardware-accelerated CRC calculation if
> > the CPU is capable (PCLMULQDQ, etc.).
> 
> So I'm confused.  If that's the case, why do we need Kanchan Joshi's
> patch to set some magic bio flag and adding a mount option to btrfs?

Well, as stated in reply to the series there really isn't.  The
case with a buffer duplicates the existing auto-PI in the block layer,
and the no-buffer cases reduces the protection envelope compared to
using the auto PI.


