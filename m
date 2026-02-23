Return-Path: <linux-fsdevel+bounces-77903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFi2Fh38m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C121727E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA183024962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B653346A14;
	Mon, 23 Feb 2026 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWvhd9qN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891D18C03E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830292; cv=none; b=PnH6NozYnUYwWABGW5/D7EZhGjmlCsc377HPCBAI5hjDtik30I4271bbRhRyCGx1Sit0GZNh2hA28j/OEE7YkHbTCOkWbbIvORAClmh6TL8HyuWCFp0nFUvIa77t611UjvwgI/3qBHzfhC3eX72gW0tP2BFmPpvUWO1xkAAfOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830292; c=relaxed/simple;
	bh=FZRWd7OFFr94c+sVebCFrm+qPTKtpygBGZ1I5UbUj8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tu0842P/yfs1OUE6u6XnS6KDKQ7LABRdlclbooxRv6nAjRTt/JT2AKexrR3zn52jmrm5g19isRr6BjHp5ok3EQ3HEVvH6HJKS0FnWRWmVcMx0w8S/xlDWNBmkMfHNqrb73z5NcgQfcDH5lr6WUB60lSuvmm3Ynri2Z9tVH6MTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWvhd9qN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-824b5637daaso2019048b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830290; x=1772435090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ACR+5opE2f1Qb7L32b78WaUJ2hKK306WtP3f4Mrpeg=;
        b=pWvhd9qNuvzQ572O9PaGrTJAuMhFcr6E10rwLG4X/ylZYq3ljR25JK7vOQcihNQHRd
         4AsDElBydnpRqPKT6jkSuLoVfEEmlstEMBucbrUaU5j+KwBzSHTf98tNWa9BLQ+Oa1fv
         QfkP3gMJkqV1GZvKPilJgjltY5ckCG24iPoHV5LwnVr48v3jK5c7wPybdYT1LwXdDim6
         8AYrqiR6/MrGjPy3KCyZ6nx3gehYeR2BBY6emDi6+l61gFKXOmZaYmY8JaVBf9GimD9L
         ldRricmNp0lRhZvWNB/6oq21iCyl377gGgPNJbynpG1muZFAq1Bf1XTu0CiEMLovJTqL
         7bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830290; x=1772435090;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ACR+5opE2f1Qb7L32b78WaUJ2hKK306WtP3f4Mrpeg=;
        b=QrkUgpKsVeslv3Un7kk5OzWbtxBq0+/bn+QcNEpls7oA9wqIBy2NG2XDXPCncw/z/a
         x7I++vaYL5gahvbWr47RZgqIv7IJyZ3qtUGYQ251b3NyAtQJR9UaZHrmZ6Aq7iONjbz9
         KpDUJVoOTKCJ9KZsNiwwKECkOyC2dSUJYJZZSST3RG4Q3/8R6zlRB+0kNYD83MR0+byg
         iamr4R1XUHu7QziC4x2wgGwbVbQTRwa0x8EKbdTe/81mQWqePsAMC0Ny83yE+aul1+Ao
         5FI1RE+DKnEtUMwiLmXz9dZmqPsnygaLVIMhhpzq/0UYElW1W1euzUyKggxnT1XoW22V
         2dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbnPrL/3EsOHYDgx0GU+p+3QPIzna9sICeGuZvwRbGfCPZl7SDr5FFDaqX8b0CC0yGvdySHxM1we/6+cWn@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuBULi+vN1riv4fmYgPH6vGBeS1YNLmhQXrmNMAgpEn/Zk9hW
	i8ZMJk4SYV5eaTGywZ3Q1d8Vq84tz/j+6+3EogfYriHNNO8uWLnl5afUat8HBmg+5ZjmrZinElQ
	aj/M2jIL7gQJ+FNv6EQYLdoHNMA==
X-Received: from pfbgr10.prod.google.com ([2002:a05:6a00:4d0a:b0:7b8:ac8f:27c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2ea8:b0:823:f04:e89b with SMTP id d2e1a72fcca58-826daa5de1cmr5219573b3a.48.1771830290192;
 Sun, 22 Feb 2026 23:04:50 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <cover.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 00/10] guest_memfd: Track amount of memory allocated on inode
From: Ackerley Tng <ackerleytng@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org, 
	ackerleytng@google.com, seanjc@google.com, shivankg@amd.com, 
	rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77903-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40C121727E6
X-Rspamd-Action: no action

Hi,

Currently, guest_memfd doesn't update inode's i_blocks or i_bytes at
all. Hence, st_blocks in the struct populated by a userspace fstat()
call on a guest_memfd will always be 0. This patch series makes
guest_memfd track the amount of memory allocated on an inode, which
allows fstat() to accurately report that on requests from userspace.

The inode's i_blocks and i_bytes fields are updated when the folio is
associated or disassociated from the guest_memfd inode, which are at
allocation and truncation times respectively.

To update inode fields at truncation time, this series implements a
custom truncation function for guest_memfd. An alternative would be to
update truncate_inode_pages_range() to return the number of bytes
truncated or add/use some hook.

Implementing a custom truncation function was chosen to provide
flexibility for handling truncations in future when guest_memfd
supports sources of pages other than the buddy allocator. This
approach of a custom truncation function also aligns with shmem, which
has a custom shmem_truncate_range().

To update inode fields at allocation time, kvm_gmem_get_folio() is
simply augmented such that when a folio is added to the filemap, the
size of the folio is updated into inode fields.

The second patch, to use filemap_alloc_folio() during allocation of
guest_memfd folios, was written as a debugging step to resolve a bug
found by syzbot [1], but turned out to not be the fix. I include it
here because it cleans up the allocation process and provides a nice
foundation for updating inode fields during allocations.

The first patch was separately submitted [2], and provided here since
it is a prerequisite simplication before application of the second
patch.

[1] https://lore.kernel.org/all/29c347bde68ec027259654e8e85371307edf7058.1770148108.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/20260129172646.2361462-1-ackerleytng@google.com/

Ackerley Tng (10):
  KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios
  KVM: guest_memfd: Directly allocate folios with filemap_alloc_folio()
  mm: truncate: Expose preparation steps for
    truncate_inode_pages_final()
  KVM: guest_memfd: Implement evict_inode for guest_memfd
  mm: Export unmap_mapping_folio() for KVM
  mm: filemap: Export filemap_remove_folio()
  KVM: guest_memfd: Implement custom truncation function
  KVM: guest_memfd: Track amount of memory allocated on inode
  KVM: selftests: Wrap fstat() to assert success
  KVM: selftests: Test that st_blocks is updated on allocation

 include/linux/mm.h                            |   3 +
 mm/filemap.c                                  |   2 +
 mm/internal.h                                 |   2 -
 mm/memory.c                                   |   2 +
 mm/truncate.c                                 |  21 +++-
 .../testing/selftests/kvm/guest_memfd_test.c  |  32 +++--
 .../selftests/kvm/include/kvm_syscalls.h      |   2 +
 virt/kvm/guest_memfd.c                        | 116 +++++++++++++++---
 8 files changed, 149 insertions(+), 31 deletions(-)


base-commit: b1195183ed42f1522fae3fe44ebee3af437aa000
--
2.53.0.345.g96ddfc5eaa-goog

