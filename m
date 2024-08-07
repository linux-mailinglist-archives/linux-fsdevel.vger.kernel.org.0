Return-Path: <linux-fsdevel+bounces-25310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FF94AA1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC852837B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9E6F312;
	Wed,  7 Aug 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaM8UTfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6C6F30E;
	Wed,  7 Aug 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040961; cv=none; b=Wi/0ZgPZ62YecIAahFAVr440dlhGM0EYbgbjvYG64l/KyJ6WMqsCMxvn3tvSHxI2v5C5S1mFsRWaKQQWNcvcU+uOSC3d+Y3nqLbGWoTxLwpAkiySNsxk5qR7hXi2b+NtnmSlUdyqB5b7Z8CLrxH7OHIjGZkwMUlZajfGeosXXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040961; c=relaxed/simple;
	bh=1c1Vw1Y3wDE2nnNr4XeVDLbR5X7Ybtyob5X9ATir400=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKy8t1iGskjWwCPuvyQSeuyF57sp/eFdVQZLehGJQePbW8APlD+nq/d7niiF011a/hxnJ4DREXKoWDQdORN6cP1mXm+2XTxorV82V6DuR2bno3I2c4QNLwS0e4RWU8nlm4WMOSZKflaahLWPi51yl4wIDDI3ZQKMr8Lw3zQQnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaM8UTfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E6DC32781;
	Wed,  7 Aug 2024 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040961;
	bh=1c1Vw1Y3wDE2nnNr4XeVDLbR5X7Ybtyob5X9ATir400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaM8UTfWrH88zcE0C3pA5l5f08rB1sESch4y+uc4LhGLz4F9feWm0rdN6q9PcljAp
	 mF0MvdyICrrGU/WSBfp3v1skYNUJJ+1+DqdC2z4nsq06ssSTgm/iKFno0Q6+SaBpox
	 DO3r6/9xGb9pc13HbitMxdHvd16EWGK7bvRKUsiQjP6Mhj3pRnsdWQnDaub84uPg5W
	 tLKebGXFUSQ6TXBwGXZZFwJLpCeny4XANUHFUFBvXncBBJDY++wipbVE878yIxPm7q
	 yYh6Ic0ieX8z8HhwqC8411VReOFY/99EPD69BeR0cwySG6L94rQLIT+CyI738j/wls
	 +Az2BI3Zmciwg==
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Christian Brauner <brauner@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net-next] eventpoll: Don't re-zero eventpoll fields
Date: Wed,  7 Aug 2024 16:29:07 +0200
Message-ID: <20240807-zugeparkt-andacht-adb372d9e470@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807105231.179158-1-jdamato@fastly.com>
References: <20240807105231.179158-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=brauner@kernel.org; h=from:subject:message-id; bh=1c1Vw1Y3wDE2nnNr4XeVDLbR5X7Ybtyob5X9ATir400=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtbtnJkje7bE2XPdd3tTbNhD7BW5OXyS+Z6hF8/pAhQ 4rhtp7OjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMq2X4zWKxf3oPg9Mpv6h9 Wcu5f3yp1thokT1jR9gjBrUZXm3bpzMy3N9a8ehF0esbs39/Zw04/3j79Gyd6VMee6soHODZd5V jATMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 Aug 2024 10:52:31 +0000, Joe Damato wrote:
> Remove redundant and unnecessary code.
> 
> ep_alloc uses kzalloc to create struct eventpoll, so there is no need to
> set fields to defaults of 0. This was accidentally introduced in commit
> 85455c795c07 ("eventpoll: support busy poll per epoll instance") and
> expanded on in follow-up commits.
> 
> [...]

Applied to the vfs.misc.jeff branch of the vfs/vfs.git tree.
Patches in the vfs.misc.jeff branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.jeff

[1/1] eventpoll: Don't re-zero eventpoll fields
      https://git.kernel.org/vfs/vfs/c/394923595c20

