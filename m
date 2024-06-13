Return-Path: <linux-fsdevel+bounces-21609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16790664A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C331F235C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241F13D273;
	Thu, 13 Jun 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="STjcwns+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69213D259;
	Thu, 13 Jun 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266413; cv=none; b=pdpHoqWqvpYjfljLR1SrAj1m41waf+phzYpHhHEYv2AZ3TY7+gKMyEOJ7O2+/zhxolRd9ypLo7m//zvY0X+lRnch97Q3DYEdLd4yUj+s9wDOsW0z2LpgKk2MgOsIw96Sd3UNrsBvt5nRt571nuz79cDf2KzX71GMnDqle9Bedqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266413; c=relaxed/simple;
	bh=bVzbWx8oclR9J4LHR055JqNiEL6Gv26xOOc1+qAaEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXEBP19VVcEmVGUn7yQ+k+K0df5dAR+Tz6hiSLhRLEWM+S9mHWhse+v+1YoavDSCQma06LbMWcUSq/YbzANImTBTf61cyJuUjZO8O/Kf6GLzGhWDKTe/TxbuvtSgta4ZkOAaC0wccAPk5Pq1mpAGVI5nr3WDqar+wn5/pfsmPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=STjcwns+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4tDm3WgVInHNS/5kjhxvZFPWNjbm8XCD62VosdI0ZqA=; b=STjcwns+MX7WwUCdz1orWSM+Oj
	MUeT6jui1SDjdDuqrURypebhDqwJ6MHl5cPNgkhTystt12Ki3pzS9YNSwjojRp283glskdoCp0weI
	shnQ30LJJ9r2GvGAMVL76bISmjFRxokLlIMzj7kYvGtalND19sljJCVCYpb+oK8hBKIQ1F7s5wxQB
	xMJn61quhpGFEbCg51p1+WP++ulC67UsqdQiarG6+jB9yhNQGyw2FsQc/IQZX0Q7v7v6wI3xo3fMg
	tJSOwzsezRp8vr209sbjUexBdi8O0Q87zzQHdqSAveDjMo6N0O0gHWNlR/DWIkGJdOBVixOK6ApcG
	p7WyiSXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfaE-0000000FdVc-3F1j;
	Thu, 13 Jun 2024 08:13:22 +0000
Date: Thu, 13 Jun 2024 01:13:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
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
Message-ID: <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jun 13, 2024 at 10:07:15AM +0200, David Hildenbrand wrote:
> On 13.06.24 09:57, Luis Chamberlain wrote:
> > On Wed, Jun 12, 2024 at 08:08:15PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jun 07, 2024 at 02:58:57PM +0000, Pankaj Raghav (Samsung) wrote:
> > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > 
> > > > Usually the page cache does not extend beyond the size of the inode,
> > > > therefore, no PTEs are created for folios that extend beyond the size.
> > > > 
> > > > But with LBS support, we might extend page cache beyond the size of the
> > > > inode as we need to guarantee folios of minimum order. Cap the PTE range
> > > > to be created for the page cache up to the max allowed zero-fill file
> > > > end, which is aligned to the PAGE_SIZE.
> > > 
> > > I think this is slightly misleading because we might well zero-fill
> > > to the end of the folio.  The issue is that we're supposed to SIGBUS
> > > if userspace accesses pages which lie entirely beyond the end of this
> > > file.  Can you rephrase this?
> > > 
> > > (from mmap(2))
> > >         SIGBUS Attempted access to a page of the buffer that lies beyond the end
> > >                of the mapped file.  For an explanation of the treatment  of  the
> > >                bytes  in  the  page that corresponds to the end of a mapped file
> > >                that is not a multiple of the page size, see NOTES.
> > > 
> > > 
> > > The code is good though.
> > > 
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Since I've been curating the respective fstests test to test for this
> > POSIX corner case [0] I wanted to enable the test for tmpfs instead of
> > skipping it as I originally had it, and that meant also realizing mmap(2)
> > specifically says this now:
> > 
> > Huge page (Huge TLB) mappings
> 
> Confusion alert: this likely talks about hugetlb (MAP_HUGETLB), not THP and
> friends.
> 
> So it might not be required for below changes.

Thanks, I had to ask as we're dusting off this little obscure corner of
the universe. Reason I ask, is the test fails for tmpfs with huge pages,
and this patch fixes it, but it got me wondering the above applies also
to tmpfs with huge pages.

  Luis

