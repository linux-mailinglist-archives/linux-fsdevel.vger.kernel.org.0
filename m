Return-Path: <linux-fsdevel+bounces-76306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xRQtBh84g2nRjwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:14:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D6E5A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A9D309EF5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE533ECBEB;
	Wed,  4 Feb 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJM2SVVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924A38E5FC;
	Wed,  4 Feb 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206258; cv=none; b=MFZhHEPhf7XFBWtOh8Mt/NQgpFneioOwure+gwJIMBnSR0HcNd3UAdGB4r5Xma7UOXhoBalMuGU8R9kKisWaJSX2MhUPLZbg9nE9QREcFfU2u4hu/u24v+4PDYvTHRpxsTjRV7jR+/c3UKPItNBSfd/VHbmVJJjTJb+69CRHFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206258; c=relaxed/simple;
	bh=nKaCBdsXr+RePW+8UoAyXTX4xqDtXXOQmM28EalUlDM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LlIVOvFnUVGCxTZv+DX9Zx+cOJHua4xqsQFc4qbc4O1u0+k8rii0tBRR9IuO5ipCbnRwR6S3eRs6LTgflFG75KfiqL8DTqyx2z7eeeE/2TYpnASrHtg+k+vlaaMzMysN8e1kvI7GpOy9yuyF10YvvxNjaWxFDdmBGt7wIq5Ur4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJM2SVVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CE9C4CEF7;
	Wed,  4 Feb 2026 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206258;
	bh=nKaCBdsXr+RePW+8UoAyXTX4xqDtXXOQmM28EalUlDM=;
	h=From:Subject:Date:To:Cc:From;
	b=VJM2SVVpRXhZbMS/Q1/BAuplV0+lb+YyaOUn7UmolNa0FPcNnxX6pRQvBHCxuPy66
	 7iCVaqcIKUTPpnMm1vSiPLSOZ9Xvn8eybghS4MfIJyB6AjOMvR1blSQSHNSopCRfvz
	 6N84/SItF7BPAP+AMgAO7f8gAHL1ifnBR1JHdEVoHtkfyVOwqICDvGTpNsbwaJ5pBD
	 SIZY3spx2nWjhuksyb36hdR9t06DsGqFFIe99nkycKNtRlsHFftZyfBGRWS0c4ckUq
	 P45UmDSwIGR/LEZVQRjfgXK7jNeD6yRrdHOxDQiYFm3MPf87xeqkYeEAhabgpKVMBi
	 UzrbWDUgsV6DA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v14 0/9] rust: add `Ownable` trait and `Owned` type
Date: Wed, 04 Feb 2026 12:56:44 +0100
Message-Id: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwzg2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDE10FJSSM
 xLz0lN1M1OAAkpGBkamBsYGprqleZmFpam6RalpukaWackpZuamaZaplkpADQVAwcwKsGnRsbW
 1ACf668VdAAAA
X-Change-ID: 20250305-unique-ref-29fcd675f9e9
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
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7860; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nKaCBdsXr+RePW+8UoAyXTX4xqDtXXOQmM28EalUlDM=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzP+S0RmSshnDs03HZu1BiITH15Lhtau7kKc3
 c92wPFXu32JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYMz/gAKCRDhuBo+eShj
 d/GLEACoQMrgmndkoKB/9yLEzrbQUERG0zIvjZov8cfBANw/3ttWuWANprnrriGHBOIo0B0oRwz
 LT7/8yzeq/ad8j1j/Sl1ad/MECQZItdEiL4NXyLbHpONzXK+waPnS64tNFrxMjNRAO5X/jsQ7Cv
 YOpLjzwg2wiOVvwtGxe0qntjYul1/defEyE80jc7HAELu84sLYI4lBD6loA90h8p2eRDLj68q6z
 FU9yGx/AlD93BDCJcTh4XMuI1eU0QzcEJ3RppM1Qap30VMTUBj01TgzKuQkjZ9p8cOOm6n1rZ5n
 9eukTtiMmRng3QCebhth3eO6he2mqbgSeRbof26MTNpumK41+8KSCZmvjoEcLy/srHg7uyEQaiW
 5OckH0zC4o06xRIPFdO2iJMbUS9Dk++rYrWxnwzpJLfK6Q5re934NozCkQnzzNEQIs1fZ/kV6fN
 tNAaCvK6c8tgMiQ0pvKYaC6NVcUyqmZGHAQ/FBuuaeyh97ZhOgS+04GyZseqZ6jn5yN6UOq6fch
 BFBmOmoWGMlytTY1HpHhp8Ch9fF4PFYUDvFsCmCuAfDA3xO7WWGADog5VsobcSTMZQrCSZNIsEN
 y8wJCEfMaWhHxY5cyjzwaKqfRDcyOlgsyiJP0uWSdYz0ISRn/+Pqz9p6s7HaH4R0uWA3eRruckJ
 g8gmgRALlUQGfAA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[types.rs:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76306-lists,linux-fsdevel=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,types.rs:url,pid_namespace.rs:url,owned.rs:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 965D6E5A6D
X-Rspamd-Action: add header
X-Spam: Yes

Add a new trait `Ownable` and type `Owned` for types that specify their
own way of performing allocation and destruction. This is useful for
types from the C side.

Add the trait `OwnableRefCounted` that allows conversion between
`ARef` and `Owned`. This is analogous to conversion between `Arc` and
`UniqueArc`.

Patch 2 is difficult to merge since it requires a change everywhere
`AlwaysRefCounted` is implemented prior to application. We had new
implementations of this trait for the last few releases, so we are
probably going to have some when these patches are applied. Sorry for
that. I would ask maintainers of all affected areas to ACK these patches
as soon as possible.

This series has been underway a very long time. The work was started
off by Asahi Lina, then picked up by Oliver Mangold and is now being
finalized by Andreas Hindborg. For series like this, it is difficult to
track what contributions came from what authors at what time. I'm going
to leave authorship of the patches with the person originally submitting
the patch. I will not track changes by each individual on each patch.
Instead, I will leave a link to the original patch in the commit message
of these multi-contributor patches.

As I cannot reach out to everyone to ask if they will sign off on
the changes I have made, I will remove their tags, as these require
approval.

With this approach, checkpatch.pl is complaining about missing
Signed-off-by from patch author. I am not sure if we can keep it like
this, if I need to change the author, or if I need to hunt down the
original author to get an ACK for keeping the Signed-off-by tag?

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v14:
- Rebase on v6.19-rc7.
- Rewrite cover letter.
- Update documentation and safety comments based on v13 feedback.
- Update commit messages.
- Reorder implementation blocks in owned.rs.
- Update example in owned.rs to use try operator rather than `expect`.
- Reformat use statements.
- Add patch: rust: page: convert to `Ownable`.
- Add patch: rust: implement `ForeignOwnable` for `Owned`.
- Add patch: rust: page: add `from_raw()`.
- Link to v13: https://lore.kernel.org/r/20251117-unique-ref-v13-0-b5b243df1250@pm.me

Changes in v13:
- Rebase onto v6.18-rc1 (Andreas's work).
- Documentation and style fixes contributed by Andreas
- Link to v12: https://lore.kernel.org/r/20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me

Changes in v12:
-
- Rebase onto v6.17-rc1 (Andreas's work).
- moved kernel/types/ownable.rs to kernel/owned.rs
- Drop OwnableMut, make DerefMut depend on Unpin instead. I understood
  ML discussion as that being okay, but probably needs further scrunity.
- Lots of more documentation changes suggested by reviewers.
- Usage example for Ownable/Owned.
- Link to v11: https://lore.kernel.org/r/20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me

Changes in v11:
- Rework of documentation. I tried to honor all requests for changes "in
  spirit" plus some clearifications and corrections of my own.
- Dropping `SimpleOwnedRefCounted` by request from Alice, as it creates a
  potentially problematic blanket implementation (which a derive macro that
  could be created later would not have).
- Dropping Miguel's "kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol"
  patch, as it is not needed anymore after dropping `SimpleOwnedRefCounted`.
  (I can add it again, if it is considered useful anyway).
- Link to v10: https://lore.kernel.org/r/20250502-unique-ref-v10-0-25de64c0307f@pm.me

Changes in v10:
- Moved kernel/ownable.rs to kernel/types/ownable.rs
- Fixes in documentation / comments as suggested by Andreas Hindborg
- Added Reviewed-by comment for Andreas Hindborg
- Fix rustfmt of pid_namespace.rs
- Link to v9: https://lore.kernel.org/r/20250325-unique-ref-v9-0-e91618c1de26@pm.me

Changes in v9:
- Rebase onto v6.14-rc7
- Move Ownable/OwnedRefCounted/Ownable, etc., into separate module
- Documentation fixes to Ownable/OwnableMut/OwnableRefCounted
- Add missing SAFETY documentation to ARef example
- Link to v8: https://lore.kernel.org/r/20250313-unique-ref-v8-0-3082ffc67a31@pm.me

Changes in v8:
- Fix Co-developed-by and Suggested-by tags as suggested by Miguel and Boqun
- Some small documentation fixes in Owned/Ownable patch
- removing redundant trait constraint on DerefMut for Owned as suggested by Boqun Feng
- make SimpleOwnedRefCounted no longer implement RefCounted as suggested by Boqun Feng
- documentation for RefCounted as suggested by Boqun Feng
- Link to v7: https://lore.kernel.org/r/20250310-unique-ref-v7-0-4caddb78aa05@pm.me

Changes in v7:
- Squash patch to make Owned::from_raw/into_raw public into parent
- Added Signed-off-by to other people's commits
- Link to v6: https://lore.kernel.org/r/20250310-unique-ref-v6-0-1ff53558617e@pm.me

Changes in v6:
- Changed comments/formatting as suggested by Miguel Ojeda
- Included and used new config flag RUSTC_HAS_DO_NOT_RECOMMEND,
  thus no changes to types.rs will be needed when the attribute
  becomes available.
- Fixed commit message for Owned patch.
- Link to v5: https://lore.kernel.org/r/20250307-unique-ref-v5-0-bffeb633277e@pm.me

Changes in v5:
- Rebase the whole thing on top of the Ownable/Owned traits by Asahi Lina.
- Rename AlwaysRefCounted to RefCounted and make AlwaysRefCounted a
  marker trait instead to allow to obtain an ARef<T> from an &T,
  which (as Alice pointed out) is unsound when combined with UniqueRef/Owned.
- Change the Trait design and naming to implement this feature,
  UniqueRef/UniqueRefCounted is dropped in favor of Ownable/Owned and
  OwnableRefCounted is used to provide the functions to convert
  between Owned and ARef.
- Link to v4: https://lore.kernel.org/r/20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me

Changes in v4:
- Just a minor change in naming by request from Andreas Hindborg,
  try_shared_to_unique() -> try_from_shared(),
  unique_to_shared() -> into_shared(),
  which is more in line with standard Rust naming conventions.
- Link to v3: https://lore.kernel.org/r/Z8Wuud2UQX6Yukyr@mango

---
Andreas Hindborg (4):
      rust: aref: update formatting of use statements
      rust: page: update formatting of `use` statements
      rust: implement `ForeignOwnable` for `Owned`
      rust: page: add `from_raw()`

Asahi Lina (2):
      rust: types: Add Ownable/Owned types
      rust: page: convert to `Ownable`

Oliver Mangold (3):
      rust: rename `AlwaysRefCounted` to `RefCounted`.
      rust: Add missing SAFETY documentation for `ARef` example
      rust: Add `OwnableRefCounted`

 rust/kernel/auxiliary.rs        |   7 +-
 rust/kernel/block/mq/request.rs |  15 +-
 rust/kernel/cred.rs             |  13 +-
 rust/kernel/device.rs           |  10 +-
 rust/kernel/device/property.rs  |   7 +-
 rust/kernel/drm/device.rs       |  10 +-
 rust/kernel/drm/gem/mod.rs      |   8 +-
 rust/kernel/fs/file.rs          |  16 +-
 rust/kernel/i2c.rs              |  16 +-
 rust/kernel/lib.rs              |   1 +
 rust/kernel/mm.rs               |  15 +-
 rust/kernel/mm/mmput_async.rs   |   9 +-
 rust/kernel/opp.rs              |  10 +-
 rust/kernel/owned.rs            | 366 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/page.rs             |  57 +++++--
 rust/kernel/pci.rs              |  10 +-
 rust/kernel/pid_namespace.rs    |  12 +-
 rust/kernel/platform.rs         |   7 +-
 rust/kernel/sync/aref.rs        |  80 ++++++---
 rust/kernel/task.rs             |  10 +-
 rust/kernel/types.rs            |  13 +-
 21 files changed, 612 insertions(+), 80 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



