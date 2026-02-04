Return-Path: <linux-fsdevel+bounces-76313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAmEIP80g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:01:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07265E5770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40D76300C0CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D767F3EF0CC;
	Wed,  4 Feb 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz7NyLru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7ED3ECBEB;
	Wed,  4 Feb 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206321; cv=none; b=uVogzLK/poJWTOzGdDgkY5pF2IUVNy0zo501n3FkagEMjhLlV5wSaX6i9jtW/j8S95dsZW6nGnCLDmPkx4s3EPWFRVFxbnO7CSncU7itZ4DO0/WLfbYa2uugrNkwBoBggFB5DxvozpxuZeK1tA6eHoB2zi0FjLhxTYrKbnGlgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206321; c=relaxed/simple;
	bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QB/Z2st12jq7YoqkLNqfH1TyjxUWpphJEc0s7WFWhGMN37TkfyQ2SOhhqSfnPd1zlM2Gl8t6x6irRfjN4Rb3zLdQtL6vy5OY+uShQ7dAy4vKVRFtOhXCsFjzT0rlLP4JDYXbxLcbRbEX39EsC6WqaCpZJHnZp5lXlQiQb7+dJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz7NyLru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB73C4CEF7;
	Wed,  4 Feb 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206321;
	bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gz7NyLruiwim/m3qBSE5DCyGcBGfDnNAOVb4JpibsYAUsWYSmm1MpCPHgWwtj/fRE
	 e8VUFzL72M3Zx6A1qZzoh/IA8ii2wIC7I4cJhh+uULDLUPyMKnEvCcEKQxVOEmnib9
	 DoSHh3MiiduX7HJcOEoYvDR16yqzuWAG0XdMb3TjJ4hksqK25J8oJA81S9JdyO6hKT
	 KumBA+dRzkFBjLvTQYFQ6GwuEX6rkbvQzlazbWUeATLs2BAmRQQCZoHCpYtJV8wBG0
	 WlW6SNySBC1jA+L56+L0NXtFEY6GCjF7HOrLV7AMDGIWW1Tfv0xJw3TcrW5yiutEIv
	 NrzqX1zgg14vw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:53 +0100
Subject: [PATCH v14 9/9] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-9-17cb29ebacbb@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin.linux@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQGWPeTkfQ596Yd1NnAfAqNezMquqK4g6o3T
 qdh/ZoqiCOJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0BgAKCRDhuBo+eShj
 d4iLD/9Q3u3EUkTrf71/HDEO1t/JE9RtrcE59R/WUUVHVBm36/KFnyuhWlTrS9tw/VZFWtGQ8So
 sTWdaMtJWEC2q3QQRpNIfuFJ+Z/+jGK5LZPDwn9KXSQXO72OFyCHmoxZ8S49BGHkcXC5J36BddJ
 oBhV1NXLnyPAz4PFYpxCpsyaIvY/ndPSnFXUaDUitUS6k8jXTbQnIThXtMjwRQYwvoZ/WV124sk
 UEf0NZdBT/tTHHljmTjmsBsfh/s31GgbOsBRNZlgQbEn1nfIKUv8rkWWsiMc2z5/CrZPZFNLLc2
 dvo/sOb/S1/XSyhIfdqBW5nu6XT3aIsRyQBNla6glkOxnRCPVwGnA0cVqLJSwGDC7HwdjQp8tg3
 6OpsRLLpT8i9c7RUWvazHkNpzYJVUiCdPvQ6bTtgozQcZ3XftPlRnYqaUc0MKuQrDp32ITc1Qpf
 2+NdHl7Ap0HGYUDWUouSvjzXWw3qRpzVu9MDGgzT/Ov44EEz/z8ouTVC8G5/wtYG2DvJ2Vt29g9
 weNYSK06rZyCIJ+f9S4SG6AsSmYmsH717vhWbdgv70nWR1sWbtA2U+0U94cRyNxeQLnmIvuY9CJ
 jUyG0IGKuA+MPWHoxjeNdu0VkFmHoW388Q536eQxeCfpBS7lljXv3TWUIUBmJqIKc7HOg81GZK1
 dE20j3imAjE0sfg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76313-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 07265E5770
X-Rspamd-Action: no action

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/page.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 4591b7b01c3d2..803f3e3d76b22 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be valid for use as a reference for the duration of `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // SAFETY: By function safety requirements, ptr is not null and is
+        // valid for use as a reference.
+        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }
+    }
+
     /// Runs a piece of code with this page mapped to an address.
     ///
     /// The page is unmapped when this call returns.

-- 
2.51.2



