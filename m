Return-Path: <linux-fsdevel+bounces-78771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK+pNfX5oWlkyAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:09:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DD1BD3D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 846BB3037F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D946AF34;
	Fri, 27 Feb 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+U9FbqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A14436353;
	Fri, 27 Feb 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222948; cv=none; b=pGFzacWEc6Amj8LiGF2pGv9z3bjLTIcq89KY0uozbm7dbsLydNEU3tESFagTIjfNLDmpynYe/CI+90bP8scKgU50VoxgDR5ADITw045zlHnQMpY+BPH2Q4Mhw0WQCrBfXrURpElJ6rAJaBCkaejgj6tn186H6mqBni1ozbwQiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222948; c=relaxed/simple;
	bh=uHYxem2rcFuwlV7scbCWwSyUtQMuMwhNJjysCrEHJOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbvCO6JDGqgYiEjuhsslSKBkQEZUt3dExi+/dAlLm73KS0EsMiorQHiTgkrXS/AaBod4VmCYvyf7A9yGbsQZ35cPugS+p0V0SXyxeCo/P0eOlFX1uz63KtVzN4UxmU+yv7nRFo5n5t+RpMZHGBuVgjNsdjGjPUN4KRa0evH3dHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+U9FbqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E88C116C6;
	Fri, 27 Feb 2026 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772222948;
	bh=uHYxem2rcFuwlV7scbCWwSyUtQMuMwhNJjysCrEHJOo=;
	h=From:To:Cc:Subject:Date:From;
	b=P+U9FbqKF3CgiBsEPqPexZzZ93XmAcCqzSbUwaOX1Y8siePI12ijG2mxzI5YIf0mL
	 /ms5mDjzZ41zbR+y1lyjSjd5si16Ajj3yoCRxi8QeNf7VJlp5WbLWxR/Cm1nnjaTYO
	 IOJj8irdOEN+aJhdaLJh+fKK7+dKb7KlCCDxdNslqcoGrctiSrHy1YeE9LnRXJRhDK
	 ivNZRpe0JCZ8M0dux5O/xFyufs7KMwSQdWCOqjqmQAjFgGIXu0NS+l21cUs4WBsHt5
	 gFLiipJYdZxphu1iU6VvsVMrLyOefgdnpc25102oxNzG5Kz3JMlEpdrlW7fczulnx6
	 d9eorSp6XyA4Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "linux-mm @ kvack . org" <linux-mm@kvack.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v1 00/16] mm: cleanups around unmapping / zapping
Date: Fri, 27 Feb 2026 21:08:31 +0100
Message-ID: <20260227200848.114019-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78771-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 602DD1BD3D4
X-Rspamd-Action: no action

A bunch of cleanups around unmapping and zapping. Mostly simplifications,
code movements, documentation and renaming of zapping functions.

With this series, we'll have the following high-level zap/unmap functions
(excluding high-level folio zapping):
* unmap_vmas() for actual unmapping (vmas will go away)
* zap_vma(): zap all page table entries in a vma
* zap_vma_for_reaping(): zap_vma() that must not block
* zap_vma_range(): zap a range of page table entries
* zap_vma_range_batched(): zap_vma_range() with more options and batching
* zap_special_vma_range(): limited zap_vma_range() for modules
* __zap_vma_range(): internal helper

Patch #1 is not about unmapping/zapping, but I stumbled over it while
verifying MADV_DONTNEED range handling.

Patch #16 is related to [1], but makes sense even independent of that.

[1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

The CC list is already long enough. As these are simple changes to
drivers/arch code, I'm only CCing maintainers of all changes but only
reviewers of the MM bits.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>

Cc: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sgx@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: x86@kernel.org


David Hildenbrand (Arm) (16):
  mm/madvise: drop range checks in madvise_free_single_vma()
  mm/memory: remove "zap_details" parameter from zap_page_range_single()
  mm/memory: inline unmap_mapping_range_vma() into
    unmap_mapping_range_tree()
  mm/memory: simplify calculation in unmap_mapping_range_tree()
  mm/oom_kill: use MMU_NOTIFY_CLEAR in __oom_reap_task_mm()
  mm/oom_kill: factor out zapping of VMA into zap_vma_for_reaping()
  mm/memory: rename unmap_single_vma() to __zap_vma_range()
  mm/memory: move adjusting of address range to unmap_vmas()
  mm/memory: convert details->even_cows into details->skip_cows
  mm/memory: use __zap_vma_range() in zap_vma_for_reaping()
  mm/memory: inline unmap_page_range() into __zap_vma_range()
  mm: rename zap_vma_pages() to zap_vma()
  mm: rename zap_page_range_single_batched() to zap_vma_range_batched()
  mm: rename zap_page_range_single() to zap_vma_range()
  mm: rename zap_vma_ptes() to zap_special_vma_range()
  mm/memory: support VM_MIXEDMAP in zap_special_vma_range()

 arch/powerpc/platforms/book3s/vas-api.c |   2 +-
 arch/powerpc/platforms/pseries/vas.c    |   2 +-
 arch/s390/mm/gmap_helpers.c             |   2 +-
 arch/x86/kernel/cpu/sgx/encl.c          |   2 +-
 drivers/android/binder/page_range.rs    |   4 +-
 drivers/android/binder_alloc.c          |   2 +-
 drivers/comedi/comedi_fops.c            |   2 +-
 drivers/gpu/drm/i915/i915_mm.c          |   4 +-
 drivers/infiniband/core/uverbs_main.c   |   6 +-
 drivers/misc/sgi-gru/grumain.c          |   2 +-
 include/linux/mm.h                      |  23 ++-
 kernel/bpf/arena.c                      |   3 +-
 kernel/events/core.c                    |   2 +-
 lib/vdso/datastore.c                    |   2 +-
 mm/internal.h                           |   7 +-
 mm/interval_tree.c                      |   5 -
 mm/madvise.c                            |  24 +--
 mm/memory.c                             | 217 ++++++++++++------------
 mm/oom_kill.c                           |  15 +-
 mm/page-writeback.c                     |   2 +-
 net/ipv4/tcp.c                          |   7 +-
 rust/kernel/mm/virt.rs                  |   4 +-
 22 files changed, 162 insertions(+), 177 deletions(-)


base-commit: df9c51269a5e2a6fbca2884a756a4011a5e78748
-- 
2.43.0


