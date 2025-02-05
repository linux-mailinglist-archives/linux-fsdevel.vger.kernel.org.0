Return-Path: <linux-fsdevel+bounces-40913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64434A28B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 14:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A889E1882E26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1A1DDA15;
	Wed,  5 Feb 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSRsAZzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8B136658
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761151; cv=none; b=TuCWIEPlIqWpC/nXFlhnWAYTEO72ertEcS+y8cL5bKX8LkGXCjhUVU5KlQ56/KmMzzSZlelUtUdVgE/0/OdqWM7c/c/8Xeke0pfWCq+U7bSo0JhBnTLetFg31Ds7/S0O5YmUioHRj0kiBjkYgL482RdYwVHR1b3sEpoXRJaYfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761151; c=relaxed/simple;
	bh=MwZ69cc8av7aghuUB1txl0B6ZC1TlAgZXjw0pi0B9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PT4aqfTHh6WW1JdsviuGqTuSYYEqFrxuEqFGuKSczZWxnRpLoKnS8X5L5+JaTY5TqW0qZrtPv2R+QJq8rKoKDhpKmv5/kdExqRV2oo8nm9hiB2eu4YZkRURvGoJa6Xpc0tb8Db4eYqnGOqSey5uO9Na1BUakAQiD4oW5ClNkHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSRsAZzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9347C4CEE3;
	Wed,  5 Feb 2025 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738761150;
	bh=MwZ69cc8av7aghuUB1txl0B6ZC1TlAgZXjw0pi0B9mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSRsAZzYai5MUHbFeP9GuA9t9VrXxCrW1Zx3rbQahRlOxoqney0GDmYktU/HXkkzT
	 jj1o1fnK8sohGw4Ubgf8d07cYjAYE8wLY69z+ZDlGZ6obMAlTsvRHKR+FUW+5os03a
	 rveEXDSTMKyVzT5DiV/Pme3Kb93lWkkAazpvGMqyd2TcdGiav8Yt+LYUA4rSRbAUmT
	 5Xd0hdZsxH+RZOUincok1pzEugMk8V3T2gLSPS+eF52eHzg/obMoLBDBN3x65EDOKA
	 WsJQUc7lRr3aF6SnpZhGUbZVPB/re2qhzyn38WOP8JoVweqpjOssw09bqOGnhQu0rM
	 a1qs/0AHPu+/A==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix for huge faults regression
Date: Wed,  5 Feb 2025 14:12:22 +0100
Message-ID: <20250205-sinnieren-hausgemacht-790042af33a4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203223205.861346-1-amir73il@gmail.com>
References: <20250203223205.861346-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=brauner@kernel.org; h=from:subject:message-id; bh=MwZ69cc8av7aghuUB1txl0B6ZC1TlAgZXjw0pi0B9mM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvTt7xfuUTlqtVkjI1dxf5yfOny5zsnWcqxfLXn6tA+ reAhqB6RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+Xmf4p/RcesvlmY6lcyZv TLP4Wc516uMq52U/FUTnGydOsn++KYvhn03U3Tw51kXfj+T6XAz+3HKjZKGKml1zwceNpYF5vP9 O8gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Feb 2025 23:32:02 +0100, Amir Goldstein wrote:
> Christian,
> 
> I thought these fixes could go through your tree, because they are
> mostly vfs/file related.
> 
> Hoping that Jan could provide an ACK.
> 
> [...]

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

[1/3] fsnotify: use accessor to set FMODE_NONOTIFY_*
      https://git.kernel.org/vfs/vfs/c/fe1052f7e420
[2/3] fsnotify: disable notification by default for all pseudo files
      https://git.kernel.org/vfs/vfs/c/54dbee0b21e1
[3/3] fsnotify: disable pre-content and permission events by default
      https://git.kernel.org/vfs/vfs/c/af6671679734

