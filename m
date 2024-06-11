Return-Path: <linux-fsdevel+bounces-21460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CB90434E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D9E28D509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A784F5F9;
	Tue, 11 Jun 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k86RAQaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F0249E5;
	Tue, 11 Jun 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129756; cv=none; b=KAZZItJLRVUzFysXFpumllZ+GIaiH+LSYDBb9K6OiQSEogZSfghK1Y4bGUZHYHwzXPFNHjWJbwik9FVBK4uxlHKpfSgjR3raJePX5nIJiMwfgpi4qP/YzV0DoZ5/NODfQZd5am3mjB27+WCrAnCK1MnmvaLOaQW7hwgEPJ2iMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129756; c=relaxed/simple;
	bh=v46CDCGwGUeW+lfXszQlWf78g2fNI8PxH/dA9IlvNhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtMx1N2Ux8hfdmz4nag8F0wECz8mb66YJGrZCbcLRZ5JzTdbBAGQTBZcxh/CMmrkS5YPsYV9KE3Ym8hU4GfaOut8VubCgZZniRT9vzN4DW0OR/4loKWqJVur9PTJLl8EkrH9f3PSHktB0dgZTZiIW1s4hB+ZusO9Q3qnohYPpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k86RAQaJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=we709GSrSi71LXBSzqvO1IMG9MEKMIAa8MQWGK8e8Rg=; b=k86RAQaJB2pO/3bH4b5xgLqG3O
	m9XVNqyJEnWSDrNZxjEkMeafgLdxxuFtWk2l6aRqhG89GNqV9y50TJehG3bSG2REq/s01oLbqT41D
	emhDRSIQQF7Vqys1AEgOzlWFYUvJQo+wbPVE5A9XGenYTz+fe1j7AweyTnE5x6iBNsQdrdVXEi2dn
	rE3DEjsuD3/to1vdDILnLurdUn5ljJBUn8L+0KiswP5vNrPYb5ZKxgRYQ/KYYrtxjOKLmDpMUYpXL
	fWomhalzcwK7yw1Va5svurPLM5IewVNdpx/n00AvCvy3tovDi8atK6smav4j7rCqLI/x10zdIWJ6t
	PmdZrMUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH62C-00000009oHv-2dF3;
	Tue, 11 Jun 2024 18:15:52 +0000
Date: Tue, 11 Jun 2024 11:15:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 5/5] fstests: add stress truncation + writeback test
Message-ID: <ZmiUWCPcmtFSdrBG@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-6-mcgrof@kernel.org>
 <20240611144503.GI52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611144503.GI52977@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jun 11, 2024 at 07:45:03AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 10, 2024 at 08:02:02PM -0700, Luis Chamberlain wrote:
> > +# Requires CONFIG_DEBUGFS and truncation knobs
> > +_require_split_debugfs()
> 
> Er... I thought "split" referred to debugfs itself.
> 
> _require_split_huge_pages_knob?

Much better, thanks.

> > +# This aims at trying to reproduce a difficult to reproduce bug found with
> > +# min order. The issue was root caused to an xarray bug when we split folios
> > +# to another order other than 0. This functionality is used to support min
> > +# order. The crash:
> > +#
> > +# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> 
> You might want to paste the stacktrace in here directly, in case the
> gist ever goes away.

Its not a simple crash trace, it is pretty enourmous considering I
decoded it, and it has all locking candidates. Even including it after
the "---" lines of the patch might make someone go: TLDR. Thoughts?

> > +if grep -q thp_split_page /proc/vmstat; then
> > +	split_count_after=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
> > +	split_count_failed_after=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
> 
> I think this ought to be a separate function for cleanliness?
> 
> _proc_vmstat()
> {
> 	awk -v name="$1" '{if ($1 ~ name) {print($2)}}' /proc/vmstat
> }

> Otherwise this test looks fine to me.

Thanks!

  Luis

