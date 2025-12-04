Return-Path: <linux-fsdevel+bounces-70643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B25CA325C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 11:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA0BD3007666
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069633858A;
	Thu,  4 Dec 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osh22c/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A11A9FAF;
	Thu,  4 Dec 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842762; cv=none; b=H6dB8SmvBQer6o8lAwopJdD89PJ07qOeD2OT9Ht0OU8yJN0dia7pOyqU9x154aOUXWgTqHf8KszhNnWL6XZRIIkG4a5dKzojIE1z4pY/FvtSaT6NW9NZcq/tdXWu3i/0eybv/1ZMoScJCsuXGBB1Tz1WsBm1+WI4uDO2T+76x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842762; c=relaxed/simple;
	bh=HdxuyW48hjewxA37dD/zbSml/Oj0HqVBN0P1TbtJSfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu1oU3fCB3QYOBT/z4oPmr8VBoHZZLin1tam1oVq0OgnxFonGxb/7ROpXEeNreG8I2zXxA190KbPIlTp5nEd7QYbUrlpR7oKiWmhAFWmLucaVQY3gKTHE52seiQ8wdWqhos80eSi16CVQI/Ki8Nr3wjhFGMoePFPBBHASr8D0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osh22c/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C558BC4CEFB;
	Thu,  4 Dec 2025 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842761;
	bh=HdxuyW48hjewxA37dD/zbSml/Oj0HqVBN0P1TbtJSfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Osh22c/gHyR+VPM2kPcT0dPiD6K9BvVhe5Ewzn9HXTkYe8a046bP8uE4VgCP19aDi
	 K7xBIYI24RyUjLFUPu8Jsurggk4oUE//29xVfPPkiZv362d67AnRunbs4b5rs1+Gjw
	 YS2XQ/6kgerJ6XOyYneyYfkre1v2DNabxE2eCArlBtO1fZs0/9oUkgnRGacd11N388
	 /GqZScuD1gNPgkWGXr8EGPBS8fC6oU43ADwQuKp3i8wBSNVTdMRqREmWXwUbXqmGUE
	 ffmQYPQtEzvEiW/FXBg4sDYheO7g+t6NXrH78pesoPO/l7JrqMckbFuomSJrJhGli1
	 QsAy+pTCZPGgA==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Carlos Llamas <cmllamas@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	Benno Lossin <lossin@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lyude Paul <lyude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	Remo Senekowitsch <remo@buenzli.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Gary Guo <gary@garyguo.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	linux-usb@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Rae Moar <raemoar63@gmail.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: (subset) [PATCH 00/46] Allow inlining C helpers into Rust when using LTO
Date: Thu,  4 Dec 2025 11:05:29 +0100
Message-ID: <20251204-denkbar-stinktier-8a7c07650891@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=brauner@kernel.org; h=from:subject:message-id; bh=HdxuyW48hjewxA37dD/zbSml/Oj0HqVBN0P1TbtJSfw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQaxnzoC5KPC9BQ6Xq2IqjgffnvpRpvskU9368/659bp HtRXnNJRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESuWjAyXDA8eVezNuVTq5R5 o8gOmf3FN+71+Ire2yjd+7GFVzhvPyPDbR6JQvt2uT/tr3YuKJvw1D1B7vuZ55NmCNlPeyuwRvU UKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Dec 2025 19:37:24 +0000, Alice Ryhl wrote:
> This patch series adds __rust_helper to every single rust helper. The
> patches do not depend on each other, so maintainers please go ahead and
> pick up any patches relevant to your subsystem! Or provide your Acked-by
> so that Miguel can pick them up.
> 
> These changes were generated by adding __rust_helper and running
> ClangFormat. Unrelated formatting changes were removed manually.
> 
> [...]

Applied to the vfs-6.20.rust branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.rust branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.rust

[18/46] rust: fs: add __rust_helper to helpers
        https://git.kernel.org/vfs/vfs/c/02c444cc60e5
[27/46] rust: pid_namespace: add __rust_helper to helpers
        https://git.kernel.org/vfs/vfs/c/f28a178408e4
[29/46] rust: poll: add __rust_helper to helpers
        https://git.kernel.org/vfs/vfs/c/de98ed59d678

