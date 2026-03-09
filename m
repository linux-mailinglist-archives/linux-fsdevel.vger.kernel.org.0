Return-Path: <linux-fsdevel+bounces-79753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNo5NUWZrmnFGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:56:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 408CC2369E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB76305E9C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD71381B1C;
	Mon,  9 Mar 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPYz9xrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6B387583
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050059; cv=none; b=hWPZhxMnRbZLXht4EaBcLuCxKudGqxOCY+9sgVriT4bmK/4pWEbA74YHAxc2WtwCZ8mntBqfiISIAird4TiZlS3jWHMDxkNXYTamFYAl3MKehKuoLOF2WbFvPI8pJiRPHaGdLF+Lwc0RIIR3Uc9PLefb2evPDbWk9bUM2rVAI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050059; c=relaxed/simple;
	bh=0dslHDfc8e0m/ec8VD6G1x697Vl+o1F8eHqZCQrHxw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIIFSb888XWXu7gagkwVVdWaF0WnjyCyccVmcNjVXa4McmkDpV+cRiQLGvloYpt3Yr/Sl+3knAOH+Zajqrw0y7BEjLqbhYPr+zVLFhNkNupKVSYfSY3cnQAbg+t6EKvZ+UePanqr5PHEi3tMlVqePCG1vx5uV+xIEeNYpY5m9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPYz9xrz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae59e057f1so85643255ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050055; x=1773654855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgiSP3km688q6ojjEduHXzfYAonyqsNdhLOg8lFMsCA=;
        b=tPYz9xrzAiBA9mLrq+Pxvw7CMRlncd2bEcNV/TK9pRDzsGousLh9yF2h2ESkf99tud
         wU6aO6lVS12eXMFrM7EfJKdfHCgGO2oZItM9lPcgDmfZMZYI3aihb83/VqzwJDG6MM7J
         YwKtR1231up7r07dVfTI9fMT4KHaERAiLaE/19oD5GVXXAMmwcLPR5lwUesgRXKS6cOr
         jJ9fLgIMnXL4DqUZAdN31Sr7drLjOsN3nj6osr7f8QKgKU1oBdhcRglXCCmG65eDi0HN
         lOScGOvIe9wtIqY9RHhLTTn2uRyldrAxWikvIbGpzWBaPWJA0VnQIBCGJcgKr1dAOUQN
         yabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050055; x=1773654855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgiSP3km688q6ojjEduHXzfYAonyqsNdhLOg8lFMsCA=;
        b=hQLRhp/5aTbWmUziC62phaTp5cTAW423717pDTjDYVSXe9QGHzAYo3+EVFaBaPT4zG
         hcObmTdVu/Hx8BCVpd9mTWxdqk/2k5M7OMDjOeRkkPlGL0kSeMzfBE9gt4lxL7hmNp7V
         d0XMCT7i9CTra9qjufYCC5YyUTBbFcN6EOCqfjOp+SzW28lQ3GVY8w0dMKWHqaVih5Ub
         Khgq3jqyesWh2lT7Eq0E5COj+HmFH16TqIbgku7BFzNdKCUkPF1Ka5GbwuCZUfdTn2Py
         I9nQbMeRBlIO/r+kooHinvMG57/nUG3ahsHkOeq4AbW8vs/ntVSmAE36mJulQ8RyEZWl
         tc1A==
X-Forwarded-Encrypted: i=1; AJvYcCW0RyyIuA7ZVNNglCwWwg77raHbKkRuMqXa+XT8E8en3fjj6ND5ftuIi9zKn9nWNLhELJB/nQ0UxrjoEJpX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnxxr0ojMugZIfRTFICqg8GjjSmMGzrYMcOzUpb5PSI17XHNLM
	AFTpcR5lAFdMIH/mAYzf+5AZ8PdN8jRFRnzPLIOsjmkDFcNBEdxfVIch0QPGUHjnm+em3Cl/X4r
	4KVZFIWn3H/93+K5USQjRn9hdqg==
X-Received: from plef1.prod.google.com ([2002:a17:902:f381:b0:2a5:9a43:6fdf])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:18b:b0:2ae:7fa3:df1c with SMTP id d9443c01a7336-2ae823985a0mr98528365ad.21.1773050055283;
 Mon, 09 Mar 2026 02:54:15 -0700 (PDT)
Date: Mon, 09 Mar 2026 09:53:53 +0000
In-Reply-To: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773050050; l=820;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=0dslHDfc8e0m/ec8VD6G1x697Vl+o1F8eHqZCQrHxw8=; b=eOCypP2XtIK7WY3YqZd54ElrueSK8F6DJhK/7Y2HZaR12KKA6z53pp3vMBE5jxXzUPXRiI7/S
 mHsrhIlZsLlCMKxkujWBCQjp/ZE0AdpD8N7mP1eC2QkmTI2K/92Y0+b
X-Mailer: b4 0.14.3
Message-ID: <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com>
Subject: [PATCH RFC v3 2/4] KVM: guest_memfd: Set release always on
 guest_memfd mappings
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
X-Rspamd-Queue-Id: 408CC2369E0
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
	TAGGED_FROM(0.00)[bounces-79753-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.909];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Set release always on guest_memfd mappings to enable the use of
.invalidate_folio, which performs inode accounting for guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 77219551056a7..8246b9fbcf832 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -607,6 +607,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	mapping_set_inaccessible(inode->i_mapping);
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+	mapping_set_release_always(inode->i_mapping);
 
 	GMEM_I(inode)->flags = flags;
 

-- 
2.53.0.473.g4a7958ca14-goog


