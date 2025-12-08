Return-Path: <linux-fsdevel+bounces-70964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEDCACA36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50EDF301A725
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3A2F25F0;
	Mon,  8 Dec 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjN1SahT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088B2C21C0;
	Mon,  8 Dec 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185728; cv=none; b=A2X8UwnBnUwqbCKe8kpE2fYhPsTckJlEiNqRfMOVwT+w82U+N8fw2RJiTTuPm35miNzz2YlYT+B6woSgQcwrejPgvySJ52+C3Nr++x0X3MSNIxcQ1JRA3OoPqWGoHugMWa2ZghrtltGVXpDkXyyIWvYYv9BP/20qmHaS7TfiMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185728; c=relaxed/simple;
	bh=1y+h/RRhbiOiejemkWoAfy9ANDy/n/eMEI/mQUh9wpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4+Zc4SoWLykE6M2w4+Heav2STnMND74FeEdYeGfLUXqeObltstLkP5ZXy+aXKLaY0mHroiMB+EEDsmAHqG57fY9DzkAu6BJSSIXHpXxRb0UFAfdh0nZcw+JQrBF9C0Ao0FQ5cOn63EaQdW+2YcQhfiqj19HdX/Lq48CBoZvkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qjN1SahT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0dcNIAJdjwBa1TCUp38vaur9HiS4AJA/cGpCIXdnO5E=; b=qjN1SahTYyloXwm8SJrCrf184I
	w9otFRfJIiodnl9/tkfHtO4amgYDh3/l7ydG9N8jUIaIEFReEkPhEbGPBfzJLPA1P3VjD/0InX4Hp
	ZukfS//KM0ELhf/LrFMpObb6pJjVA3uE9LeBBfzwgb3as7+Tf5XIm+SLGDGJdPNlYBoGwNAUh2Vl0
	yvWlMG7GDDSC/pSw3Ncwubutwjued2F6uMyWlmhsRFsm3ar3Guo1WoZZ4xEXtzCpO9U5YE+u8dRtJ
	H364kKN9S6hwEv7NLtxWfLATsWg3e8U3nKECruHTRbtkxYWRzFlz11xTbvp7HTGrZx3QxcduZbuhn
	j4tYR28A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSXRO-00000009aFr-4Bvx;
	Mon, 08 Dec 2025 09:21:59 +0000
Date: Mon, 8 Dec 2025 09:21:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>, Alex Mastro <amastro@fb.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>,
	Yi Liu <yi.l.liu@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: Add file_operations.get_mapping_order()
Message-ID: <aTaYtlTdhxKx2R24@casper.infradead.org>
References: <20251204151003.171039-1-peterx@redhat.com>
 <20251204151003.171039-3-peterx@redhat.com>
 <aTGmkHsRSsnneW0G@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTGmkHsRSsnneW0G@x1.local>

On Thu, Dec 04, 2025 at 10:19:44AM -0500, Peter Xu wrote:
> > Add one new file operation, get_mapping_order().  It can be used by file
> > backends to report mapping order hints.

This seems like a terrible idea.  I'll look at it after Plumbers.

