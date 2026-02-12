Return-Path: <linux-fsdevel+bounces-77028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHHmH2v9jWm0+AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:18:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2DF12F459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAD433045E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566123D7DD;
	Thu, 12 Feb 2026 16:18:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C054774;
	Thu, 12 Feb 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913128; cv=none; b=Xm5R8YPmNVqaBNzlFTP9toV41kgG2xB0Awfkife3SDayQCCWnYAH1vTM5DII1vKfNZk/6cmsIp6f4w89Yg8Fr6QBnfMmq4MMWnl2aUs8euhbuBMT6jenplLzao1hnGJUbvUmX8TwrGNs2bnKcYosWFhWfms7HEynGLaFFeqYYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913128; c=relaxed/simple;
	bh=m3MppjwD0lziKrRCb4QXyYxGwpqTA2YX+2nAh2ew2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKfLabrj0pNSLZVu73yMML2MwS1Rwv+YcnhK32qucCEDpzNjwpiO1KK1AVz6ab8JOX5zZaAVAWaHEqoBBHAM455HfY6mXkJhaCKT7e68bDJ5bANJ11oEolOV9e4ixb+A0Ac31sqPX1B2MCa/iOu0/jUT2dAs8RBu5gnlRv5E8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73033339;
	Thu, 12 Feb 2026 08:18:38 -0800 (PST)
Received: from GX9GF4H4XN (unknown [10.1.30.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2B03F63F;
	Thu, 12 Feb 2026 08:18:43 -0800 (PST)
From: Seunguk Shin <seunguk.shin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, jack@suse.cz,
 willy@infradead.org, dan.j.williams@intel.com, Nick.Connolly@arm.com,
 ffidencio@nvidia.com, seunguk.shin@arm.com
Subject: [PATCH v2] fs/dax: check zero or empty entry before converting
 xarray entry
Date: Thu, 12 Feb 2026 16:18:33 +0000
Message-ID: <m2tsvmue92.fsf@arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-77028-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seunguk.shin@arm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,suse.cz:email]
X-Rspamd-Queue-Id: DD2DF12F459
X-Rspamd-Action: no action

Trying to convert zero or empty xarray entry causes kernel panic.

[    0.737679] EXT4-fs (pmem0p1): mounted filesystem 79676804-7c8b-491a-b2a6-9bae3c72af70 ro with ordered data mode. Quota mode: disabled.
[    0.737891] VFS: Mounted root (ext4 filesystem) readonly on device 259:1.
[    0.739119] devtmpfs: mounted
[    0.739476] Freeing unused kernel memory: 1920K
[    0.740156] Run /sbin/init as init process
[    0.740229]   with arguments:
[    0.740286]     /sbin/init
[    0.740321]   with environment:
[    0.740369]     HOME=/
[    0.740400]     TERM=linux
[    0.743162] Unable to handle kernel paging request at virtual address fffffdffbf000008
[    0.743285] Mem abort info:
[    0.743316]   ESR = 0x0000000096000006
[    0.743371]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.743444]   SET = 0, FnV = 0
[    0.743489]   EA = 0, S1PTW = 0
[    0.743545]   FSC = 0x06: level 2 translation fault
[    0.743610] Data abort info:
[    0.743656]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[    0.743720]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.743785]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.743848] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000b9d17000
[    0.743931] [fffffdffbf000008] pgd=10000000bfa3d403, p4d=10000000bfa3d403, pud=1000000040bfe403, pmd=0000000000000000
[    0.744070] Internal error: Oops: 0000000096000006 [#1]  SMP
[    0.748888] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.18.4 #1 NONE
[    0.749421] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.749969] pc : dax_disassociate_entry.constprop.0+0x20/0x50
[    0.750444] lr : dax_insert_entry+0xcc/0x408
[    0.750802] sp : ffff80008000b9e0
[    0.751083] x29: ffff80008000b9e0 x28: 0000000000000000 x27: 0000000000000000
[    0.751682] x26: 0000000001963d01 x25: ffff0000004f7d90 x24: 0000000000000000
[    0.752264] x23: 0000000000000000 x22: ffff80008000bcc8 x21: 0000000000000011
[    0.752836] x20: ffff80008000ba90 x19: 0000000001963d01 x18: 0000000000000000
[    0.753407] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.753970] x14: ffffbf3154b9ae70 x13: 0000000000000000 x12: ffffbf3154b9ae70
[    0.754548] x11: ffffffffffffffff x10: 0000000000000000 x9 : 0000000000000000
[    0.755122] x8 : 000000000000000d x7 : 000000000000001f x6 : 0000000000000000
[    0.755707] x5 : 0000000000000000 x4 : 0000000000000000 x3 : fffffdffc0000000
[    0.756287] x2 : 0000000000000008 x1 : 0000000040000000 x0 : fffffdffbf000000
[    0.756871] Call trace:
[    0.757107]  dax_disassociate_entry.constprop.0+0x20/0x50 (P)
[    0.757592]  dax_iomap_pte_fault+0x4fc/0x808
[    0.757951]  dax_iomap_fault+0x28/0x30
[    0.758258]  ext4_dax_huge_fault+0x80/0x2dc
[    0.758594]  ext4_dax_fault+0x10/0x3c
[    0.758892]  __do_fault+0x38/0x12c
[    0.759175]  __handle_mm_fault+0x530/0xcf0
[    0.759518]  handle_mm_fault+0xe4/0x230
[    0.759833]  do_page_fault+0x17c/0x4dc
[    0.760144]  do_translation_fault+0x30/0x38
[    0.760483]  do_mem_abort+0x40/0x8c
[    0.760771]  el0_ia+0x4c/0x170
[    0.761032]  el0t_64_sync_handler+0xd8/0xdc
[    0.761371]  el0t_64_sync+0x168/0x16c
[    0.761677] Code: f9453021 f2dfbfe3 cb813080 8b001860 (f9400401)
[    0.762168] ---[ end trace 0000000000000000 ]---
[    0.762550] note: init[1] exited with irqs disabled
[    0.762631] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

This patch just reorders checking and converting.

Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Signed-off-by: Seunguk Shin <seunguk.shin@arm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
Changes in v2:
- Add Fixes and Reviewed-by tags.
- Rebase on the latest.
- Link to v1: https://lore.kernel.org/lkml/18af3213-6c46-4611-ba75-da5be5a1c9b0@arm.com/T/#r7160ab8ce8b04db157ea73a7c203b2c69626bfc6
---
 fs/dax.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 289e6254aa30..de316be2cc4e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -443,11 +443,12 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
                                unsigned long address, bool shared)
 {
        unsigned long size = dax_entry_size(entry), index;
-       struct folio *folio = dax_to_folio(entry);
+       struct folio *folio;

        if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
                return;

+       folio = dax_to_folio(entry);
        index = linear_page_index(vma, address & ~(size - 1));
        if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
                if (folio->mapping)
@@ -468,21 +469,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
                                bool trunc)
 {
-       struct folio *folio = dax_to_folio(entry);
+       struct folio *folio;

        if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
                return;

+       folio = dax_to_folio(entry);
        dax_folio_put(folio);
 }

 static struct page *dax_busy_page(void *entry)
 {
-       struct folio *folio = dax_to_folio(entry);
+       struct folio *folio;

        if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
                return NULL;

+       folio = dax_to_folio(entry);
        if (folio_ref_count(folio) - folio_mapcount(folio))
                return &folio->page;
        else
--
2.34.1

