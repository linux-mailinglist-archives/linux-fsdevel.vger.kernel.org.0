Return-Path: <linux-fsdevel+bounces-51156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3BEAD35C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DA03B8C76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A28EA6B;
	Tue, 10 Jun 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVUZUe8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBF28ECC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557592; cv=none; b=t/ECwVHydeTw6GqPUynsLfkWRwR+AT067eCecESRQpbDRvJBHiVS8bEFQKYSYopY6HSCgOs8kX2BIjUdg5QvDB5AGoVZUXm1CVD3jaCs2MC5lr3wAD5yq0pprJDD3y1eCVBVEUzny9NFvJfPFblGiV5oORWUpDowm+74hWiVVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557592; c=relaxed/simple;
	bh=mzbZlpAOR/Pt9RbE4H2dw2sePah/VWNwkDic8n/Ah40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8U0WoCsT2B391lz4FEeihymxClTN8yWIL/TqvY/zqMxNfQ5VQxVEKJrxeTrVtBSjnWK6c9Lgw7sCpGxevpz3OUCCOILBtpamY/PuyaBGhTUfEgJs2/DBvxLuBAXVL6xF0IMSCqaARBjYuJ0jNZAWcM9a8hHvovOxrkqCG60FR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVUZUe8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749557589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heKlbXfDgVVxe8Ad9VgCzHCzkhfC1CaiT7d1fNBqdeo=;
	b=LVUZUe8oeKpqjWg1mAjAqVwj9OlQYsAMiYWH3QfX9gcCAREQ4Tverr2y1i7+3KxB0kWQli
	F/bYPR86NzmbYCzaQsTJhWFE21TxkuGx2feQI5F2HIBo2VyiMxofz2UAsgr14Cpz3JP6hs
	Av/kcBXY+m8NJ9fojUFu4mFAFdcp1Yk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-_zIHByZTNMCjtTFLLKzi-g-1; Tue,
 10 Jun 2025 08:13:06 -0400
X-MC-Unique: _zIHByZTNMCjtTFLLKzi-g-1
X-Mimecast-MFC-AGG-ID: _zIHByZTNMCjtTFLLKzi-g_1749557585
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05BBE195604F;
	Tue, 10 Jun 2025 12:13:05 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8BAB30001B1;
	Tue, 10 Jun 2025 12:13:03 +0000 (UTC)
Date: Tue, 10 Jun 2025 08:16:38 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/7] iomap: move pos+len BUG_ON() to after folio lookup
Message-ID: <aEgiJtDFPZ4eWzzg@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-2-bfoster@redhat.com>
 <20250609161649.GF6156@frogsfrogsfrogs>
 <aEeyow8IRhSYpTow@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEeyow8IRhSYpTow@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 09, 2025 at 09:20:51PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 09, 2025 at 09:16:49AM -0700, Darrick J. Wong wrote:
> > Hmm.  Do we even /need/ these checks?
> > 
> > len is already basically just min(SIZE_MAX, iter->len,
> > iomap->offset + iomap->length, srcmap->offset + srcmap->length)
> > 
> > So by definition they should never trigger, right?
> 
> Yes, now that it is after the range trim it feels pretty pointless.
> So count me in for just removing it.
> 
> 

Fair points.. I'll update this patch to just drop it.

Brian


