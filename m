Return-Path: <linux-fsdevel+bounces-77780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DS6Fh0vmGkzCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3D1667A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 166773016B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D033321A6;
	Fri, 20 Feb 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa9f/rFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3332AAA5;
	Fri, 20 Feb 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581166; cv=none; b=KsBpnbKtPhXTTTjufJKpYNm1N/CW17AjQjCXn+mNjuAg23pgyZSOcxSZK+poZ8hGvU6QEDFROcZ8Mu7IrLQo3cv/nRDvqANJJ69M8cK7OBordzw7SJbt2LyBQM9rZ6E7aldTSPt4utVhi83g1xXc/58dksHcKXKGGr9oFvQ4V30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581166; c=relaxed/simple;
	bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3Ow4vpIRY9JuFMWKuo00YNMZ40cA9krFD99qobD5MYulbGLlXpAzHPJ8jOZsduav+OseBBFE2oFSwoYrT2wTLCzlUSjqs9ZwfeiXn9MADqy5EpbeLkKoQsq5bjhruhWq6IvmZaZkiXRdZRiCzS9Qs0V2Cnl7Mk7M3y5aJAcbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa9f/rFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952BDC116C6;
	Fri, 20 Feb 2026 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581166;
	bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pa9f/rFMzl4E/wPD8ciUx13iCfAgUF6vmSFXaR6Ks+u5bb5DAJXeMviiLdxh2MJv8
	 8+qc5hza/6VMGw4cPNgIQtSvcyxAvv/XWpRWhKCTzzjefbOVYgl2Bn+9VGuU00cEAc
	 jTvBr1iVHBszyNOkPQO3sX9uTj+4qv9eIpWpokFIoB5BYxSyamUEEtpnqHSLtYolX3
	 imBdySgeUu1FiifVSkCzKnQQ5D89I3lmT78VRrlGo0C4YvUidrWgNYFLXT3STRDR1B
	 TCUlRIjeq31xVyq9aJ1FHRa6M6evLAQpUau+Rs7uGaiXXLTqvstat9/ewV25hDKnY2
	 FyieTCY2HPk1g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:18 +0100
Subject: [PATCH v15 9/9] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4kJUgBgTj0V7kRaDlo9MltCBPjRgIT4dj8eMOKXfB5o=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6mLFWJC4FUrb2akl8BDN0BW5kYHddNAH8R6
 ePI4Cw2p8aJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZgupgAKCRDhuBo+eShj
 d4hjD/9a6KYUv/3QDTCUbU4jBZySYMrlWTE3KyUKD7sMA5hI7Q0Tt6utA8LOxT6+fWgt78T6dsP
 YLaKTrcMsbBbF9ZlaZrHl8lklZikAR4xxXgnPSPGr59l/ggK4Mo7kCUQdgwUuC8ahkpgb3RVcUP
 l5OhLwF21W8lWV0hEx409t8Kzk3WeW2aOLHrkVtgPaBMUoTkJvPAEdi/M7QMEd7KvTGtBEN10Sd
 uhQioHELdqQTvuoGD/2Nklb8dMjHCDjnPf6DJyD7DydQTfEn2hjA6jQdq7K8J00MQuP/InZd1qU
 EMO1sfL3nqfaUHKHOpGHjKARDrvThnL2r030YD0tcCw2YZMWv5umGNAlyGF1CNCEDVa59lBEGmW
 owSPtNvf3UrEKKpr7iymtNmm91VsmBBLGJ8Zwg5nZHvn44w2XR5sr6sXo0Qe5IlG+RZQPG7y+cX
 rB+YoFcD82kVzVU3ZT/1RJWC2PZPOs34ie+0a+iU/I3k5swQfcovtHfPX+UM5RXMZmUiFZJmvKU
 FWReMNdU9IC65rTvBqhTBOmM6OZJu8DGdagZs9ZIcaXPj84ZEtd+dYi7mQlLkTxwBnCjC0nwacH
 JuKEKkSC25+lzZDp9QXvecJqUf1eC1gnMOjlYogawynT0QOSpqelvJDq1GJeBuRYH3wCvocTQ8u
 WWDeedFFS03kT+w==
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
	TAGGED_FROM(0.00)[bounces-77780-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 38E3D1667A3
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



