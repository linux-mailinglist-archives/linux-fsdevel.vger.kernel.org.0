Return-Path: <linux-fsdevel+bounces-77781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKn6DPIwmGkzCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:01:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E8166935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA9AB3020236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9453375DC;
	Fri, 20 Feb 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXuKsXuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE533439D;
	Fri, 20 Feb 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581175; cv=none; b=ZUD/LI4Lxickx0Z16Uxk9EpGXJ6zDCuallxr3M0m0jL1lZcFLkIWxH/ZlWfLFAgrxxSu/0cgmS1O5sV5rflzXdqV4FZiMvTVOoJtvg3u7v+5f3IJ8zD630IYj9y/2XpCjo+/a05LIFDkJuXE77JgUIYXgyipkAfxH8a74bWIeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581175; c=relaxed/simple;
	bh=MH7qgXhxS+4W/slhJWtX05AT1X6dliBzfHD+GHMyYOE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EzScp3qZaObOE7PtYIdzbvfjJxZnmt1lz/l3diZY/jO/hALGz87IycL67EeaKD3IXYBVcVvvK9+O52aBMViidkr0oraINuBq0SKTylM+pNntmnN0MakRRbc8oTvTr6BFnIYO4fQY68EUYxvGsUT6ieJOOwIV6VTexhHMQeYs7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXuKsXuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC660C116C6;
	Fri, 20 Feb 2026 09:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581174;
	bh=MH7qgXhxS+4W/slhJWtX05AT1X6dliBzfHD+GHMyYOE=;
	h=From:Subject:Date:To:Cc:From;
	b=uXuKsXuc1oi5NTmbeIJbJwg0qiB09J1EnFmfBOMmbVqGRz+UJFRLx+qXIjeqU9XKI
	 1A90JCDNNwqq8AdAqBUjHRZkLh5RubGQkb/Juj+12z5eJNquVrH3I3xs/hXcVvfymd
	 9ZLhBlOiPcePHYNQ1iA7bouVitDd8VTG04OOaT9SKOK6qDSKDuFxJP5nwRasNquPv9
	 faOPvqwkyGSWpot7ohnKQPl2a07RtHuKchyjZ4ZvDub50nhLXx6Oj2f5PY98zCXiS7
	 8WovQXFjcdunMP8dhaMmzCvvqkevp1G9euoEUyOi4yqrTW3jk830t0K6KnG6r+3SSX
	 SZeR2Dseyv9Ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v15 0/9] rust: add `Ownable` trait and `Owned` type
Date: Fri, 20 Feb 2026 10:51:09 +0100
Message-Id: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI0umGkC/02MwQ6DIBAFf8XsuTRARUNP/Y/Gg+CimzZgoZo2h
 n8veupx5uXNBgkjYYJrtUHElRIFX0CoUwV26v2IjIYiQHKp+IUrtnh6LcgiOia1s0PTKqdRQzn
 MRdLnqN27whOld4jfI76Ketd7p+GS1/+dsjHORGuN1Gh6a8ztgdHj8xziCF3O+QfRbXHyqAAAA
 A==
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
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6914; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=MH7qgXhxS+4W/slhJWtX05AT1X6dliBzfHD+GHMyYOE=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6SPN6GHiEtdlstRzjq+GDhU+BAAtaEl2yZ5
 dAZnwhbahyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZgukgAKCRDhuBo+eShj
 d+m0EADD1vNs5vo1isrR+dReFMAAh/IJGnL65NOiczhIAW1wZZkrrgnlL/5hKfHTutsQgv1mke4
 N4j8Es0nIBqbQlz8aIzKxjyKHbjtaJ/Aae9Gmzyi2WyazIIGiGwXctb9d2QjMU68ylbnbmctfmd
 dTiGfbWsaEpGMSO9/g2ktoHb5GzVKC/DjLpDSx1RPC4JxYachdHG/YdIttm4+eNpOAxm/SXDYcx
 Qdur7+G2M/eonzgx9Clyzq6/b+HUP6AfKUB1W8IoT/vqPBQMDvgm6Wzc1Qr7/QdxfKOARrKWQ3K
 jSXpnSIyYCsulQo+RAXYrTt7Dp5uJEp8x8khBuQ5lq7EyhSihDWnzrG4g/uQW5HFstiTaqv23q+
 JZu96aZkK7R833cL8ztJTTik5IBG8eo+MWaXRnt3EqMWdNEMJ+tNZHaHCtBrqAtK745SUom7ZR9
 rmPN97whe0pdmYs+hRc10u0nuNmzCkwiZHUI2mkrfCBD9Y7EqVNvty4r6Kj4q6RC9cYYevc+KWe
 QVVe85NnCdnW2vEsTJ1Zj/lHRETLiyY4nsOYetdypxDfEXXkU7ekD8SaunSxjI97C6Kdf2Lk36s
 KF6omKgbg3Md8trx81AGUNWZM6YDm2c2ymNEtmKbyhBgwWYj7Q2CYkpLbioQazJkP9CnTx8mpGG
 30dNWCcJBeMR84w==
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
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-77781-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RSPAMD_URIBL_FAIL(0.00)[pid_namespace.rs:query timed out,msgid.link:query timed out];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.680];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,types.rs:url,msgid.link:url,pid_namespace.rs:url,owned.rs:url]
X-Rspamd-Queue-Id: 1D5E8166935
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
 rust/kernel/usb.rs              |  15 +-
 22 files changed, 624 insertions(+), 83 deletions(-)
---
base-commit: b8d687c7eeb52d0353ac27c4f71594a2e6aa365f
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



