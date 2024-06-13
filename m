Return-Path: <linux-fsdevel+bounces-21655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC79076CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29531F2293D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628F12E1CE;
	Thu, 13 Jun 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uyHdUvob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A7A23;
	Thu, 13 Jun 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293109; cv=none; b=CedVuZ3RnLrjRGOhjFksTISf+RkjDtCoWr2N4X/rjDiSula91HLbksrtrCbwGZGFR2nGqRcn5RG1XSGJmkHNosOPywtFw+iS+1drLQVHfNPUzJqEDcj7pcZ1w0k95JbB/QqGSAtTAxUfaX2yLUcHnSQ96tajj+IFC+2tBm0Q0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293109; c=relaxed/simple;
	bh=FrvBVhz0++2R4BSv8Qtuukl2qRYtnPm/zmZw8ORB0Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdbqO7nIj13/RLCc4UBXmYGxFjUhJCQfx9scJXOkZfd1NaEE1zOt6DvMRFHHZZGc6MOco/a3jAnudR+r/msqDnW+01j4605huAO5B6ArDnxHHcQIDAitNm/XH9hvaDdGSCf9PAt1erboy0eVWkTahaXuDQUIrYtPe93CZkf6Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uyHdUvob; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QqcQdAVSX0DGR4a20koQtjFGscN2RD3oSHZsa+S9uOc=; b=uyHdUvobNQT50e966AtRjS6tNw
	KoDzyBBRuqsPCQYzqTF/Bmtb59n6/BhVjArn5563FiGMCTcapDCTwG8LbqdbrQkz4RCl8bI73zU0d
	Y9C/0/ILQkLVjKj1SU9pmyaF7CbV3PGmrlFudbTEOXB+KBS4J6b2Zc5WaVfL+AJd9FpBBeNWLTY5Q
	N/xRM405+UjnpdPsIM5WJGW7vzJU9lSIOmaAjDrxHlyRXp0t5CiZGuo9cFIdU471ZCECypXJaMRbg
	trICrD3W/Q5n8RD4aUoE6POLfKUBTK6p4b4oR8gYxKTdcKvEiJNwc4RPvmtCu5YSXlicPGse2TxfC
	4KZ5WHgA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmWl-0000000HC76-0vUu;
	Thu, 13 Jun 2024 15:38:15 +0000
Date: Thu, 13 Jun 2024 08:38:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
	yang@os.amperecomputing.com, linmiaohe@huawei.com,
	muchun.song@linux.dev, osalvador@suse.de,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmsSZzIGCfOXPKjj@bombadil.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
 <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
 <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
 <ZmsP36zmg2-hgtak@bombadil.infradead.org>
 <ZmsRC8YF-JEc_dQ0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsRC8YF-JEc_dQ0@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jun 13, 2024 at 04:32:27PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 13, 2024 at 08:27:27AM -0700, Luis Chamberlain wrote:
> > The case I tested that failed the test was tmpfs with huge pages (not
> > large folios). So should we then have this:
> 
> No.

OK so this does have a change for tmpfs with huge pages enabled, do we
take the position then this is a fix for that?

  Luis

