Return-Path: <linux-fsdevel+bounces-12945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63886905F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F0A1F23328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA013A279;
	Tue, 27 Feb 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M52asngj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB01384BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036607; cv=none; b=DOD6vWSNul8aY4fTngRG92O6EcubYxCII+oWXMOW0PqJNOvzjzGG0YX1g6yQgpmbyhtxUIgcX+b9vZLZnYnCcJ3DGsNciS4f4YQVlP4Frns2Lv2tulD2G6JhpceyNsBRNrrlf3QROc9MI4YxiOnjIo1EckryiVwl3LCLjsNQbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036607; c=relaxed/simple;
	bh=oONBI46FP5h0MNqhVD/Lwu9vPDTEPC4WpPnO8yEXZ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VePkBhZUIZa4NVGwthAaP1TD8rJQhOFkZanw1p1GjIOE48RH/5lfjAOYLcxY97LpnhgqVcHsi6fnhfMGYtEeHqHhxNGHdp+2WLoiZupZv4AcC7ooIyQdl9Ca/EOGGDZA/R3558dRVpuazSw2NQWKiIpO5K/uzT2KqCVH6vwtaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M52asngj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776B9C433C7;
	Tue, 27 Feb 2024 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709036605;
	bh=oONBI46FP5h0MNqhVD/Lwu9vPDTEPC4WpPnO8yEXZ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M52asngjF6RBJgoLutKmBcMwiQQEpCG1xA1gqmaLGqnPXE/fUNRnf7tK0VzAbu8Zt
	 8xAME+8x/IKh6dAyH6LIUuSZUjFmXfx7bEWLKCyKbf3o+tdgcJkeYRbDw2Vl5xOSOT
	 43cOFMORQbzJxBviyFfju4PnY0KeJB6MyMT8N69cxtr5xnqulsP5IQog7FHRW0sWL4
	 7loWwfLz1fJolmEZoLvRzrPL42TByQiDyUhwQiR7Ixzh/pa6lD0qvLULBdFlAB0SAe
	 70zKDHBHpNBMNbvAoGaN9v97vU5vtVIXnBej0kYM6an81ARlhB9E+AyAyXLYRiHQzk
	 ZJ3yBlPCvnf0w==
From: Christian Brauner <brauner@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	al@alarsen.net,
	sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: convert qnx4 to use the new mount api
Date: Tue, 27 Feb 2024 13:23:17 +0100
Message-ID: <20240227-klarmachen-kurzhaarschnitt-924d07e7aaa3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226224628.710547-1-bodonnel@redhat.com>
References: <20240226224628.710547-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=brauner@kernel.org; h=from:subject:message-id; bh=oONBI46FP5h0MNqhVD/Lwu9vPDTEPC4WpPnO8yEXZ6A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTevWL+VCHu3qm8TourKZlXWWWjrnG+SYo7dY/j6dMlr 6TsDrq87ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIfEuG/1lJ76fN31ay4tqX M3lTG/6JPwto1XmR8/5QZuPnKwJa4rqMDJ2v/Xeuvfj/k8slw4M63L9ufUi4JvPwwc3HE1P3G13 w+MAOAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 26 Feb 2024 16:46:28 -0600, Bill O'Donnell wrote:
> Convert the qnx4 filesystem to use the new mount API.
> 
> Tested mount, umount, and remount using a qnx4 boot image.
> 
> 

Thank you!

---

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

[1/1] qnx4: convert qnx4 to use the new mount api
      https://git.kernel.org/vfs/vfs/c/bc07c283ea2a

