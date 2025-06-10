Return-Path: <linux-fsdevel+bounces-51100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B4AD2C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC8516E73A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E825DAFC;
	Tue, 10 Jun 2025 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzMjDDOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22F25D8E0;
	Tue, 10 Jun 2025 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529297; cv=none; b=ov3zSzfvlQ8UEKOHenSY8eU5MZQiFrKoZN1wxDAIFaKnb3VfpfRVPe/xlM+5d4Ndjth5qGgx2SuwMmMOgKZDqG4rJF7zodYk3xTeJB2lZ7JwSMZStrbHG7ez4/MyQZOQHBQNHzhnkUznBpNMuUpCZQ7OGe6sijFhMRE+Muj+JBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529297; c=relaxed/simple;
	bh=KLjRQHniKA+gffqwcYAxeudaF+tEGRZWYLJlvjzEdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz2TWeN2CvZHRk1f79NbiFf3JmeS8+jNO0CZ3jVu+lO2ZEG2bBEx9XvEh+j9ny38nTtuHRrjIyuzDkqa2Tn8Abozp542JJBwfVGTsjHDi9pmdB3q9JQA/DYtmL3ZlbOs590Q8q7oEg9a3riUyW2gQZe0gJKgwRnunkyiucg+Xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JzMjDDOI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0clwr9vbeRCKOE9WcmGuqNgAuzM91WDDv0FB3e4qu1k=; b=JzMjDDOIc8ZHDmkBp3TqSZCgo3
	4l9LDhahZJMpHyzPpIDotOY4caYhElrxgOfQuzB5nBfiU20SB0JJ9oPNrDARqnMzhtnKB1nUIDO1n
	2RNqJWIVuhrKrnp6/f3kackvxfEm212yLAN6g/zsJn3fTMKDaYp3aM8e8fAHBkETGmPTS01qwIYVx
	n24NFwN1RWjk3nGAOoo8NWwj7jwBvhlRzBGMSXoy3Eh/84PTU5FwMVKjfSWhp3KpOna+FRINqdn/X
	Y1Lmcqugo2jn3+7uewWK43tp/VAMb9lfGsySWiu0UX3bxi3gBXcfhmIFEBaKlzzBAfdtu3clARDPM
	ZXbGFV9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqUR-00000005k0Q-21dG;
	Tue, 10 Jun 2025 04:21:35 +0000
Date: Mon, 9 Jun 2025 21:21:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <aEeyz4UUs2P76CDu@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-3-bfoster@redhat.com>
 <20250609154802.GB6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154802.GB6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 08:48:02AM -0700, Darrick J. Wong wrote:
> You might want to cc willy directly on this one... 

And keep it first in the series as the non-subsystem dependency.


