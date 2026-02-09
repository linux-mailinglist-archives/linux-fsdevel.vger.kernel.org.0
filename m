Return-Path: <linux-fsdevel+bounces-76751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDe6DkU/imlGIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:10:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DC114581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C960300B9FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F82DCC13;
	Mon,  9 Feb 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFVXZSa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030A2DEA6B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667840; cv=none; b=mqXcCR72bWs/L4+C2sQ/4xIk4U6haK75p241jIa01BwAkN0Q3jK9k8LF347iNyl3Psa5dG+akju2hhP4phbCoeO/doMg3T+A467cVCh+I4imf09F9WLkEPFa2tEiHg0iqLX3kac67Z9G521YUC09YxTrfiC8q0BTDBHfXgWbX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667840; c=relaxed/simple;
	bh=Ub3xib2q2Kd4FePhGQrDrFB+CH036qqHlSOOKdTSrAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDRR8r9b4X2KiuBMNw3uqs0kFumtsHNtJQNAR7FLLXclOHPmhOU0lbQY8l08xIgM/cPU1M5H/+A80/5OM0vnVI+nFdmYBRfx9NdvY8wsNQZuJ60t8V4+T60j9HLrs8VU6g+agmOEaTzy6JyFNP4vIbc0s5Uiy0CuyQ0UwXCevJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFVXZSa8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770667840; x=1802203840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ub3xib2q2Kd4FePhGQrDrFB+CH036qqHlSOOKdTSrAI=;
  b=BFVXZSa86uTiT7UGeLkPmGMtZxZAwfXfE63/ve+wVy1UOfFQVtsYp8Zc
   PXIDJmqICOzgd/K2F2CbuaXcAvlMZsOTVOoReyZGjw41ewWT6G6e8l6kT
   MwgTIOWC7iunbSDJ+HIuVeGhzkWCwoMn0g3bWGMuju0eYiBxbeuSHQ5qI
   xLR2twu/wCCZIZNiZGoTqK/HSvYQzvkNjgPyOz6VN/A9wsNr2o0/CpddJ
   BLB6Vbbyn1owhrVVGTm9fhjjJzovUHed0Eh3Qhzxu25TFsXhg/qMzP0zg
   YmvA1+EtDBLd7wuSU93cd8jzF8dVPFjtnJ7+037uH27RPp2mqp9Ji5kWC
   g==;
X-CSE-ConnectionGUID: FdUpBnNVTrqqqJyqmKKsKQ==
X-CSE-MsgGUID: 3eUzkJuBQkyKU97DbsFxSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89204846"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="89204846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 12:10:39 -0800
X-CSE-ConnectionGUID: 4bSyStmOScmHsfiH8aJo2g==
X-CSE-MsgGUID: yqMOwH24TiqKYpgvv13Apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="242307196"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 12:10:39 -0800
Date: Mon, 9 Feb 2026 12:10:37 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] smaps: Report correct page sizes with THP
Message-ID: <aYo_PWYK5ezWLoO6@tassilo>
References: <20260209193223.230797-1-ak@linux.intel.com>
 <aYo91kREDEIsM60V@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYo91kREDEIsM60V@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76751-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 881DC114581
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:04:38PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 09, 2026 at 11:32:23AM -0800, Andi Kleen wrote:
> > +	} else {
> > +		unsigned ps = vma_mmu_pagesize(vma);
> > +		/* Will need adjustments when more THP page sizes are added. */
> > +		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", ps);
> > +		if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp > 0 &&
> > +		    ps != HPAGE_PMD_SIZE)
> > +			SEQ_PUT_DEC(" kB\nMMUPageSize2:   ", HPAGE_PMD_SIZE);
> > +	}
> 
> I'm not a fan of adding support for just two page sizes when we already
> know that we need to support many.  Particularly not with such an
> uninformative name as "MMUPageSize2".

What is uninformative about it? 

I intentionally used the number to make it extensible for the future,
you can add MMUPageSize3 and 4 and beyond, although the current code doesn't
implement it.

> 
> Something like MMUOtherPageSizes: 64Kib,256KiB,2MiB would work for me.
> But maybe other people have better ideas.

I considered just adding the numbers to a single line (the existing one),
but the risk of breaking some existing parser seemed too high. No other entry
in smaps has multiple numbers, and it seems to be against standard /proc
conventions.

-Andi

