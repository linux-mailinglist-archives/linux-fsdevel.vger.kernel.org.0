Return-Path: <linux-fsdevel+bounces-78252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLBCCzeLnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:27:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9A186427
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCCC326774D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53E37E308;
	Tue, 24 Feb 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEbr9SH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94437BE6C;
	Tue, 24 Feb 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932024; cv=none; b=Elk2pyx1rEzRPq+trzhlNSJwDdmcWvLRccWdSu9hJzoSSxGnlUCCDKg0wugUbCACLLQd5dEAqlr4NLbi0gU6SHHvMvACZJST4/kY8A939wl3+n1ISRuPxcyscq2g2npFVm+jAhH+1B2KCRMYP2Rkl1aWP7fm/u9b+1Pby8XW/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932024; c=relaxed/simple;
	bh=u+CxE4WAb4lLYs646rqUMrYESFoSfCpkJ/yBahV7oWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFm+r1S20Zpsjg4ZHRX3suZihP8ZOYekr1m5+VXqDpCBgd1qWmpF71Xm51dLf8mZx9hDH62ICF3Y6WRGo4bPqj3we82MpMZy07KfXmdblRiwRZ3KwIwT1V2gtBajg3FcyNPqnDx4qSyWXbNRGRiFTmjMRLVreyqXa45k4Ek3C7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEbr9SH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B3C116D0;
	Tue, 24 Feb 2026 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771932024;
	bh=u+CxE4WAb4lLYs646rqUMrYESFoSfCpkJ/yBahV7oWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lEbr9SH4g+vkYJTX1S89jMNlf3p84ZRU/v6+jnkKrqULJxEJdYlaFLJCqESxXcBdB
	 95iKFGtV5tH/t/0vNO+wxU1aDpsO11zqlfymtcsNTA4YvmO9YR5aYjFFMj7Ln8loPY
	 rEgIKnAaxeg9kAjJlVwUqwUS0bEBBgWhB6fED96nwJgySVJezf35zzy0HLBtD08lQt
	 18In2j581km/tx1LLr/t4qqKAv5qEGQ1bpe2ctkMSNIPvMoiyy72CIAU4GrmCyvsRy
	 yWMO3Jz5aMRBD1stVUIxNLV6DUau4VBUlFtdK8KkiaW/QzOk4ZH4TKPq+YaDfDzI1w
	 ytRWw5P2ZZ/YQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:18:05 +0100
Subject: [PATCH v16 10/10] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-10-c21afcb118d3@kernel.org>
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
In-Reply-To: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
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
 Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=u+CxE4WAb4lLYs646rqUMrYESFoSfCpkJ/yBahV7oWU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj8LE4iboDu3XEQEDgUJPpBWv16iN6jxTcXc
 nc4VDozC1yJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I/AAKCRDhuBo+eShj
 d3r2EAC9HrXGAN5UQmY4yPBtdIt+D/gH6jEj9h2dHBDQcF6dzQMjKgBxItt5MpEuDUUqRp1qYP8
 If2k0oZc8AYRDlxYq2p6mzw5+29obQYMI48OgM8Bfv5ZCxLkp/LfqJO/xM/TppNhuO+krTmAShb
 MCl0orP42ytvBWvpv+kpvZvNudBNTHqwxzk6KIC8d6Z0OqxgLrm2FYAfzdgre0WjeIRPhoj4yo5
 Lc22cKyp/OyVtDzKciBOk7U3Dqo2qa5QbrgWdeR4srzD5HlhiRGErLc4geoJYKik0cT7Tuh+l9I
 ByT2s8DzyaJBwaWEzC9klxmxn8O+D6hrUFWbBSV0Km6LY1IblkmwNJOI+yHbB1vpCLe2+Ducl0f
 3oav38GaY3BIWHZOz3/fU9i4RQoyFKsucZoj7GdL+0I29K5W+fIDEiVtPXb5VwLlS9uuOGZmLCf
 TArqmlPzTFT4FzZY5BIgFAJJ55D0M0j7VpIUm/zpXbEyRF5BXnMPHjxGxEQcMZVtJBDrNt+mGkP
 o6hstg9wsEObY5kFIUXlLbrqXnAEXEOA8z96T7KvE4sHClZAEUouSvzlF/evoKDuxwBvArbB0tN
 c+9pkL/JWcpGsrJzdlXjerAmFT8ic9gqMnxpaPOlQ7WQTf6RGMqRo+mJ5SnYrtDuJPHdl3QqHwe
 fXaCMyhvccgrgVg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78252-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: A5F9A186427
X-Rspamd-Action: no action

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/page.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index e21f02ae47b72..96f1ec125f043 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -192,6 +192,17 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // SAFETY: By function safety requirements, `ptr` is not null and is convertible to a shared
+        // reference.
+        unsafe { &*ptr.cast() }
+    }
+
     /// Runs a piece of code with this page mapped to an address.
     ///
     /// The page is unmapped when this call returns.

-- 
2.51.2



