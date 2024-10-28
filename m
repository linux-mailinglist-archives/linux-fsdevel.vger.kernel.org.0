Return-Path: <linux-fsdevel+bounces-33059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B59B2FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E071F22AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541251D8E16;
	Mon, 28 Oct 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKpH/xlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE217C61;
	Mon, 28 Oct 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117925; cv=none; b=oZhmryqwBKLs/O8Pv8eWY56GmoP5E95Hj4Btla+cVgwFg+BS0ClCyNjGpnhZWJSEcIegqc/DcQ4TNYxbK1Y2piEG9dx78JNsGLiOZzJZcHORcquTTVJvETMYPmqMCTbrvBwuT6bhkbZPFZI5CiYA5No/4imL3bOwAECosbDkrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117925; c=relaxed/simple;
	bh=0H8r7TBHT37tjzCNRwO0VZNVQ8S36hpd0jKeDGVcZik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knqLdU4Ceav3Qz2oDYU4YBVuI+59A0DmD8SZcE3c9UIUvTOlXOtO+fkX5VqCwJkw7kxAGJoH0InQtJm7d97DKlgmZ06mxr2n7cMIE7Lofequ5fq3lL9nxBTRUFxlLf2UXErOlvs6ng1H2Os6I/ehy2k7mbh74sEtgYsWhiU6Vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKpH/xlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67E1C4CEC3;
	Mon, 28 Oct 2024 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730117925;
	bh=0H8r7TBHT37tjzCNRwO0VZNVQ8S36hpd0jKeDGVcZik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKpH/xlXRxMKcdNtTRHI7tjVhS3KsWBpLiVeqHxpekiGCWHsZp3lsaK2JD74E20CS
	 6vNs4prZ7MwLJwuqhw+hGthiYZ4Ndy1DNAhkOeCWVrfrfgiJvgjsWXCcgFdUph8AFe
	 b4B0YyUkDD+4drWqBj6Sdv17dTsMULxP8ESE/MjIHRg+jXvyxfm3msbUoDtmWCVb5h
	 IylKJWjNMeHqH+FWB+kA1OD6EVuNhZFa7razs7Ul4OAmispAjXn1X61EmkQNuM9ktb
	 e7pHevDdQK8NEY5zHZiP2mJCq1arj+Kq9AqhUgFgwkij8jjBx9XmCedesmppXZsAnL
	 23ed9Q/sQNWBg==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	autofs mailing list <autofs@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] autofs: fix thinko in validate_dev_ioctl()
Date: Mon, 28 Oct 2024 13:18:39 +0100
Message-ID: <20241028-filmt-lesebrille-20feb7581897@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027224732.5507-1-raven@themaw.net>
References: <20241027224732.5507-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=brauner@kernel.org; h=from:subject:message-id; bh=0H8r7TBHT37tjzCNRwO0VZNVQ8S36hpd0jKeDGVcZik=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTLN8rr/SrTW8ukyDXD4lva61nluXsruCp+b1rgdWFp4 7xAaZcjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxmMvwP/L2r2WGwZf7jKN0 bC5J6QR/cdl5Z+K0LF+uiSU3GNYGejMyvF5nv/tYfNivgI5CMy8OH86Pl/1PlX0RMdv8KjTlRPs fNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 06:47:17 +0800, Ian Kent wrote:
> I was so sure the per-dentry expire timeout patch worked ok but my
> testing was flawed.
> 
> In validate_dev_ioctl() the check for ioctl AUTOFS_DEV_IOCTL_TIMEOUT_CMD
> should use the ioctl number not the passed in ioctl command.
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

[1/1] autofs: fix thinko in validate_dev_ioctl()
      https://git.kernel.org/vfs/vfs/c/f19910006eff

