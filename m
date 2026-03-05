Return-Path: <linux-fsdevel+bounces-79475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLoyNYVgqWnj6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795E2100A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D493056E5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BC364EA7;
	Thu,  5 Mar 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks2WnXhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E416371D11;
	Thu,  5 Mar 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707831; cv=none; b=N9ryKdIM7zV4U5Z8HtqtqKyVMcN/7uO0x8YGtAE9DKwVbfV0vnzEwJhO8FYjthK+fw6nAWgg7c/D9A2FNqnr73vkWXBD4Bs3a4g1ykN8bXsn3jouql6Cp4N1K7DZ4XDUeVPQynjlvl5BxIlTAmiSfTGhwvu9wcMsPPMZ5ozBg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707831; c=relaxed/simple;
	bh=0/QAvDFwZi+F+9QH+vbMTA5rIfdw8VEPToPzhoxxIs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STf0u+dzj18uxqEEqJfNQ2iK5VzYPgHkWyY275HwnT1lhFtRrRCMwgVY5JoYo29Eb2+4IWUyqYTNP+BaJEmb14x12OrzlsdjKowhchvNxnb9WXQx+SJs+2iDwq9uvkQUV+giUvz7CV8xxcEF9CPNLSJatf0bya+dWHeonpE/5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks2WnXhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7BC116C6;
	Thu,  5 Mar 2026 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707830;
	bh=0/QAvDFwZi+F+9QH+vbMTA5rIfdw8VEPToPzhoxxIs8=;
	h=From:To:Cc:Subject:Date:From;
	b=Ks2WnXhBZhJYCciDsJ/Fjo8g68UnOm1+2N5sQ4oKF/kGeATt0cOgG+p7IStQiz3z2
	 EaiKLpNcYuvQR0g+WTb5buzNJSSfOvUyoPW9kVP1mxiGLOY0aaIL36Y8HeRxCRWjH0
	 xPNNxHX1xyrDEsAcz9u21dlmMcxuEfinuXRzrRvtJ7zbfASMxifc8jFI1uuXm0VkKV
	 vO8JJM2Fd72GNEUcYoWCy/ySVJ/YSjCa2F7WYjhFHDQGWKarW2sHEvezQchoGe9GZ5
	 xra3AjQzJT0q+i6jzWOOPQIuXDSNX56qDPetnPGikvlCk8ESka3PTrdJXR50wB3Usv
	 cHc1r7gvVBIug==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-mm@kvack.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] mm: vma flag tweaks
Date: Thu,  5 Mar 2026 10:50:13 +0000
Message-ID: <cover.1772704455.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9795E2100A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79475-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The ongoing work around introducing non-system word VMA flags has
introduced a number of helper functions and macros to make life easier when
working with these flags and to make conversions from the legacy use of
VM_xxx flags more straightforward.

This series improves these to reduce confusion as to what they do and to
improve consistency and readability.

Firstly the series renames vma_flags_test() to vma_flags_test_any() to make
it abundantly clear that this function tests whether any of the flags are
set (as opposed to vma_flags_test_all()).

It then renames vma_desc_test_flags() to vma_desc_test_any() for the same
reason. Note that we drop the 'flags' suffix here, as
vma_desc_test_any_flags() would be cumbersome and 'test' implies a flag
test.

Similarly, we rename vma_test_all_flags() to vma_test_all() for
consistency.

Next, we have a couple of instances (erofs, zonefs) where we are now
testing for vma_desc_test_any(desc, VMA_SHARED_BIT) &&
vma_desc_test_any(desc, VMA_MAYWRITE_BIT).

This is silly, so this series introduces vma_desc_test_all() so these
callers can instead invoke vma_desc_test_all(desc, VMA_SHARED_BIT,
VMA_MAYWRITE_BIT).

We then observe that quite a few instances of vma_flags_test_any() and
vma_desc_test_any() are in fact only testing against a single flag.

Using the _any() variant here is just confusing - 'any' of single item
reads strangely and is liable to cause confusion.

So in these instances the series reintroduces vma_flags_test() and
vma_desc_test() as helpers which test against a single flag.

The fact that vma_flags_t is a struct and that vma_flag_t utilises sparse
to avoid confusion with vm_flags_t makes it impossible for a user to misuse
these helpers without it getting flagged somewhere.

The series also updates __mk_vma_flags() and functions invoked by it to
explicitly mark them always inline to match expectation and to be
consistent with other VMA flag helpers.

It also renames vma_flag_set() to vma_flags_set_flag() (a function only
used by __mk_vma_flags()) to be consistent with other VMA flag helpers.

Finally it updates the VMA tests for each of these changes, and introduces
explicit tests for vma_flags_test() and vma_desc_test() to assert that they
behave as expected.

Lorenzo Stoakes (Oracle) (6):
  mm: rename VMA flag helpers to be more readable
  mm: add vma_desc_test_all() and use it
  mm: always inline __mk_vma_flags() and invoked functions
  mm: reintroduce vma_flags_test() as a singular flag test
  mm: reintroduce vma_desc_test() as a singular flag test
  tools/testing/vma: add test for vma_flags_test(), vma_desc_test()

 drivers/char/mem.c                 |   2 +-
 drivers/dax/device.c               |   2 +-
 fs/erofs/data.c                    |   3 +-
 fs/hugetlbfs/inode.c               |   2 +-
 fs/ntfs3/file.c                    |   2 +-
 fs/resctrl/pseudo_lock.c           |   2 +-
 fs/zonefs/file.c                   |   3 +-
 include/linux/dax.h                |   4 +-
 include/linux/hugetlb_inline.h     |   2 +-
 include/linux/mm.h                 | 100 +++++++++++++++++++++--------
 include/linux/mm_types.h           |   2 +-
 mm/hugetlb.c                       |  12 ++--
 mm/memory.c                        |   2 +-
 mm/secretmem.c                     |   2 +-
 tools/testing/vma/include/custom.h |   5 +-
 tools/testing/vma/include/dup.h    |  48 ++++++++++----
 tools/testing/vma/tests/vma.c      |  58 +++++++++++++----
 17 files changed, 177 insertions(+), 74 deletions(-)

--
2.53.0

