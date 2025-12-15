Return-Path: <linux-fsdevel+bounces-71336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFECBE514
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46B003019A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DDF327C01;
	Mon, 15 Dec 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0ZSvqo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51C2DFA5B;
	Mon, 15 Dec 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807154; cv=none; b=FmSeeKOoG031+F3RbQ55OVWHTBfdYY1tNbi/oQSoCwn71+rptDdZfqMBjFOrK5jsBk3/3q/xKBSvKqto77B/FLcAx2pg3dhO/lp+FGwByc+evEwR0XBHj9NX7EE64woz8ASB/b1B3kmG3lU2Ab4PNN4OewuF3QC9EXzULHTOjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807154; c=relaxed/simple;
	bh=YQ0YmiEKTBiByyCk2XIiAXJahBqdOSyVHDmgyhFstuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzPmMP3YiU3w/pPj9bVYZNR37Ocfcegxmehd7SN8cNL4BDQb4jYt7QkT869spT7vDT6GvDOeML/Yzc7UevPoWIcAYHvWEyQqsVCzyc/mzihy8SaXhMAZoOdTjupu7zfNtXXM30piaX1Js/QMCOjB6e5EEKIo4C+ue3oA1QLym1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0ZSvqo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84039C4CEF5;
	Mon, 15 Dec 2025 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807153;
	bh=YQ0YmiEKTBiByyCk2XIiAXJahBqdOSyVHDmgyhFstuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K0ZSvqo9FNH+vPZrOVLOU5ZraIN5/Hx4lzXEVk8deQoFTzZrfVB3Sn8wUVb8UaBDT
	 IPKJL1FeYjBc4++kymDagnMFo+aO6gmHV+UWQO7cqHTOD6VMMtizrJjRFLGRY7Ee7L
	 w4mP9rPOGGMbKthLu+r5v9Ru7rhk3vDAc1XCmmrB5wHkqvV8acOQhuC1BVzlP5ME/H
	 H7EzKs7+bvfSkQA41DZXMI2/LRypKRi0eSe24U8EkDVDNspUAYXac7itmfYbMOTmxv
	 x+MHyD8AednEYtbIisGEt5V/tIfQDU8l0ImBMScwR5yt2mJk+grnKjhIaLlaCyGSER
	 QNwLC455/HDNw==
From: Mark Brown <broonie@kernel.org>
To: rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Elle Rhumsaa <elle@weathered-steel.dev>, 
 Carlos Llamas <cmllamas@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
 Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 linux-security-module@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Lyude Paul <lyude@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, Remo Senekowitsch <remo@buenzli.dev>, 
 "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
 Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
 Gary Guo <gary@garyguo.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
 Mitchell Levy <levymitchell0@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
 Rae Moar <raemoar63@gmail.com>
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Subject: Re: (subset) [PATCH 00/46] Allow inlining C helpers into Rust when
 using LTO
Message-Id: <176580714194.161338.1959594276727103368.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[35/46] rust: regulator: add __rust_helper to helpers
        commit: 03d281f384768610bf90697bce9e35d3d596de77

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


