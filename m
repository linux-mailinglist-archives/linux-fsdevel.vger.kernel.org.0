Return-Path: <linux-fsdevel+bounces-76391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIGUHjp3hGkX3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:55:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2DF183E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE93306EB44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C73A9628;
	Thu,  5 Feb 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2VWNekv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F443AA1B6
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288711; cv=none; b=In7kOmlFLTaXjSVnbgmNyWWnh1NFD4rS85hC4Y9KfFh9kIHHMzDdca+FcmKaObCosOwrb4PUV3c0XFk1MsVxUmumj85xaraCdoq6eZOtSjfmA81JeI7Hg2ERqs5DfXJ6n69QNiYgjb6m7v/2qZ/ibXio0oT5T8s/WHehSkIROQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288711; c=relaxed/simple;
	bh=u7tNOSUp16XQ9Cw8SF0QUGSikFb1+CWkD1yI1QkYzoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POyQEzFCZwAoA8rgXDG2Ea5AqQ50SIJR9nVPdshE032u4yEmQS9jhwZn/Rg88BVAQ3NSfXH1b3QK4LyMzjS3IG3d8lAtT93wuZDFCRLCjj1bSo3E5agtmyLLXzoN2uq2/PBetWvUO97YIXz8EnqYd++fleNjv9dLG5V68Zry5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2VWNekv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso834662f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288709; x=1770893509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpaIYad0WHN8wTh3ZSTIrnFcA9kAsyJ24DcP542BHNk=;
        b=X2VWNekvFtfxlT+CUnUG8A9//ETNne86b+tMqmys512g0BDoy1OKeh0pSH17s42dGs
         aAxfTpZ6JsdsFekbz3r2iJAqZi958gYfnTWnnXjfyZ1XNgyLr31rl/Ge6bjMn5nmdfsV
         eqgkf5rgy5mywQEe8ZhVMoI8ljNL8WQiCQ6oJZS+n3XkBKr7KaCG0VE0RzKD5n1nXzJq
         7Rf/K2VyGTgHFPrVikUNgbujLPt6FyZU68vCN6wZaDpQiKcP4b/NVwX5XTdImOrJxQzo
         UHoRB8P48oN3DmVOdCoQX1Vb6qH+WlrX+7kSumVk1CSELF4mWCjAOmGy5z7CC7/1r+xF
         CHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288709; x=1770893509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpaIYad0WHN8wTh3ZSTIrnFcA9kAsyJ24DcP542BHNk=;
        b=lSrrUO6oLt3xRLMI3XQwwV5tYp6qwqRrC/Z7bw1vk9RJ/QzlV06CM3advYTGBma/sR
         NW7Cggjf0sm/26Uw/Wlv5WlIqtNkfpAT1Sopdwai3fBAgXTKfc5Wx6EMGyqKyzysbIiL
         sVHy2T1oycK6qypW3INxEXZzFQuinpHZ3ulhyfBbWJjJqe+Qs8xiYGmSAom8BdD+70CI
         6gzjcPVOWJEiD9ZMLDEhLD+mlMUqhMtQl5sq2HdDGsK7nsbAv7lDqAhYwe0bNwickdK+
         oJwIGFXot+L1KSPyWzcBsEHvtml+ecscOfV7SwyLkE/02A/g0HziLsOAYxyFReskdOrO
         Pu8g==
X-Forwarded-Encrypted: i=1; AJvYcCVq+UvZKfurFaBu5pi1/ErU2Gz6a1c4KnAE3h25AjJiBWUw0qRIyxA7ucoNc8ZmLRNklfgUB7dnEs/9ljZD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cdVRqtH/QWAGKBKKlby3NW3GmOvvQ+ULfXPA22OS7j8ZP0TB
	F0dBLPTiYry7xJxP8waxykVrmy+/7d5uE0MvCMjGCTAmb4aztkUt6Q8yj8RSVQStBncYfGf+TLS
	X/v2+NHEo4veFWBg85Q==
X-Received: from wrd12.prod.google.com ([2002:a05:6000:4a0c:b0:435:9538:ee5d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:c0b:b0:436:19b1:c15a with SMTP id ffacd0b85a97d-43619b1c171mr5602426f8f.21.1770288709279;
 Thu, 05 Feb 2026 02:51:49 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:30 +0000
In-Reply-To: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=u7tNOSUp16XQ9Cw8SF0QUGSikFb1+CWkD1yI1QkYzoo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHY5pD8xrMoCMSi7/YAo0zBpNGTkGFDOlicJv
 SsWF7lHACqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2OQAKCRAEWL7uWMY5
 RvK4D/9Sqg7OAbaqsJt4VhIwElaxQsfFl0bkBDgM9NE0JgEtF//U3IWNLFyiDbFjyU/eYNk4vqA
 /EoImWS8mnYl49c7B4DXLibsoNeVIXCKk41En9QlYRydj2O+rGS4BRARaos3d5GjPSmcd5W/WY3
 JlN5F7KIYDwQtbzfPsAucG07Nj7n5ooKrD9vFmhSUlQOWltfSNAyris0RP0nsl1k//en5nczqcN
 Vls40YLjS1+M/48o87Ba3YvvlYh4DUWI2J5AdR9/ty4DwW+6LUYqAGimnOQ9vT1wZwyFqKs/5nV
 usl0vrnOojmKlNEIKXAhY+2Jv94Ssv0sX3Ngw5CLUFOCvPfiyzNHu609QvruEX8SKNeqwadY9NS
 YeHUBm0PnQkjoPqhJZmFyAdz9Fs30oPy9KItXYWvVWiggE0bDgPE0hsZX2WyOxOXk8z45ZYDY1L
 h4IUhPo4C9JFqzerdHy9DKCF98umsdKRVGW3CC+osSf91NbYzBFxsNQTTVNLm0Kj4WbJupA5VZY
 TAgoS3a4p2E7fv7C/DDR8exECeiis8FHGKgaP41bzhBB3p7kP9Z8L0JR1j/tZvGv28Hh0R7HOJJ
 XXjDToIdX6vm1owhmFCg8aoVz06WZ9aWdPGYaSfEgHmo2lybieLTgIshWP31cp0hOUQm9tffRSO VAuNvPd3riiG9ww==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-5-dfc947c35d35@google.com>
Subject: [PATCH 5/5] rust_binder: mark ANDROID_BINDER_IPC_RUST tristate
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76391-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rust_binder_main.rs:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4B2DF183E
X-Rspamd-Action: no action

Currently Binder only builds as built-in module, but in downstream
Android branches we update the build system to make Rust Binder
buildable as a module. The same situation applies to distros, as there
are many distros that enable Binder for support of apps such as
waydroid, which would benefit from the ability to build Binder as a
module.

Note that although the situation in Android may be temporary - once we
no longer have a C implementation, it makes sense for Rust Binder to be
built-in. But that will both take a while, and in any case, distros
enabling Binder will benefit from it being a module even if Android goes
back to built-in.

This doesn't mark C Binder buildable as a module. That would require
more intrusive Makefile changes as it's built from multiple objects, and
I'm not sure there's any way to produce a file called 'binder.ko'
containing all of those objects linked together without renaming
'binder.c', as right now there will be naming conflicts between the
object built from binder.c, and the object that results from linking
binder.o,binderfs.o,binder_alloc.o and so on together. (As an aside,
this issue is why the Rust Binder entry-point is called
rust_binder_main.rs instead of just rust_binder.rs)

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index e2e402c9d1759c81591473ad02ab7ad011bc61d0..3c1755e53195b0160d0ed244f078eed96e16272c 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -15,7 +15,7 @@ config ANDROID_BINDER_IPC
 	  between said processes.
 
 config ANDROID_BINDER_IPC_RUST
-	bool "Rust version of Android Binder IPC Driver"
+	tristate "Rust version of Android Binder IPC Driver"
 	depends on RUST && MMU && !ANDROID_BINDER_IPC
 	help
 	  This enables the Rust implementation of the Binder driver.

-- 
2.53.0.rc2.204.g2597b5adb4-goog


