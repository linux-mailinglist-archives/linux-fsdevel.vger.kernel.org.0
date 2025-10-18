Return-Path: <linux-fsdevel+bounces-64601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FC9BED9B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A1719A8711
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4B2DA775;
	Sat, 18 Oct 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zml/XwiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1552DA758;
	Sat, 18 Oct 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815058; cv=none; b=NdeYRGTesPJNSfviIT+tQ4X7XiDJ86r0lCUnY8QEsDWsNBy9UYG/RLb+IjApEVIWgaAbaZFDAyhGct3smutNWLpItd/p5G2VopLFBAk0nixXPQAk25R/iTne0YCovGf6cxbu53Du7UqttdVthFzL8pzy3ajmuqvGVKgESrdPTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815058; c=relaxed/simple;
	bh=t3MeAiRnGdoesAhwXOBk5BryendJK05svLbfpjh+K4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2vqXD/e0RufgN27feQ+b0R56hJkIf8Q3exwSrmsjlmGw1zDYS5LdMUhpP4kgz8RZyMpt5iCw1Be/LDShZrzgpx9/DGL9XYTu45iHvTtioUsfNISao1uhGNuXnYpg/U3M6MrJP9WGhB4kcGGGmT1KpNsvB+fzC/LMlzrfOR841s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zml/XwiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C6DC4CEF8;
	Sat, 18 Oct 2025 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815057;
	bh=t3MeAiRnGdoesAhwXOBk5BryendJK05svLbfpjh+K4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zml/XwiHfAwgAYGqQhQmjibupmeFVe6AL7G8yrtIuhgOGPBajlIixZDSvtj/n0cDk
	 2Z9BgLJttZxcWNnImfvAzllTCHLttg8qJu4b4dFmHIEcRX8xXKeBmCML2/EZNY7rE4
	 p4Ir/tpGxrPSTwfdst6VSVYv7LU0RGpp38aNgAgoePrOM5uUx6Vc46fHJ16izzuSeq
	 bGDflThcMknvRW0bV/o8iclVods5ULufhvLGmTeJ94Pyu6YD1WIYBz2vDiPASQSh4S
	 G/8WCo/ke3Nu5XltcaPNa36wdcUfG6WWtvNa9Ar7hgizm8vpndWzYi07A2+zrkVDMw
	 TUQSBlMs1rCLQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 18 Oct 2025 15:16:33 -0400
Subject: [RESEND PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760814989; l=931;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=D3+7P/SS4fL5Q9I/e/hnwaICnLJa3uX2WlUDB305PhA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJNTPLMMNL1Y0QjjEhUqhLLisj+FekJgSfqKzOMBilFTfJSI1pvk3DV52ieZT/JQS43drzCi0jB
 W4MEhimPTDwU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 10f1547ca9f1..466fb7f40762 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -157,7 +157,7 @@ pub fn new(
                     unsafe {
                         bindings::config_group_init_type_name(
                             &mut (*place.get()).su_group,
-                            name.as_ptr(),
+                            name.as_char_ptr(),
                             item_type.as_ptr(),
                         )
                     };

-- 
2.51.1


