Return-Path: <linux-fsdevel+bounces-60201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C4B42A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2267858169E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA7238D22;
	Wed,  3 Sep 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlmrm62D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC932F754
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929731; cv=none; b=ZxQnYHZHgc8TMdwZwcCD5XzyC9xoi1mY7UMBNJ32ztm0640yUjAgT4efHiFF77uzjeQQ5bAZGYHCHiQlVBH2gXsvoDVGyMCh7EBfnkTxHNz+F9D7xvQDcShTLIpsjTaQQthsO4ovEbvfWi/kWrOTmVN3CHeN3H7VO2a8q8hehV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929731; c=relaxed/simple;
	bh=vxIovzy/iAeQqbzPhYJg0AFSyB2BO7DsqIFM+fM972g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgMg+D0Fseti+WuPDeb0OnXSEvymJ2teEOFiZhT1iFr1F64av6V4MDmGeQI5VN20YFWAof58PiMk6/pZI4n3u7xAq1vZmtY4EiXQaLBnL9WQ2BlIOi/PT0rJ1u0VNCkKdr12T76fy9f4rEFVLtvBTcAz+Skx6ixFLnTRFTE+yqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlmrm62D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C02C4CEE7;
	Wed,  3 Sep 2025 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929731;
	bh=vxIovzy/iAeQqbzPhYJg0AFSyB2BO7DsqIFM+fM972g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hlmrm62Dm7Kb10KfPCz2NQ3cJGKSLS6Uw2ZLxVRDQVXNI7T6s1VuqmrHMgDMZDp1C
	 ReSntuXtFj8H5TXg2208lA6XNAVjer5xvJtTVDS8Xae2EaR98CKufAJVPa/2hUOHmX
	 1pZYnEFsaR+skYOLDghdMCZOggwOnK2VERCuduhLXvn6N6UCx7Ln46H36H8eXO+Vqg
	 k+vHn0YUSyQzyVU/9cnxqx+uHhTIySua5sMcOJLShXabwOEYG99fjun47GaQW+KhqE
	 qy4+DFgvtZDQ4G/4QjaIfWSbEqXQp6jSKdzYqm0ecUVPiIc8mp5UHUItsDRX4wILR9
	 bR4OVqUgVkclQ==
Date: Wed, 3 Sep 2025 13:02:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	brauner@kernel.org, willy@infradead.org, jack@suse.cz,
	hch@infradead.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 01/12] mm: pass number of pages to
 __folio_start_writeback()
Message-ID: <20250903200210.GJ1587915@frogsfrogsfrogs>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-2-joannelkoong@gmail.com>
 <e130c95a-103c-40ba-95d9-2da4303ed2fd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e130c95a-103c-40ba-95d9-2da4303ed2fd@redhat.com>

On Wed, Sep 03, 2025 at 01:48:41PM +0200, David Hildenbrand wrote:
> On 30.08.25 01:39, Joanne Koong wrote:
> > Add an additional arg to __folio_start_writeback() that takes in the
> > number of pages to write back.
> 
> Usually we pass something like page+nr_pages so we know the actual range. I
> assume here this is not required, because we only care about using the
> #pages for accounting purposes, right?

I think all the "nr_pages" here are actually the number of dirty pages
in the folio, right?  Or so I gather since later patches have iomap
walking bitmaps to find all the set/clear bits.  Perhaps that parameter
ought to be called nr_dirty(_pages)?

--D

> -- 
> Cheers
> 
> David / dhildenb
> 
> 

