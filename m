Return-Path: <linux-fsdevel+bounces-28329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDEC96965C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C611F24C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A9200129;
	Tue,  3 Sep 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtpnu6oF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3120012B;
	Tue,  3 Sep 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350406; cv=none; b=AuQFJI4G3MBTRXHQ+lw9sh2XPWkxcU95jhpa5HdYeApEUTV1A9sC9j5z6Mb52ZtvrHVs8nCU0Hu0lU9PXfvQrp6h5npT0oMw7JNTIs7iGRLLujPpKiepI0Sbws72JShq0rasALnpyXneyYQ5GSyCY00I+JQSPJwVQzTL+eEunTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350406; c=relaxed/simple;
	bh=wtGUBh7+vRyF3Qzz5jXS/rYRIj3aB+9qZydwKTmZN9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9gb/xI1wdxLlLKb2hC12yU27qg2GrZ06OOx5yMcz0pZ0FM8Qa8Uomei8nzG240UCHYG9ppP+bTgte/ChyVESl3zgnJ8jcEEG26wKuO3C8Exm4bQyEqaAVXekbDR6a0vl4RM1UIZsq1yF35+HFjwovVrkjBd0JMe3fSjgDqW91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtpnu6oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736CCC4CEC5;
	Tue,  3 Sep 2024 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350406;
	bh=wtGUBh7+vRyF3Qzz5jXS/rYRIj3aB+9qZydwKTmZN9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wtpnu6oFmwNEPKyPcgSdfLb/VWWqjRS9chiz3gomDWZtJLWKEguJaWkuov68VCDGx
	 EBvBIrgsD/fPgBP0LyKnW0PI9N6Ef3s9nuhPLrgL3qwogAgQtfzKj+WXJtGilx10q3
	 vwz9tMDI4Wl7V6QYJ2EcQ34ta2qF+WVxWGz6iSSXreH2FVcQHZHGR5TznnYCZPHKnF
	 oKEd25oj4+gZ5RrhQzk8eNyXwb+vjei9EP6vvcoTP4+HZxUdg7eAbnCcj/YKdaUr99
	 HIpWpM05A0VwCH4EldFn5NIXbIzWtT3Icy8qWk5IPp2+cAEdz5coxQD8ogQmnx7BTe
	 rfaAPRu2Lc9+g==
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	josef@toxicpanda.com,
	david@fromorbit.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iomap: flush dirty cache over unwritten mappings on zero range
Date: Tue,  3 Sep 2024 09:59:50 +0200
Message-ID: <20240903-gentherapie-flirten-dcb64096c837@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830145634.138439-1-bfoster@redhat.com>
References: <20240830145634.138439-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=brauner@kernel.org; h=from:subject:message-id; bh=wtGUBh7+vRyF3Qzz5jXS/rYRIj3aB+9qZydwKTmZN9g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdO/j34PeFPRz+d27vfrxzWfS3W05qjFM7o5J+OE+vP /f0z/sy1Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJKLYw/PdaJ/KSV826gGtv 8YLLIndY3LuEjC9L7uMznLXq3q99dxIZGWaHdAddt3Gd5+PkwnhfTlVYrHda+uInuQ9Ef7cdTvj 9mx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 30 Aug 2024 10:56:32 -0400, Brian Foster wrote:
> Here's v3 of the iomap zero range flush fixes. No real changes here
> other than comment updates to better explain the flush and stale logic.
> The latest version of corresponding test support is posted here [1].
> Thoughts, reviews, flames appreciated.
> 
> v3:
> - Rework comment(s) in patch 2 to explain marking the mapping stale.
> - Added R-b tags.
> v2: https://lore.kernel.org/linux-fsdevel/20240828181912.41517-1-bfoster@redhat.com/
> - Update comment in patch 2 to explain hole case.
> v1: https://lore.kernel.org/linux-fsdevel/20240822145910.188974-1-bfoster@redhat.com/
> - Alternative approach, flush instead of revalidate.
> rfc: https://lore.kernel.org/linux-fsdevel/20240718130212.23905-1-bfoster@redhat.com/
> 
> [...]

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/2] iomap: fix handling of dirty folios over unwritten extents
      https://git.kernel.org/vfs/vfs/c/e19d398f4eb8
[2/2] iomap: make zero range flush conditional on unwritten mappings
      https://git.kernel.org/vfs/vfs/c/2dbdb9dbad46

