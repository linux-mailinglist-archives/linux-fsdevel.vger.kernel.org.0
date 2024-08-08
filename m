Return-Path: <linux-fsdevel+bounces-25399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D835594B789
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077AD1C238B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 07:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7821891B5;
	Thu,  8 Aug 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsHyLPLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151A186294;
	Thu,  8 Aug 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101219; cv=none; b=b1ve1okvM9vzeUL3jGqsDPWdBSOwwj8msqbCo+ABCV6fjNDzqlpneMETA8SDCKygpNz9hDk5BgByBH1uPx6cdZLf301Kwava80mi8fvenaTdUof5e+DMMeiCULo967/WQgP9DDkUPU8BvtLfhzFhNC9TWmCESSbhLEaxXHLEokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101219; c=relaxed/simple;
	bh=0g9XRgxfeMZc9/uVHfto4j4RtP6dqmPPmizw0m2bd6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmj8ETtRBXRtNDhuTQ54dvMf7TAlD/6dSNSO8yzZjV+ZdtWcyGVZT4cuTAeyOortdSZv2OsYMF6afq+Bhrv1v6earOliE9YrZ5lQ7o3tSAsrl2num2hKaVrHH3nBa5Lw94M3mtIrK/hDMwP7/k72/7nHoI6Q9Xpx8Wdhw2anSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsHyLPLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D572FC4AF09;
	Thu,  8 Aug 2024 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723101218;
	bh=0g9XRgxfeMZc9/uVHfto4j4RtP6dqmPPmizw0m2bd6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsHyLPLefdQdvQC+jQGRnXZVwnSjt7F3ggBBoZL/I0bL6nAjbVdkePPxZv+aHPTeF
	 WiywH3KMXzzxx/upp6GV14gSZ8JeW66TVawsFgZS0b1bAIGsaKdAe01jnCNKUx3Q2R
	 uydw63ZfXUrkzhFR7Zvk9qIl9+oYHx41Psd4Nb2Di9438tvjQtLePmZOxuym6niaPI
	 NGcL67xBk0hKa2hue4EAiE1lCKEDxlwePef+t7D9evgmFd2KPVby0xVOEw3iWcfsDt
	 yrvHlFsMiApjDeagf6EdReWd5f7IuuBQYBOaMsOkLU8Xmk4X+nzA9YXG277WHy5JOd
	 e+qK7vu5psi+Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Cc: Christian Brauner <brauner@kernel.org>,
	netdev@vger.kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] eventpoll: Annotate data-race of busy_poll_usecs
Date: Thu,  8 Aug 2024 09:13:26 +0200
Message-ID: <20240808-geteert-skala-44fb9303360b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806123301.167557-1-jdamato@fastly.com>
References: <20240806123301.167557-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=brauner@kernel.org; h=from:subject:message-id; bh=0g9XRgxfeMZc9/uVHfto4j4RtP6dqmPPmizw0m2bd6g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtKZCcru3wjZH7y1Tr4lcXYtY4z7+z+9E80/z5CgeOb 9ylNonhe0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE5ixg+F+ScbQ3kHVFkbb0 4iNbX5QEufRwPrpmNLXIYMbWcK2PK60Z/ld6l/85uiprkdKjvJDvJdy3rJ63cJXq2AmZnoxSCSj /zwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Aug 2024 12:33:01 +0000, Joe Damato wrote:
> A struct eventpoll's busy_poll_usecs field can be modified via a user
> ioctl at any time. All reads of this field should be annotated with
> READ_ONCE.
> 
> 

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

[1/1] eventpoll: Annotate data-race of busy_poll_usecs
      https://git.kernel.org/vfs/vfs/c/b4988e3bd1f0

