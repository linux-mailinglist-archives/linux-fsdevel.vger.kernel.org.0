Return-Path: <linux-fsdevel+bounces-57360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6FB20BAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3382A70C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE991F1507;
	Mon, 11 Aug 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0UD6s80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98536130E58;
	Mon, 11 Aug 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921912; cv=none; b=H9xMuEH9ZN83Sezm9kGbtq1ua5XKL4Xuwp+woVBkmVp66PQizpv4EsDHcRgbub82oY3n4IARyz2ilK7XN13b2ic8YeAE5efEQ1YdC/cEgcABBtqkJsit70+zkW6t3JV1R9LSE8wzZp9fDA/dJsPUiVlKvaNVTqd0shlAFwkuvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921912; c=relaxed/simple;
	bh=BXYbJRElSnllH4SZeeunv/TohKTjoqGqn8JmUZ9gOqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv5hn5h/sRGC297bPFz5n6zO5YlwyuTwRAcRDIUA4gd5k+gjbg7SaoByEC995Tc+8dxEYoKhRWPxiOXZHoL4N3P7A6mIYb4fU+M0sqeqm6yDWSfOv7fodxu/gef06aere4A2hO9VXSk5YYyLuf//ulSdTFhzDjGH+Msa0N7eaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0UD6s80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5469DC4CEED;
	Mon, 11 Aug 2025 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921911;
	bh=BXYbJRElSnllH4SZeeunv/TohKTjoqGqn8JmUZ9gOqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0UD6s80FoYmxBwCjDv9almaNyqrceO+X4Bw8QZwM4nIFply47rzGIBBpmww8W/Ee
	 WQXN06VPAZVyVMzWtEKTmzykvBFXBt81ussWjT9T2g4l+oKhNWo8etUMe+Dkz1Gjyk
	 rwdUfMKAAVIt/wkTg5ihskTmjJ4F+Jw8ixeomdTE9cyhYEyIpvD9wXIhgheGGnH4pM
	 m9ONunnAd2nAe8SVHc+xE+5+Ue6XMm6lHUAV5qCjHwtFAvgR1gLy0l2npNG7HG0qcu
	 dVG4uIoSuOP2eNmSMAijMmXDSJ9mXsmtusO+napUVI7MeRJ7u7jYOk1DzuSZ9Nqnxc
	 HFJpLVdW4OFKw==
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Shivank Garg <shivankg@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES
Date: Mon, 11 Aug 2025 16:18:22 +0200
Message-ID: <20250811-wachen-formel-29492e81ee59@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
References: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org; h=from:subject:message-id; bh=BXYbJRElSnllH4SZeeunv/TohKTjoqGqn8JmUZ9gOqg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTM/L2+TrDMXUBodvxWa9fSxPQH1i3uex6+ObCQKzbu5 /78D1XpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ84GR4fHu+5mHD68pWSCz OIJP46NU19ZTwfn8R74w9vEWpfboZjEydLteLWVZIfj2Qil/89X2nToqUqe5lHYprpZqfPFZ5/A qPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 15:28:47 +0200, Vlastimil Babka wrote:
> Christoph suggested that the explicit _GPL_ can be dropped from the
> module namespace export macro, as it's intended for in-tree modules
> only. It would be possible to restrict it technically, but it was
> pointed out [2] that some cases of using an out-of-tree build of an
> in-tree module with the same name are legitimate. But in that case those
> also have to be GPL anyway so it's unnecessary to spell it out in the
> macro name.
> 
> [...]

Ok, so last I remember we said that this is going upstream rather sooner
than later before we keep piling on users. If that's still the case I'll
take it via vfs.fixes unless I hear objections.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES
      https://git.kernel.org/vfs/vfs/c/6d3c3ca4c77e

