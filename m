Return-Path: <linux-fsdevel+bounces-69054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA282C6D7DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 236E734E8D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FFC2E8B62;
	Wed, 19 Nov 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P75Jh7iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA422882D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541787; cv=none; b=c0JF7idr59oIVdlwAuXW7mTqdM+DUKuhFYDxCvINtw/Gd6UKXJZxlYT6pkUAewfyHHpVzilQ2WRZtXAbOK64cCpkrU63mo4TOKLOnvz8jOl5XiYK16k7M+Rh3Sfb7d8jG9tp8aYCia6aHl8gBeH1uI7UsbuvvbnLMhm5UTF43Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541787; c=relaxed/simple;
	bh=ESOA1W4fGPORiS6Wp+mOzuSxcedvTDUmR8zRjNiVrrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVgyjDiPwndjreFKd0N+93zT8X4KME/WcZoAwVh5CWubZ/HuqXFzDN2BdS9Rp0hKmnVayJtdBmKcxYBmScFASiUf9HycP0Jksg3TRhB56xqks4NwCx8g1pLwoeAhwYO65pX1oll1ce+06cnSp0LFK+7nk/hNEy0pwIlneyASJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P75Jh7iD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA756C16AAE;
	Wed, 19 Nov 2025 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763541785;
	bh=ESOA1W4fGPORiS6Wp+mOzuSxcedvTDUmR8zRjNiVrrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P75Jh7iDUZx/0zUo9ax4hQ48xZGq6h7+hYcq/nkGO3n7SGZrX337TTtaQbGKbGGmq
	 xpZ8YxWwt/GvktfhLEKRn5ZIQIByKLdY5pnc79kY6+t2k0eUXTJq/Ikcv3ClCybxrL
	 L67BSHamOCLzMDNi+fh08n1ei7RaQ6wY/L/UmbHqU15GP9N8Gekwgl+3/wfK97NVvT
	 hZ5qKx2KC4mvQeTjamyemLeMbbzKnkck+oreHveT/YJ2HPSo/iSIdNuGXkii+lIFQw
	 j0EnxsWxYnyxeBRRqnr90Qq2ARZ9nYQhB2B5T8W+qZY7bI31hnPvsusfC+3RVhPNEf
	 OIIqMyqHYk/ig==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Date: Wed, 19 Nov 2025 09:42:53 +0100
Message-ID: <20251119-kampagne-baumhaus-275e14d62e2f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118070941.2368011-1-hch@lst.de>
References: <20251118070941.2368011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org; h=from:subject:message-id; bh=ESOA1W4fGPORiS6Wp+mOzuSxcedvTDUmR8zRjNiVrrk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKNgtPPVus2uUwt3gy63Hp4+fX1yf6CrUskvZ8nXqkL FXtc8zEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImc2Mzwv3ZPWFA3V91SnjbF FUd0pQS0ih715X/cO2vtqY8Pm10e/WRk2LZlWtPBwubsuAUt933yL4m/WKtR76d6uUEqaLHPzB8 /uAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 08:09:41 +0100, Christoph Hellwig wrote:
> No modular users, nor should there be any for a dispatcher like this.
> 
> 

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: unexport ioctl_getflags
      https://git.kernel.org/vfs/vfs/c/87f58c6cc372

