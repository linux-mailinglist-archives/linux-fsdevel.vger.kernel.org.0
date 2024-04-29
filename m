Return-Path: <linux-fsdevel+bounces-18049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E146A8B5018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102901C212D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73414946C;
	Mon, 29 Apr 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2pAx3w3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696A8479;
	Mon, 29 Apr 2024 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362988; cv=none; b=Vz+OuSukuTFFc/MtrMG9iP84OZS/rbpKByD/l2XReyFc03+CdSyO2l7qMlixGkEbx+ESa1pzZw5vLwyFBQnbSxzYrb/cRaXb958m1jwlXMezi66GC8OLeVHKQHJp/PzQ68y3jIFNXm58eD1/b14vnOXRap5YkL8QwU36q5YzE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362988; c=relaxed/simple;
	bh=XJS/wNKVpkKXwu4FK8kulhTLv8pmwsUK//7rgNoEvY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+p1ZHggydClgO9Ld6n1+2zsDmRfUL+g8dLniby8SQ7SmlIKrs67sbTiqDODvVPtzt1aAZrH5JnXqbFCbuL2w+0B54JhwpYpaHPZgZ/t/C8RE69lGg2e2SzqjTH8atVANt5tNNdfwXUivdDyvNWvvRBReATCWqfiKp2aMyw3Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2pAx3w3o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xQ7whOK409YxkR8Cv9BM5mtiIqTovmirR+KC4rgl/J4=; b=2pAx3w3ow/jnTJlSmv8QmTHjrD
	B0RT8e/LrlDCHLWFAauIURbiHtBo+n1AMqZ0znWx0rHthWQmRoWpRYeD9dpj+QuAjDhp/F4TxbBAF
	I6A/DVak/OEMXkZ9qPyP3H2/yt4eYjXX0Y50CJVs7y2ulSG4qLDVQ9v3sq0wkMN2jRAON4vj+KPT3
	pXMwc8L5RIf9eyISFTe3R0xGslYbHA8mWkkxnLji1Vc9ngrStLCwdiyn+tDSjY/IUyuwvUmDqP3Jj
	A7YxDlR19mv4ZyqtPG2L2BLIfmUoQ1GZzX8XJSTw0a0+krFXQp4VTaNJcUgBM4nnkmSE/kUk1LcW1
	mCoQarMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1I7k-00000001NGG-2qwx;
	Mon, 29 Apr 2024 03:56:16 +0000
Date: Sun, 28 Apr 2024 20:56:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Apr 27, 2024 at 05:57:17PM -0700, Luis Chamberlain wrote:
> On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
> > On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
> > > On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> > > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > > 
> > > > > using that API for LBS is resulting in an NULL ptr dereference
> > > > > error in the writeback path [1].
> > > > >
> > > > > [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> > > > 
> > > >  How would I go about reproducing this?
> 
> Well so the below fixes this but I am not sure if this is correct.
> folio_mark_dirty() at least says that a folio should not be truncated
> while its running. I am not sure if we should try to split folios then
> even though we check for writeback once. truncate_inode_partial_folio()
> will folio_wait_writeback() but it will split_folio() before checking
> for claiming to fail to truncate with folio_test_dirty(). But since the
> folio is locked its not clear why this should be possible.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 83955362d41c..90195506211a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	if (new_order >= folio_order(folio))
>  		return -EINVAL;
>  
> -	if (folio_test_writeback(folio))
> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return -EBUSY;
>  
>  	if (!folio_test_anon(folio)) {

I wondered what code path is causing this and triggering this null
pointer, so I just sprinkled a check here:

	VM_BUG_ON_FOLIO(folio_test_dirty(folio), folio);

The answer was:

kcompactd() --> migrate_pages_batch()
                  --> try_split_folio --> split_folio_to_list() -->
		       split_huge_page_to_list_to_order()

Since it took running fstests generic/447 twice to reproduce the crash
with a minorder and 16k block size, modified generic/447 as followed and
it helps to speed up the reproducer with just running the test once:

diff --git a/tests/generic/447 b/tests/generic/447
index 16b814ee7347..43050b58e8ba 100755
--- a/tests/generic/447
+++ b/tests/generic/447
@@ -36,6 +39,15 @@ _scratch_mount >> "$seqres.full" 2>&1
 testdir="$SCRATCH_MNT/test-$seq"
 mkdir "$testdir"
 
+runfile="$tmp.compaction"
+touch $runfile
+while [ -e $runfile ]; do
+	echo 1 > /proc/sys/vm/compact_memory
+	sleep 10
+done &
+compaction_pid=$!
+
+
 # Setup for one million blocks, but we'll accept stress testing down to
 # 2^17 blocks... that should be plenty for anyone.
 fnr=20
@@ -69,6 +81,8 @@ _scratch_cycle_mount
 echo "Delete file1"
 rm -rf $testdir/file1
 
+rm -f $runfile
+wait > /dev/null 2>&1
 # success, all done
 status=0
 exit

And I verified that moving the check only to the migrate_pages_batch()
path also fixes the crash:

diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..83b528eb7100 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 	int rc;
 
 	folio_lock(folio);
+	if (folio_test_dirty(folio)) {
+		rc = -EBUSY;
+		goto out;
+	}
 	rc = split_folio_to_list(folio, split_folios);
+out:
 	folio_unlock(folio);
 	if (!rc)
 		list_move_tail(&folio->lru, split_folios);

However I'd like compaction folks to review this. I see some indications
in the code that migration can race with truncation but we feel fine by
it by taking the folio lock. However here we have a case where we see
the folio clearly locked and the folio is dirty. Other migraiton code
seems to write back the code and can wait, here we just move on. Further
reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mapping
as completely unmovable") seems to hint that migration is safe if the
mapping either does not exist or the mapping does exist but has
mapping->a_ops->migrate_folio so I'd like further feedback on this.
Another thing which requires review is if we we split a folio but not
down to order 0 but to the new min order, does the accounting on
migrate_pages_batch() require changing?  And most puzzling, why do we
not see this with regular large folios, but we do see it with minorder ?

  Luis

