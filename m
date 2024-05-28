Return-Path: <linux-fsdevel+bounces-20336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95A8D190B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8289E1F23C15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684416C458;
	Tue, 28 May 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CH3dxB++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CA16B757;
	Tue, 28 May 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893864; cv=none; b=mC+vUduPaxHp/ad4KqnxZIoo8ijxIPD3KBPyz1MONd+LumtPOOYj+zawXQyYBN3VzfbJvqBAcNX7W9D+kIWAFaGorq7kuvf2/h4d7hDFErW0twNOA0dSrTpfcwh5SGORaX7oxQRZFNnbumiDLEWWfqmISlH4Zl5cHB/Uly0CWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893864; c=relaxed/simple;
	bh=c/m3xEKbhpp6m/KzhlgzeEJVnfxcnQAyQ9VW4N9I1mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siHnlC93RfwWLjgmj9AnYpXBxaDieeD/bn3acP1r8tQi17DmW1WIURhyJAS8TXlVgwjNztlz/l1yaZsfu3Ku8wardNoGCUuVSXYHKEAkcswRYBXEtU5lYsGszL1kGiQYwlt6Ksx/eV92Oc/zoErV+S+U/keCWGIjiBnY+hICAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CH3dxB++; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4s2+SoCd+hCES+4mr97S7Vwnc2NrQ4b33WmHNmjp2/U=; b=CH3dxB++PZES5GIV/UuDLIINgO
	B6TiEaGCFVxfyo6mpn3mKyp+cmGGc7tSgWSxpcJZ7pbS87sgua+0jMBpwYt1hlKsCdHUvXxL3ACtm
	lcit36iv6j4Vhr95wu3aegbCU8z64S/zQo+XbbCEmkyYhMHp77ZMNGnGDDurVZiS7kV2ReXU72eVd
	mvynILZhQXcfPqOpse7ZM5N6njDPhKML1k4VERQe4PVsdaR/7LSqQjt0StWuFN7C1HocinGHowM6d
	TLBEMgP56CiPH3GWXFcXYZKJifsnUWIJ2xZkj8WrWyY51x5celVdE7AZHWigqS61/ZF0cmUb4/rbM
	SuSI9RCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuWR-00000000I0E-3DIG;
	Tue, 28 May 2024 10:57:39 +0000
Date: Tue, 28 May 2024 03:57:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Luis Chamberlain <mcgrof@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <ZlW4o4O9saBw5Xjr@infradead.org>
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk89vBVAeny6v13q@infradead.org>
 <4c68c88d-496c-4294-95a8-d2384d380fd3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c68c88d-496c-4294-95a8-d2384d380fd3@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 10:21:15AM +0100, John Garry wrote:
> If so, I am not sure if a mmap interface would work for DB usecase, like
> PostgreSQL. I can ask.

Databases really should be using direct I/O for various reasons.  And if
Postgres still isn't doing that we shouldn't work around that in the
kernel.


