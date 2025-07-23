Return-Path: <linux-fsdevel+bounces-55821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4FB0F1AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5267B583417
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85B2E499B;
	Wed, 23 Jul 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF0wPVh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A622DEA68;
	Wed, 23 Jul 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271665; cv=none; b=QRscvIllzjJT6XLX702VhKJJU6mWJl0qc9LCiAZYbf/644W4V7Pm/gK6VnS589tzluHffmu80QwcvvptxeCA8tLin2g0kg1c/yMAhP0rdu+Wck3qKFkLzbyVI9KwrcwWt7TFNAUWsSWs08rA49kEYLl4AZSs4286peYcUZlCHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271665; c=relaxed/simple;
	bh=vN2XmvgQR1hlosm7AC+bW4IpqBAqnWenVrjORvxQFEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPRb2UyGgtTQOATE65ic82BSdOZJ14UJHhFkv1GfSMyGK5fFYGA3O7O82t/ALsPhq7q4z1rzL1SFXFCZL+0a/xAVReDBnC5ursQUMPsCFwgT8NZTwuhXmlbwG8NpozXMdvjuw+zpCF9mwN6VU7if0n+4Gao5VfuHbNRVMF/oD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF0wPVh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA065C4CEF6;
	Wed, 23 Jul 2025 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271664;
	bh=vN2XmvgQR1hlosm7AC+bW4IpqBAqnWenVrjORvxQFEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF0wPVh3WbciQyOgBASsTrLEPw7DYMHpkBKJUVlWWWuGO+QvMfkEZ4tE6j9xO7Jss
	 twd66BpMXlYsa2HaVPCGcgoAixV8pHAh1XmBLUZ/tL6vZy/7f/kOH9ixXs0VjoTuG4
	 6nYiqFjuazWSDtsmWBB5cvaJQsnDBXU4I65qgNNLylNPLmQl/Hcq51keU/MDS1PMYQ
	 pQIJwkDf0c6z+ZP9U5FG18Yya9XyDYtqKp71AesrUj4Zx74fzJaUH6zeBYV33+gfgl
	 4GQFIzmRp5ZYC3VMmFep54coNnotSMvFOqKUeZUzgj3aZSuq/Ls3PPOa3uUcixEimN
	 bJxKnkDUz5voQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com,
	Leo Stone <leocstone@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix check for NULL terminator
Date: Wed, 23 Jul 2025 13:54:18 +0200
Message-ID: <20250723-nadel-donnerstag-86ef7adbec13@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <4119428.1753108152@warthog.procyon.org.uk>
References: <4119428.1753108152@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=brauner@kernel.org; h=from:subject:message-id; bh=vN2XmvgQR1hlosm7AC+bW4IpqBAqnWenVrjORvxQFEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0nM0+9U0kheufIafbfu20NzZPZnR6y1S+P/RgzVfPr MnR2+VWdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk3jyGv5Jf9Bat+xKkIzv9 +eTEu19PzjmYvUhATtYiT/jQwoKf978x/C+69XGqQs6O07tDDv4XF//y8KXDnKvdZ9anFG7bVX7 d+D8nAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 15:29:12 +0100, David Howells wrote:
> Add a missing check for reaching the end of the string while attempting
> to split a command.
> 
> 

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

[1/1] afs: Fix check for NULL terminator
      https://git.kernel.org/vfs/vfs/c/9aa64182952d

