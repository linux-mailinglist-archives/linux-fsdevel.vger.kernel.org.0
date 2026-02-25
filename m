Return-Path: <linux-fsdevel+bounces-78343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFDkIWCmnmmrWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:36:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6F193875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36FF31AB089
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232C329E5C;
	Wed, 25 Feb 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+dpvAW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA419D891
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004053; cv=none; b=KjbUlcQG+TrE2C2heqPmZj6YvYvBa9YCO7wIXojU+vVO4aRYQlj+tXdwV/xSYQ5H8hnorJjiqrBW4oiZENvRcqd6huHmsXe6sBHIVr44BdXy6R0d6FTCTslOlKg3mk1daSph0lM0/OGkj4QGf8YaC2uItbEFLFQBid3a20R1SPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004053; c=relaxed/simple;
	bh=qLKykmEADbn2/q4Ccup9gI+7j5uvqRK9sZMPeThKEJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jrtTvG+nNjzP+30PQP9Av4xNFlupOcOerA5cNagDF9tXTtF6J9qu4BMWEAxirdSEG7LaLGWRgzi+e4c49wzOYwCUQszrNGjb97Ekfq4mrPLaP5H/Tnl+25caIKQP9FXIa4awlarln4BMgCN3V4+ZDDafH+OSNWfTvjV6YbSQRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+dpvAW2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2add1118c19so3642765ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004052; x=1772608852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDRU6RwH6vqwiVf/LjeEDphDyyED18VHPEr6YXDP6Vo=;
        b=N+dpvAW2soWMirm/woczj2Vuo11c1dB3ITJqjQfCp8UI7Q0/fKUTSuMJNzCAb9k95V
         DkUkmKeIlbYesGrDuU0ssAYT/5wnxFmG+UjRi1vx7TvK/V2YwGCesWs6JtNqeyHlbaHE
         aKQ6cwrexKm6T9q2C+JWQYJVWeS3YZoiEWDpRKJrgeFhVjL5ItYNOgiLv1NcYCHuq2+Z
         Rq2bR/dbGJlpD8cf72qDfhPPZWHO33qd8Z/wqK5ENH8D/gxnKFGBzxosV77iUBaYxTwP
         LvbqpC6NcIFOITLtXJuxeFzKMUbECTm8eodEobmuFiJS5mofK1MM9DdMTdfDjMVtCdlm
         G36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004052; x=1772608852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDRU6RwH6vqwiVf/LjeEDphDyyED18VHPEr6YXDP6Vo=;
        b=VkmHH2h5XISgUcOV+s+PIjJVkHBm0B2Aw12SW/fQ3wisT9X3OLILqlielA28S4xqx4
         CqKWvpNsBkuk11g5IJibj+br88Xh7OPRMXjymZw4KZX9Cmzk0WIMS1yxaUtv+j15YrlC
         4pAetTzDz83JT8/0ETX07QEjfINM2B0Nxg2g8FoXJZ4FMSp/bpJGZ0LwkTQXd9na9bw0
         sqTIztt7RBO0yGNeyHdcxN+41SeM+1B1Pycc6Vm6Fmafct0SbSn0JIp2WQieAFMHQiWw
         /EaxH7+RgpJfFChKzyrmAPRiY7fHTJRtPG4yp/gITcVtc0LHvZTxWNP3Maps8U39xXPh
         kkkw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMQ+Wtxg/7gJ80+YeHOc6uWjhvntXd8Alz6AzxwOFH1yLyEkJIo4EwJlf/Jk7yNbw9CU2K0/W1MBwyhZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFqjcEfMcxfDf8YdGotCd2mKLi9Q6JvSNGdQ0IKMOFr6qQc0A
	+j43dii/8ANoVZRa+0cKlesZKcaLXkGBvZ3aZlOCn5G0z1ZWzJHdiy+AptdYkqsJOkch+GHTpmZ
	CbBiyrJwStz5LQC4TtkjoH2sn6Q==
X-Received: from plgz12.prod.google.com ([2002:a17:903:18c:b0:2ad:ae4d:4a00])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c5:b0:2a0:c58c:fdd2 with SMTP id d9443c01a7336-2ad74516011mr136747995ad.26.1772004051111;
 Tue, 24 Feb 2026 23:20:51 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:39 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=1673;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=qLKykmEADbn2/q4Ccup9gI+7j5uvqRK9sZMPeThKEJc=; b=PxKzCcZpN4XBlCkb+5wYqal7atRqWZJGyLYGiwIgdVnxm+1x2H3IPSPZKe0CxJWfo9pjig1VC
 VIXLsNc8fL3CSev+ABXwmk1qEQrJyPu2C3V81bGGt4IF7QyCFliofNZ
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-4-87d7098119a9@google.com>
Subject: [PATCH RFC v2 4/6] KVM: guest_memfd: Track amount of memory allocated
 on inode
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78343-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 01E6F193875
X-Rspamd-Action: no action

The guest memfd currently does not update the inode's i_blocks and i_bytes
count when memory is allocated or freed. Hence, st_blocks returned from
fstat() is always 0.

Introduce byte accounting for guest memfd inodes.  When a new folio is
added to the filemap, add the folio's size.  Conversely, when folios are
truncated and removed from the mapping, deduct the folio's size.

With this change, stat.st_blocks for a guest_memfd will correctly report
the number of 512-byte blocks allocated to the file, consistent with other
memory-based filesystems like tmpfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2488d7b8f2b0d..b31e6612d16a8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -137,6 +137,8 @@ static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 		return ERR_PTR(ret);
 	}
 
+	inode_add_bytes(inode, folio_size(folio));
+
 	return folio;
 }
 
@@ -553,10 +555,16 @@ static void kvm_gmem_free_folio(struct folio *folio)
 }
 #endif
 
+static void kvm_gmem_unaccount_folio(struct folio *folio)
+{
+	__inode_sub_bytes(folio_inode(folio), folio_size(folio));
+}
+
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
+	.unaccount_folio = kvm_gmem_unaccount_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
 #endif

-- 
2.53.0.414.gf7e9f6c205-goog


