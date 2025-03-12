Return-Path: <linux-fsdevel+bounces-43817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7465A5E137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EAF189E4B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904C256C6A;
	Wed, 12 Mar 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmpV8HCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0337198E76;
	Wed, 12 Mar 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794961; cv=none; b=iNlYfD85y0swStBlBHZ0ChKo3rggk066nFO/0Pt5/87umZ1mdj97NmQznXj2SkWpzvPs0LXOoykmO8DxQSGcIxnNRwQKhQUaykezcnzZaxSMhgQTO8TwIyM2HlcZedGvf9vCCR3ZfzZX58+fOT5IfGKvWsnsr83CfkqZp5apJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794961; c=relaxed/simple;
	bh=Y8XqINxWTLY7AKJYXp2mS7v0+6MGrDY3mz3QwfDceq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8mk1FC72YsVBd8chfK58c3hVCNHd4VJZDwT6rfGR0eS0C2Xxha7zjRU2ghJN2kR1YGRn3PbfzpWl0EyW+3OumNCquLUagr+ME7tXs+Kv2flFU0Ecz/FAKEhc9XiIHvKUNCGm3TH7b2O8D/Zu3gE7L4vRsFCLYb9UKmN9zU/hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmpV8HCJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sLv6DldMmCXALdSl/mjQMsKUaK5QmzyqMPOb8IvMdAQ=; b=lmpV8HCJkThP+yJ8t665ZxH5i4
	OtBX9wDa+K9zhB+tBtpyo9dwlQ0jR+Fdjlf41jEnfubxSfBItFhpXmQtsKNczXHyDBNlcIEiV5W5y
	QMA5DOH2BOQNXCrYR+BACVKj4vU/mM+uNvlyuGUVo0riTVkcNxX0Uf1c/uVTYSZCWeNuuFgaMHYPB
	5G07MyDU1Bnn0Eu0zXqFWweASsFGTGRCxcUuFhd3/+NV4/o4Oy4LdLWUSbeQ/iuqEqAXYbIivXCEG
	0OBqtsFX6UdPJJNcr6cMAA0m8yaVxFxsyQ2n6iK2fbU1a38zxGCmD9Pe0RvpEVSxgNJpSRMHAtA6a
	T1GHgtrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOR5-00000008x2P-1nh0;
	Wed, 12 Mar 2025 15:55:59 +0000
Date: Wed, 12 Mar 2025 08:55:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
Message-ID: <Z9Guj3oZPhD2LLjt@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
 <Z9E5nDg3_cred1bH@infradead.org>
 <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
 <Z9GRg-X76T-7rshv@infradead.org>
 <9337105f-d35a-4985-ad21-bf0c36c8fd50@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9337105f-d35a-4985-ad21-bf0c36c8fd50@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 02:57:38PM +0000, John Garry wrote:
> > > I do admit that the checks are a bit uneven, i.e. check vs
> > > IOMAP_DIO_ATOMIC_SW and IOCB_ATOMIC
> > > 
> > > If we want a flag to set REQ_ATOMIC from the FS then we need
> > > IOMAP_DIO_BIO_ATOMIC, and that would set IOMAP_BIO_ATOMIC. Is that better?
> > 
> > My expectation from a very cursory view is that iomap would be that
> > there is a IOMAP_F_REQ_ATOMIC that is set in ->iomap_begin and which
> > would make the core iomap code set REQ_ATOMIC on the bio for that
> > iteration.
> 
> but we still need to tell ->iomap_begin about IOCB_ATOMIC, hence

Yeah, ->iomap_begin  can't directly look at the iocb.

> IOMAP_DIO_BIO_ATOMIC which sets IOMAP_BIO_ATOMIC.

> 
> We can't allow __iomap_dio_rw() check IOCB_ATOMIC only (and set
> IOMAP_BIO_ATOMIC), as this is the common path for COW and regular atomic
> write

Well, I'd imagine __iomap_dio_rw just sets IOMAP_ATOMIC from IOCB_ATOMIC
and then it's up to file system internal state if it wants to set
IOMAP_F_REQ_ATOMIC based on that, i.e. the actual setting of
IOMAP_F_REQ_ATOMIC is fully controlled by the file system and not
by the iomap core.


