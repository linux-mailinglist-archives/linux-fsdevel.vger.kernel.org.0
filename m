Return-Path: <linux-fsdevel+bounces-71338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DBCBE303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B419A3002514
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEF2F290A;
	Mon, 15 Dec 2025 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+PIdVqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7D2561A7;
	Mon, 15 Dec 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807661; cv=none; b=qWpvOvqKyxm4YHGPn6Fk46nmquH12QbKvgMmF+kr4S3rT+Vz2418ey1g8KcIcJhE+OcbpxSxxgww3X/cbYTLFpgWcDgIwUjq1iC5MnpzvC6WwMeDz9sDhZZhkPHC6+YXTkOiV1bKBrowB6eAHi7psI9bi96e11vOU3znB3Tz8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807661; c=relaxed/simple;
	bh=WhKdV0Gnb8Mz2SBGHT7PvKpy+qC9Uv5dQyhUOIFZX84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=np/RBD7nKbik+R7awXngK5Rg3ctwqaOBhrKYNO1Xm++cMeSh1cUk2HEsnIZCgiXUa/OVEjrWpKvTEVMWNwqCu8X5fpm2NyXadL6Dsa22qE7BtgSBA+OVYnIyIXBnzDppnIByxA18tnGjUd23dFCMG6VXSlS70PQgC7G15BEtuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+PIdVqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8981C4CEF5;
	Mon, 15 Dec 2025 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807661;
	bh=WhKdV0Gnb8Mz2SBGHT7PvKpy+qC9Uv5dQyhUOIFZX84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+PIdVqfiwy/UP7TpT8QQFrKke9xeyUP4u6ut5aVXdS71yg/AeWHLp4he5JI9Ycqu
	 BUN0YBsU8tineQyeXBIM6dm/WEkvBfMjxrgebPTQ8bRL6GaoHcUH9f3y6F1uX0lcL+
	 hfNNz7tw9DM29vesZb72hgFb26erzFLLxY+EKqv94Cqc42MmGC5K5bI3lN+aDtaJVY
	 9nglLr7UXirZKjsAlUnd82ZWs52r7qlvymCozr4nF2LFIV0O4QGJbYEkhjP7u9Uf29
	 i6DOE6C0XFZ24+MXp7196khCdJLSowpKPziiexJ1OW+ifczQrFOoMHtRYMOA2oF6oK
	 Vsg2TfGfjg2/w==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	Deepakkumar Karn <dkarn@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
Date: Mon, 15 Dec 2025 15:07:35 +0100
Message-ID: <20251215-zuckungen-autogramm-a0c4291e525b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211131211.308021-1-dkarn@redhat.com>
References: <20251211131211.308021-1-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=brauner@kernel.org; h=from:subject:message-id; bh=WhKdV0Gnb8Mz2SBGHT7PvKpy+qC9Uv5dQyhUOIFZX84=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ6iGmYBCefPF3ysOphVby/y1FO49Ws8yPucf5haFC9N uu8vcuUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlY3mf4p6P+9UiKtmfA3nfx XV3GJ5dLHvlbXjTVM8onieFj16Qphxn+Ke/JsgtZsKdu/Q3GM0pqd9RDoz69+5IflLiGZ98LrXU n+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 18:42:11 +0530, Deepakkumar Karn wrote:
> try_to_free_buffers() can be called on folios with no buffers attached
> when filemap_release_folio() is invoked on a folio belonging to a mapping
> with AS_RELEASE_ALWAYS set but no release_folio operation defined.
> 
> In such cases, folio_needs_release() returns true because of the
> AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
> causes try_to_free_buffers() to call drop_buffers() on a folio with no
> buffers, leading to a null pointer dereference.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
      https://git.kernel.org/vfs/vfs/c/b68f91ef3b3f

