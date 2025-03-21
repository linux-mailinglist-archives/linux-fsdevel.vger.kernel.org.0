Return-Path: <linux-fsdevel+bounces-44698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED71A6B85F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CA9189F2ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C41F3BB8;
	Fri, 21 Mar 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+UpcPFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE21F0E4D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551231; cv=none; b=RwvbtK3xwZP8ueQp/Vu46q6jRnp4Kbf/ex5HERI6Ev5ehDgptvEnB+sPDln0hq0Bwf6IB03kgVts2Qvlk7B5Rk8jZ3QfJ80fKSdGcRGA53UeE7FFT/YIBa/d+qErp4gYwZLPrYinBziWsRIcyywWQHrgPJ2R17pvQ1tURehBTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551231; c=relaxed/simple;
	bh=MRrDhMsemmJi102SPR16/E2qfMXZMx9qjY8/k1i2x7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQX3BMDQ+gqpJwlOV/6x522KTLLBT9SfcZMCPndMoAzATS0sdihPXYujqFcxTqYDUt/8u9iLT6/cz8wIN8oM+osxUApI30+bPL8pgKLHvpnf5Pi9pxhH1ClV6fTHPeihnszy+yGugZpj/kIsQ3DDmHlJBbGLr3xIxGN55ansSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+UpcPFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AB7C4CEEA;
	Fri, 21 Mar 2025 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742551230;
	bh=MRrDhMsemmJi102SPR16/E2qfMXZMx9qjY8/k1i2x7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+UpcPFsPoB8wUbccTgCvvWYAerZMifFOsa3Oe7/bMUCEB+Iyw/Wl6hIlyRIDqrVY
	 rDT561IawLu48fn7SD+R87FAZxBCnZ7y4fR3jj93OtPDh8FhNtMgp7EnmL3Gfan2xo
	 4yXuuV5jzqzzByxpiTI9vhSqyRqcFgK3PY/fUq8n/Yz6ekLI6TGFnUk9ZFZLsZTFwZ
	 C1d2hQBE9xKeRyp4tkhQAGKf4azpzTJKrQQ9rCuVSXhANujRy18ZYDkog6VIGjOMB3
	 8639EM1+K8HryAbt9cwqfVY1WasdG+azY+wgeHlrlrtRbZ5A0rMRVEHKmjCzfZExsz
	 cqpZuG0Ui/mdw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Pavel Reichl <preichl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	aivazian.tigran@gmail.com,
	sandeen@redhat.com
Subject: Re: [PATCH] bfs: convert bfs to use the new mount api
Date: Fri, 21 Mar 2025 11:00:22 +0100
Message-ID: <20250321-unpolitisch-gezapft-410715be8606@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320204224.181403-1-preichl@redhat.com>
References: <20250320204224.181403-1-preichl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=brauner@kernel.org; h=from:subject:message-id; bh=MRrDhMsemmJi102SPR16/E2qfMXZMx9qjY8/k1i2x7s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTftdhRHfh1W+/PID5J03x9E2O/DeYqRwyzA5UPWTxf+ /+CYWpYRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2ejMyXNaNPc2/xm1ueBSb QITPFN04z7QYiS7vjF+2GdtKFzhfYWRYL5GQ4GnfFbS3//rXL3Uyk1/kGUoeFrPZv6HwUa3Pz5V cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 21:42:24 +0100, Pavel Reichl wrote:
> Convert the bfs filesystem to use the new mount API.
> 
> Tested using mount and simple writes & reads on ro/rw bfs devices.
> 
> 

Applied to the vfs-6.16.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.mount.api

[1/1] bfs: convert bfs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/609a32850f9d

