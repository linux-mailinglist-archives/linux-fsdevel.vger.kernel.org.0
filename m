Return-Path: <linux-fsdevel+bounces-79752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMCsAx2ZrmnFGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:55:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1323699D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31873051A96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F7385504;
	Mon,  9 Mar 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdt4F7pZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A838552D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050057; cv=none; b=oYXthGr9jSmmBNh455Fqg3LZ/9yBSJhGChFJKImOfmUS+ot7b0MSUejuGAo/DTd6r6NOSRV0C8yLwCtNIuPsTunFgTz3ek2PHNTT4rI2tU14tLC22QmZt47kkx6WNWnITUqgfih1O5YY9bQItmYg0EovGV5Qnfp3I643x0Dt3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050057; c=relaxed/simple;
	bh=3hqbGU4XpkQVr0yrtZKZ2iPK2V2wp+71XSAAxEJMNCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbUiWJ2atRbsoCC9cQpmtoPPVErjGet38i1jTxUOKqalha4D+zgOME21TqCZutE79g0Nx3JGvCLlDgWP5L3vvrLhbUEcZ9v02b4MF0L49y99w3TOf3lWce9BTJ1jBuNDVKaPSEky8FLdTPrSl3kBkpCzLaAswBmDKYXbPJe0Zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdt4F7pZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso11218396a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050054; x=1773654854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsuu76no6Lr54/H9nY3kYs4+gfz0/Kb8kUE1FtvvYPw=;
        b=kdt4F7pZS5aMcl0yq358zejj9uUn00c4Lb0OT44KFMFy/PwlxUUZd2rzoYIO/J7QDb
         qQmnfr+EqZqYSFBrv1AXRJY8uFn2Nc8Yi2Kjh9wHUHIr+QLL4rm8yYaWs/VtAI8n8GsR
         lOq8Ww3JTLWgZ29YSWvUGtQTxYg+auN8EezHSA11ZlnwxoDj5/EqWuF90hKpmuUcsZnQ
         WNoa20hJcGy3dcokhz117jbeWbVDitqcV7/cY2l9OS8M6gCNIUh8sRKzPOgRyMBQ7Ry+
         gZx2uUZE5YpCMOX/Li62AK/s/G8GGjYVNAdNWOn4DThjiFCJMJNqdWmxYli/YTPY9uEA
         XKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050054; x=1773654854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsuu76no6Lr54/H9nY3kYs4+gfz0/Kb8kUE1FtvvYPw=;
        b=eVW+etwk/377WxJXCZAX+WoOE7foOyFLCJ+3lzXsUXaLSQICyeA2a6qWiO93pcVOCs
         KJfvHU3tGCr0jiz6dPXHUgTiMYfV87M9TD/cu2w4xlHbuvkfBtXLGXkrhlnI2t7mbJEc
         dR03hFNrAsOzrAkfVY2OwNrPpc+W/Z6JX4hTePd/29YFzdW8eJMwnAZRxSTFGvZoP8oC
         41hhdnORziWMby404kotynQRtgJGfT27Uo3ofAyCvzvEzq14PAqlPrXDBM5AaADneh70
         yEqS2xUeL3ozuS3dKFmwDSM6Lx5iWahLWgLB8Bzb3CexppszvqdHR00AlIRv2ozJ5UZG
         aeGA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYiUtNXTMpNufkzynZkjHwKpkDLSbpX6WU0aw/kfW0r8CjUN1BfZV3Lv+bJ4hcRzE2oHMU56bTSrM6K7R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7waHuQ1wL27n1iMmAKOgULS16rbpuYhy/yLpVvuyRWUGbJ9TO
	O+sVcMi7x05AXrneQc8aeliH6fY6D3hg6V3XHNNB2fqIuRhC2vKDRQYV3fogzTDwS5qpy00L4OB
	8S82UQTUXkx0xXwlIpqNT0QzMXg==
X-Received: from pjbsc14.prod.google.com ([2002:a17:90b:510e:b0:359:78a3:a05b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b4f:b0:359:9bad:13d2 with SMTP id 98e67ed59e1d1-359be38f4ffmr9958202a91.34.1773050053688;
 Mon, 09 Mar 2026 02:54:13 -0700 (PDT)
Date: Mon, 09 Mar 2026 09:53:52 +0000
In-Reply-To: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773050050; l=1845;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=3hqbGU4XpkQVr0yrtZKZ2iPK2V2wp+71XSAAxEJMNCM=; b=DckLr8OpAPU7XT4kC4r8g0ArtuhOV9Cd8i5iwr54rk/95ZsNn/2uGsEBnIng3J2LyzzE/zy8c
 rOJt/vT4O0iC7g4iNwrc8yjDe4BprQNGW/TkdtMSLCgbt5WlFYzydCO
X-Mailer: b4 0.14.3
Message-ID: <20260309-gmem-st-blocks-v3-1-815f03d9653e@google.com>
Subject: [PATCH RFC v3 1/4] KVM: guest_memfd: Track amount of memory allocated
 on inode
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: A7B1323699D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79752-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.911];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The guest memfd currently does not update the inode's i_blocks and i_bytes
count when memory is allocated or freed. Hence, st_blocks returned from
fstat() is always 0.

Introduce byte accounting for guest memfd inodes.  When a new folio is
added to the filemap, add the folio's size.  Use the .invalidate_folio()
callback to subtract the folio's size from inode fields when folios are
truncated and removed from the filemap.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 462c5c5cb602a..77219551056a7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -136,6 +136,9 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 					 mapping_gfp_mask(inode->i_mapping), policy);
 	mpol_cond_put(policy);
 
+	if (!IS_ERR(folio))
+		inode_add_bytes(inode, folio_size(folio));
+
 	/*
 	 * External interfaces like kvm_gmem_get_pfn() support dealing
 	 * with hugepages to a degree, but internally, guest_memfd currently
@@ -532,10 +535,21 @@ static void kvm_gmem_free_folio(struct folio *folio)
 }
 #endif
 
+static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset, size_t len)
+{
+	size_t bytes = folio_size(folio);
+
+	WARN_ON_ONCE(offset);
+	WARN_ON_ONCE(len != bytes);
+
+	inode_sub_bytes(folio_inode(folio), bytes);
+}
+
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
+	.invalidate_folio = kvm_gmem_invalidate_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
 #endif

-- 
2.53.0.473.g4a7958ca14-goog


