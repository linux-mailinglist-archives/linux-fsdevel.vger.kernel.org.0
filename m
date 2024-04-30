Return-Path: <linux-fsdevel+bounces-18382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63A8B8081
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ABE1C22663
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BABA199E8A;
	Tue, 30 Apr 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJ8rRF7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D7710B;
	Tue, 30 Apr 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505234; cv=none; b=p8hPvxbzjGU4Gp27sFzRLd6L/7VS1OKglIDZtvlYo47LzKhUR1znc88l6fASrg4sHTIH2ualveeQ6SbAHBtkpr0va1poVPagh1V8MMkWv8xcMNu0Sl21ChbL1CHA47admUKAH/krqvIPl4kqAN7d1Yhb9atoVFh8p9veZ4HdmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505234; c=relaxed/simple;
	bh=tLeUnb21C0E61J6DUcp6XCZENQ2nb1hmTQn1cmnkFxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za2dZHm67QX/cwbBGXnvzx3/y0jzy9D89qicDEiqvcAsEHVlfZWxBmMiZkm1CbLR/ejsRgHCFTxNSRo5utXEfGq3W26kcoRYguMb4fwrDCGIdU/n8O+Ub7+xz/ZpI7DcGAkAaEpZ3V7jDJRCoCuFUG5gCUFG4YLj6A2q/OHtL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJ8rRF7l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=d4uhdnzN52dglUpGiwJQWyEwkgPfxbPV9ZmXem8nWDY=; b=XJ8rRF7ls2IfN2IJoliZVBdhjM
	42gv/xsrHCKCKzC6THCARoxNA6ZXylAH5AWwK6JxcCPJaJrLkdzp/k6JoxxQsIbaImIK/IbSZhlX9
	WluVFCuLV6aa8pKdhoWxY5dKKANJDxkrfQm7eCpywzPZzUmPwcpgqXTvmk99Rcn/99CLauGb2dYsv
	4HPO9oevwtxiMCjFYWpfYA++CkoectTKlZMcLDHBCVq4/gIy6u7S1qQFlnpNfPap6t86qLfYFhl17
	85JvoHZdM3Rn77spl8fm15NwRzrb9jVq66x6zYVHUBJ1HSgynpyIHfSC+47pBH45RU3EwnbHrmgr/
	kDSYU3TQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1t84-00000007iBc-0DFf;
	Tue, 30 Apr 2024 19:27:04 +0000
Date: Tue, 30 Apr 2024 12:27:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <ZjFGCOYk3FK_zVy3@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
 <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
 <202988BE-58D1-4D21-BF7F-9AECDC178D2A@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202988BE-58D1-4D21-BF7F-9AECDC178D2A@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 10:43:16PM -0400, Zi Yan wrote:
> On 29 Apr 2024, at 20:31, Luis Chamberlain wrote:
>=20
> > On Mon, Apr 29, 2024 at 10:29:29AM -0400, Zi Yan wrote:
> >> On 28 Apr 2024, at 23:56, Luis Chamberlain wrote:
> >>
> >>> On Sat, Apr 27, 2024 at 05:57:17PM -0700, Luis Chamberlain wrote:
> >>>> On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
> >>>>> On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
> >>>>>> On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> >>>>>>> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung)=
 wrote:
> >>>>>>>> From: Pankaj Raghav <p.raghav@samsung.com>
> >>>>>>>>
> >>>>>>>> using that API for LBS is resulting in an NULL ptr dereference
> >>>>>>>> error in the writeback path [1].
> >>>>>>>>
> >>>>>>>> [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c39=
7df
> >>>>>>>
> >>>>>>>  How would I go about reproducing this?
> >>>>
> >>>> Well so the below fixes this but I am not sure if this is correct.
> >>>> folio_mark_dirty() at least says that a folio should not be truncated
> >>>> while its running. I am not sure if we should try to split folios th=
en
> >>>> even though we check for writeback once. truncate_inode_partial_foli=
o()
> >>>> will folio_wait_writeback() but it will split_folio() before checking
> >>>> for claiming to fail to truncate with folio_test_dirty(). But since =
the
> >>>> folio is locked its not clear why this should be possible.
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 83955362d41c..90195506211a 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> >>>>  	if (new_order >=3D folio_order(folio))
> >>>>  		return -EINVAL;
> >>>>
> >>>> -	if (folio_test_writeback(folio))
> >>>> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
> >>>>  		return -EBUSY;
> >>>>
> >>>>  	if (!folio_test_anon(folio)) {
> >>>
> >>> I wondered what code path is causing this and triggering this null
> >>> pointer, so I just sprinkled a check here:
> >>>
> >>> 	VM_BUG_ON_FOLIO(folio_test_dirty(folio), folio);
> >>>
> >>> The answer was:
> >>>
> >>> kcompactd() --> migrate_pages_batch()
> >>>                   --> try_split_folio --> split_folio_to_list() -->
> >>> 		       split_huge_page_to_list_to_order()
> >>>
> >>
> >> There are 3 try_split_folio() in migrate_pages_batch().
> >
> > This is only true for linux-next, for v6.9-rc5 off of which this testing
> > is based on there are only two.
> >
> >> First one is to split anonymous large folios that are on deferred
> >> split list, so not related;
> >
> > This is in linux-next and not v6.9-rc5.
> >
> >> second one is to split THPs when thp migration is not supported, but
> >> this is compaction, so not related; third one is to split large folios
> >> when there is no same size free page in the system, and this should be
> >> the one.
> >
> > Agreed, the case where migrate_folio_unmap() failed with -ENOMEM. This
> > also helps us enhance the reproducer further, which I'll do next.
> >
> >>> And I verified that moving the check only to the migrate_pages_batch()
> >>> path also fixes the crash:
> >>>
> >>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>> index 73a052a382f1..83b528eb7100 100644
> >>> --- a/mm/migrate.c
> >>> +++ b/mm/migrate.c
> >>> @@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio=
 *folio, struct list_head *split_f
> >>>  	int rc;
> >>>
> >>>  	folio_lock(folio);
> >>> +	if (folio_test_dirty(folio)) {
> >>> +		rc =3D -EBUSY;
> >>> +		goto out;
> >>> +	}
> >>>  	rc =3D split_folio_to_list(folio, split_folios);
> >>> +out:
> >>>  	folio_unlock(folio);
> >>>  	if (!rc)
> >>>  		list_move_tail(&folio->lru, split_folios);
> >>>
> >>> However I'd like compaction folks to review this. I see some indicati=
ons
> >>> in the code that migration can race with truncation but we feel fine =
by
> >>> it by taking the folio lock. However here we have a case where we see
> >>> the folio clearly locked and the folio is dirty. Other migraiton code
> >>> seems to write back the code and can wait, here we just move on. Furt=
her
> >>> reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mapping
> >>> as completely unmovable") seems to hint that migration is safe if the
> >>> mapping either does not exist or the mapping does exist but has
> >>> mapping->a_ops->migrate_folio so I'd like further feedback on this.
> >>
> >> During migration, all page table entries pointing to this dirty folio
> >> are invalid, and accesses to this folio will cause page fault and
> >> wait on the migration entry. I am not sure we need to skip dirty folio=
s.
> >
> > I see.. thanks!
> >
> >>> Another thing which requires review is if we we split a folio but not
> >>> down to order 0 but to the new min order, does the accounting on
> >>> migrate_pages_batch() require changing?  And most puzzling, why do we
> >>
> >> What accounting are you referring to? split code should take care of i=
t.
> >
> > The folio order can change after split, and so I was concerned about the
> > nr_pages used in migrate_pages_batch(). But I see now that when
> > migrate_folio_unmap() first failed we try to split the folio, and if
> > successful I see now we the caller will again call migrate_pages_batch()
> > with a retry attempt of 1 only to the split folios. I also see the
> > nr_pages is just local to each list for each loop, first on the from
> > list to unmap and afte on the unmap list so we move the folios.
> >
> >>> not see this with regular large folios, but we do see it with minorde=
r ?
> >>
> >> I wonder if the split code handles folio->mapping->i_pages properly.
> >> Does the i_pages store just folio pointers or also need all tail page
> >> pointers? I am no expert in fs, thus need help.
> >
> > mapping->i_pages stores folio pointers in the page cache or
> > swap/dax/shadow entries (xa_is_value(folio)). The folios however can be
> > special and we special-case them with shmem_mapping(mapping) checks.
> > split_huge_page_to_list_to_order() doens't get called with swap/dax/sha=
dow
> > entries, and we also bail out on shmem_mapping(mapping) already.
>=20
> Hmm, I misunderstood the issue above. To clarify it, the error comes out
> when a page cache folio with minorder is split to order-0,

No, min order is used.

In order to support splits with min order we require an out of tree
patch not yet posted:

https://github.com/linux-kdevops/linux/commit/e77a2a4fd6d9aa7e2641d5ea456ad=
0522c1e8a04

The important part is if no order is specified we use the min order:

int split_folio_to_list(struct folio *folio, struct list_head *list)
{
	unsigned int min_order =3D 0;

	if (!folio_test_anon(folio))
		min_order =3D mapping_min_folio_order(folio->mapping);

	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
}

and so compaction's try_split_folio() -->
   split_folio_to_list(folio, split_folios)

will use the min order implicitly due to the above.

So yes, we see a null ptr deref on the writeback path when min order is set.

> I wonder if you can isolate the issue by just splitting a dirty minorder
> page cache folio instead of having folio split and migration going on tog=
ether.
> You probably can use the debugfs to do that. Depending on the result,
> we can narrow down the cause of the issue.

That's what I had tried with my new fstsest test but now I see where it
also failed -- on 4k filesystems it was trying to split to order 0 and
that had no issues as you pointed out. We can now fine tune the test
very well. I can now reproduce the crash on plain on boring vanilla
linux v6.9-rc6 on a plain xfs filesystem with 4k block size on x86_64
doing this:

You may want the following appended to your kernel command line:

   dyndbg=3D'file mm/huge_memory.c +p'

mkfs.xfs /dev/vdd
mkdir -p /media/scratch/
mount /dev/vdd /media/scratch/

while true; do dd if=3D/dev/zero of=3D$FILE bs=3D4M count=3D200 2> /dev/nul=
l; done &
while true; do sleep 2; echo $FILE,0x0,0x4000,2 > /sys/kernel/debug/split_h=
uge_pages 0x400000 2> /dev/null; done

The crash:

Apr 30 10:37:09 debian12-xfs-reflink-4k kernel: SGI XFS with ACLs, security=
 attributes, realtime, scrub, repair, quota, fatal assert, debug enabled
Apr 30 10:37:09 debian12-xfs-reflink-4k kernel: XFS (vdd): Mounting V5 File=
system d1f9e444-f61c-4439-a2bf-61a13f6d8e81
Apr 30 10:37:09 debian12-xfs-reflink-4k kernel: XFS (vdd): Ending clean mou=
nt
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: huge_memory: split file-bac=
ked THPs in file: /media/scratch/foo, page offset: [0x0 - 0x200000]
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: BUG: kernel NULL pointer de=
reference, address: 0000000000000036
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: #PF: supervisor read access=
 in kernel mode
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: #PF: error_code(0x0000) - n=
ot-present page
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: PGD 0 P4D 0
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: Oops: 0000 [#1] PREEMPT SMP=
 NOPTI
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: CPU: 4 PID: 89 Comm: kworke=
r/u37:2 Not tainted 6.9.0-rc6 #10
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: Hardware name: QEMU Standar=
d PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: Workqueue: writeback wb_wor=
kfn (flush-254:48)
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: RIP: 0010:filemap_get_folio=
s_tag (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arc=
h-fallback.h:457 ./include/linux/atomic/atomic-arch-fallback.h:2426 ./inclu=
de/linux/atomic/atomic-arch-fallback.h:2456 ./include/linux/atomic/atomic-i=
nstrumented.h:1518 ./include/linux/page_ref.h:238 ./include/linux/page_ref.=
h:247 ./include/linux/page_ref.h:280 ./include/linux/page_ref.h:313 mm/file=
map.c:1980 mm/filemap.c:2218)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: Code: bd 06 86 00 48 89 c3 =
48 3d 06 04 00 00 74 e8 48 81 fb 02 04 00 00 0f 84 d0 00 00 00 48 85 db 0f =
84 04 01 00 00 f6 c3 01 75 c4 <8b> 43 34 85 c0 0f 84 b7 00 00 00 8d 50 01 4=
8 8d 73 34 f0 0f b1 53
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bd 06 86 00 48       	mov    $0x48008606,%ebp
   5:	89 c3                	mov    %eax,%ebx
   7:	48 3d 06 04 00 00    	cmp    $0x406,%rax
   d:	74 e8                	je     0xfffffffffffffff7
   f:	48 81 fb 02 04 00 00 	cmp    $0x402,%rbx
  16:	0f 84 d0 00 00 00    	je     0xec
  1c:	48 85 db             	test   %rbx,%rbx
  1f:	0f 84 04 01 00 00    	je     0x129
  25:	f6 c3 01             	test   $0x1,%bl
  28:	75 c4                	jne    0xffffffffffffffee
  2a:*	8b 43 34             	mov    0x34(%rbx),%eax		<-- trapping instructi=
on
  2d:	85 c0                	test   %eax,%eax
  2f:	0f 84 b7 00 00 00    	je     0xec
  35:	8d 50 01             	lea    0x1(%rax),%edx
  38:	48 8d 73 34          	lea    0x34(%rbx),%rsi
  3c:	f0                   	lock
  3d:	0f                   	.byte 0xf
  3e:	b1 53                	mov    $0x53,%cl

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 43 34             	mov    0x34(%rbx),%eax
   3:	85 c0                	test   %eax,%eax
   5:	0f 84 b7 00 00 00    	je     0xc2
   b:	8d 50 01             	lea    0x1(%rax),%edx
   e:	48 8d 73 34          	lea    0x34(%rbx),%rsi
  12:	f0                   	lock
  13:	0f                   	.byte 0xf
  14:	b1 53                	mov    $0x53,%cl
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: RSP: 0018:ffffa8f0c07cb8f8 =
EFLAGS: 00010246
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: RAX: 0000000000000002 RBX: =
0000000000000002 RCX: 0000000000018000
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: RDX: 0000000000000002 RSI: =
0000000000000002 RDI: ffff987380564920
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: RBP: 0000000000000000 R08: =
ffffffffffffffff R09: 0000000000000000
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: R10: 0000000000000228 R11: =
0000000000000000 R12: ffffffffffffffff
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: R13: ffffa8f0c07cbbb8 R14: =
ffffa8f0c07cbcb8 R15: ffff98738c4ea800
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: FS:  0000000000000000(0000)=
 GS:ffff9873fbd00000(0000) knlGS:0000000000000000
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: CR2: 0000000000000036 CR3: =
000000011aca8003 CR4: 0000000000770ef0
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: PKRU: 55555554
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: Call Trace:
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel:  <TASK>
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? __die (arch/x86/kernel/du=
mpstack.c:421 arch/x86/kernel/dumpstack.c:434)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? page_fault_oops (arch/x86=
/mm/fault.c:713)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? do_user_addr_fault (./inc=
lude/linux/kprobes.h:591 (discriminator 1) arch/x86/mm/fault.c:1265 (discri=
minator 1))=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? exc_page_fault (./arch/x8=
6/include/asm/paravirt.h:693 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1=
563)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? asm_exc_page_fault (./arc=
h/x86/include/asm/idtentry.h:623)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? filemap_get_folios_tag (.=
/arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallba=
ck.h:457 ./include/linux/atomic/atomic-arch-fallback.h:2426 ./include/linux=
/atomic/atomic-arch-fallback.h:2456 ./include/linux/atomic/atomic-instrumen=
ted.h:1518 ./include/linux/page_ref.h:238 ./include/linux/page_ref.h:247 ./=
include/linux/page_ref.h:280 ./include/linux/page_ref.h:313 mm/filemap.c:19=
80 mm/filemap.c:2218)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? filemap_get_folios_tag (m=
m/filemap.c:1968 mm/filemap.c:2218)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? __pfx_iomap_do_writepage =
(fs/iomap/buffered-io.c:1963)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: writeback_iter (./include/l=
inux/pagevec.h:91 mm/page-writeback.c:2421 mm/page-writeback.c:2520)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: write_cache_pages (mm/page-=
writeback.c:2568)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: iomap_writepages (fs/iomap/=
buffered-io.c:1984)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: xfs_vm_writepages (fs/xfs/x=
fs_aops.c:508) xfs
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: do_writepages (mm/page-writ=
eback.c:2612)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? update_sd_lb_stats.constp=
rop.0 (kernel/sched/fair.c:9902 (discriminator 2) kernel/sched/fair.c:10583=
 (discriminator 2))=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: __writeback_single_inode (f=
s/fs-writeback.c:1659)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: writeback_sb_inodes (fs/fs-=
writeback.c:1943)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: __writeback_inodes_wb (fs/f=
s-writeback.c:2013)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: wb_writeback (fs/fs-writeba=
ck.c:2119)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: wb_workfn (fs/fs-writeback.=
c:2277 (discriminator 1) fs/fs-writeback.c:2304 (discriminator 1))=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: process_one_work (kernel/wo=
rkqueue.c:3254)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: worker_thread (kernel/workq=
ueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2))=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? _raw_spin_lock_irqsave (.=
/arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic=
/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomi=
c-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:1=
11 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./inc=
lude/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock=
=2Ec:162 (discriminator 4))=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? __pfx_worker_thread (kern=
el/workqueue.c:3362)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: kthread (kernel/kthread.c:3=
88)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? __pfx_kthread (kernel/kth=
read.c:341)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ret_from_fork (arch/x86/ker=
nel/process.c:147)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ? __pfx_kthread (kernel/kth=
read.c:341)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel: ret_from_fork_asm (arch/x86=
/entry/entry_64.S:257)=20
Apr 30 10:38:04 debian12-xfs-reflink-4k kernel:  </TASK>

The full decoded crash on v6.9-rc6:

https://gist.github.com/mcgrof/c44aaed21b99ae4ecf3d7fc6a1bb00bc

  Luis

