Return-Path: <linux-fsdevel+bounces-20221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2F8CFE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5002B1F2182C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51713BC3B;
	Mon, 27 May 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJxRuRSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7C249FF;
	Mon, 27 May 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808153; cv=none; b=gVlWuUNlmXceAMZsa7lJX5JRFZpecp7ucvAjogpKkb11MLIHAYb4aoRG35tEWq7RlhsGnjPb7TX955n6PXXbRwxSOi9Rn85B0EgKRXGId5yMuPk0zJjjlEnAF143+ZPDK1uctcq8eNqYUzLxZcryEoAucaayqPFPdiEl5d2V0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808153; c=relaxed/simple;
	bh=62hMWxUD6NFUz/J34q8tsRJOtZmuEttxuaWbk0zbTEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7DTZJw7GtVaSI9fmCX8+AMInk9QPN6dzvcjl7PEj+l+XzW8/W6OybGYnL0YY3pg2sEHXu9tgSiJsL/wP0c1s2yrbIEbuju+A1cGqT79gg+50TppjlUJOle+rl0HK4K/iZgPMSkLIMG9FJQaiLt9o9qIbFRnwyrK+WwXWXj+DUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJxRuRSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31AC2BBFC;
	Mon, 27 May 2024 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716808152;
	bh=62hMWxUD6NFUz/J34q8tsRJOtZmuEttxuaWbk0zbTEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJxRuRSyF8aZl6lcHv4GNNbUtVqSVlKp+Xe/+i+D6yW1/oO/ot6EalwOzSHtrCo4K
	 s0dQbDVSkXR6WepDxxDij1Q54BKKBWWhdmNiSj8TTkMqt9MTvIiiPdh49TRPO6Pj86
	 rWP0aK1OzS00I+zfo7KiYPoyReQVkRqVHKqOwaqlnSGP7f2HTBJ/5G1FScQj0Q9Dz8
	 keqj6K/C1AuubkdWkfcykho2TfTj7Ukds7jbRtwZZjliN36IBWlvehAG7mXvXGjSMy
	 UG9U+OMvUnqNU5ZqRlchB7sVZE4/zAiYA1s8HL5QllUGwa5ynmsu52/Nml3RMEB9vg
	 dGhHN3oDTUPBA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot+df038d463cca332e8414@syzkaller.appspotmail.com,
	syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com,
	syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve French <sfrench@samba.org>,
	Hillf Danton <hdanton@sina.com>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v3] netfs, 9p: Fix race between umount and async request completion
Date: Mon, 27 May 2024 13:09:00 +0200
Message-ID: <20240527-losgefahren-albern-a9b1d8be3835@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <755891.1716560771@warthog.procyon.org.uk>
References: <755891.1716560771@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=62hMWxUD6NFUz/J34q8tsRJOtZmuEttxuaWbk0zbTEE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFZJ7zelnJM7U+5vs16+iDzU/eHak22+8zK2h3/Nxtx kt0hJJkO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiZ8/wP5lhXd2tnn2lDrHe S064NiWHCmp8PyXfyLxJ4KB6Y7f0U0aGtffmxsec3rSGNywtN+FVmNpSSVFb/R/TPYJj8uSzQl6 wAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 15:26:11 +0100, David Howells wrote:
> netfs, 9p: Fix race between umount and async request completion
> 
> There's a problem in 9p's interaction with netfslib whereby a crash occurs
> because the 9p_fid structs get forcibly destroyed during client teardown
> (without paying attention to their refcounts) before netfslib has finished
> with them.  However, it's not a simple case of deferring the clunking that
> p9_fid_put() does as that requires the p9_client record to still be
> present.
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

[1/1] netfs, 9p: Fix race between umount and async request completion
      https://git.kernel.org/vfs/vfs/c/e20fe12bfb0b

