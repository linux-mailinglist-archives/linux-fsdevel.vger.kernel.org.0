Return-Path: <linux-fsdevel+bounces-77537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBbxChBilWl6QAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:54:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE515387B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E723019068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3353309EE8;
	Wed, 18 Feb 2026 06:53:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97C1DF73C;
	Wed, 18 Feb 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397639; cv=none; b=IVowVnNNnPZIiuPe0XT/gwIvkd+Pnht4hIi4Sc9ad9FSlTMJUTiJfH4QwJJo+CkeuEqJfcmPGZaKq5FlMhunSZ8mLqCObsZCDCL3CsDjnEeeLAei5Vj+p+rAc/uX702YDOfvi+jaXfNqxqGXbySaU/YgZ7Y5kkEEcZJ6c21rGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397639; c=relaxed/simple;
	bh=QIphd3WJ79WCF+z9/Fn0REHKAqiLCDZ0bz5bWgP3e74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju0p/EAU+8O7V+e22E7qC/qhBCA+onHtCK/jAQaHGoK8flD7letVOkFnja1Izy+/V4J03niHrGCz23t4Z1XhpRmgMEesSCy4aOEoSTswlepfZZmAmEsMKUcoKba2SDS2zOr1cJcdlIyPrOheiHDOy+p+jSIFMex/EoRH3Gl65Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 946E068B05; Wed, 18 Feb 2026 07:53:53 +0100 (CET)
Date: Wed, 18 Feb 2026 07:53:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andres Freund <andres@anarazel.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, ritesh.list@gmail.com,
	jack@suse.cz, ojaswin@linux.ibm.com,
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <20260218065353.GA9072@lst.de>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev> <20260217055103.GA6174@lst.de> <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com> <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77537-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 72FE515387B
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:47:07AM -0500, Andres Freund wrote:
> Most prominently: With DIO concurrently extending multiple files leads to
> quite terrible fragmentation, at least with XFS. Forcing us to
> over-aggressively use fallocate(), truncating later if it turns out we need
> less space. The fallocate in turn triggers slowness in the write paths, as
> writing to uninitialized extents is a metadata operation.  It'd be great if
> the allocation behaviour with concurrent file extension could be improved and
> if we could have a fallocate mode that forces extents to be initialized.

As Dave already mentioned, if you do concurrent allocations (extension
or hole filling), setting an extent size hint is probably a good idea.
We could try to look into heuristics, but chances are that they would
degrade other use caes.  Details would be useful as a report on the
XFS list.

> 
> A secondary issue is that with the buffer pool sizes necessary for DIO use on
> bigger systems, creating the anonymous memory mapping becomes painfully slow
> if we use MAP_POPULATE - which we kinda need to do, as otherwise performance
> is very inconsistent initially (often iomap -> gup -> handle_mm_fault ->
> folio_zero_user uses the majority of the CPU). We've been experimenting with
> not using MAP_POPULATE and using multiple threads to populate the mapping in
> parallel, but that feels not like something that userspace ought to have to
> do.  It's easier to work around for us that the uninitialized extent
> conversion issue, but it still is something we IMO shouldn't have to do.

Please report this to linux-mm.


