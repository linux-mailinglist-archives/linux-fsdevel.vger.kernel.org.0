Return-Path: <linux-fsdevel+bounces-43781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024FA5D7F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D727A69E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C623237C;
	Wed, 12 Mar 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBx43/M2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4415539A;
	Wed, 12 Mar 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767221; cv=none; b=At3H/qXjRwixhXl91abHvgfLDsvSRzCp4sWWjq8eMD30uwiZ7YP0jGJeWCyfUNjUuD+l36CzDZihY9F8zoxj+PeJ+bufPs81jolI31+pEjq1fuzrCalW3Scl49FNe35AS0x85Fwj/HSiQj0ztRd9r/i6p/GdZfK+FwdTTlu93r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767221; c=relaxed/simple;
	bh=fmaPeZPre5TVMrxxIKY2UDE9mVjDBhZXUA8uqPMmiCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFCzYHzH3rMeuvrB021z69DbMNm0rV5sJWSCf+0eF5np8BfjstrBy7jY8lVnTTYUQfUtH+rx6z6kTUcq+oalbYtQm2uG9QF3zY15XjyZzYu+SWdTbCm5anzUhSltdJtGgUHeH/cS8LGldiDKaPBrt/uBZSOTzrdjitf6RIO6gLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VBx43/M2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VEbZGeMUdbtVWvTResu9Bep6dxewes9CyBQbLmDJa7k=; b=VBx43/M2VR0/o1HSgz0rwjFzdY
	Oz1gP0H9tdMzvK7ssq5UE0qWjDuD3m5P1KgKCAraNKw45odhDzA3ZnlLZesn0WG4X6V+LBp6UJAHO
	oR6gQuRnjCEP/vYxiiGokafddEgd63snYKkOmWo4awd1hOmxBY2I//CXEHKBA0Be80+BlxpypDLRG
	VN4vyAd8cVoW/K4WurrpywFwIQ20gVnfJVk0Vl/nWtezbCZFEFr/BX0Q7pCdKI59BTyd1RDHvdcvE
	gCZPZVLhpv6fAvM9BOjjcuXxArBF9t0TUzoJdBo/4e79VGupc4FEUKlPc/jrpYiaDiGsiaAFd3tGr
	pBvbIm6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHDf-00000007nuM-1HVD;
	Wed, 12 Mar 2025 08:13:39 +0000
Date: Wed, 12 Mar 2025 01:13:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 08/10] xfs: Update atomic write max size
Message-ID: <Z9FCMwZTzpmwsw1W@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-9-john.g.garry@oracle.com>
 <Z9E6oMABchnZIBfm@infradead.org>
 <fb6f286d-19b5-4f30-ac0d-799311980521@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb6f286d-19b5-4f30-ac0d-799311980521@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 08:09:47AM +0000, John Garry wrote:
> On 12/03/2025 07:41, Christoph Hellwig wrote:
> > On Mon, Mar 10, 2025 at 06:39:44PM +0000, John Garry wrote:
> > > For RT inode, just limit to 1x block, even though larger can be supported
> > > in future.
> > 
> > Why?
> 
> Adding RT support adds even more complexity upfront, and RT is uncommonly
> used.
> 
> In addition, it will be limited to using power-of-2 rtextsize, so a slightly
> restricted feature.

Please spell that out in the commit message.


