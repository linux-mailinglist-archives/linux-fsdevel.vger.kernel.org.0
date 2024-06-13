Return-Path: <linux-fsdevel+bounces-21654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32A9076BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92391283232
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5629712EBF3;
	Thu, 13 Jun 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmE6lUHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E915BACF;
	Thu, 13 Jun 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292765; cv=none; b=Mn8CsJUnlfggNf44eW1dgNot0CRw5sJT4URbkIeeReo+kclElE6xw4wXv1UA0oKddZUjDrHCjeZFwbQZ7bkoLQ5ZfSXKIMoX7YRkpjh/IaQDMUFXlOwTuxopv+VBnGE8Ju0nOJHo0vCiKIpZzB3v5apT2DjM5loMkBXsJE+IGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292765; c=relaxed/simple;
	bh=QuUHK0e/otJ7SUMe1STzRoAujp3yiqn/wk9YrOIAIGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9gB2T/oKx+NmGx7CDOr4rYEKZ4AEZALyYWPKTWMOELGm8nzQ7W7473R87P6vDreuWWSU2v69sviDUCCM64sJ7Y22YmgPHaIYxoAv8t4D5ccb1AIyj1LFGUwDnkPGchiXfrcbli/DGprBJeOFmEARcc/9UEtFVx0ShOyFJbFyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmE6lUHe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QuUHK0e/otJ7SUMe1STzRoAujp3yiqn/wk9YrOIAIGU=; b=OmE6lUHeM97WFUAxa68p7/25WE
	+JWiU42q4yaWKpro+SCqVFS2hBT9euSWZnRQgxkdXevU7aPzbnI5fKRWfohmThYb9GpV+x6+cc4DX
	jmWjSvDpTZEFaOQKSCelogn4r2Ae7wrz0C7wOlyA3F+U5GUyz/HPxhHsk6Ely7CBBSAsMP7ANXYgm
	xzGIl82TKR8n5FduOTiQfOW9xH9v909roc0nxu5k7aaqSSi4GP38bkABKkdle4BQ5+GsKusAXNXAq
	fyv0mELBqiQK8S3RGjmTP0gEckmfNdXE/RhIiVXaltDbnu7qfrFr4tPgoOR6p6piJQXatQ9at7XAo
	SQl1m/qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmR9-0000000FuPW-1kCJ;
	Thu, 13 Jun 2024 15:32:27 +0000
Date: Thu, 13 Jun 2024 16:32:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <ZmsRC8YF-JEc_dQ0@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
 <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
 <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
 <ZmsP36zmg2-hgtak@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsP36zmg2-hgtak@bombadil.infradead.org>

On Thu, Jun 13, 2024 at 08:27:27AM -0700, Luis Chamberlain wrote:
> The case I tested that failed the test was tmpfs with huge pages (not
> large folios). So should we then have this:

No.

