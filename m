Return-Path: <linux-fsdevel+bounces-4571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CED800D44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798F31C2095E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69141FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZtzyTb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04F6FAE;
	Fri,  1 Dec 2023 13:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FABC433C9;
	Fri,  1 Dec 2023 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701435686;
	bh=nKZ13NuAVFyDVkkW6Kh85flwpj1kfXAcyGjj3u/r2rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZtzyTb/ueqkSWBKnyrnh/Od1ffBPrIdv0630oHmteh22P3XWB0RvdCdXLG40N/lV
	 RwZWys0BeiyRQMjLG/Mu+RjpJm2jXhm80jL0xr+u/jeHHBfdpgboZPYPzpyxcXArSO
	 hvd9T2/RkMvYpjxC+XK33vuimtR+lQ4FBSZeO1HEg7zJRaZEj9gcx1muV/cBiBKstn
	 2Yu3nC/gVdid0m8p6voJYKjn6RBsa9t9gbA7cGkysfJOzbhNJhtOqorT3lF1POzyM/
	 if5AU6ITTUoGybZ0+mZN7uroxNWdUD7JxyH1AbWtbV0p6ILo7BlmqcfLh16dRSoHC9
	 YytwDAcvG+aMw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Lukas Schauer <lukas@schauer.dev>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pipe: wakeup wr_wait after setting max_usage
Date: Fri,  1 Dec 2023 14:01:11 +0100
Message-ID: <20231201-reparationen-einfuhr-da33df9ff38e@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201-orchideen-modewelt-e009de4562c6@brauner>
References: <20231201-orchideen-modewelt-e009de4562c6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=nKZ13NuAVFyDVkkW6Kh85flwpj1kfXAcyGjj3u/r2rM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRm3hRbUMOy52qvVW7QRd4fon/0pT/e7n29p1ct9HTyx LpVxxq3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykJ4Phn920m4kKKlMWCez2 FJP/sLRTqCPp3xPFf+x/2Tjf/Dvp2Mrwh4ulmoNd/F3Hxfo3bVODfghaek7zrwwIm8ijErUs72g NIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 01 Dec 2023 11:11:28 +0100, Christian Brauner wrote:
> Commit c73be61cede5 ("pipe: Add general notification queue support") a
> regression was introduced that would lock up resized pipes under certain
> conditions. See the reproducer in [1].
> 
> The commit resizing the pipe ring size was moved to a different
> function, doing that moved the wakeup for pipe->wr_wait before actually
> raising pipe->max_usage. If a pipe was full before the resize occured it
> would result in the wakeup never actually triggering pipe_write.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] pipe: wakeup wr_wait after setting max_usage
      https://git.kernel.org/vfs/vfs/c/348806de39e0

