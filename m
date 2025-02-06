Return-Path: <linux-fsdevel+bounces-41070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD5A2A8D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0153A2A18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4622DFB3;
	Thu,  6 Feb 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1RoxKLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9013D897;
	Thu,  6 Feb 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846460; cv=none; b=LKiZD+9+dTpwoRj8vXdlkUaUvLXnWjVbSuq/WaTajFADEnfeR+Xu/GR30dAeem09uUxohyd1QQKF/YqeY7DEja2SKli9YISqVDFq2Xkf1LPd5f0pD3nhLETw5rTclGtwnFAfYe+Rula9T++HflyuAaMAlvaZzYZiMLGXkBnirl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846460; c=relaxed/simple;
	bh=P0DU+Pue/EtuRnc1HCGRgJw49M319sGow9ye9hm5cJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3iIdNQjxCt3ecs2mTn4KZW7mo0LW8oM16epTPfaJpSPwTH8MQX+cnKbHAx4uCIfMP7QkwJs24Qr60HdRdNKIa4TrgcjmqbB2dRm3aeFZVBlKM/b5PbPnT+x89fVfy+JAV511XzyP4jhJhrUkyITpSMP96mXGfIvyNdRIzvDKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1RoxKLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB3C4CEDD;
	Thu,  6 Feb 2025 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738846460;
	bh=P0DU+Pue/EtuRnc1HCGRgJw49M319sGow9ye9hm5cJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1RoxKLCZ9X6o7e79h3sVu7xJm0TNcKeWyzD+PcSnn3AgcEWeZd5o0UaNhRZU8ykL
	 mvVvKUNAyXIeLpNflUMUqmrhJsQZV+AHZZvSDMbdshdsbv54jAYBsv/kYQf8z3FFPP
	 mqGQHlBqBANgTvhaUi2QZD9crreKEi09HElStSTrLt3u1Qdqwp60Yrh1NXCfMvOTf9
	 7wrjG3B0fSALBkQ90H9bRSa6n4d/BNg487uN+ECfImIliUBDy4TvQoZrxpFyDcIi6L
	 zUN0aUGZ3LMHFSS7+2jaAZbIYV0uibRdT6sitNYpOLgrjQmN/O3TNlL4w1GS9qls4D
	 iKy3Zb/Q1NxXg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: (subset) [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
Date: Thu,  6 Feb 2025 13:54:09 +0100
Message-ID: <20250206-thema-unsauber-1d6daa83a6e5@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206054504.2950516-8-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de> <20250206054504.2950516-8-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=brauner@kernel.org; h=from:subject:message-id; bh=P0DU+Pue/EtuRnc1HCGRgJw49M319sGow9ye9hm5cJk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv2fBZp33V723RKlsm1v5z4AkM8lsl8+DT0tPJ9yLdG k9ufZ6/uqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAibhcZ/icz+m469rnESPKP c4NnmLfNlURxI5vLzLwxYUVux+aJ/Gb4Z/BrapNN+QnvaZotztWHSkLvn8/I2vzhyoOHbj8Vpdb t4gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 16:42:44 +1100, NeilBrown wrote:
> The LOOKUP_ bits are not in order, which can make it awkward when adding
> new bits.  Two bits have recently been added to the end which makes them
> look like "scoping flags", but in fact they aren't.
> 
> Also LOOKUP_PARENT is described as "internal use only" but is used in
> fs/nfs/
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[07/19] VFS: repack LOOKUP_ bit flags.
        https://git.kernel.org/vfs/vfs/c/01db36d3f0da

