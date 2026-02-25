Return-Path: <linux-fsdevel+bounces-78341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMmcN/WjnmlPWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:25:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76C1935E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 024E93061B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB1314D0B;
	Wed, 25 Feb 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGHQ6fUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6193314D13
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004050; cv=none; b=lKkIqmCzWWDn8+pJKS15ujRb9g2mJ85pbFAcJXt1JOBipZu5rxmU6LAN5K33up6hrq/zqdYNYOLCpZwcay4o4QCFo8yWVWGO1zSeiV3FFuMBRQ8h/GQY8W3m9B4uI9c1ZC5PpNKo2jk5QPb4wS9mHOEg+cJqEo7KA5hN9mLDv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004050; c=relaxed/simple;
	bh=8mavK4GAEJyfzQeJv7/hD42p9ioK1z0FeEYGJdf10ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kE9IMn6yQld7q8uKbO5hQJKltoZDKxtxfWrPdweclusXGLrtTCj1DnPkztBfLoeCirTb1swOceGLw00X8EprHSRSVOGiri5Yt1g+QmGoxD3y0KkIbU2iXMRQArMnrRZfgsgYx/P00vZIXeED4iwiyhvWszJyrceXK5s+p8H6rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGHQ6fUJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358ffccebf1so918107a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004048; x=1772608848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVs0Hnm474cWoV833GLo9MNmWlUj207hFkSykyvopd4=;
        b=XGHQ6fUJsiyeW6/flR7Ha9ULHmAjbO3JNzeE+lnEaqiNaqOHT+xTI29dU/FfYd15/S
         WB9XySh8aQyQJnjnb8qU9KE+R2yadsOEGd+bH2hjbgu51sy3fkr/sY7/F3+rVkhZ9thO
         9uJGsZtsY25n2IDbh4dmK3b9NpBjTGg2NKyhzaQh4P/cdwfstrzVgYfZSJ9iLcRIlPiL
         4bPgy3iJxr5q5DyjVknGjqwqpMoitrP7AiYTI2uNzm+Sswk6s+MBvL8J/4brpTyO2yXC
         A0TfjzJLQ8QjgrX119df4WPKGDs2ZkLGHTUvvCzjay4cyIPgAfhwskq6iBbh9hjbTaXO
         2Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004048; x=1772608848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVs0Hnm474cWoV833GLo9MNmWlUj207hFkSykyvopd4=;
        b=WqUCD4pn+27FG2r0otGU9tDKkKx9cRgHzPSbE0Kg5AcAMrluyTSVHXy1UrDs16Ycrp
         ZUKSk0ri8LCYq8ncMoCqcx8QqvrNTrLO4Wk/Xetlac+v4mspx9SUkcFsbts3UQU5xvvg
         17m11tKWqr3qeg8V4vzzeQnnCVqHGOojMlahpbi2hYCEM6SZvOB387eCDx7EJ8+lBL5e
         9uCMz4bQY+efvoQNsG/TI3KnNv639hAJYqPgVvefNf/rwqxrKs5nvrV1zz1YZAusigI+
         zu3777sP9B6RaBI93ZAFHg0qip3f07kINvVnYVgfIFXPydm9yZ3qpYKJdievaaWZlE+1
         Px3w==
X-Forwarded-Encrypted: i=1; AJvYcCXRGy7ajlrG4NKu2L69tKHQmz91PdxaO+Zy2mX7bfeALVSlgcivdO31zUKdQzxmIKQDygcjFYgCBKT4zv29@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdQXYeZaJOADfjlkVhAZH+dGK4bvcz/DDsW/G9Gfpt56eKQbU
	hlSywdRIipYhVMuntYgvkaSFk9UALlSMEAuHiHM2RPycQj+cFiRakwQ/KT9KgJ205LTq4xbCoYv
	MJQ1UcbQP0cfU4QhWuoUQu1l2fQ==
X-Received: from pjbcx18.prod.google.com ([2002:a17:90a:fd92:b0:34c:64ab:be12])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4987:b0:349:7f0a:381b with SMTP id 98e67ed59e1d1-358ae7f824amr12058965a91.8.1772004047924;
 Tue, 24 Feb 2026 23:20:47 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:37 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=2942;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=8mavK4GAEJyfzQeJv7/hD42p9ioK1z0FeEYGJdf10ss=; b=n5HyVsPKnVDH4PevFzPZC0SURMs/a4aw01ly03D56U81pYoGm3xjhy0a96R2oMYy/oWparMvX
 0N/vWJdxHi/DhAl1wJaJFq98Amz6oOt1OmvqMUx13/SxRSVR8WBVXyz
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-2-87d7098119a9@google.com>
Subject: [PATCH RFC v2 2/6] KVM: guest_memfd: Directly allocate folios with filemap_alloc_folio()
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78341-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E76C1935E5
X-Rspamd-Action: no action

__filemap_get_folio_mpol() is parametrized by a bunch of GFP flags, which
adds complexity for the reader. Since guest_memfd doesn't meaningfully use
any of the other FGP flags, undo that complexity by directly calling
filemap_alloc_folio().

Directly calling filemap_alloc_folio() also allows the order of 0 to be
explicitly specified, which is the only order guest_memfd supports. This is
easier to understand, and removes the chance of anything else being able to
unintentionally influence allocated folio size.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 51 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2df27b6443115..2488d7b8f2b0d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -107,6 +107,39 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
 }
 
+static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+{
+	/* TODO: Support huge pages. */
+	struct mempolicy *policy;
+	struct folio *folio;
+	gfp_t gfp;
+	int ret;
+
+	/*
+	 * Fast-path: See if folio is already present in mapping to avoid
+	 * policy_lookup.
+	 */
+	folio = filemap_lock_folio(inode->i_mapping, index);
+	if (!IS_ERR(folio))
+		return folio;
+
+	gfp = mapping_gfp_mask(inode->i_mapping);
+
+	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
+	folio = filemap_alloc_folio(gfp, 0, policy);
+	mpol_cond_put(policy);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = filemap_add_folio(inode->i_mapping, folio, index, gfp);
+	if (ret) {
+		folio_put(folio);
+		return ERR_PTR(ret);
+	}
+
+	return folio;
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -118,23 +151,11 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
-	/* TODO: Support huge pages. */
-	struct mempolicy *policy;
 	struct folio *folio;
 
-	/*
-	 * Fast-path: See if folio is already present in mapping to avoid
-	 * policy_lookup.
-	 */
-	folio = filemap_lock_folio(inode->i_mapping, index);
-	if (!IS_ERR(folio))
-		return folio;
-
-	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
-	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
-					 FGP_LOCK | FGP_CREAT,
-					 mapping_gfp_mask(inode->i_mapping), policy);
-	mpol_cond_put(policy);
+	do {
+		folio = __kvm_gmem_get_folio(inode, index);
+	} while (PTR_ERR(folio) == -EEXIST);
 
 	/*
 	 * External interfaces like kvm_gmem_get_pfn() support dealing

-- 
2.53.0.414.gf7e9f6c205-goog


