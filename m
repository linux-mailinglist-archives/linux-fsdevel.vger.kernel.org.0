Return-Path: <linux-fsdevel+bounces-78245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFtnHmyMnWn5QQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:33:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A563186535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4350831CE25E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D837C11A;
	Tue, 24 Feb 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni5jHbXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04629B799;
	Tue, 24 Feb 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931951; cv=none; b=pOP2cIbR6U2vE4yOyvJw9Y1zpmPlQtjgJ5UExzZKITtd+rbUHotZ+BR1j2wc/i7ceEar/GCHe31+PoTr6pyncNzOCmJT/7RoA6ejO3sWQDqmQnvtdNdr5CFeqmW/xnLNDXn1VCEITU7DOy2mC06TuON855vnidbQdrhClAxDidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931951; c=relaxed/simple;
	bh=ETQpOfT+9mRvOB/13pm/mxYN/3+tJD4a1mkuBe/uzcY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FL5XfOfpO7PsizNHkd76x9/EE8xMPHs7xSO30A07aJgHbVZy5O9r5UDLzLbidKLJczPoyQ2yyA+TXZEg1xgR8ypkK3XkGbIzpG8JdbtyWYEA/NaPVOkemmVfr3m2Eihgwri01qfwGiQHy+U3XfKped1SOEUPYSFbUIa4sZNccjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni5jHbXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E760C116D0;
	Tue, 24 Feb 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931951;
	bh=ETQpOfT+9mRvOB/13pm/mxYN/3+tJD4a1mkuBe/uzcY=;
	h=From:Subject:Date:To:Cc:From;
	b=ni5jHbXnK97clga4K+MDRHITiQB4e6ojDUOBS2aEhSZb8xlZq8Afb+R4l4EjwJfhS
	 Tu5wZ0Eb/3k8TLhsps4YgOM++Ztjt1LIKXlzyAtCL7yK3J+jTfucPqiUw7pWEJ/C7o
	 4zTenmJ1NWQdJCqB9XcjrWyjAGGda7TAQnS7niUv0fX7txN4kHPMzTPm2nTu0/Z8Jy
	 l3xeF/hx2QuyRX8T/tiwFAVaVAhSDBRooMr9LXifD6tWbYzXeHbb8jyPbIeawwDXKm
	 c97RDmvrOA553wgiOdc/hT1Iove7mH20/FiKpX/Lpf5HHrXMg67rjvXTtOGrC9RoJf
	 cMfpAYT1glo3A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v16 00/10] rust: add `Ownable` trait and `Owned` type
Date: Tue, 24 Feb 2026 12:17:55 +0100
Message-Id: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOInWkC/1WMwQ6CMBAFf4Xs2ZptoYV68j+MB1oWaDRFWyEaw
 r9bOMHxzcvMDJGCowiXbIZAk4tu8GlwdcrA9rXviLkmARAoJOYo2ejdeyQWqGVCt7ZRpWw1aUj
 CK0H33Wq3e9q9i58h/Lb4xIsVrx2FAot9J30MGS+tEZpMbY25Pih4ep6H0MFamrjc2QKPtkx2p
 XNqKmVQWXuwl2X5A8NqfJTmAAAA
X-Change-ID: 20250305-unique-ref-29fcd675f9e9
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
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7697; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ETQpOfT+9mRvOB/13pm/mxYN/3+tJD4a1mkuBe/uzcY=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYjm1MAZgtDuaM4LgRM/TU2b9K/LDkwt3nKjK
 H7yejbRVeGJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I5gAKCRDhuBo+eShj
 d+gvD/0V6lU4+rTLuz6f4PZvwzg+ML9dkM1Z/6DCT705wg+vauLnNPBI49MbfslFc04dAhI69G2
 XGYmtX2Bx4Nb2uNO3UQFYmnwTNf2fCxedGUEwRNLAwJdnB5bkZbpzvvFM0hYqamTCmYTORgsuGT
 ga4qN6cnTstPKhnw5yA3E9838CnZ2jvUhwWXWKtcd2bQ/A9uCpeQdQdqmBT+KgNryDiEN/oNMCv
 BODC+GqSH6V82bMsrek9oHuWOYdai5Pbm9KyVscV4QU9EQKzqsN7CbSkiT4hZfYhnxeBc7rv2WH
 abQeMbppAkp7zKmfpjr2yqPz9zz5wVtB9lVQtXXsLRFLnCIStqyZDRjMaCRi0j7JnpqraI/G8qp
 coOKkAiyrClLpdm5Km04JYDsztuH4VceDbw8PUu90b1HHwVt6G71WN5sfCatCL99QHzIHe4uCPB
 zuFtM+mdSu1838hHY6PPRGfPm/x+z3dVcZaD73++HUPiT58Y7NUzo09u+Nyhyx7Jh+BuoqW3Z+Q
 O9DkX50jFd7TtCIqV5DnD/rKzTB0Lwb7i+I3bo/cOuxHEYR282zvjVmEmvhboxPwMpmBtUM08pp
 O9WICRBIIAxuR5JPNT53gOBnhZFTWQ9y0n5VUtJIivWGGYD6HYz8mWjzihaFdRYMRHwdMZM5paI
 Ck6zdtadWb213xA==
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
	TAGGED_FROM(0.00)[bounces-78245-lists,linux-fsdevel=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	RCPT_COUNT_TWELVE(0.00)[47];
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
	NEURAL_SPAM(0.00)[0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,pid_namespace.rs:url,types.rs:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,owned.rs:url]
X-Rspamd-Queue-Id: 1A563186535
X-Rspamd-Action: add header
X-Spam: Yes

Add a new trait `Ownable` and type `Owned` for types that specify their
own way of performing allocation and destruction. This is useful for
types from the C side.

Add the trait `OwnableRefCounted` that allows conversion between
`ARef` and `Owned`. This is analogous to conversion between `Arc` and
`UniqueArc`.

Convert `Page` to be `Ownable` and add a `from_raw` method.

Implement `ForeignOwnable` for `Owned`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v16:
- Simplify pointer to reference cast in `Page::from_raw`.
- Use `NonNull<Page>` rather than `Owned<Page>` for `BorrowedPage` internals.
- Use "convertible to reference" wording when converting pointers to references.
- Fix formatting for `Page::from_raw` docs.
- Leave imports alone when adding safety comment to aref example.
- Use `KBox::into_nonnull` for examples.
- Add patch for `KBox::into_nonnull`.
- Change invariants and safety comments of `Ownable` and make the trait safe.
- Make `Ownable::release` take a mutable reference.
- Fix error handling in example for `Ownable`
- Link to v15: https://msgid.link/20260220-unique-ref-v15-0-893ed86b06cc@kernel.org

Changes in v15:
- Update series with original SoB's.
- Rename `AlwaysRefCounted` in `kernel::usb`.
- Rename `Owned::get_pin_mut` to `Owned::as_pin_mut`.
- Link to v14: https://msgid.link/20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org

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
Andreas Hindborg (5):
      rust: alloc: add `KBox::into_nonnull`
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

 rust/kernel/alloc/kbox.rs       |   8 +
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
 rust/kernel/owned.rs            | 350 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/page.rs             |  61 +++++--
 rust/kernel/pci.rs              |  10 +-
 rust/kernel/pid_namespace.rs    |  12 +-
 rust/kernel/platform.rs         |   7 +-
 rust/kernel/sync/aref.rs        |  78 ++++++---
 rust/kernel/task.rs             |  10 +-
 rust/kernel/types.rs            |  13 +-
 rust/kernel/usb.rs              |  15 +-
 23 files changed, 617 insertions(+), 84 deletions(-)
---
base-commit: b8d687c7eeb52d0353ac27c4f71594a2e6aa365f
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



