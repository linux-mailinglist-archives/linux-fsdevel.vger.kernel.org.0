Return-Path: <linux-fsdevel+bounces-76389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG++A8V2hGkX3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:53:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB79F17DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6307E3049965
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C153AA1A9;
	Thu,  5 Feb 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4X4sbtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539293A9D8C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288705; cv=none; b=QFp0juSxzjangEMZJG270/F9a9Nm9o9UeZeC9upCd7WDebiTs+ylb10aCLkh59KQA04T5THwvZNy27f8i1y0T9MZ9QDlQnErL7fGSbrTBnIIStWXzoBzxC3Z5jGJ8V6uc/vod/BvUNM7HtZsc1M551xpsBcCnFqDqdo8tUbcUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288705; c=relaxed/simple;
	bh=lHbpClqy5L1XyxxmB7KNUoFqATCRTP8Er1SZGKGJ6tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUbTUlKoeJhCCVFeAaa7VhJhW1gy3gnYALv52RXm8K5R4zy7oU1asQ6640DnJrDb+BWk+S35YYuXvvEY3U5hTD4883I9qcSJo2KBHltIdTxqAsKzUHy9BtV/2VHWN9HYnAq57UUqNmS7uS4Ico+HlJ0BPs55kSS1XHhpf7pJyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4X4sbtg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so11237235e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288704; x=1770893504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMyX8uRGOmUN6KZEX+IAO29sQdtn60nQJQNJ760wFa4=;
        b=f4X4sbtgmJNi4I5LXEGwdLk286fabxXk73Vsft7Qpg/gzsX0MUPQ88wa3ia+uayZ2t
         CvgR4X+R81eRy4eIhOFp6dnYPwG13txRFOjWgw6Q0v5jG0BLN3hPIivz1LeqUbt0XTks
         v54K8Z8LSvnsoYkBghaLueBRv+2BJIMBBQGAdjsywEjEo6bYWzsESju5SdbTgXS32OVI
         F7H4u0NLfjBDdRKMMX6wIoYjO8ky968uc6skEu681xgEYE7u8YDySz/RUJW8q157uw66
         /vo3CwBCwArbP4//fEHpxCxcbA/FYIPDR1lKAcEsvzlyLvjuIer3S5lIYMi7iw+KBTRk
         NhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288704; x=1770893504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMyX8uRGOmUN6KZEX+IAO29sQdtn60nQJQNJ760wFa4=;
        b=RdqTbA0z0SnAC4TwBWDNv07mveqRD2XV5PXpQseyeumfg+rgDfTRDebVUnSwveLHMe
         LZeW+0/Np4rhx3W8iv1xJDzjNZlW13Wd73LjX1CcRbYTAL0YUNJ5Sz1oqzkzwLEPQNVX
         orjxNLir4W5NhjnD1GwkkNmyIilkLW4900GoFw27ppHKHvQOn5yRZ1u3t2fGbVzWEjt0
         igDv0yCNMBPp/Gn4RpXioDm01WdqSo2dk/eFtvoM+QrozBbG1UMk1kmeteQTfFIGCFOd
         arzhjx2ah7vDVKiT0a+r9RcIEAqQSVFzbFG54dBJLoI7thkaasfKCEluMMDgzOCQ15R+
         gYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVWiwBAB2RmNxhQKyyZQj8sm+hVvz+FHlpLNlDeq/6/OOiJxsd99lkdQFrbhbJhNMkU8oeNfdbHpUlWDJg3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4t4Pnu/PgU4f0SWxxywGkA6YYWHTEUkA7pkUXDHYvNso97LY
	B7fUZLzJRWOROD3hpH8kPEpCyZvap74ivROWf9YoopnkDpgr+TeFIjYWgdxBompap+unKldRE/u
	J72WmtjQ0VTYRslZ3XQ==
X-Received: from wrf23.prod.google.com ([2002:a05:6000:43d7:b0:436:f00:c1cf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154a:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-4830e93478amr80493955e9.8.1770288703598;
 Thu, 05 Feb 2026 02:51:43 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:27 +0000
In-Reply-To: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=lHbpClqy5L1XyxxmB7KNUoFqATCRTP8Er1SZGKGJ6tI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHY4aveNr15TrzG7ybOw4TJxbQ92vW+WTNFwe
 SWpiksgXOeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2OAAKCRAEWL7uWMY5
 RpEbEAC0yt4w3VlnWagA17RkTMJUz2p4xk2iEYS9GjmxYT8blDHPFMYFaItdVcShUAHSGKR/5uP
 sp56JdoMwss+uH23eVwJiQ+HbryIOXdKVtLt+5oKl0UqRnr5R2uiwWlvusffAP+LAQhX7oP7VWE
 V+SwLxDVamJaGEIJp695c0KtFyx6MVHwB6+VNY3ABU5KqkjaFcDy1b97UDGC14f7sAQcpSxk7YI
 ZQRzS/O2c29hQ4VJw/Q93nYRKuPOnB4Lhm5nFc9IZfQJ6xZhp+ND1h6pfZBgfP+78TTEY+0O0RL
 p6niPOid/1OsqecLYRt5KuPv9CwTXmislZfm6l6AtWKzV9HSL3UwjzYp89wj+8/2y9Alk35MqDB
 Vm3YEb/L5lP3F24xewKmeQ5qtr5D6ypVUuOJ6PNseGVxaD1uHJ25HW0xZ0o7lsd1Natiy7AogWP
 Z1cRoiXXGc89E4N5N343Mb2Bmc8HofAHx+W/n1Kcs6XZf1phN7RKpkdqTysMnSSx6ghhABdaBE4
 9xSTp48eyJq9u6ArYggMUOck58X2jH5+HWSOTpAUC6omijpbWoq2lBtdcV3fh9lvrDtVR533LAh
 ppXfMNZX5Fp+lnVq12G31nZs7qvqYsQT/QCxlBJIsYHttULTQrcsadK44k6RzJrRzBwoRAQWvQ0 UruzpTUpSPSbVnA==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-2-dfc947c35d35@google.com>
Subject: [PATCH 2/5] security: export binder symbols
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
	TAGGED_FROM(0.00)[bounces-76389-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6DB79F17DD
X-Rspamd-Action: no action

To enable building Binder as a module, export these symbols.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 security/security.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/security.c b/security/security.c
index 31a688650601b62df1e536bbe4407817edbd6707..b4776f0e25b33df95379a08a7659c0e5f767237b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -488,6 +488,7 @@ int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return call_int_hook(binder_set_context_mgr, mgr);
 }
+EXPORT_SYMBOL_GPL(security_binder_set_context_mgr);
 
 /**
  * security_binder_transaction() - Check if a binder transaction is allowed
@@ -503,6 +504,7 @@ int security_binder_transaction(const struct cred *from,
 {
 	return call_int_hook(binder_transaction, from, to);
 }
+EXPORT_SYMBOL_GPL(security_binder_transaction);
 
 /**
  * security_binder_transfer_binder() - Check if a binder transfer is allowed
@@ -518,6 +520,7 @@ int security_binder_transfer_binder(const struct cred *from,
 {
 	return call_int_hook(binder_transfer_binder, from, to);
 }
+EXPORT_SYMBOL_GPL(security_binder_transfer_binder);
 
 /**
  * security_binder_transfer_file() - Check if a binder file xfer is allowed
@@ -534,6 +537,7 @@ int security_binder_transfer_file(const struct cred *from,
 {
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
+EXPORT_SYMBOL_GPL(security_binder_transfer_file);
 
 /**
  * security_ptrace_access_check() - Check if tracing is allowed

-- 
2.53.0.rc2.204.g2597b5adb4-goog


