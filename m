Return-Path: <linux-fsdevel+bounces-76390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDwMIe52hGkX3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:54:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C7F1819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65600305542B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623E3ACA46;
	Thu,  5 Feb 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMvBOGpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209033AA1B2
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288707; cv=none; b=diNoCruELkfUnOZqVdsellU7dwuYBEa7yZOI1dOiKfDZ22vWLhPKSo1qNpXeOkoaaQ6GEPiRWFoR0cu44uglkFUyIP/jFg7lGJDr1bVGSSGsNts+MY+3Qtt04D0Ha3hVlbnipLPmQJpGkyU8/SDV7jq7voupQhTpBJ+Nf7KOjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288707; c=relaxed/simple;
	bh=7nNbabhQli00eKYXyBEya1GgL6seGPzs0VSa7Ef6UeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kF0S70Ch2eEctkpFzwf3ydoLXnPzuvdiykZ3K9buowChhHP4U0NWMjexCoSlncDOQcCmDew8k217hFijj/uBlBCBRDlx1lIgD1m3ZqQul0maNPLlrTLIav+2rdMS3a9mWMVpda4vXq3NX2G94B1NR04PfBRZwvDvVZpU/i83eRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMvBOGpX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-658b82db375so839317a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288705; x=1770893505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AP/JFqXWkX3OpU6TUDwkTdWwj0hDDWhh2cwk4JKQ6LM=;
        b=HMvBOGpXSjah3Hqt5NzouuDxnE+K80hYBkMpaxDxUdYBE0Zl8xQkre1/EAeAZsviGR
         onB5bRnfYalzo4pMZbX1oZbYb9wwYfSgSm1TZs3+79EoYgSjNVJj+wuUVg+XQrWVwLOd
         cqI6nCf3QN0GYokbEg0sA/SosNsuefQkX8ssQTtrL0fnqIZqpo0ExKLY98Wf7FPPPlqu
         p5fvOWVSXzk74MtHl0LiTssE0DcSJwwggNJWuSc+nQbFo9ddF9O2UroNHHkibK6Wuujx
         QzvDS77Yu/nm4gCO4U0/j2n2Mk4FpphRppcE7CsAKp7ha+0t9kBa5OMVz4alZnK4ZqqY
         gq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288705; x=1770893505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP/JFqXWkX3OpU6TUDwkTdWwj0hDDWhh2cwk4JKQ6LM=;
        b=qZP/v7p/F9F6bqg0+ACwWzxVzA3+C3Xc/CDmu4wTDvadItBjkTn7PdtKWiNLQCXLv3
         FwGpYD4n0Xdrlzt7v1TeKHHH7xn437oJUi5EeRmoFKnoNv6SYPtAUyh7CWK3GSCRq1dT
         NCpDY2q40THHbWda1mHXtWs3z21CbEL+IWCct19q8WGW3Gcxkat5wEJnI+xBe4i40NC4
         mBTtldHE+P9JU0eCrqdZinGS/oLXUmcifHR/m+6Lmp5Na1FSZho1AkYFNr8sDe0vQfhI
         sdJyxsGv5hAEyCZNZOZMoSIhoeW1+kL7BtYE9zohOx0CKQBg89CXAYrjPEpLuM0clgoP
         C6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXS5b8VXqxzvZNnRibL09z5s+FoNWC7ighdz935HGp73wukZX9bTyASq3rACCcZzggDJ4JiurXoqQBlWlNX@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDQ+7R47S1UUfj9FyS/5mGX+911tNh/4qcImPfC33hSLJBJXj
	AJDUI8UyG1y7m+z3pJR+pGFml8XZiiPacMnJDLRAVhyPaMhOdtT7AKBQJZEGq7UsQMKi5T4jTbJ
	9+S/HWBaKZw6eo7GVLQ==
X-Received: from edxv16.prod.google.com ([2002:a05:6402:1750:b0:640:f53e:dd40])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ed5:b0:659:408e:b7e6 with SMTP id 4fb4d7f45d1cf-65949ecd24emr3465734a12.29.1770288705209;
 Thu, 05 Feb 2026 02:51:45 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:28 +0000
In-Reply-To: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7nNbabhQli00eKYXyBEya1GgL6seGPzs0VSa7Ef6UeU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHY4GykYgqnAddZwhAJstuhv/o/aLQBkNGp9h
 QcRdesjbOWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2OAAKCRAEWL7uWMY5
 Rq6YD/wKnkqeQiAcPzLSP8eM33RuuO4YudSw/EWJpzvDVL2FRsvqG+V2wVizffdP/6LYRWB/v6p
 Jqxwl3WBoPazV6eYFmbQ7WkUae/bNPfKpw2rRI+GxtPrA0EXUWSHDGB0bCp3kpDiWkIW9piV+jc
 zyAyp192j/gCxBD9q5VGxNqj3fglu4FV2cwElNzQIPs3nL+6cljxCnHhUAuzD1oSAYWZqAkuAsT
 MqEzlL5SSG2Rfiwbmhejf/KqCgG9blnH33kNdm3KehQq321SPc6PgGPT50jqjD3ay4+dmITJvnQ
 wOPK+VLCMD+OsMCS/P9DqxPhY7KXw6hQPtDyqRyI1jaGiHSj/7gj3OdnaZ3Bfux2anW+MdT5lRj
 ACUeamuoq1SUSCgNh2Vn7wSbZQMaYKsvyUfk6Mh/qK/OlkHOM/tVGClAsne/JWWu1WdhIy6UqrW
 rViiGmDhW/0oqW+hkQuWxEGoGRQWErMDsiWkA5VuMf/eh4LogZDWpEqKFr0ZQYv3G204RGVoRdR
 HzwRdgPSztNDiMJUf3XdQ8l4/BWYvULyzliWBh8Bav+Ia+fRIw8T84VjQJWazB68y1lXSTqSzVj
 YlhURKpOqlpm9XqDLSINCdFRkmGY0keD/CPIvSuvRKsQcd3rcnRoub0YtmTklMJCkMXUvre3Jze jjS185bhgckt4IQ==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
Subject: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76390-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,google.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E22C7F1819
X-Rspamd-Action: no action

These are the functions needed by Binder's shrinker.

Binder uses zap_page_range_single in the shrinker path to remove an
unused page from the mmap'd region. Note that pages are only removed
from the mmap'd region lazily when shrinker asks for it.

Binder uses list_lru_add/del to keep track of the shrinker lru list, and
it can't use _obj because the list head is not stored inline in the page
actually being lru freed, so page_to_nid(virt_to_page(item)) on the list
head computes the nid of the wrong page.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 mm/list_lru.c | 2 ++
 mm/memory.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 	unlock_list_lru(l, false);
 	return false;
 }
+EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
@@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 	unlock_list_lru(l, false);
 	return false;
 }
+EXPORT_SYMBOL_GPL(list_lru_del);
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 {
diff --git a/mm/memory.c b/mm/memory.c
index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	zap_page_range_single_batched(&tlb, vma, address, size, details);
 	tlb_finish_mmu(&tlb);
 }
+EXPORT_SYMBOL(zap_page_range_single);
 
 /**
  * zap_vma_ptes - remove ptes mapping the vma

-- 
2.53.0.rc2.204.g2597b5adb4-goog


