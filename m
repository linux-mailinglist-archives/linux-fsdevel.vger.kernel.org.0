Return-Path: <linux-fsdevel+bounces-34183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D113B9C37EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857461F21D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E314A630;
	Mon, 11 Nov 2024 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FH7t8EtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29618E1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304440; cv=none; b=HPI9qX7SooFQhX6A81pAClp7p4/VnkA5A9sHg91GcUcODOKZb8WSSXULER+SxDny1cMw6vfp/o5+yrDI5RjSY6m2Hr3VJloVl8VdedBpTSQcWVPsz2Dn30WyC2KazXs4NHaXgG+rUOA6b8ax7CSXgexndOKT35+NuLqJb1fAn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304440; c=relaxed/simple;
	bh=mOMfCP/70J1+wcOul91GiXFWPKlCnMCNtofnTfKsWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7s7HGUo7EXPSdb14WfeSHhnIudCR2CPUT1pRiBhTd3sNO6MqgDz+u9Ld0a6xu+k3KtwKm8grPb/xflq03T81TlndlfjTRas+ECm9ZBGB3ZxcNQu18l3cMqAur6H/ulQJQwD/eVRMbLquc8NkiGPZ35f6aRzJYRSMlalBsGIec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FH7t8EtQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOMfCP/70J1+wcOul91GiXFWPKlCnMCNtofnTfKsWx4=; b=FH7t8EtQ5gpLzxCcq1gMNzAzg5
	7SyrdyzeYyaeYvSRt8xWhSK3+M9pXOeO9bFzLZ8PBueipb1AZFeQ26TZE1d5Rv4Rhz+XG+xcfHZmF
	HC3ot7Vv9ftKC+R/R+sAiPLEeXZ1NO719gtb0mkonB3z/Bj2c7JuHWfpfPuGMmRfR0nZ444TWNm/0
	I/uk/AzFadqstRurcY796GJ5lLoKMjuotZfiBp0RDWRxyu+MxeyPm0wvSnTjnVS/twVqJQHL1zhXT
	ifE+Gp+q7FQt7iPTEELVicFNArVmee0H5ZvS3+uXjdRcV2tVCgy+TK0O+wDTiOQUZa+EjQZ4gfOI6
	9EE5Qkug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tANN8-0000000GQO7-0Ow1;
	Mon, 11 Nov 2024 05:53:58 +0000
Date: Sun, 10 Nov 2024 21:53:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iomap: reset per-iter state on non-error iter
 advances
Message-ID: <ZzGb9is7JIpNNVkZ@infradead.org>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(btw, can you keep Ccing iomap patches to linux-xfs per the entry
in MAINTAINERS?)


