Return-Path: <linux-fsdevel+bounces-17987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FD8B48F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F709B21419
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7A10F2;
	Sun, 28 Apr 2024 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWHqDCYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758067E1;
	Sun, 28 Apr 2024 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714265848; cv=none; b=cog7h0mayUNiy74bCCewoqZKCwaKH6d/MOtgEPlT9kQxgOor0SkrnAqR13RNsyijiqmJdRWuvnTMHXjNqetCPfSY8KXW8n6sHoL95EoWPlRJq22uPMIY8iuqRQukdIA2G1ltX3lo/6Wwol+mUEhr5svaMDOkMnABPfRgDOgGSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714265848; c=relaxed/simple;
	bh=54uIGKbchIqeyGHCinmigs69p/bVqpwlPIcL4lKukpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uonBy4nHXkFcmUKnQcq79r86Pm3L9ZoB9gyNuX2KMUniWp4vCuyqqSa5HTGDPaHNYsszm8QiuH6qGFpfFqsHG4fw+QBsTF4I/tN/dTbTUyjyfqKKKkr92xEhC6MSCEmv9HfynDqc6/CT9bU3Xw2oYeq0y/WICxWi8yJfZ0Otpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IWHqDCYU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iEhnO4AWXoNxFsAFeSCOgVl/u1tIJg7C/6bLYFJsfso=; b=IWHqDCYUczIV+YtqAUlL6HVU+V
	qCtZyJpY5Sh2NfLpSQK0jlGyEtErUphjfxsjrprhsLPjB+PmckQ17consJv5VugT5B64CyFQ3dIAD
	WajK1Il7ARNNEV/N8P0Mb0R5DHCFMJoAMKyWI7Qmz4Lu6MNnDpgneBWjCEKZoSN8OpO1PbghXkg+c
	vrs8MDYIDAUlKDlpojo4H5DPbN0R8m6m/6qvwBnplNJ9p4Lm03LOOuvj5k846ad5o1rV/sczirBif
	P5BktIszYYw7GDr4ZqNSZVwKat58sz1tf2UdKbpR4DrowlURDVSud5kA9E9EvWWc+Q5LmyKtpUtoW
	wy8sUNtw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0sqz-0000000GWGt-1oqf;
	Sun, 28 Apr 2024 00:57:17 +0000
Date: Sat, 27 Apr 2024 17:57:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
> > On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > 
> > > > using that API for LBS is resulting in an NULL ptr dereference
> > > > error in the writeback path [1].
> > > >
> > > > [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> > > 
> > >  How would I go about reproducing this?

Well so the below fixes this but I am not sure if this is correct.
folio_mark_dirty() at least says that a folio should not be truncated
while its running. I am not sure if we should try to split folios then
even though we check for writeback once. truncate_inode_partial_folio()
will folio_wait_writeback() but it will split_folio() before checking
for claiming to fail to truncate with folio_test_dirty(). But since the
folio is locked its not clear why this should be possible.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 83955362d41c..90195506211a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (folio_test_writeback(folio))
+	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return -EBUSY;
 
 	if (!folio_test_anon(folio)) {

