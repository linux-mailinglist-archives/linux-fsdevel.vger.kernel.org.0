Return-Path: <linux-fsdevel+bounces-37270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB879F0473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 06:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024A11695D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C718BBAC;
	Fri, 13 Dec 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JWGjaxXm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A446F30F;
	Fri, 13 Dec 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069424; cv=none; b=TUQohdbEkrmkkPAoc5w1nB0JrgBwgbzu6NM+5/o2xfrSQRwvT9YNmu/NLHTHrnMwtsdO52azeYtDwY4S+dHR9PIZoLsK7LjYW3EgYDTGGExZBtJXkAInvtjX9N7nXUqejoVOPPRYIUUAwAcyd5lOx3WK7FSrHGWAchggLONDCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069424; c=relaxed/simple;
	bh=fRwSZFuKlVEwX8oDyo8IvsgFnf2SLOzzaiX84qKJvFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU6rXw4aMymZJS+P+Zt6K24hnCn5jRrlq9Wx3cGR39SQplPtrCWzqWeo1kco7YkIKJTdBSKp3QQhQRSxBPjE4T/pArRQJLh0/HvoSIPP2Qp3TF7WEmPOrlC8zVReRNPpAAcX2aF5K2GcEefyRugZGXHkRl2r5DchcuW877q/4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JWGjaxXm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VtYK1Jcfu1QDnzrzvT1193eWum7ll3HtEhe/SLwyPBk=; b=JWGjaxXmLWf+ysB/Vls5WDllNB
	tCn8uwzNJWbt8i4S4ez6Incd/C08f704FwkKi7U2mNEtbLYsAUXv6aKhmVmOlZXvSs3hrsmoQeTDR
	hjZsAhOYZEK6DG+8Mh+Pwyte+0EO2SEN2DVY1EqlX/JeEo1VooJ8CN2G4Bzjy6RCpXvQGSO+4x0A3
	3pc+yTa1FE4U1CmrjoWVp743vuAbZq7mCXSlGrwlksoxKQx9EiOKOKr45/nTxEAmWlgFMckTPeK1U
	cuyLUtU6ARCEr8NSVuQ7sdn2knC5tRtN0QS72E2npOqKbD8VRANkrCqfQVSmlMHcHyJpCoN3GwVZ0
	jdgyJYZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLyfd-00000002ocI-0sDb;
	Fri, 13 Dec 2024 05:57:01 +0000
Date: Thu, 12 Dec 2024 21:57:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/3] include/linux.h: Factor out generic
 platform_test_fs_fd() helper
Message-ID: <Z1vMrUqBWcarQ6_s@infradead.org>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>
 <20241211180902.GA6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211180902.GA6678@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 11, 2024 at 10:09:02AM -0800, Darrick J. Wong wrote:
> > +
> > +static __inline__ int platform_test_ext4_fd(int fd)
> > +{
> > +	return platform_test_fs_fd(fd, 0xef53); /* EXT4 magic number */
> 
> Should this be pulling EXT4_SUPER_MAGIC from linux/magic.h?

I think we can just drop adding platform_test_ext4_fd with the
suggested patches later in the series?  Having ext4-specific code
in xfsprogs would seem pretty odd in xfsprogs anyway over our previous
categories of xfs only or generic.


