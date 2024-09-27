Return-Path: <linux-fsdevel+bounces-30231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2BD988016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E2283AF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322171898ED;
	Fri, 27 Sep 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se15U+ok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D717DFED;
	Fri, 27 Sep 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424707; cv=none; b=C3Tctfk0iG8ccLIu8l1ro3y3ckvO5aV0hm64SR+GUUWmCjz8k+q7UqXjwC14Ql0pwyXBHOyOAUJAow092F+OsONhfC967AscOdbpzA3Rmc7bmipaKYqEOJJ0IWN1bQg4Snsz0mS+xL/QnVKgNEuJZ1nEdxNjvccqx/N22HWv9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424707; c=relaxed/simple;
	bh=pKoWQGQi8zygMyBTXKzNuwWkbTBQAq104vRTFm9FGsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCY4y03bB5sufRrnKNvs7qSn/lWzUjZHEV/ORTreWzv+etUIzf4TCwxXCK5Jc5xN2861ub5FJCyv2GddPsVAaLd/W4O6HU4sfnsxjiJ5ctXDTFGbMFHC8Kmkm7qDk0tj5/N2AovjyLNjmSSuipuPDAffz1TnKB73mJGkZYADY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se15U+ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49142C4CEC4;
	Fri, 27 Sep 2024 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424707;
	bh=pKoWQGQi8zygMyBTXKzNuwWkbTBQAq104vRTFm9FGsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se15U+ok5WlGyRs1cAUaai2r9djKv3DgavREoi0byaaYfjDHbWVP/5dP44jLDm73V
	 XLhuIpNbPm0vr6qQqVw0szn8wb+hHpGuxidNG/YL8jED6I0C4toeQ+cj4pzJvXgs21
	 TxvI3fkM7U5MUQG/dUuNom9p/BRYYhiG6A0bb5XbLTKJul7R24bNkGPHYPlZlp5cFT
	 y0XsHrQEHNCBHWWHCtjLgSw9sNxhS1eAZS0cNZtMz73Ks67W/E8O0D0qxeITeMDCcG
	 ojFp866/Qj4J4y0Yc9v0h1Oy8BIRjpTgtMYDJMLQ53+hRGu0SCEIFDKZ8UtTdj3Eg+
	 to9CB6TuLFvtA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Steve French <sfrench@samba.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Advance iterator correctly rather than jumping it
Date: Fri, 27 Sep 2024 10:11:33 +0200
Message-ID: <20240927-weinreben-ortstarif-e855de189596@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2238548.1727424522@warthog.procyon.org.uk>
References: <2238548.1727424522@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=brauner@kernel.org; h=from:subject:message-id; bh=pKoWQGQi8zygMyBTXKzNuwWkbTBQAq104vRTFm9FGsg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9y9hTnbAv6OiyGZeveEwzuf5pvnJ50gfOC0ebl1wwU AmZl53xtaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiJ3oYGT5YpNyXtlOZ80GS e+uSRL38mc/WnWzawlP0JazG2T9JeSfD/6JXRQ/Cotu3uv16cmDj6anel98IuGV0W57qyP4dcH7 SehYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 09:08:42 +0100, David Howells wrote:
> In netfs_write_folio(), use iov_iter_advance() to advance the folio as we
> split bits of it off to subrequests rather than manually jumping the
> ->iov_offset value around.  This becomes more problematic when we use a
> bounce buffer made out of single-page folios to cover a multipage pagecache
> folio.
> 
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

[1/1] netfs: Advance iterator correctly rather than jumping it
      https://git.kernel.org/vfs/vfs/c/507a9ef9e851

